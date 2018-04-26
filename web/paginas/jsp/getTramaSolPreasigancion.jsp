<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
<% 
if (session.getAttribute("tokenP")!=null){
    String trama = session.getAttribute("tokenP").toString();
    %>
       <result>1</result>
       <trama><%=trama%></trama>
       <% }else{ %>

          <result>2</result>
    <% }           %>

</root>