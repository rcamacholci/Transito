package inscripcion;

import java.util.List;
import java.util.Iterator;
import java.io.File;
import java.util.StringTokenizer;
import modelo.Direccion;
import modelo.Persona;
import org.apache.commons.fileupload.servlet.*;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.*;

/**
 *
 * @author Civitrans
 */
public class procesarDatos {

    String result = "";

    public procesarDatos(javax.servlet.http.HttpServletRequest request, modelo.Model model,modelo.Usuario usuario) {

        String fileName = "";
        String noLiquidacion = request.getParameter("noLiquidacion");
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
                        fileName = "C:/Civitrans/transito/build/web/paginas/data/personas/"+fileItem.getName();
                        File saveTo = new File(fileName);
                        try {
                            fileItem.write(saveTo);
                            java.io.FileInputStream fis = new java.io.FileInputStream(saveTo);
                            java.io.DataInputStream dis = new java.io.DataInputStream(fis);
                            String line = "";
                            while ((line = dis.readLine()) != null) {
                                try{
                                    StringTokenizer st = new StringTokenizer(line,"|");
                                    Persona p = new Persona();
                                    p.setId_persona(Long.parseLong(st.nextToken()));
                                    p.setFecha_nac(new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(st.nextToken()).getTime()));
                                    p.setGrupo_sanguineo(st.nextToken());
                                    p.setRh(st.nextToken());
                                    p.setSexo(st.nextToken());
                                    p.setNombre_1(st.nextToken().trim());
                                    p.setNombre_2(st.nextToken().trim());
                                    p.setApellido_1(st.nextToken().trim());
                                    p.setApellido_2(st.nextToken().trim());
                                    p.setTipo_documento(Integer.parseInt(st.nextToken()));
                                    p.setDocumento(st.nextToken());
                                    p.setFk_divipo(Long.parseLong(st.nextToken()));
                                    p.setFk_lugar_nacimiento(Long.parseLong(st.nextToken()));
                                    p.setFecha_exp(new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(st.nextToken()).getTime()));
                                    Direccion d = new Direccion();
                                    d.setDescripcion(st.nextToken());
                                    d.setTelefono(st.nextToken());
                                    d.setFk_divipo(Long.parseLong(st.nextToken()));
                                    inscripcion.registrarPersonaRunt ip = new inscripcion.registrarPersonaRunt(model);
                                    ip.inscribirPersona(p, d,noLiquidacion);
                                }catch(Exception exc){
                                    
                                }
                            }
                            dis.close();
                            fis.close();
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
