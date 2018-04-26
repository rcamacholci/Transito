<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
    try {
        if (session.getAttribute("model") != null) {
            System.out.println("LISTA " + ((java.util.LinkedList) session.getAttribute("permisosU")));
            System.out.println("PATH  " + request.getServletPath());
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                Model modelo = (Model) session.getAttribute("model");
                Parametro parametro = new Parametro();
                Sede sede = (Sede) session.getAttribute("sede");
                if (modelo != null) {
                    List<SolicitudAudiencia> lista = modelo.listarSolicitudesAudienciasPendientes(1);


%>
<html>
    <head>
        <title>Ver Arhivos Planos</title>
        <style type="text/css">
            .label {font-size: 11px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold ; width:110px}
            .text {font-size: 11px; color:#000000; text-align:center ; font-family:Arial; font-weight:bold ; width:120px; text-transform:uppercase}
            .date {font-size: 11px; color:#000000; text-align:center ; font-family:Arial; font-weight:bold; width:100px }
            .bdate {font-size: 10px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold; width:20px }
            .select {font-size: 11px; color:#000000; text-align:left ; font-family:Arial; font-weight:bold; width:120px }
            .input { width:130px }
            .check { font-size: 11px; color:#000000; text-align:center ; font-family:Arial; font-weight:bold; }
        </style>
        <link title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
        <script type="text/javascript" src="../html/scripts/adicionarComparendo.js"></script>
        <script type="text/javascript" src="../html/scripts/consultasGenerales.js"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
    </head>
    <body>
        <form name="form" id="form" method="POST">
            <table name="parentT" border="0" width="60%" align= "center">
                <tr>
                    <td class="title_" align="center">
                        SOLICITUDES PENDIENTES
                    </td>
                </tr>
                <tr>
                    <td align="center">Numero</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </form>
    </body>
</html>
<%   }
} else {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<% }
} else {%>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%            }
} catch (Exception mexe) {
    System.out.println("EXCEPCION  " + mexe);%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="2"></jsp:param>
    <jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param>
</jsp:forward>
<%  }%>

