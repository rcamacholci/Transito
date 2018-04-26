<%--
    Document   : procesarDetalle2013
    Created on : 30/12/2012, 09:18:35 AM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"  import="modelo.*" import="java.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
<%

       Model modelo = (Model)session.getAttribute("model");
      //Cartera cartera = modelo.consultarCartera2013();
       java.util.List cart = modelo.listado2013();
       for(int i =0;i<cart.size();i++){
       Cartera cartera = (Cartera)cart.get(i);
      long id_cartera = cartera.getId_cartera();
       try{
       double nvalor = cartera.getValor()- 12448 ;
       modelo.actualizarValor2013(nvalor, id_cartera);
       System.out.println("Detalle Cartera 2013: "+id_cartera);
       System.out.println("Numero: "+i);
       }catch (Exception ex){
        System.out.println("Error" + ex);
       }

    }

%>
    </body>
</html>
