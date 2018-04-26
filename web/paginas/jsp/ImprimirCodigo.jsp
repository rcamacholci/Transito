<%-- 
    Document   : AjaxRangoComparendo
    Created on : 19/07/2012, 09:17:40 AM
    Author     : acer
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
                    Model model = null;
                    model = (Model) session.getAttribute("model");
                    java.util.Map parameters = (java.util.HashMap)session.getAttribute("Codigo");
                    String dir = application.getRealPath("/paginas/reports/reportes/Tikecs.jasper");
                    Reports reporte = new Reports(model,parameters,dir,response);
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
