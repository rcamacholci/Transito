<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="modelo.*" %>
<root>
<%
try{
	Model modelo= (Model)session.getAttribute("model");
	if(request.getParameter("numero")!=null){
		if (!request.getParameter("numero").equals("")){
			Grua agente = modelo.consultarGrua(Integer.parseInt(request.getParameter("numero")));
			if(agente!=null){%>
                             <result>si</result>
                             <nombre><%=agente.getPlaca()%></nombre>

                      <%}else{%>
                            <result>no</result>
                      <%}
                }else{%>
                    <result>no</result>
              <%}
             }else{%>
                <result>no</result>
            <%}
}catch(Exception exc){}%>
</root>