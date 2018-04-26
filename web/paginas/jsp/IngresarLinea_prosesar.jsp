<%-- 
    Document   : IngresarLinea_prosesar
    Created on : 5/06/2012, 06:00:45 PM
    Author     : acer
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" errorPage="" import="java.text.SimpleDateFormat"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%
     Model modelo = new Model();
    try{
       
        modelo.conectar();
        String marc,linea,Flinea;
        modelo.getCon().setAutoCommit(false);
            if(request.getParameter("marca")!=null && !request.getParameter("marca").isEmpty() && request.getParameter("linea")!=null && !request.getParameter("linea").isEmpty() && request.getParameter("Flinea")!=null && !request.getParameter("Flinea").isEmpty()){
                marc = request.getParameter("marca");
                linea = request.getParameter("linea").toUpperCase();
                Flinea = request.getParameter("Flinea");
                modelo.RegistrarLinea(Long.parseLong(Flinea),Long.parseLong(marc),linea);
                modelo.getCon().commit();
    %>
    <script>
        alert("Linea Ingresada Correctamente");
     </script>
    <%      }else{    %>
    <script>
    alert("Faltan campos por llenar");
    window.location.href="IngresarLinea.jsp"
    </script>
    <%
        }
    }catch(Exception e){
        e.printStackTrace();
         modelo.getCon().rollback();
         %>
    <script>
    alert("Error en el ingreso Comunique al administrador");
    </script>
    <%
    }
    %>
    <script>
    window.location.href="IngresarLinea.jsp"
    </script>
    <body>
       
    </body>
</html>
