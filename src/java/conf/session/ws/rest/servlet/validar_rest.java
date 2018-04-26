/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conf.session.ws.rest.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.GregorianCalendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.FechaMaxUsuario;
import modelo.Model;
import modelo.Persona;
import modelo.Sede;
import modelo.Usuario;
import modelo.UsuarioRunt;

/**
 *
 * @author Jcarreno
 */
public class validar_rest extends HttpServlet {

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

        try {
            PrintWriter out = response.getWriter();
            /* TODO output your page here. You may use following sample code. */
            if (request.getParameter("user") == null || request.getParameter("pass") == null || request.getParameter("rec") == null) {
                response.sendError(403);
            }

            java.io.File f = new java.io.File("C:/Civitrans/logRestInicio.txt");
            Model model = new Model();
            model.conectar();
            model.getCon().setAutoCommit(false);
            String rec = request.getParameter("rec");

            String user = request.getParameter("user");
            String pass = request.getParameter("pass");
            Usuario usuario;// = model.consultarUsuario(user, pass);
            usuario = model.consultarUsuario(Long.parseLong(pass));
            if (usuario != null && usuario.getNombre().equals(user)) {
                FechaMaxUsuario fechau;
                fechau = model.consultarMaxFechaHis(usuario.getId_usuario());
                GregorianCalendar fechaactss = new GregorianCalendar();
                Date fec1 = fechau.getFecha() != null ? fechau.getFecha() : new Date();
                Date fec2 = fechaactss.getTime();
                long time = fec2.getTime() - fec1.getTime();
                long dif = (time / (3600 * 24 * 1000));

                if (dif < 16000) {
                    java.util.List<String> listaIP = model.consultarUsuariosIP(usuario.getId_usuario());
                    boolean access = true;
                    if (listaIP.isEmpty()) {
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
                        request.getSession().setAttribute("Owner", "Civitrans");
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
                                    // response.sendRedirect("./paginas/jsp/autenticarUsuario.jsp");
                                } else {
                                    out.print("<script>alert('Usuario no posee usuario Runt'); </script>");
                                }
                            } else {
                                out.print("<script>alert('Usuario no posee usuario Runt'); </script>");
                            }
                        } else {
                            if (!f.exists()) {
                                f.createNewFile();
                            }
                            try {
                                java.io.FileOutputStream fos = new java.io.FileOutputStream(f, true);
                                java.io.DataOutputStream dos = new java.io.DataOutputStream(fos);
                                dos.writeBytes(request.getRemoteAddr()
                                        + ";" + request.getParameter("user")
                                        + ";" + request.getParameter("rec")
                                        + ";" + new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm:ss aa").format(new java.util.Date())
                                        + ";Autentificaion"
                                );
                                dos.writeBytes("\n");
                            } catch (Exception ex) {
                                response.sendError(403, "Error");
                            }
                            //out.print("https://Localhost:8181"+request.getContextPath()+"/paginas/jsp/"+rec);
                            response.sendRedirect("../paginas/jsp/" + rec);
                            //request.setAttribute("recurso", rec);
                            //response.sendRedirect("../paginas/jsp/newInicio.jsp");
                        }
                    } else {
                        out.print("<script>alert('Acceso Ip incorrecto'); </script>");
                        f = new java.io.File("C:/Civitrans/logRestInicio.txt");
                        if (!f.exists()) {
                            f.createNewFile();
                        }
                        try {
                            java.io.FileOutputStream fos = new java.io.FileOutputStream(f, true);
                            java.io.DataOutputStream dos = new java.io.DataOutputStream(fos);
                            dos.writeBytes(request.getRemoteAddr()
                                    + ";" + request.getParameter("user")
                                    + ";" + request.getParameter("rec")
                                    + ";" + new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm:ss aa").format(new java.util.Date())
                                    + ";Acceso Ip incorrecto"
                            );
                            dos.writeBytes("\n");
                        } catch (Exception ex) {
                            response.sendError(403, "Error");
                        }
                        response.sendRedirect("/Civitrans/content/home.civ");
                    }

                } else {
                    out.print("<script>alert('Contraseña vencida, favor cambie su contraseña'); "
                            + " document.location.href='editarpasswordobligatoria.html';</script>");
                }
            } else {
                out.print("<script>alert('Usuario y/o contraseña incorrecto(a)');"
                        + "</script>");
                f = new java.io.File("C:/Civitrans/logRestInicio.txt");
                if (!f.exists()) {
                    f.createNewFile();
                }
                try {
                    java.io.FileOutputStream fos = new java.io.FileOutputStream(f, true);
                    java.io.DataOutputStream dos = new java.io.DataOutputStream(fos);
                    dos.writeBytes(request.getRemoteAddr()
                            + ";" + request.getParameter("user")
                            + ";" + request.getParameter("rec")
                            + ";" + new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm:ss aa").format(new java.util.Date())
                            + ";Denegado por autentificaion"
                    );
                    dos.writeBytes("\n");
                } catch (Exception ex) {
                    response.sendError(403, "Error");
                }
                response.sendRedirect("/Civitrans/content/home.civ");
            }
        } catch (Exception ex) {
            response.sendRedirect("/Civitrans/content/home.civ");
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
