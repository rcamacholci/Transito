<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>

<root>
<%
Model model = (Model)session.getAttribute("model");

String sw = "0";

try{
    model.getCon().setAutoCommit(false);
    Usuario usuario = (Usuario)session.getAttribute("usuario");

    long idVehiculo = Long.parseLong(request.getParameter("idVehiculo"));
    long idclase = Long.parseLong(request.getParameter("idclase"));
    long idmarca = Long.parseLong(request.getParameter("idmarca"));
    long idlinea = Long.parseLong(request.getParameter("idlinea"));
    long cilindraje = Long.parseLong(request.getParameter("cilindraje"));
    long modelo = Long.parseLong(request.getParameter("modelo"));
    long modalidadVeh = Long.parseLong(request.getParameter("modalidadVeh"));
    long carroceriaVeh = Long.parseLong(request.getParameter("carroceriaVeh"));
    long codServicio = Long.parseLong(request.getParameter("codServicio"));
    long subServicioVeh = Long.parseLong(request.getParameter("subServicioVeh"));
    long cantpasajeros = Long.parseLong(request.getParameter("cantpasajeros"));
    String capatonelaje = request.getParameter("capatonelaje");
    float valorAvaluo = Float.parseFloat(request.getParameter("valorAvaluo"));
    float valorRetencion = Float.parseFloat(request.getParameter("valorRetencion"));
    int idtablaAva = Integer.parseInt(request.getParameter("idtablaAva"));
    int anoactual = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);

    model.adicionarValorRetencion(idVehiculo, idclase, idmarca, idlinea, cilindraje, modelo, modalidadVeh, carroceriaVeh, codServicio, subServicioVeh, cantpasajeros, capatonelaje, anoactual, usuario.getId_usuario(), valorAvaluo, valorRetencion, idtablaAva);

    model.getCon().commit();
    sw="1";

}catch(Exception ex){
    model.getCon().rollback();
    System.out.println("/*-"+ex+"*/");
}
%>
<sw><%=sw %></sw>
</root>