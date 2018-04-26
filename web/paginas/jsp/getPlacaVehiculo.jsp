<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>

<root>
<% Model modelo= (Model)session.getAttribute("model");
String lic = "0";
if (!request.getParameter("numero").isEmpty()){
	Vehiculo  vehiculo = modelo.consultarVehiculo(request.getParameter("numero").toUpperCase());
        if(vehiculo!=null){
            Licencia_Transito lt = modelo.consultarLicenciaTransito(vehiculo.getId_vehiculo());
            
         %>
            <result>si</result>
            <clase><%=vehiculo.getClase_vehiculo()%></clase>
            <servicio><%=vehiculo.getServicio()%></servicio>
            <%  if(lt!=null){         %>
            <licenciaT><%=lt.getNumero()%></licenciaT>
     <%
                }else{
                 %>
            <licenciaT><%=lic%></licenciaT>
     <%
                }

    	}else{
            %>
            <result>no</result>
            <%
		
	}
}else{
            %>
            <result>no</result>
            <%
		
	}
            %>
</root>