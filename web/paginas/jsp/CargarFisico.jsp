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
    String hidden = request.getParameter("comparendo");

%>
<head>
    <title>Cargar Comparendo Fisico</title>
 <script language="JavaScript1.2">
function buscarInfraccion(){
	var col = document.form.infraccion.value;
	window.frames[0].location.href = "ProcesoCargarFisico.jsp";
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
    <form  name="form"  method="post" action="ProcesoCargarFisico.jsp" enctype="multipart/form-data">
	<fieldset>
            <input type="hidden" name="filename" value="<%=hidden%>"/>
	   <table width="35%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr style="border:none; background:url(../html/images/inicio_3.png)">
				<td colspan="2" align="center"><h3 class="Estilo1 style1">COMPARENDO FISICO</h3></td>
			</tr>
			<tr>
			  <td colspan="2" class="text">
			    <input type="file" size="60%" name="archivo" />			
                          </td>
						  
			</tr>
			<tr>
			<td colspan="2"><input type="submit" value="guardar" /></td>
			</tr>
                        <tr>
			 <td align="center" colspan="2">&nbsp;</td>
			 </tr>
			<tr>
			  <td colspan="2" align="center">&nbsp;</td>
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