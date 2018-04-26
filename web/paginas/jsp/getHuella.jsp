<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
<% Model modelo= (Model)session.getAttribute("model");
if (!request.getParameter("idPersona").equals(null)){
    modelo.getCon().setAutoCommit(false);
    modelo.eliminarHuella(Long.parseLong(request.getParameter("idPersona")));
    modelo.getCon().commit();
    %>
       <result>1</result>
       <% }else{ %>

          <result>2</result>
    <% }           %>

</root>