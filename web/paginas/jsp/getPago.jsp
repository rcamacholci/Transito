<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
<% Model modelo= (Model)session.getAttribute("model");
if (!request.getParameter("pago").equals(null)){
    Tiquete tiquete = modelo.consultarTiqueteByFactura(request.getParameter("pago").toUpperCase());
	if(tiquete!=null){
            Detalle_Tiquete detalleT = modelo.consultarDetalleTiqueteEstado(tiquete.getId_tiquete(),1);
               if(detalleT!=null){
                   Persona persona = modelo.consultarPersona(tiquete.getFk_persona());
                   if(persona!=null){
                   %>
                        <result>1</result>
                        <persona><%= persona.getDocumento()+" "+persona.getNombre_1()+" "+persona.getApellido_1().replace("Ñ","N") %></persona>
                   <%
                   }else{
                   System.out.println("No se encontro persona");
                   }
                        if(detalleT.getFk_tramite()!= 0){
                                Tramite tramite = modelo.consultarTramite(detalleT.getFk_tramite());
                        %>
                        <tramiteCod><%=tramite.getId_tramite()%></tramiteCod>
                        <tramite><%=tramite.getNombre() %></tramite>
                        <%
                        long tra = tramite.getId_tramite();
                            if(tra==28||tra==29||tra==30||tra==31||tra==34||tra==35||tra==57){ %>
                                <tipoPago>LICENCIA</tipoPago>
                                <sw>1</sw>
                        <%  }else{%>
                                <tipoPago>VEHICULO</tipoPago>
                                <sw>2</sw>
                   <%       }
                       }
                 }else{ %>
                 <result>2</result>
               <% }
       }else{  %>
          <result>3</result>
    <% }
}
            %>

</root>