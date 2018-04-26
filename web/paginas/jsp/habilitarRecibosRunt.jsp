<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
<%
    if(request.getParameter("tipoLiquidacion")!=null){
        if(request.getParameter("tipoLiquidacion").equals("1")){
            session.setAttribute("runtTiquete", "1");
        }else{
            session.removeAttribute("runtTiquete");
        }
    }
%>
</root>