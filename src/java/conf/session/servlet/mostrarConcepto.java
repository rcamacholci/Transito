/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conf.session.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Concepto;
import modelo.Model;

/**
 *
 * @author acadrasco
 */
public class mostrarConcepto extends HttpServlet {

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
        Model modelo = (Model) request.getSession().getAttribute("model");///
        if (request.getParameter("fk_concepto") == null) {
            out.println("<script type=\"text/javascript\">");
            out.println("function mensajeTransaccion(){");
            out.println("alert('Debes Seleccionar un valor de la lista de opciones........')");
            out.println("} mensajeTransaccion();");
            out.println("</script>");

        } else {
            try {
                //se recibe el parametro enviado desde el select
                String concepto = request.getParameter("fk_concepto");

                //se convierte a entero para mandarlo como parametro de entrada en el metodo que lista los tramites asociados a la clase.
                int idconcepto = Integer.parseInt(concepto);
                String nombreConcepto = modelo.buscarNombreConcepto(idconcepto);

                //Los campos de busqueda se muestran en una tabla independiente
                out.println("<table align='center' width='40%' border='1' >  ");
                out.println("<tr>");
                out.println("<td> <b> Nombre del Concepto </b> </td>");
                out.println("<td>  <b> Asociar Concepto </b> </td> ");
                out.println("</tr>");
                out.println("<tr>");
                out.println("<td> "+nombreConcepto +"  </td>");                
                out.println("<td ><input type='submit'  id='btnac' value='Asociar' onclick='cargarListaConceptos();'/> </td> ");
                out.println("</tr>");
                out.println(" </table> ");  //Fin de campos de busqueda
                out.println("<input type='hidden' value='" + idconcepto + "'id='fk_concepto'/>");
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
