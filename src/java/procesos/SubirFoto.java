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
public class SubirFoto {
private transient Connection con;
public void cargarPlanosPolca(javax.servlet.http.HttpServletRequest request, modelo.Model model, modelo.Usuario usu){
        String fileName = "";
        try {
            String archivo = "";
            String fallo="";
            //System.out.println("------ok------");
            if (ServletFileUpload.isMultipartContent(request)) {
                ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                List fileItemsList = servletFileUpload.parseRequest(request);
                org.apache.commons.fileupload.FileItem fileItem = null;
                Iterator it = fileItemsList.iterator();
                while (it.hasNext()) {
                    FileItem fileItemTemp = (FileItem) it.next();
                    if (fileItemTemp.isFormField()) {
                        //System.out.println("ok "+fileItemTemp.getFieldName());
                        if (fileItemTemp.getFieldName().equals("filename")) {
                            archivo = fileItemTemp.getString();
                            //Audiencia_fallo(archivo,model,usu);
                        }
                    } else {
                        fileItem = fileItemTemp;
                    }
                }
                ///////////////////////
                 org.apache.commons.fileupload.FileItem fileItem1 = null;
                 Iterator it1 = fileItemsList.iterator();
                while (it1.hasNext()) {
                    FileItem fileItemTemp = (FileItem) it1.next();
                    if (fileItemTemp.isFormField()) {
                        if (fileItemTemp.getFieldName().equals("fallo")) {
                            fallo = fileItemTemp.getString();
                            System.out.println("Archivo -5- funciono = /*"+fallo+"/");
                            Audiencia_fallo(archivo,model,usu,fallo);
                        }
                    } else {
                        fileItem1 = fileItemTemp;
                    }
                }
                ////////////////////////////
                if (fileItem != null) {
                    if (fileItem.getSize() > 0) {
                        fileName = "C:/Civitrans/transito/build/web/paginas/data/planes/" + archivo;
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
/**************************************************************************************************************************/
public void Audiencia_fallo(String archivo,modelo.Model model,modelo.Usuario usu,String fallo) throws SQLException{
        try{
        model.getCon();
        model.getCon().setAutoCommit(false);
        System.out.println("Archivo -|- funciono = /*"+archivo+"*/");
        String com = archivo.substring(0,archivo.length()-4);
        modelo.Comparendo comp = model.consultar_Comparendo(com);

        Long op = Long.parseLong(fallo);
        /****************************************/
            java.sql.Timestamp fechaSystem = new java.sql.Timestamp(new java.util.Date().getTime());
         // java.util.List<modelo.Cartera> tempAud = (java.util.List<modelo.Cartera>) session.getAttribute("TempAuditoria");
        //  for (modelo.Cartera c : tempAud) {
            long estado=op==1?7:4;
            modelo.auditoria_comparendo aud = new modelo.auditoria_comparendo();
         // System.out.println("ok vamos hace esto ->"+c.getReferencia());
            modelo.Comparendo temp = model.consultar_Comparendo(com);
            model.UpdateAditoriaComparendo(fechaSystem,temp.getId_comparendo());
            aud.setFk_comparendo(temp.getId_comparendo());
            aud.setFk_estado(1);
            aud.setFecha_proceso(fechaSystem);
            aud.setUsuario(usu.getId_usuario());
            aud.setEstado(estado);
            aud.setFecha_inicio(fechaSystem);
            aud.setFecha_fin(null);
            model.InsertAuditoriaComparendo(aud);
            model.UpdateSA(aud.getFk_comaprendo(),0);
            model.getCon().commit();
        // }
        /****************************************/

        System.out.println("Archivo -5- funciono = /*"+comp.getNumero()+"*/");
        }catch(Exception e){
           model.getCon().rollback();
           System.out.println("/*Archivo - funciono = "+e+"*/");  
        }
    }
/**************************************************************************************************************************/
}
