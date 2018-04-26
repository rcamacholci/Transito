<%-- 
    Document   : SetDescuento
    Created on : 28/08/2017, 09:01:02 AM
    Author     : Jcarreno
--%>
<%@page import="modelo.*"%>
<%@page import="modelo.Conf_Descuento"%>
<?xml version="1.0" encoding="UTF-8"?>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<root>
<%
    try {
        Conf_Descuento descuento = new Conf_Descuento();
        long fk_vehiculo = Long.parseLong(request.getParameter("valor"));
        Model model = (Model) session.getAttribute("model");
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        boolean des;
        if (request.getParameter("op") == null) {
            des = descuento.aplicarDescuentoCartera(model, fk_vehiculo, usuario);
        } else {
            des = descuento.eliminarDescuento(model, fk_vehiculo, usuario,1);
        }
        if (des) {%>
<stt>Operacion Correcta</stt>
            <%} else {%>
<stt>Error Aplicando El interes</stt>
    <%}
    } catch (Exception e) {%>
<stt><%=e.getMessage()%></stt>
    <%}%>
</root>