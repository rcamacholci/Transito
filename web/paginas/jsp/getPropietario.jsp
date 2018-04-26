<%@page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro" import="modelo.Vehiculo" import="modelo.Cartera" import="modelo.Concepto"  import="modelo.Propietario"  import="modelo.Persona" errorPage="" %>
<%
    try {
        Model modelo = (Model) session.getAttribute("model");
        if (!request.getParameter("placa").equals(null)) {
            System.out.println("placaS = " + request.getParameter("placa"));
            Vehiculo vehiculo = modelo.consultarVehiculo(request.getParameter("placa").toUpperCase());
            java.util.HashMap listaTipos = modelo.crearHashParametrosAbreviatura(5);
            if (vehiculo != null) {

                List<Propietario> listPro = modelo.consultaPropietarios(vehiculo.getPlaca());
                if (listPro.size() == 1) {
                    Persona persona = modelo.consultarPersona(listPro.get(0).getFk_persona());
%>
<input type="text"  name="propietario" readonly="readonly" id="propietario" style="width:600px;" value="<%=listaTipos.get(persona.getTipo_documento() + "") + " " + persona.getDocumento() + " - " + persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "") + " " + persona.getNombre_1()%>"/>
<%
} else if (listPro.size() > 1) {

%>
<select id="propietario">
    <%    for (Propietario obj : listPro) {
            Persona persona = modelo.consultarPersona(obj.getFk_persona());
    %>
    <option  style="width:600px;" value="<%=persona.getId_persona()%>" ><%=listaTipos.get(persona.getTipo_documento() + "") + " " + persona.getDocumento() + " - " + persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "") + " " + persona.getNombre_1()%></option>
    <%}%>
</select>
<%
                }
            }
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>

