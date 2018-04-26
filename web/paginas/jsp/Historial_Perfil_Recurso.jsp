<%-- 
    Document   : Historial_Perfil_Recurso
    Created on : 15/06/2012, 02:28:59 PM
    Author     : acer
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
Model modelo= (Model)session.getAttribute("model");
modelo.getCon().setAutoCommit(false);
javax.swing.JOptionPane.showMessageDialog(null,"funciona"+ request.getParameter("usu"));

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
