/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package procesos;
import java.util.List;
import java.util.Iterator;
import java.io.File;
import java.util.StringTokenizer;
import javax.swing.JOptionPane;
import org.apache.commons.fileupload.servlet.*;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.*;
import modelo.*;

 /*
 * @author Desarrollo
 */
public class RespuestaSolicitud {

  public RespuestaSolicitud(javax.servlet.http.HttpServletRequest request,  Model model, Usuario usuario) {      

        String fileName = "";
        try {
            String archivo = "";
            String idcodigo = "";
            String oficioC = "";
            String num="";
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
                        if (fileItemTemp.getFieldName().equals("num")) {
                            num = fileItemTemp.getString();
                        }
                        if (fileItemTemp.getFieldName().equals("idOficio")) {
                            idcodigo = fileItemTemp.getString();
                        }
                        if (fileItemTemp.getFieldName().equals("oficioC")) {
                            oficioC = fileItemTemp.getString();
                        }

                    } else {
                        fileItem = fileItemTemp;
                    }
                }
                if (fileItem != null) {
                    if (fileItem.getSize() > 0) {
                        fileName = "C:/Civitrans/" + archivo;
                        File saveTo = new File(fileName);
                        try {
                            fileItem.write(saveTo);
                            java.io.FileInputStream fis = new java.io.FileInputStream(saveTo);
                            java.io.DataInputStream dis = new java.io.DataInputStream(fis);
                            String linea = "";
                             model.getCon().setAutoCommit(false);
                            int cont = 0;
                            int cont1 = 0;
                            while ((linea = dis.readLine()) != null) {
                            //inico while
// Usuario usuario = (Usuario)session.getAttribute("usuario");
java.util.List lista = obtenerCampos(linea);
String campo = "";
String tipoD = "";
System.out.println("Num: "+num);
if(num.equals("1")){
    campo = lista.get(0).toString(); System.out.println("CAMPO : "+campo);
}else{
    campo = lista.get(0).toString(); System.out.println("CAMPO : "+campo);
    tipoD = lista.get(1).toString(); System.out.println("TIPO DOCUMENTO : "+tipoD);
    if(tipoD.equals("C")){
        tipoD="1";
    }else if (tipoD.equals("N")){
        tipoD="2";
    }else if (tipoD.equals("T")){
        tipoD="4";
    
    }else if(tipoD.equals("P")){
        tipoD="5";
    }else if (tipoD.equals("E")){
        tipoD="3";
    }
}
if(!campo.equals("CEDULA")){
    System.out.println("Dline"+ campo);
    System.out.println("NUm :"+num);   
    String mensaje ="";
Respuesta_Solicitud respuestaS = new Respuesta_Solicitud();
 java.sql.Timestamp fechaSystem= new java.sql.Timestamp(new java.util.Date().getTime());
 java.sql.Date fechaRespuesta = new java.sql.Date(new java.util.Date().getTime());    
        
        if(!idcodigo.equals("")){
            System.out.println("idOficio :"+ idcodigo);
            if(!oficioC.equals("")){
            System.out.println("oficioC :"+oficioC);    
            int numeroF = model.consultarConsecutivo(usuario.getFk_sede(), 9, java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
            String numeroReal = "0000000".substring(0,7-String.valueOf(numeroF).length())+String.valueOf(numeroF);
            System.out.println("numeror :"+numeroReal);   
            respuestaS.setNum_oficioRespuesta(numeroReal);
            model.actualizarConsecutivo(usuario.getFk_sede(), 9, java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
            respuestaS.setFecha_proceso(fechaSystem);
            respuestaS.setEstado(1);
            respuestaS.setFecha_oficioRespuesta(fechaRespuesta);
            respuestaS.setFk_solicitud_Oficio(Long.parseLong(idcodigo));
            respuestaS.setFk_usuario(usuario.getId_usuario());
            respuestaS.setOficio_comercial(oficioC);
             model.adicionarRespuestaSolicitud(respuestaS);
            Respuesta_Solicitud R_solicitud =model.consultarRespuestaSolicituds(numeroReal);
            
            if(num.equals("1")){
                int j = 1;
                    //while(j<=Integer.parseInt(request.getParameter("cantidad"))&&(request.getParameter("placa"+j))!=null){
                        //String placa = request.getParameter("placa"+j);
                        Vehiculo vehiculo =  model.consultarVehiculo(campo);
                        String respuesta = "";
                            if(vehiculo!=null){
                                respuesta = "S";
                            }else{
                                respuesta = "N";
                            }
                     model.adicionarDetalleRespuestaSolicitud(R_solicitud.getId_oficioRespuesta(), campo, respuesta, "","");
                     model.actualizarEstadoOficio(Long.parseLong(idcodigo));
                     model.getCon().commit();
                    j++;
                    //}
            }else{
                 int j = 1;
                   // while(j<=Integer.parseInt(request.getParameter("cantidad"))&&(request.getParameter("documento"+j))!=null&&(request.getParameter("tipoDoc"+j))!=null&&(request.getParameter("nombre"+j))!=null){
                        //int tipoDoc = Integer.parseInt(request.getParameter("tipoDoc"+j));
                        //String nombre = request.getParameter("nombre"+j);
                        //String documento = request.getParameter("documento"+j);
                        Persona persona =  model.consultarPersona(Integer.parseInt(tipoD), campo);
                        //Persona persona = model.consultarPersonaDocu(campo);
                        if (persona!=null){
                            System.out.println("Persona");   
                        String nombre =persona.getNombre_1()+" "+persona.getApellido_1();
                        String documento = persona.getDocumento();
                            List  pers_vehiculo =  model.Listar_Propietarios(persona.getId_persona());
                            if(pers_vehiculo.size()!=0){
                                Iterator itt = pers_vehiculo.iterator();
                                while (itt.hasNext()) {                                   
                                    Propietario propietario= (Propietario)itt.next();
                                       if(propietario.getFecha_final()==null){
                                            Vehiculo vehiculo= model.consultarVehiculoById(propietario.getFk_vehiculo());
                                            String respuesta = "";
                                            if(vehiculo!=null){
                                                respuesta = "S";
                                            }else{
                                                respuesta = "N";
                                            }
                                         model.adicionarDetalleRespuestaSolicitud(R_solicitud.getId_oficioRespuesta(),persona.getTipo_documento()==1?"C "+documento:"N "+documento, respuesta, vehiculo!=null?vehiculo.getPlaca():"",persona.getNombre_1()+" "+persona.getApellido_1());
                                         model.actualizarEstadoOficio(Long.parseLong(idcodigo));
                                            }else{
                                             model.adicionarDetalleRespuestaSolicitud(R_solicitud.getId_oficioRespuesta(),persona.getTipo_documento()==1?"C "+documento:"N "+documento,"N","",persona.getNombre_1()+" "+persona.getApellido_1());
                                             model.actualizarEstadoOficio(Long.parseLong(idcodigo));
                                             model.getCon().commit();
                                        }
                                }
                          }else{
                                  model.adicionarDetalleRespuestaSolicitud(R_solicitud.getId_oficioRespuesta(),persona.getTipo_documento()==1?"C "+documento:"N "+documento, "N","",nombre);
                                  model.actualizarEstadoOficio(Long.parseLong(idcodigo));
                                  model.getCon().commit();
                          }
                          
                       
                        }else{
                             model.adicionarDetalleRespuestaSolicitud(R_solicitud.getId_oficioRespuesta(),Integer.parseInt(tipoD)==1?"C "+campo:"N "+campo, "N","","NO REGISTRA");
                             model.actualizarEstadoOficio(Long.parseLong(idcodigo));
                             model.getCon().commit();
                        }
                    j++;
                 //}
            }                // fin si num

             model.getCon().commit();
       
        
      
       }else{
            System.out.println("No encontro el numero de oficio comercial");
       }
     }else{
        System.out.println("No encontro el oficio de solicitud");
     }

                     
}//end if 
}
                            
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
    }

     public java.util.List obtenerCampos(String text){
        java.util.List lista = new java.util.LinkedList();
        int start = 0;
        int end = 0;
        while(true){
            end = text.indexOf(";", start);
            if(end!=-1){
                lista.add(text.substring(start, end));
                start = end+1;
            }else{
                lista.add(text.substring(start, text.length()));
                break;
            }

        }
        return lista;
    }


}
