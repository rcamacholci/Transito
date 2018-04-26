<%@page import="com.movillife.Parametros"%>
<%@page import="modelo.Parametro"%>
<%@page import="modelo.Model"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%
            try {
                modelo.Model model = new Model();
                model.conectar();
                model.getCon().setAutoCommit(false);
                modelo.Sede sede = (modelo.Sede) session.getAttribute("sede");
                long id = Long.parseLong(request.getParameter("id"));
                modelo.Concepto conc = model.consultarConcepto(id);

        %>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <!-- Viewport Metatag -->
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
            <!-- Viewport Metatag -->
            <meta name="viewport" content="width=device-width,initial-scale=1.0">
                <script>
                    function guardarConceptos() {
                        ajax2 = nuevoAjax3();
                        var tramite = document.form.tramite.value;
                        var idconp = document.form.id.value;
                        var resolucion = document.form.resolucion.value;
                        var fecha = document.form.fecha.value;
                        var valor = document.form.valor.value;
                        ajax2.open("POST", "SetConfiguracionConcepto.jsp", true);
                        ajax2.onreadystatechange = function () {

                            if (ajax2.readyState == 4) {
                                var docxml = ajax2.responseXML;
                                var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue
                                if (result == '1') {
                                    var mensaje = docxml.getElementsByTagName('msg')[0].childNodes[0].nodeValue
                                    alert(mensaje);
                                    document.location.href = "ListConfiguracionConcepto.jsp?reso=" + resolucion + "&fecha=" + fecha;
                                } else {
                                    var mensaje = docxml.getElementsByTagName('msg')[0].childNodes[0].nodeValue
                                    alert(mensaje);
                                }
                            }
                        }
                        ajax2.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                        ajax2.send("id=" + idconp + "&tramite=" + tramite + "&resolucion=" + resolucion + "&fecha=" + fecha + "&valor=" + valor);
                    }
                    function nuevoAjax3() {
                        var xmlhttp = false;
                        try {
                            xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
                        } catch (e) {
                            try {
                                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                            } catch (E) {
                                xmlhttp = false;
                            }
                        }
                        if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
                            xmlhttp = new XMLHttpRequest();
                        }
                        return xmlhttp;
                    }
                    function validarDatos() {
                        var prioridad = document.form.tramite.value.trim();
                        var NombreColor = document.form.txt_Nombre_Concepto.value.trim();
                        var valor = document.form.valor.value.trim();

                        if (NombreColor.length > 0) {
                            if (valor > 0) {
                                if (prioridad > 0) {
                                    guardarConceptos();
                                } else {
                                    if (confirm("Se aplicara el valor de $" + valor + " a al concepto " + NombreColor + " para todos sus tramites asociados")) {
                                        guardarConceptos();
                                    }
                                }
                            } else {
                                alert("El campo valor no puede estar vacio")
                                document.form.valor.focus();
                            }
                        } else {
                            alert("El campo nombre no puede estar vacio")
                        }
                    }
                    function datos() {
                        var salrio = document.form.salrio.value;
                        salrio = salrio / 30;
                        var salario = document.form.salario.value;
                        salrio = salrio * salario;
                        document.getElementById("valor").value = parseInt(salrio);
                    }
                </script>
                <script src="../../html/scripts/motorAjax.js" type="text/javascript"></script>
                <!-- Plugin Stylesheets first to ease overrides -->
                <link rel="stylesheet" type="text/css" href="../../plugins/colorpicker/colorpicker.css" media="screen">
                    <link rel="stylesheet" type="text/css" href="../../html/css/Style.css" media="screen">
                        <!-- Required Stylesheets -->
                        <link rel="stylesheet" type="text/css" href="../../bootstrap/css/bootstrap.min.css" media="screen">
                            <link rel="stylesheet" type="text/css" href="../../css/fonts/ptsans/stylesheet.css" media="screen">
                                <link rel="stylesheet" type="text/css" href="../../css/fonts/icomoon/style.css" media="screen">
                                    <link rel="stylesheet" type="text/css" href="../../css/mws-style.css" media="screen">
                                        <link rel="stylesheet" type="text/css" href="../../css/icons/icol16.css" media="screen">
                                            <link rel="stylesheet" type="text/css" href="../../css/icons/icol32.css" media="screen">
                                                <!-- Demo Stylesheet -->
                                                <link rel="stylesheet" type="text/css" href="../../css/demo.css" media="screen">
                                                    <!-- jQuery-UI Stylesheet -->
                                                    <link rel="stylesheet" type="text/css" href="../../jui/css/jquery.ui.all.css" media="screen">
                                                        <link rel="stylesheet" type="text/css" href="../../jui/jquery-ui.custom.css" media="screen">
                                                            <!-- Theme Stylesheet -->
                                                            <link rel="stylesheet" type="text/css" href="../../css/mws-theme.css" media="screen">
                                                                <link rel="stylesheet" type="text/css" href="../../css/themer.css" media="screen">

                                                                    <title>Documento sin t&iacute;tulo</title>
                                                                    </head>
                                                                    <form id="form" name="form" class="mws-form">
                                                                        <body>
                                                                            <div style="width: 99%" align="center">
                                                                                <div >
                                                                                    <div>
                                                                                        <span style="color:#003366;font-style:italic"><i class="icon-table"></i>Conf. Conceptos</span>
                                                                                    </div>
                                                                                    <%                                                                        java.util.List<modelo.Salarios_Minimos> salrio = model.consultarSalariosMinimos(0, 2015);
                                                                                    %>
                                                                                    <input type="hidden" id="resolucion" name="resolucion" value="<%=request.getParameter("resolucion")%>"/>
                                                                                    <input type="hidden" name="salrio" id="salrio" value="<%=salrio.get(0).getValor()%>" />
                                                                                    <input type="hidden" id="fecha" name="fecha" value="<%=request.getParameter("fecha")%>"/>
                                                                                    <input type="hidden" id="id" name="id" value="<%=request.getParameter("id")%>"/>
                                                                                    <table class="mws-table" style="width: 100%">                                                                        
                                                                                        <tr >
                                                                                            <td width="31%" style="color: #000000;text-align: left"><i class="icon-tasks"/>&nbsp;&nbsp;Nombre</td>
                                                                                            <td width="26%"><input type="text"  style="font-variant-caps: all-small-caps" size="40%" name="txt_Nombre_Concepto" id="txt_Nombre_Concepto" disabled readonly value="<%=conc.getNombre()%>" onKeyPress="return soloTexto(event)" /></td>
                                                                                            <td colspan="2">&nbsp;</td>
                                                                                            <td colspan="2">&nbsp;</td>

                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td width="31%" style="color: #000000;text-align: left"><i class="icon-tasks"/>&nbsp;Tramite(s)&nbsp;Asosiado(s)</td>
                                                                                            <!--<td style="color:#000000;text-align: left"><i class="icon-tasks"></i>&nbsp;Tramite(s)&nbsp;Asosiado(s)</td>-->
                                                                                            <td>
                                                                                                <select class="select" style="width:300px" id="tramite" name="tramite">
                                                                                                    <%
                                                                                                        try {
                                                                                                            java.util.List<modelo.Sede_tramite_concepto> listtra = model.ListaTramitebyconcepto(id, sede.getId_sede());
                                                                                                            if (listtra.size() > 1) {
                                                                                                    %><option value="0"><-Todo los Tramites -></option><%
                                                                                                          }
                                                                                                          for (int i = 0; i < listtra.size(); i++) {
                                                                                                              modelo.Tramite tra = model.consultarTramite(listtra.get(i).getFk_tramite());%>
                                                                                                    <option value="<%=tra.getId_tramite()%>"><%=tra.getNombre()%></option>
                                                                                                    <%
                                                                                                            }
                                                                                                        } catch (Exception ex) {
                                                                                                            out.println("Error Option tramites Asosiados (ProcesoConfigurarConceptos)");
                                                                                                            ex.printStackTrace();
                                                                                                        }
                                                                                                    %>
                                                                                                </select>
                                                                                            </td>
                                                                                            <td width="6%" style="color: #000000;text-align: left"><i class="icon-tasks"/>&nbsp;Salario&nbsp;</td>
                                                                                            <td width="4%"><input type="text" style="font-variant-caps: all-small-caps" onKeyPress="return soloNumerosYpunto(event)" onblur="datos()" size="4"  name="salario" id="salario" /></td>

                                                                                            <td width="3%" style="color: #000000;text-align: left"><i class="icon-tasks"/>&nbsp;Valor&nbsp;</td>
                                                                                            <td width="30%"><input type="text" style="font-variant-caps: all-small-caps" size="10%" name="valor" id="valor" onKeyPress="return soloNumeros(event)" /></td>
                                                                                        </tr>

                                                                                        <tr style="color: #000000;text-align: center">
                                                                                            <td colspan="2" class=""><i class="icon-tasks"/>&nbsp;</td>
                                                                                            <td colspan="4"  style="color:#003366;cursor: pointer" > <input type="button" value="Adicionar" onclick="validarDatos()"></input></td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </div>
                                                                        </body>
                                                                    </form>
                                                                    </html> <%                                                                            } catch (Exception ex) {
                                                                        ex.printStackTrace();
                                                                    }%>