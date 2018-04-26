/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package procesos;
import java.io.*;
import java.sql.*;
import java.util.Calendar;
import java.util.LinkedList;
import java.util.HashMap;
import oracle.*;
import java.util.Iterator;
import java.util.GregorianCalendar;
/************************/
import java.sql.SQLException;
import modelo.*;
import java.util.List;
import java.util.Iterator;
import java.io.File;
import java.util.StringTokenizer;
import javax.swing.JOptionPane;
import org.apache.axis.session.Session;
import org.apache.commons.fileupload.servlet.*;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.*;
/**
 *
 * @author acer
 */
public class ComparendoFisico {
  private transient Connection con;
public void CargarCompFisico(javax.servlet.http.HttpServletRequest request, modelo.Model model, modelo.Usuario usu){
        String fileName = "";
        try {
            String archivo = "";
            String fallo="";
            System.out.println("/*----*/");
            if (ServletFileUpload.isMultipartContent(request)) {
                System.out.println("/*----*/");
                ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                List fileItemsList = servletFileUpload.parseRequest(request);
                org.apache.commons.fileupload.FileItem fileItem = null;
                Iterator it = fileItemsList.iterator();
                while (it.hasNext()) {
                    FileItem fileItemTemp = (FileItem) it.next();
                    if (fileItemTemp.isFormField()) {
                        System.out.println("/*--"+fileItemTemp.getFieldName()+"--*/");
                        if (fileItemTemp.getFieldName().equals("filename")) {
                            archivo = fileItemTemp.getString();
                            //Audiencia_fallo(archivo,model,usu);
                        }
                    } else {
                        fileItem = fileItemTemp;
                    }
                }
                if (fileItem != null) {
                    if (fileItem.getSize() > 0) {
                        fileName = "C:/Comparendos/Fisico/"+archivo+".pdf";
                        File saveTo = new File(fileName);
                        try {
                            fileItem.write(saveTo);
                            java.io.FileInputStream fis = new java.io.FileInputStream(saveTo);
                            java.io.DataInputStream dis = new java.io.DataInputStream(fis);
                            String linea = "";
                            model.getCon().setAutoCommit(false);
                            int cont = 0;
                            int cont1 = 0;
                            System.out.println("cantidad guardada: "+cont);
                            System.out.println("cantidad no guardada : "+cont1);
                            model.getCon().commit();
                          } catch (Exception e) {
                            e.printStackTrace();
                            model.getCon().rollback();

                        }
                    }
                }
            }
            System.out.println("Archivo -- funciono = /*"+archivo+"*/");
           //Audiencia_fallo(archivo);
        } catch (Exception excw) {
            excw.printStackTrace();
        }
}
}