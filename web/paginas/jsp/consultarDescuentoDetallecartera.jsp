<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarCarteraPersona.jsp")||((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarCarteraVehiculo.jsp")){
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Caracteristicas</title>

<style type="text/css">
<!--
.Estilo2 {color: #FFFFFF; font-weight: bold; }
.Estilo4 {color: #333333; font-weight: bold; }
.Estilo9 {color: #0066CC; font-weight: bold; }
-->
</style>
<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>

<style type="text/css">
<!--
.style2 {color: #333333}
.style3 {
	font-family: Tahoma;
	font-size: 12px;
}
.style4 {font-size: 12px}
.style5 {font-family: Tahoma;
	font-weight: bold;
	color: #FFFFFF;
	font-size: 12px;}
.style6 {
	font-family: Tahoma;
	font-weight: bold;
	color: #333333;
	font-size: 12px;
}
-->
</style>
</head>
<%@ page import="modelo.*"%>
<%@ page import="java.util.*"%>

<%
Model modelo= (Model)session.getAttribute("model");
String id_cartera = request.getParameter("id_cartera");
if(id_cartera!=null){
	List  lista_detalle=modelo.listarDetalleCartera(Integer.parseInt(id_cartera));
    Iterator itt = lista_detalle.iterator();
    Detalle_Cartera detallecartera;
	%>
	<body>
	<div align="center" class="style6">DETALLE DE CARTERA </div>
	<br/>
	<table width="100%" border="1" cellpadding="1" cellspacing="0"  >
	  <tr  style="border:none; background:url(../html/images/inicio_3.png)">
		<td width="50%"  style="border:none"><div align="center" class="style5">CONCEPTO</div></td>
		<td width="10%"  style="border:none"><div align="center" class="style5">REFERENCIA</div></td>
		<td width="10%"  style="border:none"><div align="center" class="style5">FECHA</div></td>
		<td width="10%"  style="border:none"><div align="center" class="style5">VALOR</div></td>
		<td width="10%"  style="border:none"><div align="center" class="style5">USUARIO</div></td>
		<td width="10%"  style="border:none"><div align="center" class="style5">ESTADO</div></td>
	  </tr>
	  <%
		  while (itt.hasNext()) {
			  detallecartera = (Detalle_Cartera)itt.next();
			  Usuario usu = modelo.consultarUsuario(detallecartera.getFk_usuario());
			  Concepto con = modelo.consultarConcepto(detallecartera.getFk_concepto());
			  String nombre = modelo.consultarParametroName(302, detallecartera.getEstado());
     		%>
		  <tr>
			<td style="font-size:12px" align="left"><span class="Estilo4 style2"><strong><%=con.getNombre()%></strong></span></td>
			<td style="font-size:12px" align="center"><span class="Estilo4 style2"><strong><%=detallecartera.getReferencia()%> </strong></span></td>
			<td style="font-size:12px" align="center">
				<span class="Estilo4 style2"><strong><%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(detallecartera.getFecha())%> </strong></span></td>
			<td style="font-size:12px" align="right"><span class="Estilo4 style2"><strong>$&nbsp;<%=detallecartera.getValor()%></strong></span></td>
			<td style="font-size:12px" align="center"><span class="Estilo4 style2"><strong><%=usu.getNombre()%> </strong></span></td>
			<td style="font-size:12px" align="center"><span class="Estilo4 style2"><strong><%=nombre%> </strong></span></td>
		  </tr>
		<%
   		  }// fin del while
		  %>
	</table>
	</body>
<% }  %>
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
