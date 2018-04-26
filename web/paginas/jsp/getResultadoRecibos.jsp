<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="modelo.*" %>
<root>
<%
try{
	Model modelo= (Model)session.getAttribute("model");
	if(request.getParameter("noreciboANT")!=null && request.getParameter("norecibo")!=null ){
		if (!request.getParameter("noreciboANT").equals("") && !request.getParameter("norecibo").equals("")){
                        
                    Tiquete tiq1 = modelo.consultarTiqueteByFactura(request.getParameter("noreciboANT"));
                    Tiquete tiq2 = modelo.consultarTiqueteByFactura(request.getParameter("norecibo"));

                        if(tiq1.getEstado()==3){
                            if(tiq2.getEstado()==4){
                            java.util.List estadoTiquete = modelo.listarEstadoDetalleTiquete(tiq1.getId_tiquete());
                                if(estadoTiquete.size()==0){

                                    if(tiq1.getFk_persona()==tiq2.getFk_persona()){
                                        %><result>si</result><%
                                    }else{
                                        %><result>El recibo no coincide con la referencia o placa</result><%
                                    }

                                }else{
                                    %><result>El recibo se encuentra en estado Utilizado</result><%
                                }
                            }else{
                            %><result>El recibo no se encuentra en estado Preliquidado</result><%
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