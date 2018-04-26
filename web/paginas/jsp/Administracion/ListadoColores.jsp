<%--
    Document   : adicionarMunicipio
    Created on : 1/05/2010, 11:39:31 AM
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
    <title>Adicionar Color</title>
 <script language="JavaScript1.2">
function buscarColor(){
	var col = document.form.color.value;
	window.frames[0].location.href = "listarColores.jsp?id=0&color="+col.toUpperCase();
}

</script>
 <style type="text/css">
<!--
.Estilo2 {color: #FFFFFF; 	font-family: Tahoma; 	font-size: 12px; 	font-weight: bold; }
.Estilo1 {
	color: #0066CC;
	font-weight: bold;
	font-size: 12px;
}
.Estilo3 {color: #333333; font-size: 12px; font-weight: bold; }
-->
 </style>
</head>
<body>
    <form  name="form"  method="post" action="javascript:buscarColor()">
	<fieldset>
	   <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr style="border:none; background:url(../html/images/inicio_3.png)">
				<td colspan="2" align="center" > <span class="Estilo2">ADICIONAR COLOR</span></td>
			</tr>
			<tr>
			  <td width="100%" align="center"><div align="center" class="Estilo3">
			    <input type="text" name="color" style="width:300px; font-size:11px"/>
			  </div>
                          </td>
			</tr>
                        <tr>
			 <td align="center" colspan="2">&nbsp;</td>
			 </tr>
			<tr>
			  <td colspan="2" align="center">
			  	<iframe allowtransparency="true" frameborder="0" scrolling="no" name="listarColores"  src="#" width="100%" height="300"></iframe>			  </td>
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