<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%

Model modelo= (Model)session.getAttribute("model");
modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
String mensaje ="";
long numero_interno = 0;
try{
    modelo.getCon().setAutoCommit(false);
    Reclamos_Pagos reclamo = new Reclamos_Pagos();
    long tra = 0;
    java.sql.Timestamp fechaSystem= new java.sql.Timestamp(new java.util.Date().getTime());
    java.sql.Date fecha = new java.sql.Date(new java.util.Date().getTime());
    Tiquete tiquete = new Tiquete();
        if((request.getParameter("pago")!=null)&&(request.getParameter("tipoPago")!=null)){
            tiquete = modelo.consultarTiqueteByFactura(request.getParameter("pago").toUpperCase());
            if(tiquete!=null){
                if(request.getParameter("tramiteCod")!=null){
                    java.util.List lista = modelo.listasDetalleTiquetesByFactura(tiquete.getId_tiquete(),1);
                    for(int i=0;i<lista.size();i++){
                    Detalle_Tiquete dt = (Detalle_Tiquete)lista.get(i);
                    if(dt.getFk_tramite()!= 0){
                        Tramite tramite = modelo.consultarTramite(dt.getFk_tramite());
                        tra = tramite.getId_tramite();
                    }else{
                        tra = 0;
                    }
                    if(tra!=0){
                    reclamo.setFK_TRAMITE(tra);
                    if(tra==28||tra==29||tra==30||tra==31||tra==34||tra==35||tra==57){
                        reclamo.setTIPO(2);
                        if(request.getParameter("documento")!=null&&request.getParameter("tipoDocumento")!=null){
                            String documento = request.getParameter("documento");
                            int tipoDoc = Integer.parseInt(request.getParameter("tipoDocumento"));
                            Persona persona = modelo.consultarPersona(tipoDoc, documento);
                            if(persona!=null){
                                reclamo.setFK_PERSONA(persona.getId_persona());
                            }
                        }
                    }else{
                        reclamo.setTIPO(1);
                        if(request.getParameter("placa")!=null){
                            reclamo.setPLACA(request.getParameter("placa"));
                        }
                    }
                    Pago pago = modelo.consultarPagoByTiquete(tiquete.getId_tiquete());
                    if(pago!=null){
                        int vigencia = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                        int factura = modelo.consultarConsecutivo(44, 16, vigencia);
                        String consecutivo = ("0000".substring(0, 4-(factura+"").length()))+factura;
                        reclamo.setNUMERO(consecutivo);
                        reclamo.setFK_PAGO(pago.getId_pago());
                        reclamo.setESTADO(1);
                        reclamo.setFECHA_PROCESO(fechaSystem);
                        reclamo.setFECHA(fecha);
                        reclamo.setFK_USUARIO(usuario.getId_usuario());
                        if(request.getParameter("observacion")!=null){
                            reclamo.setOBSERVACION(request.getParameter("observacion"));
                        }
                        modelo.adicionarRelamoPago(reclamo);
                        modelo.actualizarConsecutivo(usuario.getFk_sede(),16, vigencia);
                        mensaje = "1";
                        modelo.getCon().commit();
                    }else{
                        mensaje= "error : de vaildacion";
                    }
                    }else{
                    mensaje= "error al validar el pago";
                    }
                    }

                }else{
                   mensaje= "error : no se registro la validacion del pago : Codido tramite errado";
                }
            }else{
                   mensaje= "error : no se registro la validacion del pago : No existe pago";
            }
       }else{
           mensaje= "error : no se registro la validacion del pago : parametros null";
       }
%>


    <%
	}catch(Exception ecx){
		modelo.getCon().rollback();
		ecx.printStackTrace();        %>
		<script language="javascript" type="text/javascript">
			alert("validacion del pago No pudo Ser Realizada");
			document.location.href = "reclamosPagos.jsp";
		</script>
<%  }

    if(mensaje.equals("1")){
        %>
        <script language="javascript" type="text/javascript">
                alert("Mensaje :Validacion del pago Realizada con Exito");
            document.location.href = "reclamosPagos.jsp";
	</script>
   <% }else{
     %>
        <script language="javascript" type="text/javascript">
            alert("Mensaje : <%=mensaje%>");
            document.location.href = "reclamosPagos.jsp";
	</script>
   <%

        }


%>


</body>
</html>
