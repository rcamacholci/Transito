<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
<% Model modelo= (Model)session.getAttribute("model");
Parametro clase = new Parametro();
Parametro servicio = new Parametro();
if (!request.getParameter("numero").equals(null)){
	Comparendo comparendo = modelo.consultar_Comparendo(request.getParameter("numero"));
	if(comparendo!=null){
            Vehiculo veh = modelo.consultarVehiculo(comparendo.getPlaca());
          if(veh!=null){
           DatosVehiculo dat1 = modelo.consultarDatosVehiculo2(veh.getId_vehiculo(),2, 40,19);
           DatosVehiculo dat2 = modelo.consultarDatosVehiculo2(veh.getId_vehiculo(),2, 40,20);
           Linea lin = modelo.getLinea(veh.getFk_linea());
           Marca mar = modelo.getMarca(lin.getFk_marca());
           Propietario pro = modelo.getUnicoPropietarioVehiculo(veh.getId_vehiculo());
           Persona per = modelo.consultarPersona(pro.getFk_persona());
        %>
            <result>1</result>
           <motor><%=dat1.getValor()%></motor>
           <chasis><%=dat2.getValor()%></chasis>
           <lin><%=lin.getNombre()%></lin>
           <mar><%=mar.getNombre()%></mar>
           <pro><%=per.getNombre_1()%> <%=per.getApellido_1()%></pro>
           <modelo><%=veh.getModelo()%></modelo>
           <documento><%=per.getDocumento()%></documento>

	<%}
        }else{            %>
            <result>2</result>
            <%

	}
}else{
            %>
            <result>2</result>
            <%

	}%>
</root>