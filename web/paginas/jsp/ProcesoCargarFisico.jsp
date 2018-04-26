<%-- 
    Document   : listarInfracciones
    Created on : 14/03/2011, 01:51:45 PM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="procesos.*"%>
<%@page import="modelo.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
Model model = (Model)session.getAttribute("model");
Usuario usu = (Usuario)session.getAttribute("usuario");
procesos.ComparendoFisico sub = new ComparendoFisico();
try{
if(model!=null){
sub.CargarCompFisico(request, model,usu);
//sub.Aduiencia_fallo(request, model);
}
%>
<html>
<head>
    <title></title>
<style type="text/css">
<!--
.style1 {
	font-size: 12px;
	font-weight: bold;
	font-style: italic;
	color: #003366;
        text-align:center;
}
-->
</style>
<script language="javascript" type="text/javascript">
		alert("foto cargada correctamente");
		//window.parent.opener.document.form.infraccion.value = codigo;
        //window.parent.opener.document.form.nombreInfraccion.value = text;
        window.parent.close();
</script>
</head>
<body>
</body>
<%
}catch(Exception e){
    System.out.println("Error ->"+e);
}
%>
</html>