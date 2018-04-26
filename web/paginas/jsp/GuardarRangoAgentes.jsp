<%-- 
    Document   : GuardarRangoAgentes
    Created on : 13/07/2012, 10:37:40 AM
    Author     : acer
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
 Model modelo = (Model) session.getAttribute("model");
 long id_rango = Long.parseLong(request.getParameter("idrango"));
 long fk_agente = Long.parseLong(request.getParameter("placaAgente"));
 long estado = 1;
 long numero=0;
 long x = Long.parseLong(request.getParameter("Rangos"));
 int i=0;
 Rangos_Comparendos ran = modelo.consultarRangoComparendoByid_rango(id_rango);
 java.util.List temp = modelo.ListarRangosAgentesByrango(id_rango);
int sw=0;


 for(int j=0;j<x;j++){
     Detalle_Rango_Comparendo det = new Detalle_Rango_Comparendo();

     if(temp.size()>0 && sw==0){
            i = temp.size()-1;
            Detalle_Rango_Comparendo detalle = (Detalle_Rango_Comparendo)temp.get(i);
            numero=Long.parseLong(detalle.GetNumero());
            System.out.println(id_rango+"-"+fk_agente+"-"+estado+"-"+numero+"-"+x);
            sw=1; 
            }else{
                if(sw==0){
                    numero = Long.parseLong(ran.GetNum_Inicial());
                }
            sw=1;
            }

     modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
    java.sql.Date  fechaSystem = new java.sql.Date(new java.util.Date().getTime());
     System.out.println(id_rango+"-"+fk_agente+"-"+estado+"-"+numero+"-"+x);
     String test = "0"+numero;
     det.SetFk_rango(id_rango);
     det.SetNumero(test);
     det.SetEstado(estado);
     det.SetFk_agente(fk_agente);
     det.Setfecha_asignacion(fechaSystem);
     det.SetFk_usuario(usuario.getId_usuario());
     System.out.println(usuario.getId_usuario());
     
      numero=numero+1;
      System.out.println(numero);
     modelo.adicionarDetalleRango(det);
    
 }
   modelo.getCon().commit();

  %>

                <script>
                    alert(" Los Usuarios se Actualizon Correctamente...");
                    window.location.href="AsignarRangosAgentes.jsp?&idrango="+<%=id_rango%>;
                </script>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
