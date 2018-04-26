<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro" import="modelo.Vehiculo" import="modelo.Sede" import="modelo.Usuario" errorPage="" %>

<% try {
        Model model = (Model) session.getAttribute("model");
        if (!request.getParameter("parametro").equals("")) {%>
<%
    Vehiculo vehiculo = model.consultarVehiculo(request.getParameter("parametro").toUpperCase());
    if (vehiculo != null) {
        session.setAttribute("listaLiquidacion", null);
        Sede sede = model.consultarSede(vehiculo.getFk_sede());
        if (sede != null) {%>
<select name="sede" id="sede" style="width:350px;color:#333333;font-size:11px" onchange="actualizarListados()" onblur="actualizarListados()">
    <option value="<%=sede.getId_sede() + ""%>" selected><font size="11px"><%=sede.getNombre_corto().trim().length() > 42 ? sede.getNombre_corto().substring(0, 42) : sede.getNombre_corto()%></font></option>
</select>    
<% } else {
    sede = model.consultarSede(234);
%>
<select name="sede" id="sede" style="width:350px;color:#333333;font-size:11px" onchange="actualizarListados()" onblur="actualizarListados()">
    <option value="<%=sede.getId_sede() + ""%>" selected><font size="11px"><%=sede.getNombre_corto().trim().length() > 42 ? sede.getNombre_corto().substring(0, 42) : sede.getNombre_corto()%></font></option>
</select> 
<%}
          } else { %>
<select name="sede" id="sede" style="width:350px;color:#333333;font-size:11px" onchange="actualizarListados()" onblur="actualizarListados()">
    <% //java.util.List lista = model.consultarSedes();
        java.util.List lista = new java.util.LinkedList();
        lista.add(model.consultarSede(234));
        for (int i = 0; i < lista.size(); i++) {
            Sede sede = (Sede) lista.get(i);
                    if (i == 0) {%>
    <option  value="<%=sede.getId_sede() + ""%>" selected>
        <font size="11px"><%=sede.getNombre_corto().trim().length() > 42 ? sede.getNombre_corto().substring(0, 42) : sede.getNombre_corto()%></font>
    </option>
    <%} else {%>
    <option value="<%=sede.getId_sede() + ""%>">
        <font size="11px"><%=sede.getNombre_corto().trim().length() > 42 ? sede.getNombre_corto().substring(0, 42) : sede.getNombre_corto()%></font>
    </option>
    <%  }
                     } %>
</select>
<%}
} else {
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    Sede sede = model.consultarSede(usuario.getFk_sede());
          if (sede != null) {%>
<select name="sede" id="sede" style="width:350px;color:#333333;font-size:11px" onchange="actualizarListados()" onblur="actualizarListados()">
    <option value="<%=sede.getId_sede() + ""%>" selected><font size="11px"><%=sede.getNombre_corto().trim().length() > 42 ? sede.getNombre_corto().substring(0, 42) : sede.getNombre_corto()%></font></option>
</select>    
<% }
        }
    } catch (Exception exc) {
        out.println("No conectado a Oracle");
    }
%>
