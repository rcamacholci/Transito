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
import org.apache.commons.fileupload.servlet.*;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;

/**
 *
 * @author Civitrans
 */
public class procesarRecaudoExterno {

    public procesarRecaudoExterno(javax.servlet.http.HttpServletRequest request, modelo.Model model,modelo.Usuario usuario) {

        String fileName ;
        try {
            if (ServletFileUpload.isMultipartContent(request)) {
                ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                List fileItemsList = servletFileUpload.parseRequest(request);
                org.apache.commons.fileupload.FileItem fileItem = null;
                Iterator it = fileItemsList.iterator();
                while (it.hasNext()) {
                    FileItem fileItemTemp = (FileItem) it.next();
                    if (fileItemTemp.isFormField()) {
                        if (fileItemTemp.getFieldName().equals("filename")) {
                            //String archivo = fileItemTemp.getString();
                        }
                    } else {
                        fileItem = fileItemTemp;
                    }
                }
                if (fileItem != null) {
                    if (fileItem.getSize() > 0) {
                        fileName = "C:/Civitrans/transito/build/web/paginas/data/pagosExternos/"+fileItem.getName();
                        File saveTo = new File(fileName);
                        try {
                            fileItem.write(saveTo);
                            aplicarPagosExternos aplicarPagosExternos = new procesos.aplicarPagosExternos(model, usuario, saveTo);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        } catch (Exception excw) {
            excw.printStackTrace();
        }
    }

}
