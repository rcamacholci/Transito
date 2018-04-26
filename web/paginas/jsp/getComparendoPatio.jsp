<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
<% Model modelo= (Model)session.getAttribute("model");
Parametro clase = new Parametro();
Parametro servicio = new Parametro();
if (!request.getParameter("numero").equals(null)){
	Comparendo comparendo = modelo.consultar_Comparendo(request.getParameter("numero"));
	if(comparendo!=null){
            

            %>
            <result>1</result>
            <placa><%=comparendo.getPlaca()%></placa>
    <%
      servicio = modelo.consultarParametro(comparendo.getServicio(), 3);
      clase = modelo.consultarParametro(comparendo.getClase(), 1);
      %>
      <clase><%=clase.getNombre()%></clase>
      <servicio><%=servicio.getNombre()%></servicio>
	<% }else{
            %>
            <result>3</result>
            <%

	}
}else{
            %>
            <result>3</result>
            <%

	}%>
</root>