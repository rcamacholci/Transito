<%-- 
    Document   : cargarCarroceria
    Created on : 18/04/2018, 01:44:41 PM
    Author     : acadrasco
--%>

<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%  
    Model modelo = (Model) session.getAttribute("model");
    System.out.println("carroceria");
    int marca_cod = 0;
    if (request.getParameter("clase") != null) {
        marca_cod = Integer.parseInt(request.getParameter("clase").toString());
    }

    java.util.List carrocerias = modelo.listaCarroceria(marca_cod); %>
<select name="carrocerias" id="carrocerias" style="width:202px; font-size:10px; color:#333333">
    <option value="0"><<--Seleccione Carroceria-->></option>
    <%  for (int i = 0; i < carrocerias.size(); i++) {
                Parametro parametro = (Parametro) carrocerias.get(i);%>
    <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
    <%}%>
</select>