<%--
    Document   : seleccionarPagoExterno
    Created on : 09-jun-2011, 23:50:27
    Author     : Civitrans
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
            try {
               
                    if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("seleccionarPagoExterno.jsp")) {
                       if (session.getAttribute("model") != null) {
                        Model model = (Model) session.getAttribute("model");
                        if (model != null) {
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Civitrans</title>
        <style type="text/css">
            <!--
            .style1 {color: #006699}
            -->
        </style>
    </head>
    <body>
        <form name="form" action="procesarRecaudoExterno.jsp" method="POST" enctype="multipart/form-data" target="respuesta">
            <table align="center" border="0" width="100%">
                <tr>
                    <td  height="40px" align="center">
                        <h1 class="style1">Aplicacion Recaudo Externo</h1>
                    </td>
                </tr>
                <tr>
                    <td height="40px" align="center">
                        <input type="file" name="archivo" size="80px" value="" />
                    </td>
                </tr>
                <tr>
                    <td height="40px" align="center">
                        <input type="submit" name="aceptar" value="Enviar">
                    </td>
                </tr>
                <tr>
                    <td height="60px" align="center">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <iframe allowtransparency="0" frameborder="0" height="300px" scrolling="no" width="400px" name="respuesta"></iframe>
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>
<%   }
} else {%>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%            }

                       } else {%>
<jsp:forward page="../no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<% }

            } catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="2"></jsp:param>
    <jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param>
</jsp:forward>
<%  }%>