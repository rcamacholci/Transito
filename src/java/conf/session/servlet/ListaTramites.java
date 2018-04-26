/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conf.session.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Model;
import modelo.Usuario;

/**
 *
 * @author acadrasco
 */
public class ListaTramites extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ParseException, Exception {
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
                out.println("<label>Tramites Asociados:</label>");
                out.println("<select id='listaT' onchange='cargarListaConceptos();' style='width:200px'>");
                out.println("<option value='-1'>Seleccione una opcion .... </option >");
                //pasamos el id como parametro de entrada al metodo listarTramitesAsociados
                java.util.List hm = modelo.listarTramitesAsociados(id);
                java.util.Iterator it = hm.iterator();
                for (Object elem : hm) {
                    HashMap hash = (HashMap<String, String>) elem;
                    System.out.println(hash.get("FK_TRAMITE"));
                    System.out.println(hash.get("NOMBRE"));
                    out.println("<option value='" + hash.get("FK_TRAMITE") + "'>" + hash.get("NOMBRE") + " </option >");
                    
                }
                out.println("</select>");
                out.println("<input type='hidden' value='" + id + "' id='clase'/>");
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
            Logger.getLogger(ListaTramites.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(ListaTramites.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(ListaTramites.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ListaTramites.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(ListaTramites.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(ListaTramites.class.getName()).log(Level.SEVERE, null, ex);
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
