/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conf.session.servlet;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.StringTokenizer;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Model;
import modelo.Sede;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import procesos.generarPlano;

/**
 *
 * @author acadrasco
 */
public class procesarPlanoFestivos extends HttpServlet {

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
            throws ServletException, IOException, SQLException, FileUploadException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Model modelo = (Model) request.getSession().getAttribute("model");///
        Sede sede = (Sede) request.getSession().getAttribute("sede");
        String fileName = "";
        final String SEPARADOR = ",";
        String[] campos;
        BufferedReader bufferLectura = null;
        try {
            String rutafile = "C:/Civitrans/transito/build/web/paginas/data/festivos/";
            String vector[] = new String[1];
            /*FileItemFactory es una interfaz para crear FileItem*/
            FileItemFactory file_factory = new DiskFileItemFactory();

            /*ServletFileUpload esta clase convierte los input file a FileItem*/
            ServletFileUpload servlet_up = new ServletFileUpload(file_factory);
            /*sacando los FileItem del ServletFileUpload en una lista */
            //request.setCharacterEncoding("UTF-8");  
            servlet_up.setSizeMax(1024 * 1024 * 5);//tamaño máximo de los archivos 5 MB 

            List items = servlet_up.parseRequest(request);
            /*declaramos un hashmap donde guardaremos los parametros*/
            //String apellido = request.getParameter("primerapellido");
            //System.out.println("apellido:"+apellido);
            HashMap<Object, Object> parametros = new HashMap<Object, Object>();
            String valor = "", codigo = "", codigoCarpeta = "";
            File archivo_server = null;
            for (int i = 0; i < items.size(); i++) {
                /*FileItem representa un archivo en memoria que puede ser pasado al disco duro*/
                FileItem item = (FileItem) items.get(i);

                if (item.isFormField()) {

                    valor = item.getString();

                    System.out.println("Nombre campo:" + item.getFieldName());
                    System.out.println("Valor campo:" + valor);
                    if (item.getFieldName().equals("numdoc")) {
                        codigo = item.getString() + "-" + (new Date().getTime());
                        System.out.println(codigo);
                        vector[0] = codigo;
                    }

                } else {
                    for (int y = 0; y < vector.length; y++) {
                        System.out.println(vector[y]);
                        codigoCarpeta = vector[y];
                    }
                    /*creamos un nombre, para que no se sobre-escriban archivos*/
                    valor = item.getName();
                    /*cual sera la ruta al archivo en el servidor*/

                    File carpeta = new File(rutafile);
                    System.out.println(carpeta);
                    carpeta.mkdirs();
                    archivo_server = new File(carpeta, valor);

                    /*y lo escribimos en el servidor*/
                    item.write(archivo_server);
                    //le paso el valor de archivo_server para poder colocar el valor en el hashmap.
                    valor = archivo_server.toString();
                    System.out.println("Archivo nombre " + archivo_server.toString());
                    //FileInputStream fis = new FileInputStream(archivo_server);
                    //System.out.println("Este es el archivo" + fis); 

                }
            }

            try {
                // Abrir el .csv en buffer de lectura
                bufferLectura = new BufferedReader(new FileReader(archivo_server.toString()));

                // Leer una linea del archivo
                String linea = bufferLectura.readLine();
                out.println("<h6 align='center' class='style1'>Lista de Calendario Festivo Cargado</h6>");
                //Los campos de busqueda se muestran en una tabla independiente
                out.println("<table align='center' width='40%' border='1' >  ");
                out.println("<tr>");
                out.println("<td> <b> Fecha </b> </td>");
                out.println("<td> <b> Descripción </b> </td>");
                out.println("</tr>");
                while (linea != null) {
                    // Sepapar la linea leída con el separador definido previamente
                    campos = linea.split(SEPARADOR);
                    System.out.println("Campo0 " + campos[0]);
                    System.out.println("Campo1 " + campos[1]);
                    //conversion de fecha tipo String a date                
                    //System.out.println(Arrays.toString(campos));
                    boolean insert = modelo.registrarDiasFestivos(campos[0], campos[1], (int) sede.getId_sede());
                    if (insert == true) {
                        modelo.getCon().commit();
                    } else {
                        out.println("<script type=\"text/javascript\">");
                        out.println("function mensajeTransaccion(){");
                        out.println("alert('Error al registrar la fecha' " + campos[0] + " );");
                        out.println("} mensajeTransaccion();");
                        out.println("</script>");
                        modelo.getCon().rollback();
                    }
                    out.println("<tr>");
                    out.println("<td>  "+campos[0]+"  </td>");
                    out.println("<td>  "+campos[1]+"  </td>");
                   
                    out.println("</tr>");
                    // Volver a leer otra línea del fichero
                    linea = bufferLectura.readLine();
                }
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                // Cierro el buffer de lectura
                if (bufferLectura != null) {
                    try {
                        bufferLectura.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }

            /* TODO output your page here. You may use following sample code. */
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
        } catch (FileUploadException ex) {
            Logger.getLogger(procesarPlanoFestivos.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(procesarPlanoFestivos.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (FileUploadException ex) {
            Logger.getLogger(procesarPlanoFestivos.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(procesarPlanoFestivos.class.getName()).log(Level.SEVERE, null, ex);
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
