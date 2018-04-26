
<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>

<root>
<% Model modelo= (Model)session.getAttribute("model");

String estado = "0";
String vehi = "0";
String fecha = "0";
String cart = "0";


if (!request.getParameter("numero").isEmpty()){
       	Vehiculo  vehiculo = modelo.consultarVehiculo(request.getParameter("numero").toUpperCase());
        if(vehiculo!=null){
               if(vehiculo.getEstado()==4){
                   if(vehiculo.getFecha_matricula()!=null){
                       Cartera carte = modelo.consultarCarteraRev(vehiculo.getId_vehiculo());
                       if(carte!=null){
                           cart = "1";
                           }
                    }else{
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
<estado><%=estado %></estado>
<fecha><%=fecha %></fecha>
<cart><%=cart %></cart>
</root>