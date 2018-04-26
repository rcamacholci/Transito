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
public class asociarConceptoTramite extends HttpServlet {

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
       if (request.getParameter("clase") == null && request.getParameter("fkt") == null) {
            out.println("<script type=\"text/javascript\">");
                        out.println("function mensajeTransaccion(){");
                        out.println("alert('Debes Seleccionar un valor de la lista de opciones........')");                        
                        out.println("} mensajeTransaccion();");
                        out.println("</script>");

        } else { 
            try {
                //se recibe el parametro enviado desde el select
                String clase = request.getParameter("clase");
                String fkt =  request.getParameter("fkt");
                //se convierte a entero para mandarlo como parametro de entrada en el metodo que lista los tramites asociados a la clase.
                int idclase = Integer.parseInt(clase);
                int fk_tramite = Integer.parseInt(fkt);
                Concepto concep = new Concepto();
                out.println("<table align='center' width='40%' border='1' >  ");
                out.println("<tr>");
                out.println("<td> <b> <label>Lista de Conceptos:</label> </b> </td>");    
                
                out.println("<td>");            
                out.println("<select id='listaConceptos' onchange='mostrarConcepto()' style='width:400px'>");
                out.println("<option value='-1'>Seleccione una opcion .... </option >");
                //pasamos el id como parametro de entrada al metodo listarTramitesAsociados
                ArrayList hm = modelo.listarConceptosSedeTramiteConcepto(fk_tramite, idclase);
                java.util.Iterator it = hm.iterator();
                
                for(int i=0;i < hm.size(); i++ ){                
                    concep=(Concepto)hm.get(i);             
                    out.println("<option value='" + concep.getId_concepto() + "'>" + concep.getNombre() + " </option >");                
                
                }                
                 
                 out.println("<input type='hidden' value='" +fk_tramite + "'id='fk_tramite'/>");
                 out.println("<input type='hidden' value='" + idclase + "' id='clase'/>");
                 out.println("</td> ");
                  out.println("</tr>");
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
