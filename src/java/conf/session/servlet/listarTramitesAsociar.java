/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conf.session.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Model;

/**
 *
 * @author Admin
 */
public class listarTramitesAsociar extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Model modelo = (Model) request.getSession().getAttribute("model");///

        if (request.getParameter("op") == null) {
            out.println("<script type=\"text/javascript\">");
            out.println("function mensajeTransaccion(){");
            out.println("alert('Debes Seleccionar un valor de la lista de opciones........')");
            out.println("} mensajeTransaccion();");
            out.println("</script>");

        } else {
            try {
                //se recibe el parametro enviado desde el select
                String opcion = request.getParameter("op");

                //se convierte a entero para mandarlo como parametro de entrada en el metodo que lista los tramites asociados a la clase.
                int id = Integer.parseInt(opcion);
                out.println("<h6 align='center'>Tramites Asociados:</h6>");
                out.println("<table align='center' width='40%' border='1' >  ");
                out.println("<tr>");
                out.println("<td> <b> Nombre del Tramite </b> </td>");
                out.println("<td> <b> Asociar Concepto</b> </td>");
                out.println("</tr>");

                //pasamos el id como parametro de entrada al metodo listarTramitesAsociados
                java.util.List hm = modelo.listarTramitesAsociados(id);
                java.util.Iterator it = hm.iterator();
                for (int i = 0; i < hm.size(); i++) {
                    HashMap hash = (HashMap<String, String>) hm.get(i);
                    System.out.println(hash.get("FK_TRAMITE"));
                    System.out.println(hash.get("NOMBRE"));
                    out.println("<tr>");
                    out.println("<td><input type='hidden' id='tra" + i + "' value='" + hash.get("FK_TRAMITE") + "' />" + hash.get("NOMBRE") + "  </td>");
                    out.println("<td ><input type='submit'  id='btn" + i + "' value='Asociar' onclick='mandarId(tra" + i + ",btn" + i + ")'/> </td> ");
                    out.println("</tr>");

                }
                out.println(" </table> ");  //Fin de campos de busqueda
            } finally {
                out.close();
            }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(listarTramitesAsociar.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(listarTramitesAsociar.class.getName()).log(Level.SEVERE, null, ex);
        }
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
