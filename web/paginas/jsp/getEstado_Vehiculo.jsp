<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>

<root>
<% Model modelo= (Model)session.getAttribute("model");

String estado = "0";
String vehi = "0";
String fecha = "0";

if (!request.getParameter("numero").isEmpty()){
       	Vehiculo  vehiculo = modelo.consultarVehiculo(request.getParameter("numero").toUpperCase());
        if(vehiculo!=null){
            if(vehiculo.getEstado()==1||vehiculo.getEstado()==5){
                   if(vehiculo.getFecha_matricula()==null){
                        fecha = "1";
                    }
                   }else{
                       estado = "1";
                   }
        }else{
                vehi = "1";
            }
        }
%>
<vehi><%=vehi %></vehi>
<fecha><%=fecha %></fecha>
<estado><%=estado %></estado>
</root>