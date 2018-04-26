/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conf.session.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Model;

/**
 *
 * @author acadrasco
 */
public class procesarActualizarValoresRetencion extends HttpServlet {

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
        try {

            if (request.getParameter("avaluo") != null && request.getParameter("retencion") != null && request.getParameter("fk_vehiculo") != null) {
                String av = request.getParameter("avaluo");
                String rt = request.getParameter("retencion");
                String fk = request.getParameter("fk_vehiculo");
                //convertimos los tipos
                int avaluo = Integer.parseInt(av);
                int retencion = Integer.parseInt(rt);
                int fk_vehiculo = Integer.parseInt(fk);
                //pasamos los valores convertidos como paramteros al metodo ActualizarValoresRetencion
                boolean update = modelo.ActualizarValoresRetencion(avaluo, retencion, fk_vehiculo);
                //si se actualizo 
                if (update == true) {
                    out.println("<script type=\"text/javascript\">");
                    out.println("function mensajeTransaccion(){");
                    out.println("alert('Transaccion exitosa........');");
                    out.println("} mensajeTransaccion();");
                    out.println("</script>");
                    modelo.getCon().commit();
                    out.println("<script language='JavaScript'>function redireccionarPagina() {\n"
                            + "   window.top.location.href = \"inicio.jsp\";\n"
                            + "}"
                            + "setTimeout(\"redireccionarPagina()\", 5000);</script>");
                } else {
                    out.println("<script type=\"text/javascript\">");
                    out.println("function mensajeTransaccion(){");
                    out.println("alert('Transaccion no Procesada........')");
                    out.println("} mensajeTransaccion();");
                    out.println("</script>");
                    modelo.getCon().rollback();
                }

            } else {
                //si vienen nulos
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(procesarActualizarValoresRetencion.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(procesarActualizarValoresRetencion.class.getName()).log(Level.SEVERE, null, ex);
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
