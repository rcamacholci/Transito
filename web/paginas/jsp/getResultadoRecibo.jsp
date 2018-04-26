<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="modelo.*" %>
<root>
<%
try{
	Model modelo= (Model)session.getAttribute("model"); 
	if(request.getParameter("norecibo")!=null){
		if (!request.getParameter("norecibo").equals("")){
                        Tiquete tiq = modelo.consultarTiqueteByFactura(request.getParameter("norecibo"));
                        if(tiq.getEstado()==3){
                            java.util.List estadoTiquete = modelo.listarEstadoDetalleTiquete(tiq.getId_tiquete());
                                if(estadoTiquete.size()==0){
                                        %><result>si</result><%
                                }else{
                                    %><result>El recibo se encuentra en estado Utilizado</result><%
                                }
                        }else{
                        %><result>El recibo no se encuentra en estado Aplicado</result><%
                        }
                }else{%>
                    <result>no</result>
              <%}
         }else{%>
                    <result>no</result>
          <%}
             
        
}catch(Exception exc){}%>
</root>