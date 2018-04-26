<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% %>

<%
            try {
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Recursos</title>
    </head>
    <body>
        <%
                Model modelo = (Model) session.getAttribute("model");
                Model mod = new Model();
                modelo.Tramitesasociados tramitesAsociados = new modelo.Tramitesasociados();
                String nombre_tramite = request.getParameter("tipoTramite");
                String referencia = "";
                java.sql.Date fecha = null;
                fecha = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaO")).getTime());

                String observacion = "";
                String estado = request.getParameter("estado");
                Usuario usuario = (Usuario) session.getAttribute("usuario");
                int usuario_solicitante = Integer.parseInt(""+usuario.getId_usuario());
                Vehiculo vehiculo = new Vehiculo();
                vehiculo = modelo.consultarVehiculo(request.getParameter("placa"));
                Long fk_vehiculo = vehiculo.getId_vehiculo();


                tramitesAsociados.setNombre_tramite(nombre_tramite);
                tramitesAsociados.setReferencia(referencia);
                tramitesAsociados.setFecha(fecha);
                tramitesAsociados.setObservacion(observacion);
                tramitesAsociados.setEstado(estado);
                tramitesAsociados.setUsuario_solicitante(usuario_solicitante);
                tramitesAsociados.setFk_vehiculo(fk_vehiculo);
                modelo.getCon().setAutoCommit(false);
                modelo.adicionarTramiteAsociado(tramitesAsociados);
                modelo.getCon().commit();


        %>
        <script language="javascript" type="text/javascript">
            alert("Se Ha Guardado Correctamente");
            document.location.href = "consultarTramitesVehiculo.jsp?id=1";
        </script>
    </body>
</html>
<%
            } catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% }%>

