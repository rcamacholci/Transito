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
import java.util.Iterator;
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
public class ListaConceptos extends HttpServlet {

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
            throws ServletException, IOException, SQLException, ParseException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Model modelo = (Model) request.getSession().getAttribute("model");///
        Usuario user = (Usuario) request.getSession().getAttribute("usuario");
        java.util.Date utilDate = new java.util.Date();
        java.sql.Date fechaRegistro = new java.sql.Date(utilDate.getTime());
        if (request.getParameter("op") == null && request.getParameter("resol") == null) {
            out.println("<script type=\"text/javascript\">");
            out.println("function mensajeTransaccion(){");
            out.println("alert('Debes Seleccionar un valor de la lista de opciones........')");
            out.println("} mensajeTransaccion();");
            out.println("</script>");

        } else {
            try {
                //se recibe el parametro enviado desde el select
                String opcion = request.getParameter("op");
                String resol = request.getParameter("resol");
                String fecha = request.getParameter("fhr");

                //valores para asociar conceptos
                if (request.getParameter("fkc") != null && request.getParameter("fkt") != null && request.getParameter("sede") != null) {
                    String fkc = request.getParameter("fkc");
                    String fkt = request.getParameter("fkt");
                    String sede = request.getParameter("sede");
                    //Convertimos a los tipos de datos que necesitamos para realizar el proceso de insercion
                    //convercion a enteros y dobles                    
                    int fk_concepto = Integer.parseInt(fkc);
                    int fk_tramite = Integer.parseInt(fkt);
                    int nResolucion = Integer.parseInt(resol);
                    int sedeOT = Integer.parseInt(sede);

                    //conversion de fecha tipo String a date
                    SimpleDateFormat formatoDelTexto = new SimpleDateFormat("dd/MM/yyyy");
                    java.util.Date fechaRes = formatoDelTexto.parse(fecha);
                    java.sql.Date fechaResolucion = new java.sql.Date(fechaRes.getTime());

                    boolean insertar = modelo.registrarSedeTramitesConceptos(fk_concepto, fk_tramite, nResolucion, fechaResolucion, 0, sedeOT, user.getNombre(), fechaRegistro);
                    if (insertar == true) {

                        out.println("<script type=\"text/javascript\">");
                        out.println("function mensajeTransaccion(){");
                        out.println("alert('Transaccion exitosa........');");
                        out.println("} mensajeTransaccion();");
                        out.println("</script>");
                        modelo.getCon().commit();

                    } else {
                        out.println("<script type=\"text/javascript\">");
                        out.println("function mensajeTransaccion(){");
                        out.println("alert('Transaccion no Procesada........')");
                        out.println("} mensajeTransaccion();");
                        out.println("</script>");
                        modelo.getCon().rollback();
                    }
                }

                if (request.getParameter("quitar") != null) {
                    String fkc = request.getParameter("fkc");
                    String fkt = request.getParameter("op");
                    int fk_concepto = Integer.parseInt(fkc);
                    int fk_tramite = Integer.parseInt(fkt);
                    boolean update = modelo.ActualizarFechaFinVigencia(fechaRegistro, fk_tramite, fk_concepto);
                    if (update == true) {

                        out.println("<script type=\"text/javascript\">");
                        out.println("function mensajeTransaccion(){");
                        out.println("alert('Transaccion exitosa........');");
                        out.println("} mensajeTransaccion();");
                        out.println("</script>");
                        modelo.getCon().commit();

                    } else {
                        out.println("<script type=\"text/javascript\">");
                        out.println("function mensajeTransaccion(){");
                        out.println("alert('Transaccion no Procesada........')");
                        out.println("} mensajeTransaccion();");
                        out.println("</script>");
                        modelo.getCon().rollback();
                    }
                }

                //se convierte a entero para mandarlo como parametro de entrada en el metodo que lista los tramites asociados a la clase.
                int id = Integer.parseInt(opcion);
                out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                        + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                        + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                        + "<a href='#' id='agregar' title='Asociar Concepto' onclick='asociarConceptoTramite()'><img align='bottom' src='../html/images/adicionar.png'  height='25' width='25' alt='Asociar Concepto'/></a>&nbsp;&nbsp;");

                out.println("<h6 align='center'>Lista de conceptos asociados al tramite</h6>");
                //Los campos de busqueda se muestran en una tabla independiente
                out.println("<table align='center' width='40%' border='1' >  ");
                out.println("<tr>");
                out.println("<td> <b> ID del Concepto </b> </td>");
                out.println("<td> <b> Nombre del Concepto </b> </td>");
                out.println("<td>  <b> valor Actual </b> </td> ");
                out.println("<td>  <b> Numero de SMDLV </b> </td> ");
                out.println("<td>  <b> Nuevo Valor </b> </td> ");
                out.println("<td>  <b> Actualizar Concepto </b> </td> ");
                out.println("<td>  <b> Quitar Concepto </b> </td> ");
                out.println("</tr>");

                //pasamos el id como parametro de entrada al metodo listarTramitesAsociados
                java.util.List hm = modelo.listarConceptosAsociados(id);
                for (int i = 0; i < hm.size(); i++) {
                    HashMap hash = (HashMap<String, String>) hm.get(i);
                    out.println("<tr>");
                    out.println("<td><input type='hidden' id='concep" + i + "' value='" + hash.get("ID_CONCEPTO") + "' />" + hash.get("ID_CONCEPTO") + "  </td>");
                    out.println("<td>" + hash.get("NOMBRE") + "  </td>");
                    out.println("<td ><input type='text' readonly='readonly' id='valant" + i + "' value='" + hash.get("VALOR") + "' style='width:80px;'/></td>");
                    out.println("<td> <input type='text' style='width:80px;' onkeypress='return soloNumeros(event)' id='salario" + i + "' onblur='calcularValor(salario" + i + ",valor" + i + ")'/>  </td> ");
                    out.println("<td> <input type='text'  style='width:80px;' onkeypress='return soloNumeros(event)' id='valor" + i + "' />  </td> ");
                    out.println("<td ><input type='submit'  id='btn" + i + "' value='Guardar' onclick='mandarId(valor" + i + ",concep" + i + ",salario" + i + ",valant" + i + ",btn" + i + ")'/> </td> ");
                    out.println("<td ><input type='submit'  id='btnQ" + i + "' value='Quitar' onclick='quitarConcepto(concep" + i + ")'/> </td> ");
                    out.println("</tr>");
                }

                out.println(" </table> ");  //Fin de campos de busqueda

                out.println("<input type='hidden' value='" + id + "'id='fk_tramite'/>");

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
            Logger.getLogger(ListaConceptos.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(ListaConceptos.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ListaConceptos.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(ListaConceptos.class.getName()).log(Level.SEVERE, null, ex);
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
