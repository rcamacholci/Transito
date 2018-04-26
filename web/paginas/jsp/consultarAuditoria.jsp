<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                Model modelo = (Model) session.getAttribute("model");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Auditoria</title>
        <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript">

            function buscarDoc() {
                if (document.form.usuario.value != 0 || document.form.tabla.value != 0 || document.form.accion.value != 0 || document.form.fecha.value.length > 0 || document.form.placa.value.length > 0) {
                    document.form.submit();
                } else {
                    alert("Digite El Numero de la Placa");
                }
            }
            function verReporte() {
                ancho = 789;
                alto = 700;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "reportes/classic_landscape.jasper";
                var nombre = "AUDITORIA_";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }



        </script>
        <STYLE>
            <!--
            A.ssmItems:link		{color:black;text-decoration:none;}
            A.ssmItems:hover	{color:black;text-decoration:none;}
            A.ssmItems:active	{color:black;text-decoration:none;}
            A.ssmItems:visited	{color:black;text-decoration:none;}
            .style7 {color: #333333; font-weight: bold; font-size: 10px; font-family: Tahoma; }
            .style8 {
                color: #FFFFFF;
                font-size: 12px;
                font-family: Tahoma;
                font-weight: bold;
            }
            .Estilo12 {
                color: #333333;
                font-size: 12px;
                font-family: Tahoma;
                font-weight: bold;
            }
            -->
        </STYLE>


    </head>
    <%
        modelo.Sede sede = (modelo.Sede) session.getAttribute("sede");
    %>
    <body>
        <form name="form" id="form" method="post" action="verAuditoria.jsp" target="respuesta">
            <fieldset>
                <table width="100%" border="0" align="center">
                    <tr style="border:none; background:url(../html/images/inicio_3.png)">
                        <td colspan="11" align="center"><span class="style2 style14 style8">CONSULTAR AUDITORIA </span></td>
                    </tr>
                    <tr>
                        <td colspan="7"><table border="0" width="100%" id="tabla1">
                                <tr valign="middle">
                                    <td align="right" width="6%"><span class="style7">USUARIO</span>&nbsp;</td>
                                    <td align="center" width="15%"><span style="font-size: 10px">
                                            <select name="usuario" id="usuario"  style="width:110px; font-size:10px; color:#333333">
                                                <option value="0"><<--Seleccione-->></option>
                                                <%  java.util.List usuarios = modelo.listarUsuariosAuditoria();
                                                    for (int i = 0; i < usuarios.size(); i++) {
                                                        String usuario = usuarios.get(i).toString();
                                                %>
                                                <option  value="<%=usuario%>"><%= usuario%></option>

                                                <%} %>
                                            </select>
                                        </span></td>
                                    <td align="center" width="6%"><span class="style7">TABLA</span>&nbsp;</td>
                                    <td align="center" width="18%"><span style="font-size: 10px">
                                            <select name="tabla" id="tabla"  style="width:150px; font-size:10px; color:#333333">
                                                <option value=""><<--Seleccione-->></option>
                                                <option value="VEHICULOS">VEHICULOS</option>
                                                <option value="DATOS_VEHICULOS">DATOS_VEHICULOS</option>
                                                <option value="HISTORICO_COLOR">HISTORICO_COLOR</option>
                                                <option value="PROPIETARIOS">PROPIETARIOS</option>
                                                <option value="ALERTAS">ALERTAS</option>
                                                <option value="EMBARGOS">EMBARGOS</option>
                                                <option value="CARTERAS">CARTERAS</option>
                                                <option value="DETALLE_CARTERAS">DETALLE_CARTERAS</option>
                                                <option value="PAGOS">PAGOS</option>
                                                <option value="PRELIQUIDACION">PRELIQUIDACION</option>
                                            </select>
                                        </span></td>
                                    <td align="center" width="6%"><span class="style7">ACCION</span>&nbsp;</td>
                                    <td align="center" width="13%"><span style="font-size: 10px">
                                            <select name="accion" id="accion"  style="width:110px; font-size:10px; color:#333333">
                                                <option value=""><<--Seleccione-->></option>
                                                <option value="INSERT">INSERCION</option>
                                                <option value="UPDATE">MODIFICACION</option>
                                                <option value="DELETE">ELIMINACION</option>
                                            </select>
                                        </span></td>


                                    <td width="6%" scope="col" align="center" colspan="">
                                        <label style="color:#666666"><span class="style7">PLACA </span></label></td>
                                    <td width="11%" scope="col" align="center" colspan="">
                                        <input id="placa" name="placa" type="text" maxlength="6" style="text-align:center;color:#333333;font:bold; text-transform:uppercase; width:90px; font-size:10px"/></td>



                                </tr>
                                <tr valign="middle">
                                    <td width="32%" align="right"><label style="color:#333333"><span class="style7">FECHA&nbsp;INICIAL</span></label>
                                    </td>
                                    <% String fecha_hoy22 = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
                                    <td width="16%" scope="col" align="right"><input  id="fechaI" name="fechaI" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this, '/', true)" maxlength="10" value="<%=fecha_hoy22%>"/>
                                        &nbsp;<input name="bfechaI" type="button" id="bfechaI" value="..." style="width:30px">
                                            <SCRIPT type="text/javascript">
                                                Calendar.setup({
                                                    inputField: "fechaI",
                                                    ifFormat: "%d/%m/%Y",
                                                    button: "bfechaI"
                                                });
                                            </SCRIPT></td>
                                    <td width="13%"  align="center"><label style="color:#333333"><span class="style7">FECHA&nbsp;FINAL</span></label>
                                    </td>
                                    <% String fecha_hoy23 = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
                                    <td width="23%" scope="col"><input  id="fechaF" name="fechaF" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this, '/', true)" maxlength="10" value="<%=fecha_hoy23%>"/>
                                        &nbsp;<input name="bfechaF" type="button" id="bfechaF" value="..." style="width:30px">
                                            <SCRIPT type="text/javascript">
                                                Calendar.setup({
                                                    inputField: "fechaF",
                                                    ifFormat: "%d/%m/%Y",
                                                    button: "bfechaF"
                                                });
                                            </SCRIPT></td>
                                </tr>
                                <tr>
                                    <td colspan="10" scope="col" align="center"><input id="buscar"  name="buscar" type="button" value="Consultar" style="color:#333333; font-size:12px;width:100px" onClick="buscarDoc()"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="reporet" id="reporet" value="Reporte" onClick="verReporte()"/></td>
                                </tr>


                            </table>


                        </td>
                    </tr>

                </table>
            </fieldset>
            </br>
            <fieldset><legend align="center"> <span class="Estilo12">RESULTADO DE LA AUDITORIA</span></legend>
                <iframe src="#" width="100%" name="respuesta" id="respuesta" height="230"  frameborder="0" scrolling="auto"></iframe>
            </fieldset>
            </br>
            <fieldset ><legend align="center"> <span class="Estilo12">DETALLE DE LA AUDITORIA</span></legend>
                <iframe src="#" width="100%" name="respuesta2" id="respuesta2" height="80"  frameborder="0" scrolling="auto"></iframe>
            </fieldset>
        </form>
    </body>
</html>
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
