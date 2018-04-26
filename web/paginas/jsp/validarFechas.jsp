<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
    Model modelo= (Model)session.getAttribute("model");
    try{
        long id = Long.parseLong(request.getParameter("id"));
        String placa = request.getParameter("placa");
        String fi = request.getParameter("fi");
        String ff = request.getParameter("ff");
        java.util.List colores = modelo.consultarColoresPlaca(placa);
        out.print(modelo.edicionFechas(id, fi, ff, colores));
    }catch(Exception ecx){
        
    }
%>