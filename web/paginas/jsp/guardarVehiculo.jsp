
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="modelo.*"%>
<%@page import="java.util.*"%>

<%
/**
 * @author EOAchury VI-MMXII
 */

Model modelo= (Model)session.getAttribute("model");
modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
Respuesta_Solicitud respuestaS = new Respuesta_Solicitud();
 java.sql.Timestamp fechaSystem= new java.sql.Timestamp(new java.util.Date().getTime());
 java.sql.Date fechaRespuesta = new java.sql.Date(new java.util.Date().getTime());
      	if(request.getParameter("ni")!=null && request.getParameter("placa")!= ""){
               String placa = request.getParameter("placa");

               int numeroF = modelo.consultarConsecutivo(234, 9, java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
               String numeroReal = "0000000".substring(0,7-String.valueOf(numeroF).length())+String.valueOf(numeroF);

                respuestaS.setNum_oficioRespuesta(numeroReal);
                respuestaS.setFecha_proceso(fechaSystem);
                respuestaS.setEstado(1);
                respuestaS.setFecha_oficioRespuesta(fechaRespuesta);
                respuestaS.setFk_solicitud_Oficio(Long.parseLong(request.getParameter("ni")));
                respuestaS.setFk_usuario(usuario.getId_usuario());
                respuestaS.setOficio_comercial(request.getParameter("oficioC"));
//System.out.println(numeroReal);
               // Respuesta_Solicitud R_solicitud = modelo.consultarRespuestaSolicitud(numeroReal);
     
     java.util.List<Respuesta_Solicitud> list = modelo.ConsultarRS(numeroReal);
               if(list.size()==0){
                  modelo.adicionarRespuestaSolicitud(respuestaS);
                  modelo.getCon().commit();
               }
                    Respuesta_Solicitud R_solicitud2 = modelo.consultarRespuestaSolicitud(Long.parseLong(request.getParameter("ni")));

                      Detalle_Respuesta D_Respuesta = modelo.consultarRespuestaDetalle(placa,R_solicitud2.getId_oficioRespuesta());
                        if (D_Respuesta == null){
                            Vehiculo vehiculo = modelo.consultarVehiculo(placa);
                            String respuesta = "";
                            if(vehiculo!=null){
                                respuesta = "S";
                                modelo.adicionarDetalleRespuestaSolicitud(R_solicitud2.getId_oficioRespuesta(), placa, respuesta, "","");
                                modelo.getCon().commit();
                               // modelo.actualizarEstadoOficio(Long.parseLong(request.getParameter("ni")));
                                %> <span class="Estilo1">Vehiculo Registrado</span><%
                           }else{
                                respuesta = "N";
                                modelo.adicionarDetalleRespuestaSolicitud(R_solicitud2.getId_oficioRespuesta(), placa, respuesta, "","");
                                modelo.getCon().commit();
                              //   modelo.actualizarEstadoOficio(Long.parseLong(request.getParameter("ni")));
                                %> <span class="Estilo1">Veh. no Registrado</span><%
                           }
                         }else{
                         %> <span class="Estilo1">Vehiculo ya esta registrado</span><%
                        }
                      //  listaPlacas.jsp?cantVeh=2&id_oficio=1237&oficioC=77
                   
	}else{
                %> <span class="Estilo1">Campo Placa Vacio</span><%
        }

%>