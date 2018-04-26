<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.DatosVehiculo" errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Caracteristica</title>
<style type="text/css">
<!--
.Estilo1 {
	color: #0066CC;
	font-weight: bold;
}
.Estilo3 {color: #0033CC; font-weight: bold; }
.Estilo4 {color: #0033CC}
.style2 {
	color: #333333;
	font-weight: bold;
	font-family: Tahoma;
	font-size: 12px;
}
.style3 {
	color: #333333;
	font-family: Tahoma;
}
.style4 {
	font-family: Tahoma;
	font-weight: bold;
	font-size: 10px;
	color: #333333;
}
-->
</style>
<script language="javascript" type="text/javascript">
	function newC(){
		window.frames[0].location.href = "adicionarCaracteristica.jsp?id=1";
	}
	function newE(){
		window.frames[1].location.href = "adicionarEspecificacion.jsp?id=1";
	}
</script>
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
<table width="100%" border="0">
  <tr>
  	<td width="95%"><div align="center"><span class="style2">CARACTERISTICAS</span></div></td>
	
		<td width="5%" align="right" valign="middle" bgcolor="#FFFFFF">
			<div align="center"><img src="../html/images/adicionar.gif" alt="Nueva" name="adicionarCaracteristica" width="22" height="22" id="adicionarCaracteristica" style="cursor:pointer" onclick="newC()"/>&nbsp;<span class="style4">NUEVO</span></div>
	</td>
	
  </tr>
  <tr>
  	<td align="center" valign="top" colspan="2">
	<iframe src="verCaracteristicas.jsp?id=1" id="caracteristicas" name="caracteristicas" marginwidth="0" height="180" width="80%" marginheight="0" align="top" scrolling="auto" style="border:none"></iframe></td>
  </tr>
  <tr>
  	<td><div align="center" class="style2">ESPECIFICACIONES</div></td>
	
	<td align="right" valign="middle" bordercolor="#0066CC" bgcolor="#FFFFFF">
		<div align="center" class="style4">
			<img src="../html/images/adicionar.gif" alt="Nueva" name="adicionarEspecificacion" width="22" height="22" id="adicionarEspecificacion" style="cursor:pointer" onclick="newE()"/>
		&nbsp;NUEVO</div>
	</td>
	
  </tr>
  <tr>
  	<td align="center" valign="top" colspan="2">
	<iframe src="verEspecificaciones.jsp?id=1" id="especificaciones" name="especificaciones" marginwidth="0" height="200" width="80%" marginheight="0" align="top" scrolling="auto" style="border:none"></iframe></td>
  </tr>
</table>
<% }
}else{ %>
 	<script>
		alert("Digite numero de placa");
		window.href="consultar_Vehiculo.jsp";
	</script>
<% }        
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