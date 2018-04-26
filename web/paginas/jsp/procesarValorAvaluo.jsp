<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>

<root>
<%
Model model = (Model)session.getAttribute("model");

String sw = "0";
float valorRetencion = 0;
String valorRetencionS = "";

try{
    model.getCon().setAutoCommit(false);
    Usuario usuario = (Usuario)session.getAttribute("usuario");
    long idVehiculo = Long.parseLong(request.getParameter("idVehiculo"));
    float valorAvaluo = (Float.parseFloat(request.getParameter("valorAvaluo"))*1000);
    int anoactual = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
    valorRetencion = Math.round(valorAvaluo*0.01);
    model.adicionarValorRetencion(idVehiculo, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, sw, anoactual, usuario.getId_usuario(), valorAvaluo, valorRetencion,0);
    valorRetencionS= ""+Math.round(valorRetencion);
    sw = "1";
    model.getCon().commit();

}catch(Exception ex){
    model.getCon().rollback();
    System.out.println("/*-"+ex+"*/");
}
%>
<valorRetencion><%= valorRetencionS %></valorRetencion>
<sw><%= sw %></sw>
</root>