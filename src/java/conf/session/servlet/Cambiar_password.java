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
import modelo.FechaMaxUsuario;
import modelo.HIS_PAS_USUARIO;
import modelo.Model;
import modelo.Persona;
import modelo.Sede;
import modelo.Usuario;

/**
 *
 * @author Jefrey
 */
public class Cambiar_password extends HttpServlet {

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

            if (request.getParameter("txtusuario") != null && request.getParameter("txtpassword") != null && request.getParameter("txtpasswordn") != null && request.getParameter("txtpasswordcn") != null) {
                Model model = new Model();
                model.conectar();
                String user = request.getParameter("txtusuario");
                String pass = request.getParameter("txtpassword");
                String npass = request.getParameter("txtpasswordn");
                String cnpass = request.getParameter("txtpasswordcn");

                if (npass.trim().equals(cnpass.trim())) {
                    Usuario usuario = model.consultarUsuario(user.toUpperCase(), KeyStore.Encriptar(pass));
                    if (usuario != null) {

                        java.util.List<String> listaIP = model.consultarUsuariosIP(usuario.getId_usuario());
                        boolean access = false;
                        if (listaIP.size() == 0) {
                            access = true;
                        } else {
                            if (listaIP.contains(request.getRemoteAddr())) {
                                access = true;
                            }
                        }
                        if (access) {
                            //npass = Cifrado.Algoritmos_Hash.getStringMessageDigest(npass, "MD5");
                            npass = KeyStore.Encriptar(npass);
                            HIS_PAS_USUARIO hpassword = model.consultarHIS_PAS_USUARIOPass(usuario.getId_usuario(), npass);
                            if(hpassword==null){
                                model.editarPassword(usuario.getId_usuario(),npass);
                                model.adicionarHIS_PAS_USUARIO(usuario.getId_usuario(),npass);
                                out.print("<script>alert('Password cambiado Exitosamente'); document.location.href='index.html';</script>");
                            }else{
                                out.print("<script>alert('Por razones de seguridad le recomendamos no utilizar password anteriores'); document.location.href='editarpasswordobligatoria.html';</script>");;
                            }
                            
                        } else {
                            out.print("<script>alert('Acceso Ip incorrecto'); document.location.href='index.html';</script>");;
                        }

                    } else {
                        out.print("<script>alert('Usuario y/o contraseña incorrecto(a)'); document.location.href='index.html';</script>");
                    }
                } else {
                    out.print("<script>alert('Nueva contraseña no coincide, confirme su contraseña'); document.location.href='editarpasswordobligatoria.html';</script>");
                }
            } else {
                out.print("<script>alert('Los campos no pueden estar vacios'); document.location.href='editarpasswordobligatoria.html';</script>");
            }
        } catch (Exception ex) {
            out.print("<script>alert('Ha ocurrido un error al procesar la inforamción, por favor contacte con soporte tecnico. [Error: "+ex.getMessage()+"]'); document.location.href='index.html';</script>");
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
