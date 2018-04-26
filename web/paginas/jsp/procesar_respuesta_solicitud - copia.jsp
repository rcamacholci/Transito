<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<script language="javascript" type="text/javascript">

     function verReporte(){
                //document.form.motor.value
                ancho = 789;
                alto = 600;
                barra = 0;
                izquierda = (document.width) ? (document.width-ancho)/2 : 100;
                arriba = (document.height) ? (document.height-alto)/2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + 			ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "solicitudes/solicitudV.jasper";
                var nombre = "solicitud";
                url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
                window.open(url, 'popUp', opciones);
            }
</script>
</head>

<body>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%

Model modelo= (Model)session.getAttribute("model");
modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
String mensaje ="";
Respuesta_Solicitud respuestaS = new Respuesta_Solicitud();
 java.sql.Timestamp fechaSystem= new java.sql.Timestamp(new java.util.Date().getTime());
 java.sql.Date fechaRespuesta = new java.sql.Date(new java.util.Date().getTime());
try{
    modelo.getCon().setAutoCommit(false);

    if(request.getParameter("cantidad")!=null){
        if(request.getParameter("idOficio")!=null){
            if(request.getParameter("oficioC")!=null){
            int numeroF = modelo.consultarConsecutivo(234, 9, java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
            String numeroReal = "0000000".substring(0,7-String.valueOf(numeroF).length())+String.valueOf(numeroF);
            respuestaS.setNum_oficioRespuesta(numeroReal);
            modelo.actualizarConsecutivo(234, 9, java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
            respuestaS.setFecha_proceso(fechaSystem);
            respuestaS.setEstado(1);
            respuestaS.setFecha_oficioRespuesta(fechaRespuesta);
            respuestaS.setFk_solicitud_Oficio(Long.parseLong(request.getParameter("idOficio")));
            respuestaS.setFk_usuario(usuario.getId_usuario());
            respuestaS.setOficio_comercial(request.getParameter("oficioC"));
           // modelo.adicionarRespuestaSolicitud(respuestaS);
       //  Respuesta_Solicitud R_solicitud = modelo.consultarRespuestaSolicitud(numeroReal);
            if(request.getParameter("num").equals("1")){
              /*  int j = 1;
                    while(j<=Integer.parseInt(request.getParameter("cantidad"))&&(request.getParameter("placa"+j))!=null){
                        String placa = request.getParameter("placa"+j);
                        Vehiculo vehiculo = modelo.consultarVehiculo(placa);
                        String respuesta = "";
                            if(vehiculo!=null){
                                respuesta = "S";
                            }else{
                                respuesta = "N";
                            }
                    modelo.adicionarDetalleRespuestaSolicitud(R_solicitud.getId_oficioRespuesta(), placa, respuesta, "","");

                    modelo.getCon().commit();
                    j++;
                    }*/
                 modelo.actualizarEstadoOficio(Long.parseLong(request.getParameter("idOficio")));
            }else{
                modelo.actualizarEstadoOficio(Long.parseLong(request.getParameter("idOficio")));
                /*
                 int j = 1;
                    while(j<=Integer.parseInt(request.getParameter("cantidad"))&&(request.getParameter("documento"+j))!=null&&(request.getParameter("tipoDoc"+j))!=null&&(request.getParameter("nombre"+j))!=null){
                        int tipoDoc = Integer.parseInt(request.getParameter("tipoDoc"+j));
                        String nombre = request.getParameter("nombre"+j);
                        String documento = request.getParameter("documento"+j);
                        Persona persona = modelo.consultarPersona(tipoDoc, documento);
                        int sw =0;
                        if (persona!=null){
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
                                            }else{
                                                respuesta = "N";
                                            }
//                                        modelo.adicionarDetalleRespuestaSolicitud(R_solicitud.getId_oficioRespuesta(),tipoDoc==1?"C "+documento:"N "+documento, respuesta, vehiculo!=null?vehiculo.getPlaca():"",persona.getNombre_1()+" "+persona.getApellido_1());
                                            modelo.actualizarEstadoOficio(Long.parseLong(request.getParameter("idOficio")));
                                            modelo.getCon().commit();

                                        }else{
                                        Vehiculo vehiculo=modelo.consultarVehiculoById(propietario.getFk_vehiculo());
 //                                       modelo.adicionarDetalleRespuestaSolicitud(R_solicitud.getId_oficioRespuesta(),tipoDoc==1?"C "+documento:"N "+documento,"T", vehiculo!=null?vehiculo.getPlaca():"",persona.getNombre_1()+" "+persona.getApellido_1());
                                        modelo.actualizarEstadoOficio(Long.parseLong(request.getParameter("idOficio")));
                                        modelo.getCon().commit();
                                    }
                                }
                          }else{
 //                                modelo.adicionarDetalleRespuestaSolicitud(R_solicitud.getId_oficioRespuesta(),tipoDoc==1?"C "+documento:"N "+documento, "N","",nombre);
                                 modelo.actualizarEstadoOficio(Long.parseLong(request.getParameter("idOficio")));
                                 modelo.getCon().commit();
                          }


//                        }else{
                            modelo.adicionarDetalleRespuestaSolicitud(R_solicitud.getId_oficioRespuesta(),tipoDoc==1?"C "+documento:"N "+documento, "N","",nombre);
                            modelo.actualizarEstadoOficio(Long.parseLong(request.getParameter("idOficio")));
                            modelo.getCon().commit();
                        }
                    j++;
                 }*/
            }                // fin si num

            modelo.getCon().commit();             %>
            <script language="javascript" type="text/javascript">
			alert("Respuesta a Solicitud Generada Exitosamente");
            </script>
      <%



       }else{
            mensaje = "No encontro el numero de oficio comercial";
       }
     }else{
         mensaje = "No encontro el oficio de solicitud";
     }

    }else{
           mensaje= "Respuesta a solicitud No pudo ser Realizada con Exito";
    }

    if(request.getParameter("idOficio")!=null){
         HashMap parameters = new java.util.HashMap();
         parameters.put("ID_OFICIO",Long.parseLong(request.getParameter("idOficio")));
         parameters.put("OFICIO_COMERCIAL",request.getParameter("oficioC"));
         parameters.put("FECHA_OFICIO_RESPUESTA",fechaRespuesta);
         Persona usu = modelo.consultarPersona(usuario.getFk_persona());
         Cargo cargo = modelo.consultarCargoByUsuario(usuario.getId_usuario());
         Parametro grupo = modelo.consultarParametro((int)cargo.getGrupo_cargo(), 358);
         Parametro carg = modelo.consultarParametro((int)cargo.getCargo(),359);

         if(usu!=null){
            parameters.put("GRUPOCARGO",grupo.getNombre());
            parameters.put("CARGO",carg.getNombre());
            parameters.put("USUARIO",usu.getNombre_1()+" "+usu.getApellido_1());
         }
            session.setAttribute("solicitud", parameters);
      %><script language="javascript" type="text/javascript">
            verReporte();
            window.parent.parent.location.href = "RadicacionSolicitudesOficios.jsp";
        </script><%
         }
%>


    <%
	}catch(Exception ecx){
		ecx.printStackTrace();        %>
		<script language="javascript" type="text/javascript">
			alert("Error en el proceso");
			window.location.href = "RadicacionSolicitudesOficios.jsp";
		</script>
<%  }

    if(!mensaje.equals("")){
        %>
        <script language="javascript" type="text/javascript">
            alert("Mensaje : <%=mensaje%>");
            window.location.href = "RadicacionSolicitudesOficios.jsp";
	</script>
   <% }


%>
</body>
</html>
