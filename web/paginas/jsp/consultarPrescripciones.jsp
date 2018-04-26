<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>

<%
    modelo.Model modelo = (modelo.Model) session.getAttribute("model");
    modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
%>


<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%@ page import="modelo.*"%>
        <%@page import="java.util.*"%>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Vehiculo</title>
        <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript">

            function buscarPrescripcion() {
                if (document.form.placa.value.length != 0) {
                    window.frames[0].location.href = "verPrescripcion.jsp?num=1&placa=" + document.form.placa.value;
                } else {
                    alert("Digite el numero de la placa a Buscar");
                }
            }

            function paso() {
                if (document.form.fechaI.value.length > 0) {
                    if (document.form.fechaF.value.length > 0) {
                        document.form.action = 'consultarPrescripciones.jsp'
                        document.form.submit();
                    } else {
                        alert("Digite la fecha final del reporte Genearal");
                    }
                } else {
                    alert("Digite la fecha inicial del reporte General");
                }
            }





            function buscarFecha() {
                if (document.form.fechaI.value.length == 10) {
                    if (document.form.fechaF.value.length == 10) {
                        window.frames[0].location.href = "verPrescripcion.jsp?num=2&fechaI=" + document.form.fechaI.value + "&fechaF=" + document.form.fechaF.value;
                    } else {
                        alert("Digite la fecha Final de la Busqueda");
                    }
                } else {
                    alert("Digite la fecha Inicial de la Busqueda");
                }
            }

            function mostrar() {
                window.frames[0].location.href = "verPrescripcion.jsp?num=2";
            }


            function ver() {
                if (document.form.busqueda[0].checked) {
                    document.getElementById('tabla1').style.display = "block";
                    document.getElementById('tabla2').style.display = "none";
                } else {
                    document.getElementById('tabla1').style.display = "none";
                    document.getElementById('tabla2').style.display = "block";
                }

            }
            function verReporte() {
                /*ancho = 789;
                 alto = 250;
                 barra = 0;
                 izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                 arriba = (document.height) ? (document.height - alto) / 2 : 100;
                 opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                 var dir = "/prescripcion/ReportePreasignaciones.jasper";
                 var nombre = "prescripciones";
                 url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                 window.open(url, 'popUp', opciones);*/
                if (document.form.fechaI.value.length == 10) {
                    if (document.form.fechaF.value.length == 10) {
                        window.frames[0].location.href = "verPrescripcion.jsp?num=2&fechaI=" + document.form.fechaI.value + "&fechaF=" + document.form.fechaF.value+"&excel=1";
                    } else {
                        alert("Digite la fecha Final de la Busqueda");
                    }
                } else {
                    alert("Digite la fecha Inicial de la Busqueda");
                }
            }
        </script>
        <STYLE>
            <!--
            A.ssmItems:link	{color:black;text-decoration:none;}
            A.ssmItems:hover	{color:black;text-decoration:none;}
            A.ssmItems:active	{color:black;text-decoration:none;}
            A.ssmItems:visited	{color:black;text-decoration:none;}

            .style5 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
            .Estilo11 {color: #0066CC;font-weight: bold;font-size: 10px;}
            .style7 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
            -->
        </STYLE>


    </head>
    <%
        if (request.getParameter("fechaI") != null && request.getParameter("fechaF") != null && !request.getParameter("fechaI").isEmpty() && !request.getParameter("fechaF").isEmpty()) {
            HashMap parameters = new java.util.HashMap();
            parameters.put("USUARIO", usuario.getNombre());
            parameters.put("FECHA_INI", request.getParameter("fechaI"));
            parameters.put("FECHA_FIN", request.getParameter("fechaF"));
            session.setAttribute("prescripciones", parameters);
    %>
    <script language="javascript" type="text/javascript">
        verReporte();
    </script>

    <%  }


    %>
    <body> 
        <form name="form" id="form" method="post" action="verPrescripcion.jsp" >
            <fieldset>
                <table width="100%" border="0" align="center">
                    <tr style="border:none; background:url(../html/images/inicio_3.png)">
                        <td colspan="6" align="center" valign="middle"><span class="style7">CONSULTAR PRESCRIPCIONES</span></td>
                    </tr>
                    <tr>

                        <td colspan="1" valign="middle" align="center" width="50%"><span class="Estilo11">
                                <input type="radio" name="busqueda" value="1" checked="checked" onClick="ver()"> 
                                    PLACA				  
                            </span></td>
                        <td colspan="2" valign="middle" align="center" width="50%"><span class="Estilo11">
                                <input type="radio" name="busqueda" value="2"  onClick="ver()">
                                    FECHA</span></td>				
                    </tr>
                    <tr align="center">
                        <td height="50" colspan="4" align="center" >

                            <table border="0" width="100%" id="tabla2" style="display:none"  >
                                <tr valign="middle">
                                    <td width="27%" align="right"><label style="color:#333333"><span class="style5">FECHA&nbsp;INICIAL</span></label>								  </td>
                                    <% String fecha_hoy = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
                                    <td width="20%" scope="col" align="center"><input  id="fechaI" name="fechaI" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this, '/', true)" maxlength="10" value="<%=fecha_hoy%>"/>
                                        <input name="bfechaI" type="button" id="bfechaI" value="<" style="width:20px">
                                            <SCRIPT type="text/javascript">
                                                Calendar.setup({
                                                    inputField: "fechaI",
                                                    ifFormat: "%d/%m/%Y",
                                                    button: "bfechaI"
                                                });
                                            </SCRIPT></td>
                                    <td width="14%"  align="center"><label style="color:#333333"><span class="style5">FECHA&nbsp;FINAL</span></label>								  </td>
                                    <td width="23%" scope="col"><input  id="fechaF" name="fechaF" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this, '/', true)" maxlength="10" value="<%=fecha_hoy%>"/>
                                        <input name="bfechaF" type="button" id="bfechaF" value="<" style="width:20px">
                                            <SCRIPT type="text/javascript">
                                                Calendar.setup({
                                                    inputField: "fechaF",
                                                    ifFormat: "%d/%m/%Y",
                                                    button: "bfechaF"
                                                });
                                            </SCRIPT></td>
                                    <td width="8%" scope="col"><input id="consultar"  name="consultar2" type="button" value="Consultar" style="color:#333333" onClick="buscarFecha()"/></td>
                                    <td width="8%" scope="col" align="center">
                                        <input id="reporte"  name="reporte" type="button" value="Reporte" style="color:#333333" onClick="verReporte()"/></td>
                                </tr>
                            </table>

                            <table border="0" width="100%" id="tabla1">
                                <tr valign="middle">
                                    <td width="10%">&nbsp;</td>
                                    <td width="20%" height="26" colspan="2" align="center"><label style="color:#333333"><span class="style5">N&ordm; PLACA </span></label></td>
                                    <td width="10%">&nbsp;</td>
                                    <td width="20%"  colspan="2" align="center"><input  id="placa" name="placa" style="text-align:center;color:#333333;font:bold; width:150px" maxlength="6" />							      </td>
                                    <td width="10%">&nbsp;</td>

                                    <td width="20%" scope="col" align="center" colspan="2"><input id="consultar"  name="consultar2" type="button" value="Consultar" style="color:#333333; width:150px" onClick="buscarPrescripcion()"/></td>
                                    <td width="10%">&nbsp;</td>
                                </tr>
                            </table>				  </td>
                    </tr>	
                </table>
            </fieldset>
            <iframe src="#" width="100%" id="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe>
        </form>               
    </body>
</html>