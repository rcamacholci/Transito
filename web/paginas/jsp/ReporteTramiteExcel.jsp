<%-- 
    Document   : ReporteTramiteExcel
    Created on : 12/07/2016, 04:37:16 PM
    Author     : Jonathan
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="modelo.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<% request.setCharacterEncoding("UTF-8"); %> 

<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("verDatosVehiculo.jsp")) {
                modelo.Model modelo = (modelo.Model) session.getAttribute("model");
                modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
                if (request.getParameter("year") != null) {
                    String año = request.getParameter("year");

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%            Date date = new Date();
            DateFormat hourdateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
            if (request.getParameter("opcion") != null) {

                int opcion = Integer.parseInt(request.getParameter("opcion"));
                switch (opcion) {

                    case 1:

                        response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
                        response.setHeader("Content-Disposition", "attachment;filename=\"ReporteTramiteAnuales.xls\"");

        %>
        <h1 style="margin-left:900px; color: #555">Reporte Estadistico De Recaudo Anual De Tramites Año: <%=año%></h1>
        <h4 style="margin-left: 900px; color: #555">Generado Por: <%=usuario.getNombre() + "    " + hourdateFormat.format(date)%></h4>
        <table width="100%" border="1">
            <tr>
                <th>TRAMITE</th>
                    <%
                        String cant_mes = "";
                        String total_mes = "";
                        for (int i = 1; i <= 12; i++) {
                            switch (i) {
                                case 1:
                                    cant_mes = "CANTIDAD ENERO";
                                    total_mes = "TOTAL ENERO";
                                    break;
                                case 2:
                                    cant_mes = "CANTIDAD FEBRERO";
                                    total_mes = "TOTAL FEBRERO";
                                    break;
                                case 3:
                                    cant_mes = "CANTIDAD MARZO";
                                    total_mes = "TOTAL MARZO";
                                    break;
                                case 4:
                                    cant_mes = "CANTIDAD ABRIL";
                                    total_mes = "TOTAL ABRIL";
                                    break;
                                case 5:
                                    cant_mes = "CANTIDAD MAYO";
                                    total_mes = "TOTAL MAYO";
                                    break;
                                case 6:
                                    cant_mes = "CANTIDAD JUNIO";
                                    total_mes = "TOTAL JUNIO";
                                    break;
                                case 7:
                                    cant_mes = "CANTIDAD JULIO";
                                    total_mes = "TOTAL JULIO";
                                    break;
                                case 8:
                                    cant_mes = "CANTIDAD AGOSTO";
                                    total_mes = "TOTAL AGOSTO";
                                    break;
                                case 9:
                                    cant_mes = "CANTIDAD SEPTIEMBRE";
                                    total_mes = "TOTAL SEPTIEMBRE";
                                    break;
                                case 10:
                                    cant_mes = "CANTIDAD OCTUBRE";
                                    total_mes = "TOTAL OCTUBRE";
                                    break;
                                case 11:
                                    cant_mes = "CANTIDAD NOVIEMBRE";
                                    total_mes = "TOTAL NOVIEMBRE";
                                    break;
                                case 12:
                                    cant_mes = "CANTIDAD DICIEMBRE";
                                    total_mes = "TOTAL DICIEMBRE";
                                    break;
                            }


                    %>
                <th><%=cant_mes%></th>
                <th><%=total_mes%></th>
                    <%}%>
                <th>TOTAL</th>
            </tr>

            <%
                java.util.List lista = modelo.listarTramiteByClase();
                long cantidad_mes = 0;
                long cant_total = 0;
                long cantTotalaño = 0;
                long totales = 0;

                for (int j = 0; j < lista.size(); j++) {
                    Tramite tramite = (Tramite) lista.get(j);
                    cantTotalaño = modelo.obtenerTramiteTotalByAño(tramite.getId_tramite(), año);
                    totales += cantTotalaño;
            %>
            <tr>
                <td><%=tramite != null ? tramite.getNombre() : ""%></td>


                <%
                    String mes = "";
                    for (int k = 1; k <= 12; k++) {
                        if (k < 10) {
                            mes = "0" + k + "/" + año;
                        } else {
                            mes = "" + k + "/" + año;
                        }
                        cantidad_mes = modelo.obtenerTramiteCantidadByMes(tramite.getId_tramite(), mes);
                        cant_total = modelo.obtenerTramiteCantidadTotalByMes(tramite.getId_tramite(), mes);

                %>

                <td><%=cantidad_mes%></td>
                <td><%=cant_total%></td>
                <%}
                %>
                <td><%=cantTotalaño%></td>
                <%}%>
            </tr>
            <tr>
                <th>TOTALES</th>
                    <%
                        long total_tamites_año = 0;
                        String mes_tramite = "";
                        for (int k = 1; k <= 12; k++) {
                            if (k < 10) {
                                mes_tramite = "0" + k + "/" + año;
                            } else {
                                mes_tramite = "" + k + "/" + año;
                            }
                            total_tamites_año = modelo.ObtenerTotalTramitesbyMes(mes_tramite);


                    %>
                <td colspan="2"><%=total_tamites_año%></td>
                <%}%>
                <td><%=totales%></td>
            </tr>
        </table>
        <%
                break;

            case 2:
                response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
                response.setHeader("Content-Disposition", "attachment;filename=\"ReporteVehiculosMatriculadosVigencia.xls\"");

        %>

        <h1 style="margin-left:900px; color: #555">Reporte Vehículos Matriculados Año: <%=año%></h1>
        <h4 style="margin-left: 900px; color: #555">Generado Por: <%=usuario.getNombre() + "    " + hourdateFormat.format(date)%></h4>
        <table width="100%" border="1">
            <tr>
                <th>NOMBRE PROPIETARIO</th>
                <th>TIPO DOCUMENTO</th>
                <th>DOCUMENTO</th>
                <th>DIRECCIÓN</th>
                <th>TELÉFONO</th>
                <th>CELULAR</th>
                <th>CORREO ELECTRÓNICO</th>
                <th>PLACA</th>
                <th>CLASE</th>
                <th>SERVICIO</th>
                <th>SALDO</th>
                <th>PERIODO DE PAGO</th>
            </tr>

            <%

                List<java.util.HashMap> matriculados = modelo.ListarVehiculosMatriculadosByaño(año);
                for (java.util.HashMap hash : matriculados) {%>
            <tr>
                <td><%=hash.get("NOMBRE_PROPIETARIO")%></td>
                <td><%=hash.get("TIPO_DOCUMENTO")%></td>
                <td><%=hash.get("DOCUMENTO")%></td>
                <td><%=hash.get("DIRECCION")%></td>
                <td><%=hash.get("TELEFONO")%></td>
                <td><%=hash.get("CELULAR")%></td>
                <td><%=hash.get("EMAIL")%></td>
                <td><%=hash.get("PLACA")%></td>
                <td><%=hash.get("CLASE")%></td>
                <td><%=hash.get("SERVICIO")%></td>
                <td><%=hash.get("SALDO")%></td>
                <td><%=hash.get("PERIODO_DE_PAGO")%></td>
            </tr>


            <%}%>
        </table>

            <%break;

                }%>

    </body>
</html>
<%
} else {%>
<script>
    alert("No se encontro referencia del reporte");
</script> 
<%}
%>
<%} else {
        out.print("Atencion: No se encontró información del año sobre el cual se desea generar el reporte.");
    }
%>

<%  } else { %>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<%  }

} else { %>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%
    }
} catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
    }%>