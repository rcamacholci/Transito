/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conf.session.servlet;

import java.io.IOException;
import java.io.PrintWriter;
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
public class procesarConcepto extends HttpServlet {

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
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Model modelo = (Model) request.getSession().getAttribute("model");///
        java.util.Date utilDate = new java.util.Date();
        java.sql.Date fechaRegistro = new java.sql.Date(utilDate.getTime());
        if (request.getParameter("clase") == null && request.getParameter("nombreConcepto") == null) {
            out.println("<script type=\"text/javascript\">");
            out.println("function mensajeTransaccion(){");
            out.println("alert('Debes Seleccionar un valor de la lista de opciones........')");
            out.println("} mensajeTransaccion();");
            out.println("</script>");

        } else {
            try {
                String clase = request.getParameter("clase");
                String nombreConcepto = request.getParameter("nombreConcepto");
                String observacion = request.getParameter("observacion");
                String sede = request.getParameter("sede");
                //convertimos los tipos de datos
                int claseT = Integer.parseInt(clase);
                int sedeOT = Integer.parseInt(sede);

                //insertamos el nuevo concepto mediante el metodo registrarConcepto
                boolean insertConcept = modelo.registrarConcepto(nombreConcepto, observacion, claseT);
                if (insertConcept) {
                    //insertamos un nuevo concepto en la tabla sede_conceptos mediante el metodo 
                    boolean insertSedeConcept = modelo.registrarSedeConcepto(sedeOT, claseT, fechaRegistro);
                    if (insertSedeConcept) {
                        out.println("<script type=\"text/javascript\">");
                        out.println("function mensajeTransaccion(){");
                        out.println("alert('Transaccion exitosa........');");
                        out.println("} mensajeTransaccion();");
                        out.println("</script>");
                        modelo.getCon().commit();
                        //despues que guarde dibujamos la tabla
                        out.println("<h6 align='center'>Asociar concepto a Tramites:</h6>");                        
                        out.println("<table align='center' width='40%' border='1' >  ");
                        out.println("<tr>");
                        out.println("<td> <b> Nombre del Concepto </b> </td>");
                        out.println("<td> <b> Clase de Tramite </b> </td>");                        
                        out.println("</tr>");
                        out.println("<tr>");
                        out.println("<td ><input type='text' readonly='readonly' value='" + nombreConcepto + "' style='width:80px;'/></td>");
                        out.println("<td >");
                        out.println("<select id='listaC' onchange='listarTramites()' style='width:200px'>");
                        out.println("<option value='-1'>Seleccione una opcion .... </option >");
                        //pasamos el id como parametro de entrada al metodo listarTramitesAsociados
                        //listar las clases de tramites
                        // Recorremos el hashMap y mostramos por pantalla el par valor y clave
                        java.util.List hm = modelo.listarClaseTramite();
                        java.util.Iterator it = hm.iterator();
                        for (Object elem : hm) {
                            HashMap hash = (HashMap<String, String>) elem;
                            System.out.println(hash.get("CODIGO"));
                            System.out.println(hash.get("NOMBRE"));
                            out.println("<option value='" + hash.get("CODIGO") + "'>" + hash.get("NOMBRE") + " </option >");

                        }
                        out.println("</select>");
                        out.println("</td>");
                        out.println("</tr>");                       
                        out.println(" </table> ");  //Fin de campos de busqueda
                        ///buscar el concepto recien insertado en la tabla concepto
                        int fk_concepto = modelo.buscarIdConcepto(nombreConcepto);
                        out.println("<input type='hidden' value='" + fk_concepto+ "'id='fk_concepto'/>");
                    } else {
                        out.println("<script type=\"text/javascript\">");
                        out.println("function mensajeTransaccion(){");
                        out.println("alert('Transaccion no Procesada........')");
                        out.println("} mensajeTransaccion();");
                        out.println("</script>");
                        modelo.getCon().rollback();
                    }
                } else {
                    out.println("<script type=\"text/javascript\">");
                    out.println("function mensajeTransaccion(){");
                    out.println("alert('Transaccion no Procesada........')");
                    out.println("} mensajeTransaccion();");
                    out.println("</script>");
                    modelo.getCon().rollback();

                }

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
        } catch (Exception ex) {
            Logger.getLogger(procesarConcepto.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (Exception ex) {
            Logger.getLogger(procesarConcepto.class.getName()).log(Level.SEVERE, null, ex);
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
