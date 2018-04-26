<%-- 
    Document   : ProcesarAplicarAudiencia
    Created on : 11/03/2013, 09:37:35 AM
    Author     : acer
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="procesos.*"%>
<%@page import="modelo.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
Model model = (Model)session.getAttribute("model");
Usuario usu = (Usuario)session.getAttribute("usuario");
procesos.SubirFoto sub = new SubirFoto();
if(model!=null){
sub.cargarPlanosPolca(request, model,usu);
//sub.Aduiencia_fallo(request, model);
}
%>
<html>
        <script>
           alert("Audiencia programada correctamente");
           window.location.href = "comparendos/consultarAudiencia.jsp";
        </script>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
