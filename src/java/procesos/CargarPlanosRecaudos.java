/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package procesos;

import java.io.File;
import java.io.InputStreamReader;
import java.util.Iterator;
import java.util.List;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author ZEE
 */
public class CargarPlanosRecaudos {

    private static final int END = -1;
    private static final int SIMPLE_INCREMENT = 1;

    public boolean cargarPlanoRecaudo(javax.servlet.http.HttpServletRequest request, modelo.Model model) {

        String fileName = "";
        try {
            String archivo = "";
            if (ServletFileUpload.isMultipartContent(request)) {
                ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                List fileItemsList = servletFileUpload.parseRequest(request);
                org.apache.commons.fileupload.FileItem fileItem = null;
                Iterator it = fileItemsList.iterator();
                while (it.hasNext()) {
                    FileItem fileItemTemp = (FileItem) it.next();
                    if (fileItemTemp.isFormField()) {
                        if (fileItemTemp.getFieldName().equals("filename")) {
                            archivo = fileItemTemp.getString();
                        }
                    } else {
                        fileItem = fileItemTemp;
                    }
                }
                if (fileItem != null) {
                    if (fileItem.getSize() > 0) {

                        File fileUrl = new File("C:/Civitrans/transito/build/web/paginas/data/planes/");

                        fileName = "C:/Civitrans/transito/build/web/paginas/data/planes/" + archivo;

                        if (!fileUrl.exists()) {
                            fileUrl.mkdirs();
                        }

                        File saveTo = new File(fileName);

                        if (!saveTo.exists()) {
                            saveTo.createNewFile();
                        }

                        try {
                            fileItem.write(saveTo);
                            java.io.FileInputStream fis = new java.io.FileInputStream(saveTo);
                            java.io.BufferedReader  dis = new java.io.BufferedReader(new InputStreamReader(fis));
                            
                            String linea = "";
                            model.getCon().setAutoCommit(false);
                            int cont = 0;
                            int cont1 = 0;
                            dis.readLine() ;
                            
                            while ((linea = dis.readLine()) != null) {
                                java.util.List lista = obtenerCampos(linea);   
                            }

                            System.out.println("cantidad guardada: " + cont);
                            System.out.println("cantidad no guardada : " + cont1);
                            model.getCon().commit();
                        } catch (Exception e) {
                            e.printStackTrace();
                            model.getCon().rollback();

                        }
                    }
                }
            }
        } catch (Exception excw) {
            excw.printStackTrace();
        }
        
        return true ;
        
    }

    /* Metodo que extrae en forma de lista ( LinkedList ) los datos del 
     * de la linea del archivo plano enviada por parametro.
     */
    public java.util.List obtenerCampos(String line) {

        // Declaracion de variables.
        java.util.List lista = new java.util.LinkedList();
        int start = 0;
        int end = 0;
        int length = 0;

        // Se define un ciclo indefinido.
        while (true) {

            end = line.indexOf(",", start);

            if (end != END) {

                lista.add(line.substring(start, end));
                start = end + SIMPLE_INCREMENT;

            } else {

                length = line.length();
                lista.add(line.substring(start, length));
                break;

            }

        }
        return lista;
    }
}
