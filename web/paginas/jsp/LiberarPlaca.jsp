<%-- 
    Document   : LiberarPlaca
    Created on : 25/01/2017, 08:43:55 PM
    Author     : JgCarreno
--%>

<%@page import="procesos.LiberarPlacas"%>
<%@page import="modelo.Model"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%-- Jsp--%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%
        Model modelo = (Model) session.getAttribute("model");
        modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
        try {
            LiberarPlacas liberar = new LiberarPlacas();
            Boolean lb = liberar.LiberarPlacas(modelo, usuario);
    %>
    <script type="text" language="text/javascript">
    alert("<%=liberar.getMessage()%>");
    </script>
    <%-- End Jsp--%>
    <body>
        <h1><%=liberar.getMessage()%></h1>
    </body>
    <%
    } catch (Exception ex) {
    %>
    <script type="text" language="text/javascript">
        alert("Se produjo un error al Liberar las Placas \n <%=ex.getMessage()%>");
    </script>
    <%
        }
    %>
</html>
