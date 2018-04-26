<%-- 
    Document   : buscarInfraccion
    Created on : 14/03/2011, 01:58:59 PM
    Author     : Administrador
--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <%
try{
    Model modelo = (Model)session.getAttribute("model");
    Parametro parametro=new Parametro();

%>
<head>
    <title>Buscar Infraccion</title>
 <script language="JavaScript1.2">
function buscarInfraccion(){
	var col = document.form.infraccion.value;
	window.frames[0].location.href = "listarInfracciones.jsp?id=0&infraccion="+col.toUpperCase();
}

</script>
 <style type="text/css">
<!--
.Estilo1 {
	color: #003366;
	font-weight: bold;
	font-size: 12px;
}
.Estilo3 {color: #333333; font-size: 12px; font-weight: bold; }
.text {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; width:120px; text-transform:uppercase}
.style1 {color: #FFFFFF}
-->
 </style>
</head>
<body>
    <form  name="form"  method="post" action="javascript:buscarInfraccion()">
	<fieldset>
	   <table width="25%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr style="border:none; background:url(../html/images/inicio_3.png)">
				<td colspan="2" align="center"><h3 class="Estilo1 style1">LISTADO DE INFRACCIONES </h3></td>
			</tr>
			<tr>
			  <td width="100%" align="center"><div align="center" class="Estilo3">
                                  <input type="text" class="text" name="infraccion" style="width:100px; font-size:11px"/>
			  </div>
                          </td>
			</tr>
                        <tr>
			 <td align="center" colspan="2">&nbsp;</td>
			 </tr>
			<tr>
			  <td colspan="2" align="center">
			  	<iframe allowtransparency="true" frameborder="0" scrolling="no" name="listarInfraccion"  src="#" width="300" height="230"></iframe>			  </td>
			</tr>
	  </table>
	</fieldset>
</form>
</body>
</html>
<%
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% } %>