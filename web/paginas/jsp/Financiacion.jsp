<%--
    Document   : Financiacion
    Created on : 10/02/2010, 04:46:17 PM
    Author     : Jorge Lopez
--%>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" import="modelo.*" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
            try {
                if (session.getAttribute("model") != null) {
                    if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                        session.removeAttribute("carteraF");
                        Model modelo = (Model) session.getAttribute("model");
                        modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
%>


<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Financiacion</title>

        <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <meta http-equiv=Content-Type content="text/html; charset=windows-1252"/>
        <link title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script src="../html/scripts/motorAjax.js" type="text/javascript"></script>
        <script src="../html/scripts/financiacion.js" type="text/javascript"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <style type="text/css">
            .label {font-size: 11px; color:#333333; text-align:center ; font-family:Arial; font-weight:bold ; width:70px}
            .text {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; width:100px; text-transform:uppercase}
            .date {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; width:100px }
            .bdate {font-size: 10px; color:#333333; text-align:left ; font-family:Arial; font-weight:bold; width:20px }
            .select {font-size: 11px; color:#003366; text-align:left ; font-family:Arial; font-weight:bold; width:120px }
            .input { width:130px }
            .check { font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; }
            .title {font-size: 12px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; text-transform:uppercase}
        </style>
    </head>
    <%
            try {
    %>
    <body>
        <div align="center">
            <div style="width:800px" align="center">
                <table width="800px" border="0" align="center">
                    <tr>
                        <td colspan="2" align="center"><span class="title">FINANCIACION DE CARTERAS</span></td>
                    </tr>
                    <tr>
                        <td colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="2" scope="col" align="center">
                            <fieldset>
                                <form action="javascript:consultarDatosFinanciacion()">
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td scope="col" class="label">Placa</td>
                                            <td scope="col">
                                                <input id="placa" name="placa" autocomplete="off" type="text" class="text" maxlength="6" disabled="disabled"/>
                                            </td>
                                            <td scope="col" class="label">Tipo</td>
                                            <td scope="col">
                                                <select name="tipos" id="tipos" class="select" style="width:140px">
                                                    <%
                                                        java.util.List listaTipos = modelo.listadoParametros(5);
                                                        for (int i = 0; i < listaTipos.size(); i++) {
                                                            Parametro parametro = (Parametro) listaTipos.get(i);%>
                                                    <option value="<%=parametro.getCodigo()%>"><%=parametro.getNombre()%></option>
                                                    <%	}   %>
                                                </select>
                                            </td>
                                            <td scope="col" class="label">Documento</td>
                                            <td scope="col">
                                                <input name="documento" id="documento" autocomplete="off" type="text" class="text" maxlength="11" onblur=""/>

                                            </td>
                                            <td scope="col"><input type="text" readonly name="nombre_rs" id="nombre_rs" class="text" style="width:230px"/></td>
                                            <td scope="col"><input id="consultar" type="submit" class="check" value="Consultar" /></td>
                                        </tr>
                                    </table>
                                </form>
                            </fieldset>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td width="400px" valign="top">
                            <table width="400px" border="0" id="contenedor" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td valign="top" width="400px" colspan="2">
                                        <fieldset>
                                            <legend class="label">Total Carteras</legend>
                                            <iframe src="verCarteraFinanciacion.jsp?id=0" width="400px" height="370px"  name="iframeCartera"  frameborder="0" marginheight="0" marginwidth="0"></iframe>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td valign="top" width="400px">
                            <fieldset>
                                <legend class="label">Parametros Financiacion</legend>
                                <iframe src="calcularTipoFinanciacion.jsp" width="400px" height="370px"  name="iframeTipo" scrolling="no"  frameborder="0" marginheight="0" marginwidth="0"></iframe>
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </body>
    <%
                    } catch (Exception exc) {
                        exc.printStackTrace();
                    }
    %>
</html>
<%  } else {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<%  }
                } else {%>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%    }
            } catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%            }%>