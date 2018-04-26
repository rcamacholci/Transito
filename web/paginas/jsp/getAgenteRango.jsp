<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
<% Model modelo= (Model)session.getAttribute("model");
if (!request.getParameter("numero").equals(null)){
	Detalle_Rango_Comparendo detalle_Rango_Comparendo = modelo.consultarAgentePorRangComp(request.getParameter("numero"));
        String placaAgente = ""+detalle_Rango_Comparendo.GetFk_agente()+"".trim();
	Agente agente = modelo.consultarAgente(Integer.parseInt(placaAgente));

        if(agente!=null){
		%>
            <placa><%=agente.getPlaca()%></placa>
            <nombre><%=agente.getNombre() %></nombre>
    <%
		}
}%>
</root>