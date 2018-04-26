/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conf.session.servlet;

import Cifrado.KeyStore;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.GregorianCalendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.FechaMaxUsuario;
import modelo.Model;
import modelo.Persona;
import modelo.Sede;
import modelo.Usuario;
import modelo.UsuarioRunt;

/**
 *
 * @author Admin
 */
public class validar_login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {

            if (request.getParameter("txtusuario") != null && request.getParameter("txtpassword") != null) {
                java.io.File f = new java.io.File("C:/Civitrans/logInicio.txt");
                java.io.FileOutputStream fos = new java.io.FileOutputStream(f, true);
                java.io.DataOutputStream dos = new java.io.DataOutputStream(fos);
                dos.writeBytes(request.getRemoteAddr() + "&" + request.getParameter("txtusuario") + "&" + new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm:ss aa").format(new java.util.Date()));
                dos.writeBytes("\n");
                dos.close();
                fos.close();
                Model model = new Model();
                model.conectar();
                model.getCon().setAutoCommit(false);
                
                String user = request.getParameter("txtusuario");
                String pass = request.getParameter("txtpassword");
                Usuario usuario = model.consultarUsuario(user.toUpperCase(), KeyStore.Encriptar(pass));
                if (usuario != null) {

                    FechaMaxUsuario fechau = null;
                    fechau = model.consultarMaxFechaHis(usuario.getId_usuario());
                    GregorianCalendar fechaactss = new GregorianCalendar();
                    Date fec1 = fechau.getFecha();
                    Date fec2 = fechaactss.getTime();
                    long time = fec2.getTime() - fec1.getTime();
                    long dif = (time / (3600 * 24 * 1000));

                    if (dif < 16) {    
                        java.util.List<String> listaIP = model.consultarUsuariosIP(usuario.getId_usuario());
                        boolean access = true;
                        if (listaIP.size() == 0) {
                            access = true;
                        } else {
                            if (listaIP.contains(request.getRemoteAddr())) {
                                access = true;
                            }
                        }
                        if (access) {

                            request.getSession().setAttribute("model", model);
                            request.getSession().setAttribute("sesionDe", usuario.getNombre() + " - " + request.getRemoteAddr());
                            Persona persona = model.consultarPersona(usuario.getFk_persona());
                            request.getSession().setAttribute("usuarioSession", usuario.getNombre() + " - " + persona.getNombre_1() + " " + persona.getApellido_1());
                            request.getSession().setAttribute("usuario", usuario);
                            request.getSession().setAttribute("permisosU", model.obtenerPermisos(usuario.getId_usuario()));
                            Sede sede = model.consultarSede(usuario.getFk_sede());
                            request.getSession().setAttribute("sede", sede);

                            //model.SetIpCivitrans(request.getRemoteAddr());
                            //model.SetUsuarioApp(usuario.getNombre());
                            
                            java.util.List lista = model.consultarCajasUsuario(usuario.getId_usuario());
                            for (int i = 0; i < lista.size(); i++) {
                                modelo.UsuarioCaja usuarioCaja = (modelo.UsuarioCaja) lista.get(i);
                                modelo.Taquilla taquilla = model.consultar_Taquilla(usuarioCaja.getFk_caja(), usuarioCaja.getFk_sede(), usuarioCaja.getFk_usuario());
                                if (taquilla != null) {
                                    if (taquilla.getEstado() == 1) {
                                        String fechaA = new java.text.SimpleDateFormat("MM/dd/yyyy").format(new java.sql.Date(taquilla.getFecha_ini().getTime()));
                                        String fechaB = new java.text.SimpleDateFormat("MM/dd/yyyy").format(new java.sql.Date(new java.util.Date().getTime()));
                                        if (!fechaA.equals(fechaB)) {
                                            taquilla.setEstado(3);
                                            float total = model.consultarValorTaquilla(taquilla.getId_taquilla());
                                            taquilla.setValor_nota_debito(total);
                                            taquilla.setValor_taquilla(total);
                                            taquilla.setFecha_fin(new java.sql.Timestamp(new java.util.Date().getTime()));
                                            model.actualizarTaquilla(taquilla, taquilla.getId_taquilla());
                                            if (usuario.getId_usuario() == 31) {
                                                model.actualizarParametroConfiguracion(2, 0);
                                            }
                                            model.getCon().commit();
                                        }
                                    }
                                }
                            }

                            if (request.getParameter("runt") != null) {
                                if (request.getParameter("runt").equals("2")) {
                                    UsuarioRunt userRunt = model.consultarUsuarioRunt2(usuario.getId_usuario());
                                    request.getSession().setAttribute("usuarioRunt", userRunt);
                                    if (userRunt != null) {
                                        response.sendRedirect("./paginas/jsp/autenticarUsuario.jsp");
                                    } else {
                                        out.print("<script>alert('Usuario no posee usuario Runt'); document.location.href='index.html';</script>");
                                    }
                                } else {
                                    out.print("<script>alert('Usuario no posee usuario Runt'); document.location.href='index.html';</script>");
                                }
                            } else {
                                response.sendRedirect("./paginas/jsp/inicio.jsp");
                            }
                        } else {
                            out.print("<script>alert('Acceso Ip incorrecto'); document.location.href='index.html';</script>");
                        }

                    } else {
                        out.print("<script>alert('Contraseña vencida, favor cambie su contraseña'); document.location.href='editarpasswordobligatoria.html';</script>");
                    }
                } else {
                    out.print("<script>alert('Usuario y/o contraseña incorrecto(a)'); document.location.href='index.html';</script>");
                }

            } else {
                out.print("<script>alert('Los campos no pueden estar vacios'); document.location.href='index.html';</script>");
            }
        } catch (Exception ex) {
            out.print("<script>alert('Ha ocurrido un error al procesar la inforamción, por favor contacte con soporte tecnico. [Error: " + ex.getMessage() + "]'); document.location.href='index.html';</script>");
            ex.printStackTrace();
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
