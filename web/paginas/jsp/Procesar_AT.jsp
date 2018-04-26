<%-- 
    Document   : Procesar_AT
    Created on : 15/06/2013, 08:55:36 AM
    Author     : ORLA
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.*" import="java.*"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
    Model model = new Model();
    try {
        model.getCon();
        model.conectar();
        String placa = request.getParameter("placa").toUpperCase();
        String rad = request.getParameter("radicacion");
        Sede sede = (Sede) session.getAttribute("sede");
        String fecha_resolucion = request.getParameter("ff");
//java.text.SimpleDateFormat("yyyy/MM/dd").format(new java.text.SimpleDateFormat("").parse(request.getParameter("ff")));
        java.sql.Date fechaF = new java.sql.Date(new java.text.SimpleDateFormat("yyyy/MM/dd").parse(request.getParameter("ff")).getTime());

        System.out.println("->" + fechaF);
        Vehiculo veh = model.consultarVehiculo(placa);
//System.out.println("ok ->"+veh.getPlaca());

        Radicacion rads = model.consultarRadicacion(rad, fechaF, sede.getId_sede());
        if (rads != null) {
            if (rads.getEstado() == 4) {
%>
<jsp:forward page="aprobarTramites.jsp">
    <jsp:param name="radicacion" value="<%=rad%>" />
    <jsp:param name="fecha_radicacion" value="<%=fecha_resolucion%>" />
</jsp:forward>
<%
} else {
    model.getCon().setAutoCommit(false);
    model.actualizarEstadoRadicacion(rads.getId_radicacion(), 4);
    model.getCon().commit();
    //window.location.href="AplicarTramite_ita.jsp";
%>
<script language="javascript" type="text/javascript">
    //alert("entro script");
    window.location.href = "aprobarTramites.jsp?radicacion=<%=rad%>&fecha_radicacion=<%=request.getParameter("ff")%>";
</script>

<%
    }

} else {
    System.out.println("Radiciacion null");
%>
<script language="javascript" type="text/javascript">
    alert("No se encontro Radicacion <%=rad%> para el la fecha <%=fechaF%>");
    // window.location.href="aprobarTramites.jsp?radicacion=<%//rad%>&fecha_radicacion=<%//request.getParameter("ff")%>";
</script>
<%

        }
    } catch (Exception ex) {
        System.out.println("-->" + ex);
    }


%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

    </body>
</html>
