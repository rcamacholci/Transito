/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conf.session.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.*;

/**
 *
 * @author acadrasco
 */
public class procesarTasaUsura extends HttpServlet {

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
        System.out.println("Estoy aqui.....");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Model modelo = (Model) request.getSession().getAttribute("model");///
        Usuario user = (Usuario) request.getSession().getAttribute("usuario");
        java.util.Date utilDate = new java.util.Date();
        java.sql.Date fechaRegistro = new java.sql.Date(utilDate.getTime());
        Calendar cal = Calendar.getInstance();
        int yearServer = cal.get(Calendar.YEAR);
        int mesServer = (cal.get(Calendar.MONTH));
        mesServer = mesServer + 1;
        try {

            if (request.getParameter("vigencia") != null && request.getParameter("mes") != null && request.getParameter("tasa") != null) {
                //Recibo los parametros
                String vigencia = request.getParameter("vigencia");
                int vigenciaActual = Integer.parseInt(vigencia);
                System.out.println("Vigencia " + vigenciaActual);
                String mes = request.getParameter("mes");//recibe el parametro.
                //System.out.println("Mes " + mes);
                String tasa = request.getParameter("tasa");
                // System.out.println("Tasa " + tasa);
                // System.out.println("Estoy aqui.....");
                boolean registro = false;
                int m1 = Integer.parseInt(mes);
                String Tasa[][] = modelo.getIntereses();//recorre los registros de la tabla de intereses                
                String fechaFinal = Tasa[modelo.consultarMaxCodigo() - 1][1];//obtiene la fecha final del ultimo registro insertado en la tabla intereses
                String year = fechaFinal.substring(6);//obtengo la vigencia actual del ultimo registro de la tabla intereses
                int yearTasa = Integer.parseInt(year);
                String month = fechaFinal.substring(0, 2); //obtengo el mes de la vigencia actual del ultimo registro de la tabla intereses
                int m2 = Integer.parseInt(month);

                //validar  vigencias
                //si la vigencia es menor que el año actual
                if (vigenciaActual < yearServer) {
                    out.println("</br><h5 align=\"center\">La vigencia no puede ser inferior al año en curso.</h5>");
                } //si la vigencia es mayor o mas años que el año actual.
                else if (vigenciaActual >= (yearServer + 2)) {
                    out.println("</br><h5 align=\"center\">La vigencia no debe ser superior por mas de un año.</h5>");

                } //si la vigencia es un año mayor que el año actual
                else if (vigenciaActual >= (yearServer + 1)) {
                    ///verificar si vigencia actual tiene la tasa de diciembre.
                    //si las tiene solo debe poder ingresar enero.                 
                    if (m2 < 12) {
                        out.println("</br><h5 align=\"center\">Tiene meses de la vigencia actual sin registrar, por favor ingrese la tasa de usura.</h5>");
                    } else if (m2 == 12 && m1 == 1) {
                        registro = modelo.IngresarTasaUsura(vigencia, mes, tasa, user, fechaRegistro);
                        if (registro == true) {
                            //Se ha registrado 
                            switch (m1) {
                                case 1:
                                    out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Enero de " + vigencia + ".</h5>");
                                    break;

                            }
                            modelo.getCon().commit();
                            out.println("<script language='JavaScript'>function redireccionarPagina() {\n"
                                    + "   window.top.location.href = \"inicio.jsp\";\n"
                                    + "}"
                                    + "setTimeout(\"redireccionarPagina()\", 5000);</script>");
                        } else {

                            out.println("</br><h5 align=\"center\">Ocurrio un problema tratando de registrar la tasa de usura.</h5>");
                        }

                    } else {

                        out.println("</br><h5 align=\"center\">Debe registrar la tasa del mes actual.</h5>");

                    }
                } //si la vigencia es igual al año en curso
                else if (vigenciaActual == yearTasa) {
                    //validar los meses
                    //si los meses son mayores o menores a los rangos considerados
                    if (m1 > 12 || m1 < 1) {
                        out.println("</br><h5 align=\"center\"> El mes suministrado no es valido.</h5>");
                    } ///si no evalua si ya existe la tasa de usura en la vigencia actual.
                    else {
                        //si se quiere ingresar las tasas de usura de dos meses seguidos mayores a la fecha actual 
                        if (m1 >= (mesServer + 2)) {
                            out.println("</br><h5 align=\"center\"> No se puede ingresar una tasa de usura superior al mes siguiente del que esta en curso.</h5>");
                        } //si el mes ingresado es menor que el de la vigencia actual
                        else if (m1 <= m2) {
                            switch (m1) {
                                case 1:
                                    out.println("</br><h5 align=\"center\">La Tasa de Usura del Mes de Enero de la vigencia " + vigencia + " ya existe." + "</h5>");
                                    break;
                                case 2:
                                    out.println("</br><h5 align=\"center\">La Tasa de Usura del Mes de Febrero de la vigencia " + vigencia + " ya existe." + "</h5>");
                                    break;
                                case 3:
                                    out.println("</br><h5 align=\"center\">La Tasa de Usura del Mes de Marzo de la vigencia " + vigencia + " ya existe." + "</h5>");
                                    break;
                                case 4:
                                    out.println("</br><h5 align=\"center\">La Tasa de Usura del Mes de Abril de la vigencia " + vigencia + " ya existe." + "</h5>");
                                    break;
                                case 5:
                                    out.println("</br><h5 align=\"center\">La Tasa de Usura del Mes de Mayo de la vigencia " + vigencia + " ya existe." + "</h5>");
                                    break;
                                case 6:
                                    out.println("</br><h5 align=\"center\">La Tasa de Usura del Mes de Junio de la vigencia " + vigencia + " ya existe." + "</h5>");
                                    break;
                                case 7:
                                    out.println("</br><h5 align=\"center\">La Tasa de Usura del Mes de Julio de la vigencia " + vigencia + " ya existe." + "</h5>");
                                    break;
                                case 8:
                                    out.println("</br><h5 align=\"center\">La Tasa de Usura del Mes de Agosto de la vigencia " + vigencia + " ya existe." + "</h5>");
                                    break;
                                case 9:
                                    out.println("</br><h5 align=\"center\">La Tasa de Usura del Mes de Septiembre de la vigencia " + vigencia + " ya existe." + "</h5>");
                                    break;
                                case 10:
                                    out.println("</br><h5 align=\"center\">La Tasa de Usura del Mes de Octubre de la vigencia " + vigencia + " ya existe." + "</h5>");
                                    break;
                                case 11:
                                    out.println("</br><h5 align=\"center\">La Tasa de Usura del Mes de Noviembre de la vigencia " + vigencia + " ya existe." + "</h5>");
                                    break;
                                case 12:
                                    out.println("</br><h5 align=\"center\">La Tasa de Usura del Mes de Diciembre de la vigencia " + vigencia + " ya existe." + "</h5>");
                                    break;
                                default:
                                    out.println("</br><h5 align=\"center\"> El mes suministrado no es valido</h5>");
                                    break;

                            }

                        } else {
                            //antes de registrar verificar que el mes anterior este. 
                            if (m1 > mesServer) {
                                //validar tasa de usura del mes anterior
                                if (mesServer == m2) {
                                    //si el mes para la tasa no esta entonces se ingresa la tasa de usura
                                    registro = modelo.IngresarTasaUsura(vigencia, mes, tasa, user, fechaRegistro);
                                    if (registro == true) {
                                        //Se ha registrado 
                                        switch (m1) {
                                            case 1:
                                                out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Enero de " + vigencia + ".</h5>");
                                                break;
                                            case 2:
                                                out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Febrero de " + vigencia + ".</h5>");
                                                break;
                                            case 3:
                                                out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Marzo de " + vigencia + ".</h5>");
                                                break;
                                            case 4:
                                                out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Abril de " + vigencia + ".</h5>");
                                                break;
                                            case 5:
                                                out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Mayo de " + vigencia + ".</h5>");
                                                break;
                                            case 6:
                                                out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Junio de " + vigencia + ".</h5>");
                                                break;
                                            case 7:
                                                out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Julio de " + vigencia + ".</h5>");
                                                break;
                                            case 8:
                                                out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Agosto de " + vigencia + ".</h5>");
                                                break;
                                            case 9:
                                                out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Septiembre de " + vigencia + ".</h5>");
                                                break;
                                            case 10:
                                                out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Octubre de " + vigencia + ".</h5>");
                                                break;
                                            case 11:
                                                out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Noviembre de " + vigencia + ".</h5>");
                                                break;
                                            case 12:
                                                out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Diciembre de " + vigencia + ".</h5>");
                                                break;
                                            default:
                                                out.println("</br><h5 align=\"center\"> El mes suministrado no es valido.</h5>");
                                                break;

                                        }
                                        modelo.getCon().commit();
                                        out.println("<script language='JavaScript'>function redireccionarPagina() {\n"
                                                + "   window.top.location.href = \"inicio.jsp\";\n"
                                                + "}"
                                                + "setTimeout(\"redireccionarPagina()\", 5000);</script>");
                                    } else {

                                        out.println("</br><h5 align=\"center\">Ocurrio un problema tratando de registrar la tasa de usura.</h5>");
                                    }

                                } else {
                                    out.println("</br><h5 align=\"center\"> La tasa de usura del mes anterior no esta registrada.</h5>");
                                }

                            } else {

                                //si el mes para la tasa no esta entonces se ingresa la tasa de usura
                                registro = modelo.IngresarTasaUsura(vigencia, mes, tasa, user, fechaRegistro);
                                if (registro == true) {
                                    //Se ha registrado 
                                    switch (m1) {
                                        case 1:
                                            out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Enero de " + vigencia + ".</h5>");
                                            break;
                                        case 2:
                                            out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Febrero de " + vigencia + ".</h5>");
                                            break;
                                        case 3:
                                            out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Marzo de " + vigencia + ".</h5>");
                                            break;
                                        case 4:
                                            out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Abril de " + vigencia + ".</h5>");
                                            break;
                                        case 5:
                                            out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Mayo de " + vigencia + ".</h5>");
                                            break;
                                        case 6:
                                            out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Junio de " + vigencia + ".</h5>");
                                            break;
                                        case 7:
                                            out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Julio de " + vigencia + ".</h5>");
                                            break;
                                        case 8:
                                            out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Agosto de " + vigencia + ".</h5>");
                                            break;
                                        case 9:
                                            out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Septiembre de " + vigencia + ".</h5>");
                                            break;
                                        case 10:
                                            out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Octubre de " + vigencia + ".</h5>");
                                            break;
                                        case 11:
                                            out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Noviembre de " + vigencia + ".</h5>");
                                            break;
                                        case 12:
                                            out.println("</br><h5 align=\"center\">Se ha registrado La Tasa de Usura del Mes de Diciembre de " + vigencia + ".</h5>");
                                            break;
                                        default:
                                            out.println("</br><h5 align=\"center\"> El mes suministrado no es valido.</h5>");
                                            break;

                                    }
                                    modelo.getCon().commit();
                                    out.println("<script language='JavaScript'>function redireccionarPagina() {\n"
                                            + "   window.top.location.href = \"inicio.jsp\";\n"
                                            + "}"
                                            + "setTimeout(\"redireccionarPagina()\", 5000);</script>");
                                } else {

                                    out.println("</br><h5 align=\"center\">Ocurrio un problema tratando de registrar la tasa de usura.</h5>");
                                }

                            }

                        }

                    }

                }

            }
        } catch (Exception e) {
            modelo.getCon().rollback();
            out.println("</br><h5 align=\"center\">Ocurrio un problema tratando de registrar la tasa de usura.</h5>");
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
            Logger.getLogger(procesarTasaUsura.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(procesarTasaUsura.class.getName()).log(Level.SEVERE, null, ex);
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
