<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.DatosVehiculo" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Colores</title>
<style type="text/css">
<!--
.Estilo1 {
	color: #0066CC;
	font-weight: bold;
}
.style2 {
	color: #333333;
	font-weight: bold;
	font-family: Tahoma;
	font-size: 12px;
}
.style4 {color: #333333; font-weight: bold; font-family: Tahoma; font-size: 10px; }
-->
</style>
<script language="javascript" type="text/javascript">
	function newP(){
		window.frames[0].location.href = "adicionarColor.jsp?id=1";
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
  	<td width="95%"><div align="center"><span class="style2">COLOR</span></div></td>
      
            <td width="5%" align="right" valign="middle" bgcolor="#FFFFFF"><div align="center">
                <img src="../html/images/adicionar.gif" alt="Nueva" name="adicionarPropietario" width="22" height="22" id="adicionarPropietario" style="cursor:pointer" onclick="newP()"/>&nbsp;<span class="style4">NUEVO</span></div>
            </td>
       
  </tr>
  <tr>
  	<td align="center" valign="top" colspan="2">
	<iframe src="verColor.jsp?id=1" id="colores" name="colores" marginwidth="0" height="500" width="100%" marginheight="0" align="top" scrolling="auto" style="border:none"></iframe></td>
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