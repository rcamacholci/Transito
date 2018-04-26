<%@page import="com.movillife.Parametros"%>
<%@page import="modelo.Parametro"%>
<%@page import="modelo.Model"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%
            try {
                Model model = (Model) session.getAttribute("model");
                java.util.LinkedList listado_bancos = model.listado_bancos();
                model.conectar();
                model.getCon().setAutoCommit(false);
                String fecha_hoy = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <!-- Viewport Metatag -->
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
            <!-- Viewport Metatag -->
            <meta name="viewport" content="width=device-width,initial-scale=1.0">
                <script src="../../html/scripts/personas.js" type="text/javascript"></script>
                <LINK title=win2k-cold-1 media=all href="../../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
                <script src="../../html/scripts/calendar.js" type="text/javascript"></script>
                <script src="../../html/scripts/calendar-es.js"ol type="text/javascript"></script>
                <script src="../../html/scripts/calendar-setup.js" type="text/javascript"></script>
                <script src="../../html/scripts/validarFecha.js" type="text/javascript"></script>
                <script language="javascript" type="text/javascript">
                    
                    function nuevoAjax() {
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
                        var Refe = document.form.Resolucion.value.trim();
                        var fecha = document.form.fecha.value.trim();
                        if (Refe.length > 0) {
                            if (fecha.length==10) {
                                window.frames[0].location.href="ListConfiguracionConcepto.jsp?reso="+Refe+"&fecha="+fecha;
                            } else {
                                alert("El campo Cuenta no debe estar vacio")
                            }
                        } else {
                            alert("El campo Resolucion no debe estar vacio")
                        }
                    }
                    
                </script>
                <!-- Plugin Stylesheets first to ease overrides -->
                <link rel="stylesheet" type="text/css" href="../../plugins/colorpicker/colorpicker.css" media="screen">
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
                                                                        <div class="mws-panel-body" style="width: 95%" align="center">
                                                                            <div class="mws-panel grid_8">
                                                                                <div class="mws-panel-header">
                                                                                    <span class="label"><i class="icon-table"></i>Configuracion Concepto</span>
                                                                                </div>
                                                                                <table class="mws-table" style="width: 100%">
                                                                                    <tr style="color: #000000;text-align: center">
                                                                                        <td   style="border:none"><div align="left"><span class="txt" ><i class="icon-tasks"/>&nbsp;&nbsp;RESOLUCION</span></div></td>
                                                                                        <td style="border:none"><input name="Resolucion" type="text" id="Resolucion" onkeypress="return soloNumeros(event)" style="width:100px" />
                                                                                        </td>
                                                                                        <td >&nbsp;</td>
                                                                                        <td   style="border:none"><div align="left"><span ><i class="icon-tasks"/>&nbsp;&nbsp;FECHA</span></div></td>
                                                                                        <td colspan="1"><span><input  id="fecha" name="fecha" type="text" style="width:100px" disabled readonly onkeyup="mascara(this, '/', true)" maxlength="10" value="<%=fecha_hoy%>"/></span>&nbsp;<input name="bfecha" type="button" id="bfecha" value="<" />
                                                                                            <script type="text/javascript">
                                                                                                Calendar.setup({
                                                                                                    inputField: "fecha",
                                                                                                    ifFormat: "%d/%m/%Y",
                                                                                                    button: "bfecha"
                                                                                                });
                                                                                            </script>
                                                                                        </td>
                                                                                            <td style="cursor: pointer" align="center"><input type="button" value="Consular" onclick="validarDatos()"/></td>
                                                                                    </tr>
                                                                                    <tr  style="color:black;height:5px" onmouseover="pointer">
                                                                                <td align="center" ><i class="icon-tasks"/>&nbsp;Codigo Concepto</td>
                                                                                <td align="center" colspan="5"><i class="icon-tasks"/>&nbsp;Nombre Concepto</td>
                                                                            </tr>

                                                                                            <tr>
                                                                                    <td colspan="6">
                                                                                    <fieldset>
                                                                                        <iframe id="targe" name="targe" src="#" width="100%" height="290" />
                                                                                    </fieldset>
                                                                                    </td>
                                                                                </tr>
                                                                                </table>
                                                                            </div>
                                                                        </div>
                                                                    </body>
                                                                </form>
                                                                </html>
                                                                <%} catch (Exception ex) {
                                                                        ex.printStackTrace();
                                                                    }%>