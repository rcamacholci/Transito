<%-- 
    Document   : procesarRegistrarSinHuella
    Created on : 20/11/2015, 01:27:05 PM
    Author     : Jefrey
--%>

<%@page import="modelo.UsuarioRunt"%>
<%@page import="com.heinsohn.runt.general.solicitudes.RegistrarAutorizacionSinHuellaOutDTO"%>
<%@page import="webservices.radicacion.RadicacionServicesClient"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        UsuarioRunt userRunt = (UsuarioRunt)session.getAttribute("usuarioRunt");
        RadicacionServicesClient radicacion = new RadicacionServicesClient();
        radicacion.setUser(userRunt.getCodigo());
        if(session.getAttribute("token2")!=null){
            radicacion.setTokenHuellaDigital(session.getAttribute("token2").toString());
        }
        
        String tipoDoc = request.getParameter("tipoD");
        String numeroDoc = request.getParameter("documento");
        String entidadCertifica = request.getParameter("txtentidad");
        int motivoNoHuella = Integer.parseInt(request.getParameter("cmbmotivo"));
        int registroNacional = 1;
        String[] tramites = new String[]{request.getParameter("cmbtramite")};
        
        RegistrarAutorizacionSinHuellaOutDTO autorizacion = radicacion.registrarAutorizacionRadicacionHuella(tipoDoc, numeroDoc, entidadCertifica, motivoNoHuella, registroNacional, tramites);
        if(autorizacion!=null){
        %><script>alert("Resultado: '<%=autorizacion.getStatus().getStatusCode() %>' - '<%=autorizacion.getStatus().getStatusDesc() %>'");document.location.href = "registrarPersonaSinHuella.jsp"</script><%
        }
        
        %>
    </body>
</html>
