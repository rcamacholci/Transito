/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conf.session.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Model;

/**
 *
 * @author acadrasco
 */
public class procesarConsultaPlaca extends HttpServlet {

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
        try {

            if (request.getParameter("placa") != null) {

                String placa = request.getParameter("placa");
                int num[] = new int[3];
                num = modelo.buscarValoresRetencionPorPlaca(placa.toUpperCase());
                
                if (num.length > 0) {
                    out.println("<h6 align='center' class='style1'>Tabla de Avaluos y Retención</h6>");
                    //Los campos de busqueda se muestran en una tabla independiente
                    out.println("<table align='center' width='40%' border='1' >  ");
                    out.println("<tr>");
                    out.println("<td> <b> Placa </b> </td>");
                    out.println("<td> <b> Valor Avaluo </b> </td>");
                    out.println("<td> <b> Valor Retención </b> </td>");
                    out.println("<td> <b> Actualizar </b> </td>");
                    out.println("</tr>");
                    out.println("<tr>");
                    out.println("<td><input type='text' readonly='readonly' value='" + placa.toUpperCase() + "' />  </td>");
                    out.println("<td><input type='text' id='avaluo' value='" + num[0] + "'  onblur='calcularRetencion();' onkeypress='return soloNumeros(event)'/>  </td>");
                    out.println("<td ><input type='text' readonly='readonly' id='retencion' value='" + num[1] + "'/></td>");
                    out.println("<td ><input type='submit'  id='btn' value='Guardar' onclick='enviar()'/> </td> ");
                    out.println("</tr>");
                    //convertir el fk del vehiculo a un entero.
                    
                    out.println("<input type='hidden' value='" +num[2]+ "'id='fk_vehiculo'/>");
                } else {
                    out.println("<script type=\"text/javascript\">");
                    out.println("function mensajeTransaccion(){");
                    out.println("alert('El vehiculo con placa '"+placa.toUpperCase()+" no se encuentra registrado en la tabla de avaluos);");
                    out.println("} mensajeTransaccion();");
                    out.println("</script>");

                }

            } else {
                //no envio la placa
                out.println("<script type=\"text/javascript\">");
                out.println("function mensajeTransaccion(){");
                out.println("alert('Transaccion no Procesada, posee valores nulos........')");
                out.println("} mensajeTransaccion();");
                out.println("</script>");
            }

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
