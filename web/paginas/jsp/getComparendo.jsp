<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
<% Model modelo= (Model)session.getAttribute("model"); 
if (!request.getParameter("numero").equals(null)){
	Comparendo comparendo = modelo.consultar_Comparendo(request.getParameter("numero"));
	if(comparendo!=null){
		%>
            <result>si</result>
    <%
	}else{
            %>
            <result>no</result>
            <%

	}
}else{
            %>
            <result>no</result>
            <%

	}%>
</root>