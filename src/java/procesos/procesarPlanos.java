/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package procesos;

/**
 *
 * @author Administrador
 */
import java.util.List;
import java.util.Iterator;
import java.io.File;
import java.sql.SQLException;
import java.util.StringTokenizer;
import org.apache.commons.fileupload.servlet.*;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.*;

public class procesarPlanos {

    public procesarPlanos(javax.servlet.http.HttpServletRequest request, modelo.Model model) throws Exception {

        String fileName = "";
        try {
            model.getCon().setAutoCommit(false);
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
                        fileName = "C:/Civitrans/transito/build/web/paginas/data/planes/" + archivo;
                        File saveTo = new File(fileName);
                        fileItem.write(saveTo);
                        java.io.FileInputStream fis = new java.io.FileInputStream(saveTo);
                        java.io.DataInputStream dis = new java.io.DataInputStream(fis);
                        String placa;
                        model.getCon().setAutoCommit(false);
                        model.refrescarPlacasPlano();
                        while ((placa = dis.readLine()) != null) {
                            System.out.println(placa);
                            StringTokenizer st = new StringTokenizer(placa, ",");
                            String pl = st.nextToken();
                            System.out.println(pl);
                            String sr = st.nextToken();
                            model.adicionarPlacaPlano(pl.toUpperCase().trim(), sr);
                        }
                        model.getCon().commit();
                        generarPlano generarPlano = new generarPlano(model);
                    }
                }
            }
        } catch (Exception excw) {
            excw.printStackTrace();
        }
    }
}
