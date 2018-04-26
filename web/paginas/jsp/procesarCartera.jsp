<%-- 
    Document   : procesarCartera
    Created on : 29/12/2012, 05:39:09 PM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*" import="java.*" %>
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

       String fechac = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.sql.Date(cartera.getFecha_creacion().getTime()));
       String fechai = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.sql.Date(cartera.getFecha_ingreso().getTime()));
       String fechas = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.sql.Date(cartera.getFecha_saldo().getTime()));
       String fechae = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.sql.Date(cartera.getFecha_estado().getTime()));
       String fechaev = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.sql.Date(cartera.getFecha_estado_vigencia().getTime()));

       String fc = fechac.substring(0,5)+"/2014";
       String fi = fechai.substring(0,5)+"/2013";
       String fs = fechas.substring(0,5)+"/2014";
       String fe = fechae.substring(0,5)+"/2014";
       String fev = fechaev.substring(0,5)+"/2013";

       java.sql.Date fcreacion = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fc).getTime());
       java.sql.Date fingreso = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fi).getTime());
       java.sql.Date fsaldo = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fs).getTime());
       java.sql.Date festado = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fe).getTime());
       java.sql.Date festadov = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fev).getTime());


       System.out.println("Fecha Creacion: "+fcreacion);
       System.out.println("Fecha Ingreso "+fingreso);
       System.out.println("Fecha Saldo "+fsaldo);
       System.out.println("Fecha Estado "+festado);
       System.out.println("Fecha Estado vigencia "+festadov);
       System.out.println("Numero: "+i);


       modelo.actualizarCartera2013(fcreacion, fingreso, fsaldo, festado, festadov, id_cartera);

       }catch (Exception ex){
        System.out.println("Error" + ex);
       }

}
%>
    </body>
</html>
