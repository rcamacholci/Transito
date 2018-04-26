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
                    long idSmt = (request.getParameter("ids") != null) ? Long.parseLong(request.getParameter("ids")) : 0;

                    List<Plano> lista = modelo.listarPlanos(idSmt, sede.getId_sede());
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
        <div align="center">
            <div align="center" style="width:560px">
                <form name="form" method="post" action="javascript:validarFormulario()">
                    <fieldset>
                        <legend></legend>
                        <table border="0" align="center" width="300px" cellpadding="1" cellspacing="1">
                            <tr>
                                <td colspan="4" align="center"><div class="text">VER&nbsp;ARCHIVOS&nbsp;PLANOS</div></td>
                            </tr>
                            <tr>
                                <td class="label" align="left">Fecha Inicial</td>
                                <td class="input" align="left">
                                    <input type="text" name="fechaIni" id="fechaIni" readonly/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <div align="center">
                                        Archivos
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <%
                                    for (Plano plano : lista) {
                                        Parametro p = modelo.consultarParametro(plano.getTipo(), 84);
                                %>
                            <tr>
                                <td align="left"><%= p.getNombre() + ": "%></td>
                                <% String fecha = new java.text.SimpleDateFormat("yyyyMMdd").format(plano.getFechaCreacion()); %>
                                <td align="left"><a target="_blank" href="<%=request.getContextPath() + "/paginas/data/simit/" + fecha + "/" + plano.getConsecutivo() + "/" + plano.getNombre() + ".txt"%>"><%= plano.getNombre()%></a></td>
                                <td colspan="2">&nbsp;</td>
                            </tr>
                            <%  }
                            %>
                            </tr>
                        </table>
                    </fieldset>
                </form>
            </div>
        </div>
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

