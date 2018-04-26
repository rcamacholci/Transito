<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<script type="text/javascript" src="../html/scripts/pagos.js"></script>
<script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
 <link rel=StyleSheet href="../html/css/msj.css" type="text/css" media=screen>
<title>Pagos</title>
<style type="text/css">
<!--
.Estilo13 {color: #FFFFFF; font-weight: bold; }
.Estilo20 {font-size: 12px; font-weight: bold; color: #333333; }
.style4 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
.style6 {font-size: 12px; font-weight: bold; color: #333333; }
.style8 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
-->
</style>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>

<%
Model modelo= (Model)session.getAttribute("model");
String placa = "";
if(request.getParameter("id")=="0"){
	placa =  request.getParameter("placa");
}else{
	placa =  session.getAttribute("placa")+"";
}
if(placa!=null){
Vehiculo vehiculo  = new Vehiculo();
vehiculo=modelo.consultarVehiculo(placa.toUpperCase());
if (vehiculo!=null){


%>
<body>
<p align="center" class="style8">PAGOS</p>
<table width="90%" border="1" cellpadding="1" cellspacing="0" align="center">
    <thead>
   <tr style="border:none; background:url(../html/images/inicio_3.png)">
    <td width="9%" style="border:none"><div align="center" class="style4">NUMERO&nbsp;FACTURA </div></td>
    <td width="20%" style="border:none"><div align="center" class="style4">FECHA</div></td>
   <td width="9%" style="border:none"><div align="center" class="style4">VALOR</div></td>
    <td width="15%" style="border:none"><div align="center" class="style4">TIPO&nbsp;PAGO </div></td>
	<td width="34%" style="border:none"><div align="center" class="style4">PAGADOR</div></td>
        <td width="12%" style="border:none"><div align="center" class="style4">ESTADO</div></td>
        <td width="12%" style="border:none"><div align="center" class="style4">USUARIO</div></td>
  </tr>
    </thead>
  <%
   java.util.List lista   =  modelo.listarPagosVehiculo(vehiculo.getId_vehiculo());
   boolean color = true;
   int inx =0;
   for(int i=0;i<lista.size();i++){
       Pago pago = (Pago)lista.get(i);
       String tipoPago = modelo.consultarParametroName(301, pago.getTipo_pago());
       Persona persona = modelo.consultarPersona(pago.getFk_persona());
       String estado = modelo.consultarParametroName(19, pago.getEstado());
       Usuario usuario = modelo.consultarUsuario(pago.getFk_usuario());
       Tiquete tiquete = modelo.consultarTiquetePorID(pago.getFk_tiquete());
       String nombres = persona.getNombre_1()+" "+persona.getApellido_1()+" "+(persona.getApellido_2()!=null?persona.getApellido_2():"");
          %>
              <tr bgcolor="#FFFFFF" class="style8" ondblclick="DetallePago(<%=inx%>, '<%=pago.getFk_tiquete()%>')">
                <td align="center"><span class="style8"><%=pago.getNumero_factura()%></span></td>
                <td align="center"><span class="style6"><%=new java.text.SimpleDateFormat("dd/MM/yy HH:mm:ss").format(tiquete.getFecha_proceso())%></span></td>
                <td align="center"><span class="style8"><%=pago.getValor_total()%></span></td>
                <td align="center"><span class="style6"><%=tipoPago%></span></td>
                <td align="center"><span class="style6"><%=nombres==null?"":nombres%></span></td>
                <td align="center"><span class="style6"><%=estado%></span></td>
                <td align="center"><span class="style6"><%=usuario.getNombre()%></span></td>
   </tr>
  <tr id="detPago<%=inx%>" style="display:none; height:0px">
                  <td colspan="7">
                      <div class="box">

                                    <!--- box border -->
                                    <div class="lb">
                                    <div class="rb">
                                    <div class="bb"><div class="blc"><div class="brc">
                                    <div class="tb"><div class="tlc"><div class="trc">
                                    <!--  -->
                                    <div id="detallePago<%=inx%>" class="content"></div>
                       <!--- end of box border -->
                                    </div></div></div></div>
                                    </div></div></div></div>
                                    <!-- -->
                    </div>                  </td>
              </tr>
     <%
   }
   %>
</table>
<% }
 }
%>
</body>
</html>
<%  }else{ %>
			   <jsp:forward page="no_access.jsp">
				 <jsp:param name="tipo" value="1"></jsp:param>
			   </jsp:forward>
	<%  }
	}else{ %>
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
