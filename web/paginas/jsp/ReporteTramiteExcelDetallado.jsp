<%-- 
    Document   : ReporteTramiteExcel
    Created on : 12/07/2016, 04:37:16 PM
    Author     : Jonathan
--%>

<%@page import="java.util.HashMap"%>
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
                if (request.getParameter("tramite") != null) {
                    response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
                    response.setHeader("Content-Disposition", "attachment;filename=\"ReporteTramiteExcelDetallado.xls\"");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Date date = new Date();
            DateFormat hourdateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

        %>
        <h1 style="margin-left:900px; color: #555">Reporte  Detallado De Tramites</h1>
        <h4 style="margin-left: 900px; color: #555">Generado Por: <%=usuario.getNombre() + "    " + hourdateFormat.format(date)%></h4>
        <table width="100%" border="1">
            <tr>
                <th>TRAMITE</th>
            </tr>
            <tr>
                <td>RADICACION</td>
                <td>NOMBRE</td>
                <td>FECHA</td>
                <td>PLACA</td>
                <td>SERVICIO</td>
            </tr>

            <%
                List<HashMap> lista = modelo.ReporteExcelTramite(request.getParameter("fecha_ini"),request.getParameter("fecha_fin"),Long.parseLong(request.getParameter("tramite")));
                for (HashMap hash : lista) {
            %>
            <tr>
                <td><%=hash.get("RADICACION")%></td>
                <td><%=hash.get("NOMBRE")%></td>
                <td><%=hash.get("FECHA")%></td>
                <td><%=hash.get("PLACA")%></td>
                <td><%=hash.get("SERVICIO")%></td>
            </tr>
            <%
                }
            %>

        </table>
    </body>
</html>
<%} else {
        out.print("Atencion: No se encontró información del Tramite sobre el cual se desea generar el reporte.");
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