<?xml version="1.0" encoding="UTF-8"?>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" %>
<root>
<%
try{
    conf.civitrans.webservices.Runt.WSrunt wsr = new conf.civitrans.webservices.Runt.WSrunt();
    if(wsr.AutenticarFuncionario(request)){
        %><result>1</result><trama><%=wsr.getToken() %></trama><%
    }else{
        %><result>2</result><%
    }
    %><mensaje><%=wsr.getMensaje() %></mensaje><%
 }catch(Exception ex){
 System.err.println("Error AutenticarFuncionario validar token");
     ex.printStackTrace();
 }
%>
</root>