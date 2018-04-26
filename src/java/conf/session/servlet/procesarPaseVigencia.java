/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conf.session.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
public class procesarPaseVigencia extends HttpServlet {

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
            throws ServletException, IOException, ParseException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Model modelo = (Model) request.getSession().getAttribute("model");///
        Usuario user = (Usuario) request.getSession().getAttribute("usuario");
        java.util.Date utilDate = new java.util.Date();
        java.sql.Date fechaRegistro = new java.sql.Date(utilDate.getTime());
        //System.out.println("Fecha registro"+fechaRegistro);

        try {

            if (request.getParameter("valor") != null && request.getParameter("fkc") != null && request.getParameter("fkt") != null
                    && request.getParameter("resol") != null && request.getParameter("fhr") != null && request.getParameter("sede") != null) {

                //recibo los parametros y los asigno a variables
                String valor = request.getParameter("valor");
                String fkc = request.getParameter("fkc");
                String fkt = request.getParameter("fkt");
                String resol = request.getParameter("resol");
                String fecha = request.getParameter("fhr");
                //System.out.println("Fecha del for" + fecha);
                String sede = request.getParameter("sede");
                String ide =  request.getParameter("id");
                String ids =  request.getParameter("ids");
                String idvant =  request.getParameter("idvant");
                String idbtn =  request.getParameter("idbtn");

                //Convertimos a los tipos de datos que necesitamos para realizar el proceso de insercion
                //convercion a enteros y dobles
                int valorConcepto = Integer.parseInt(valor);
                int fk_concepto = Integer.parseInt(fkc);
                int fk_tramite = Integer.parseInt(fkt);
                int nResolucion = Integer.parseInt(resol);
                int sedeOT = Integer.parseInt(sede);

                //conversion de fecha tipo String a date
                SimpleDateFormat formatoDelTexto = new SimpleDateFormat("dd/MM/yyyy");
                java.util.Date fechaRes = formatoDelTexto.parse(fecha);
                java.sql.Date fechaResolucion = new java.sql.Date(fechaRes.getTime());
                //System.out.println("Fecha resol"+fechaResolucion);
                //metodos para realizar el update y la insercion de los conceptos
                //primero actualizo
                boolean update = modelo.ActualizarFechaFinVigencia(fechaRegistro, fk_tramite, fk_concepto);
                if (update == true) {
                    //insertar los registros nuevos
                    boolean insertar = modelo.registrarSedeTramitesConceptos(fk_concepto, fk_tramite, nResolucion, fechaResolucion, valorConcepto, sedeOT, user.getNombre(), fechaRegistro);
                    if (insertar == true) {
                        
                        out.println("<script type=\"text/javascript\">");
                        out.println("function mensajeTransaccion(){");
                        out.println("alert('Transaccion exitosa........');"); 
                        out.println("document.getElementById('"+ide+"').value = ' ';");
                        out.println("document.getElementById('"+ids+"').value = ' ';");
                        out.println("document.getElementById('"+idvant+"').value = '"+ valorConcepto+"';");
                        out.println("document.getElementById('"+idbtn+"').value = 'Actualizado';");
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
        } catch (ParseException ex) {
            Logger.getLogger(procesarPaseVigencia.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(procesarPaseVigencia.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ParseException ex) {
            Logger.getLogger(procesarPaseVigencia.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(procesarPaseVigencia.class.getName()).log(Level.SEVERE, null, ex);
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
