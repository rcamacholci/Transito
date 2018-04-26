<?xml version="1.0" encoding="iso-8859-1"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="modelo.*" %>
<root>
<% Model modelo= (Model)session.getAttribute("model");
if (!request.getParameter("documento").isEmpty()){
	Persona persona = modelo.consultarPersona(Integer.parseInt(request.getParameter("tipo")),request.getParameter("documento"));
	if(persona!=null){
            %>
            <result>si</result>
             <nombre1><%=persona.getNombre_1().trim()%></nombre1>
             <nombre2><%=(persona.getNombre_2() != null ? persona.getNombre_2().trim() : "null")%></nombre2>
             <apellido1><%=persona.getApellido_1().trim()%></apellido1>
             <apellido2><%=(persona.getApellido_2() != null ? persona.getApellido_2().trim() : "null")%></apellido2>
      <%}else{%>
            <result>no</result>
      <%}
}else{%>
    <result>no</result>
<%}%>
</root>