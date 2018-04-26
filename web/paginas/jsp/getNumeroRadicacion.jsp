<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>

<root>
<% Model modelo = (Model) session.getAttribute("model");
    String mensaje = "";
    Radicacion ra = new Radicacion();
    if (request.getParameter("numero")!="" && request.getParameter("numR")!="" ) {
        ra = modelo.consultarRadicacionPlacaTramite(request.getParameter("numR").toUpperCase(), request.getParameter("numero").toUpperCase(), 3);
        if(ra!=null){
        Vehiculo vehiculo = modelo.consultarVehiculo(request.getParameter("numero").toUpperCase());
        if (vehiculo != null) {
            if (vehiculo.getEstado() == 4) {
                if (vehiculo.getFecha_matricula() != null) {
                    mensaje = "si";
                } else {
                    mensaje = "El vehiculo se encuentra sin fecha de matricula";
                }
            } else {
                mensaje = "El vehiculo no se encuentra en estado trasladado";
            }
        } else {
            mensaje = "El vehiculo no se encuentra en la base de datos";
        }
    }else{
        mensaje = "La radicacion no corresponde con el vehiculo";
    }
    }
%>
<mensaje><%=mensaje%></mensaje>
</root>