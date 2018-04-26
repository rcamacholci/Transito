<%--
    Documento   : consultaFinanfrm 
    Creado      : 23-mar-2010, 13:54:18
    Autor       : Desarrollo
    Corregido   : 26/12/2017
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*,java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                String fecha_hoy = new java.text.SimpleDateFormat("yyyy/MM/dd").format(new java.util.Date());
%>

<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<script src="../html/scripts/calendar.js" type="text/javascript"></script>
<script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
<script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>


<script language="javascript" type="text/javascript">
    function validarCampos() {
        if (document.form.radicacion.value.length > 0) {
            if (!isNaN(document.form.radicacion.value)) {
                if (document.form.fecha.value.length > 0) {
                    return true;
                } else {
                    alert("Seleccione fecha de radicacion");
                }
            } else {
                alert("Numero de radicacion invalido");
            }
        } else {
            alert("Ingrese numero de radicacion");
        }
        return false;
    }

    function verPersona() {
        var tipo = document.form.tipo.value;
        var documento = document.form.documento.value;
        if (document.form.documento.value > 0) {
            window.frames[0].location.href = "verFinanciacion_Imp.jsp?tipo=" + tipo + "&documento=" + documento + "&opcion=2";
        } else {
            alert("Digite numero de Documento")
        }
    }


    function buscarFecha() {
        if (document.form.fechaI.value.length == 10 && document.form.fechaF.value.length == 10) {
            window.frames[0].location.href = "verFinanciacionFecha_imp.jsp?fi=" + document.form.fechaI.value + "&ff=" + document.form.fechaF.value + "&opcion=1";
        } else {
            alert("Digite fechas de Las Financiaciones");
        }
    }



    function ver() {
        if (document.form.busqueda[0].checked) {
            document.getElementById('tabla1').style.display = "block";
            document.getElementById('tabla2').style.display = "none";
            document.getElementById('tabla3').style.display = "none";
        } else {
            if (document.form.busqueda[1].checked) {
                document.getElementById('tabla1').style.display = "none";
                document.getElementById('tabla2').style.display = "block";
                document.getElementById('tabla3').style.display = "none";

            } else {
                document.getElementById('tabla1').style.display = "none";
                document.getElementById('tabla2').style.display = "none";
                document.getElementById('tabla3').style.display = "block";
            }

        }
    }

</script>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <style type="text/css">
            .label {font-size: 11px; color:#333333; text-align:center ; font-family:Arial; font-weight:bold ; width:70px}
            .text {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; width:200px; text-transform:uppercase}
            .check { font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; }
            .title {font-size: 12px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; text-transform:uppercase}
            .style2 {font-weight: bold}
            .style3 {color: #333333}
            .style4 {font-weight: bold; font-size: 12px;}
        </style>
    </head>
    <body>
        <form target="financiacion" action="verFinanciacion_Imp.jsp" name="form" method="post">
            <fieldset>
                <legend class="title">CONSULTAR FINANCIACION</legend>
                <table width="100%" border="0" cellpadding="1" cellspacing="1" align="center">
                    <input type="hidden" name="opcion" id="opcion" value="1"/>

                    <tr>
                        <td colspan="2" valign="middle" align="center" width="30%"><span class="Estilo11 style3">
                                <input type="radio" name="busqueda" value="1" checked="checked" onClick="ver()">
                                <span class="style4">N&ordm;&nbsp;DE FINANCIACION</span></span></td>
                        <td colspan="2" valign="middle" align="center" width="30%"><span class="Estilo11 style3">
                                <input type="radio" name="busqueda" value="2"  onClick="ver()">
                            </span><span class="style4"> N&ordm;&nbsp;DE CEDULA </span></td>
                        <td colspan="2" valign="middle" align="center" width="30%"><span class="style4">
                                <input type="radio" name="busqueda" value="3" onClick="ver()">
                                FECHAS&nbsp;DE&nbsp;FINANCIACION</span></td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <table  id="tabla1" border="0" width="300px" cellpadding="1" cellspacing="1" align="center">
                                <tr>
                                    <td class="style4">NUMERO</td>
                                    <td>
                                        <input name="numeroF" type="text" class="text">
                                    </td>
                                    <td>
                                        <input type="submit" value="Consultar" class="check">
                                    </td>
                                </tr>
                            </table>
                            <table border="0" width="100%" id="tabla2"  style="display:none">
                                <tr valign="middle">
                                    <td width="10%"><span class="style2">TIPO&nbsp;DOCUMENTO </span></td>
                                    <td width="21%" scope="col" align="center">
                                        <select name="tipo"  style=" width:180px; color:#333333; font-size:12px">
                                            <%
                                                Model modelo = (Model) session.getAttribute("model");
                                                session.removeAttribute("certificado");
                                                session.removeAttribute("id_persona");
                                                Parametro parametro = new Parametro();
                                                List list = modelo.listadoParametros(5);
                                                Iterator it = list.iterator();
                                                while (it.hasNext()) {
                                                    parametro = (Parametro) it.next();
                                            %>
                                            <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
                                            <%}%>
                                        </select>
                                    </td>
                                    <td width="10%"><strong class="style2">DOCUMENTO</strong></td>
                                    <td width="22%" scope="col"><input type="text" name="documento" style="color:#333333; font-size:12px; text-align:center" value=""/>
                                    </td>
                                    <td width="20%"><input type="button" name="consultar" onClick="verPersona()" value="Consultar"/></td>
                                </tr>
                            </table>
                            <table border="0" width="100%" id="tabla3" style="display:none" >
                                <tr valign="middle">
                                    <td width="23%" align="right">
                                        <label class="style4" style="color:#333333">
                                            <span class="style5">FECHA&nbsp;INICIAL</span>
                                        </label>
                                    </td> 
                                    <td width="21%" scope="col" align="right"><input  id="fechaI" name="fechaI" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this, '/', true)" maxlength="10" value="<%=fecha_hoy%>"/>
                                        <input name="bfechaI" type="button" id="bfechaI" value="..." style="width:20px">
                                        <Script type="text/javascript">
                                            Calendar.setup({
                                                inputField: "fechaI",
                                                ifFormat: "%Y/%m/%d",
                                                button: "bfechaI"
                                            });
                                        </Script>
                                    </td>
                                    <td width="17%"  align="center"><label class="style4" style="color:#333333"><span class="style5">FECHA&nbsp;FINAL</span></label>								  </td>
                                    <td width="22%" scope="col"><input  id="fechaF" name="fechaF" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this, '/', true)" maxlength="10" value="<%=fecha_hoy%>"/>
                                        <input name="bfechaF" type="button" id="bfechaF" value="..." style="width:20px">
                                        <Script type="text/javascript">
                                            Calendar.setup({
                                                inputField: "fechaF",
                                                ifFormat: "%Y/%m/%d",
                                                button: "bfechaF"
                                            });
                                        </Script>
                                    </td>
                                    <td width="9%" scope="col">
                                        <input id="consultar"  name="consultar2" type="button" value="Consultar" style="color:#333333" onClick="buscarFecha()"/>
                                    </td>
                                    <td width="8%" scope="col" align="center">
                                        <input id="reporte"  name="reporte" type="button" value="Reporte" style="color:#333333" onClick="verReporte()"/>
                                    </td>
                                </tr>
                            </table> 
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <iframe frameborder="0" width="100%" height="450px" name="financiacion"></iframe>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </form>
    </body>
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