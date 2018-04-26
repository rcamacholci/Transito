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

Model model= (Model)session.getAttribute("model");
modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
String mensaje ="";
try{

    if(request.getParameter("id_comparendo")!=null){
        long id_comparendo =  Long.parseLong(request.getParameter("id_comparendo"));
        Comparendo comparendo = model.consultarComparendoById(id_comparendo);
        if(comparendo!=null){
            Cartera carteraComparendo = model.consultarCartera(comparendo.getFk_cartera());
            if(carteraComparendo!=null){
                model.getCon().setAutoCommit(false);
                java.sql.Date fecha = new java.sql.Date(new java.util.Date().getTime());

                Liquidacion_Cia liquidacion = new Liquidacion_Cia();
                int vigencia = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                int factura = model.consultarConsecutivo(usuario.getFk_sede(), 10, vigencia);
                model.actualizarConsecutivo(usuario.getFk_sede(),10, vigencia);
                String consecutivo = ("00000".substring(0, 5-(factura+"").length()))+factura;
                liquidacion.setNumero(consecutivo);
                liquidacion.setFk_persona(comparendo.getFk_persona());
                liquidacion.setFk_comparendo(comparendo.getId_comparendo());
                liquidacion.setFk_sede(usuario.getFk_sede());
                liquidacion.setEstado(1);
                liquidacion.setFecha(fecha);
                liquidacion.setFecha_proceso(new java.sql.Timestamp(new java.util.Date().getTime()));
                liquidacion.setFk_usuario(usuario.getId_usuario());

                float descuento = 0;
                java.util.Date fechaLimite = new java.text.SimpleDateFormat("dd/MM/yyyy").parse("15/03/2010");
                if(fechaLimite.getTime()>comparendo.getFecha().getTime()){
                    descuento = (float)0.5;
                }else{
                    int dias = model.consultarDiasHabiles(new java.sql.Date(comparendo.getFecha().getTime()));
                    if(dias <= 5){
                        descuento = (float)0.5;
                    }else{
                        if(dias < 21){
                            descuento = (float)0.25;
                        }
                    }
                }

                float valorDescuento = (float)(carteraComparendo.getValor()*(1.0-descuento));
                float valorCertificado = 0;

                valorCertificado = (float)(valorDescuento*0.25);

                valorCertificado = Math.round(valorCertificado);
                liquidacion.setValor(valorCertificado);
                
                Cartera cartera  = new Cartera();
                cartera.setFk_persona(carteraComparendo.getFk_persona());
                cartera.setFk_sede(carteraComparendo.getFk_sede());
                cartera.setTipo(5);
                cartera.setReferencia(comparendo.getNumero());
                cartera.setFecha_creacion(fecha);
                cartera.setFecha_ingreso(fecha);
                cartera.setValor(valorCertificado);
                cartera.setSaldo(valorCertificado);
                cartera.setFecha_saldo(fecha);
                cartera.setEstado_cartera(1);
                cartera.setFecha_estado(fecha);
                cartera.setEstado_vigencia(1);
                cartera.setFecha_estado_vigencia(fecha);
                cartera.setFk_usuario(usuario.getId_usuario());
                cartera.setFk_concepto(308);
                long Fk_cartera = model.adicionarCartera(cartera);

                Detalle_Cartera detalle=new Detalle_Cartera();
                detalle.setFk_cartera(Fk_cartera);
                detalle.setReferencia(cartera.getReferencia());
                detalle.setFecha(fecha);
                detalle.setFecha_sistema(new java.sql.Timestamp(fecha.getTime()));
                detalle.setFk_usuario(usuario.getId_usuario());
                detalle.setEstado(1);
                detalle.setFk_concepto(308);
                detalle.setValor((float)cartera.getSaldo());

                model.adicionarDetalleCartera(detalle);
                model.adicionarLiquidacionCia(liquidacion);
                model.getCon().commit();
                mensaje= "Liquidacion generada exitosamente";
                %>
                 <script language="javascript" type="text/javascript">
                                    document.location.href = "formularioDescuentoComparendo.jsp?id=1";
                </script>
                <%
            }
        }
    }else{
           mensaje= "Solicitud No pudo ser Realizada con Exito";

	}
%>


    <%
	}catch(Exception ecx){
		model.getCon().rollback();
		ecx.printStackTrace();        %>
		<script language="javascript" type="text/javascript">
			alert("Liquidacion No pudo Ser Realizada");
			document.location.href = "formularioDescuentoComparendo.jsp?id=1";
		</script>
<%  }

    if(!mensaje.equals("")){
        %>
        <script language="javascript" type="text/javascript">
            alert("Mensaje : <%=mensaje%>");
            document.location.href = "formularioDescuentoComparendo.jsp?id=1";
	</script>
   <% }


%>


</body>
</html>
