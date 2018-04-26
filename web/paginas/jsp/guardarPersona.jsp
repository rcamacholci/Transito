<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="modelo.*"%>
<%@page import="java.util.*"%>

<%
/**
 * @author EOAchury VI-MMXII
 */

try{

Model modelo= (Model)session.getAttribute("model");
modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
Respuesta_Solicitud respuestaS = new Respuesta_Solicitud();
 java.sql.Timestamp fechaSystem= new java.sql.Timestamp(new java.util.Date().getTime());
 java.sql.Date fechaRespuesta = new java.sql.Date(new java.util.Date().getTime());
      	if(request.getParameter("ni")!=null && request.getParameter("nombre")!= "" && request.getParameter("doc")!= ""){

               String doc = request.getParameter("doc");
               String nombre = request.getParameter("nombre");
               int tipoDoc = Integer.parseInt(request.getParameter("tido"));

                int numeroF = modelo.consultarConsecutivo(234, 9, java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
                String numeroReal = "0000000".substring(0,7-String.valueOf(numeroF).length())+String.valueOf(numeroF);

                respuestaS.setNum_oficioRespuesta(numeroReal);
                respuestaS.setFecha_proceso(fechaSystem);
                respuestaS.setEstado(1);
                respuestaS.setFecha_oficioRespuesta(fechaRespuesta);
                respuestaS.setFk_solicitud_Oficio(Long.parseLong(request.getParameter("ni")));
                respuestaS.setFk_usuario(usuario.getId_usuario());
                respuestaS.setOficio_comercial(request.getParameter("oficioC"));
System.out.println(numeroReal);
// Respuesta_Solicitud R_solicitud = modelo.consultarRespuestaSolicitud(numeroReal);

java.util.List<Respuesta_Solicitud> list = modelo.ConsultarRS(numeroReal);

   if(list.size()==0){
            modelo.adicionarRespuestaSolicitud(respuestaS);
            modelo.getCon().commit();
   }

Respuesta_Solicitud R_solicitud = modelo.consultarRespuestaSolicitud(Long.parseLong(request.getParameter("ni")));
Persona persona = modelo.consultarPersona(tipoDoc, doc);
if (persona!=null){

    Respuesta_Solicitud R_solicitud2 = modelo.consultarRespuestaSolicitud(Long.parseLong(request.getParameter("ni")));

    Detalle_Respuesta D_Respuesta = modelo.consultarRespuestaDetalle(tipoDoc==1?"C "+doc:"N "+doc,R_solicitud2.getId_oficioRespuesta());
    if (D_Respuesta == null){
                            List  pers_vehiculo = modelo.Listar_Propietarios(persona.getId_persona());
                            if(pers_vehiculo.size()!=0){
                                Iterator itt = pers_vehiculo.iterator();
                                while (itt.hasNext()){
                                    Propietario propietario= (Propietario)itt.next();

                                       if(propietario.getFecha_final()==null){
                                                Vehiculo vehiculo=modelo.consultarVehiculoById(propietario.getFk_vehiculo());
                                                String respuesta = "";
                                                if(vehiculo!=null){
                                                    respuesta = "S";
                                                    try{
                                                     modelo.adicionarDetalleRespuestaSolicitud(R_solicitud.getId_oficioRespuesta(),tipoDoc==1?"C "+doc:"N "+doc, respuesta, vehiculo!=null?vehiculo.getPlaca():"",persona.getNombre_1()+" "+persona.getApellido_1());
                                                     modelo.getCon().commit();
                                                     }catch (Exception ex){
                                                     System.out.println("Error en guardar persona(Radicar Solicitud de Ofiios): "+ex);
                                                     }
                                                     %> <span class="Estilo1">* Se encontro Vehiculo</span><%
                                                }else{
                                                    respuesta = "N";
                                                    try{
                                                     modelo.adicionarDetalleRespuestaSolicitud(R_solicitud.getId_oficioRespuesta(),tipoDoc==1?"C "+doc:"N "+doc, respuesta, vehiculo!=null?vehiculo.getPlaca():"",persona.getNombre_1()+" "+persona.getApellido_1());
                                                     modelo.getCon().commit();
                                                     }catch(Exception ex){
                                                     System.out.println("Error en guardar persona(Radicar Solicitud de Ofiios): "+ex);
                                                     }
                                                     %> <span class="Estilo1">* No se encontro vehiculo</span><%
                                                }

                                            //    modelo.actualizarEstadoOficio(Long.parseLong(request.getParameter("idOficio")));
                                               // modelo.getCon().commit();

                                        }else{
                                        Vehiculo vehiculo=modelo.consultarVehiculoById(propietario.getFk_vehiculo());
                                        try{
                                        modelo.adicionarDetalleRespuestaSolicitud(R_solicitud.getId_oficioRespuesta(),tipoDoc==1?"C "+doc:"N "+doc,"T", vehiculo!=null?vehiculo.getPlaca():"",persona.getNombre_1()+" "+persona.getApellido_1());
                                        modelo.getCon().commit();
                                        }catch(Exception ex){
                                        System.out.println("Error en guardar persona(Radicar Solicitud de Ofiios): "+ex);
                                        }
                                        %> <span class="Estilo1">* Ya no posee Vehiculo</span><%
                                  //      modelo.actualizarEstadoOficio(Long.parseLong(request.getParameter("idOficio")));
                                     //   modelo.getCon().commit();
                                    }
                                }
                          }else{
                                try{
                                 modelo.adicionarDetalleRespuestaSolicitud(R_solicitud.getId_oficioRespuesta(),tipoDoc==1?"C "+doc:"N "+doc, "N","",nombre);
                                 modelo.getCon().commit();
                                 }catch(Exception ex){
                                 System.out.println("Error en guardar persona(Radicar Solicitud de Ofiios): "+ex);
                                 }

                             //  modelo.actualizarEstadoOficio(Long.parseLong(request.getParameter("idOficio")));
                              //   modelo.getCon().commit();
                               %> <span class="Estilo1">* No posee vehiculo</span><%
                          }
        }else{
            %> <span class="Estilo1">* Persona ya esta Registrada en oficio</span><%
        }

}else{
    try{
    modelo.adicionarDetalleRespuestaSolicitud(R_solicitud.getId_oficioRespuesta(),tipoDoc==1?"C "+doc:"N "+doc, "N","",nombre);
    modelo.getCon().commit();
    }catch(Exception ex){
            System.out.println("Error en guardar persona(Radicar Solicitud de Ofiios): "+ex);
    }
   //   modelo.actualizarEstadoOficio(Long.parseLong(request.getParameter("idOficio")));
  //  modelo.getCon().commit();
     %> <span class="Estilo1">* No se encuentra persona</span><%
}


}

 }catch(Exception ex){
 System.out.println("Error en guardar persona(Radicar Solicitud de Ofiios): "+ex);
 }
%>