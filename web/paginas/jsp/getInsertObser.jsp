<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>

<root>
<%
Model modelo = (Model)session.getAttribute("model");

String sw = "0";

try{
    modelo.getCon().setAutoCommit(false);

    if(request.getParameter("placaveh")!=null && request.getParameter("observacion")!=null){

       modelo.InsertarObserCert(request.getParameter("placaveh"),request.getParameter("observacion"));
       sw = "1";
    }
    modelo.getCon().commit();

}catch(Exception ex){
    modelo.getCon().rollback();
    System.out.println("/*-"+ex+"*/");
}
%>
<sw><%=sw %></sw>
</root>
