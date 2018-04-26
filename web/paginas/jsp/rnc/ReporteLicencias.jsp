<%-- 
    Document   : ReporteHacienda
    Created on : 31/07/2017, 11:10:16 AM
    Author     : Jcarreno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
        <title>JSP Page</title>
        <LINK title=win2k-cold-1 media=all href="../../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script src="../../html/scripts/validarFecha.js" type="text/javascript"></script>
        <script>
            function buscarR() {

                if (document.form.fechaI.value.length === 10 && document.form.fechaF.value.length === 10) {

                    window.frames[0].location.href = "Licenciasexcel.jsp?fi=" + document.form.fechaI.value + "&ff=" + document.form.fechaF.value;
                } else {
                    alert("Digite fechas de comparendo");
                }
            }
        </script>
        <STYLE>
            <!--
            A.ssmItems:link		{color:black;text-decoration:none;}
            A.ssmItems:hover	{color:black;text-decoration:none;}
            A.ssmItems:active	{color:black;text-decoration:none;}
            A.ssmItems:visited	{color:black;text-decoration:none;}
            .style1 {
                font-size: 12px;
                font-family: Tahoma;
            }
            .style5 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
            .Estilo11 {
                color: #0066CC;
                font-weight: bold;
                font-size: 10px;
            }
            -->
        </STYLE>
    </head>
    <body>
        <form name="form" id="form" method="post">
            <%try {%>
            <fieldset>
                <legend>
                    <h2>
                        Reporte de Licencias Excel
                    </h2>
                </legend>
                <table border="0">
                    <tbody>
                        <tr>
                            </td>
                            <% String fecha_hoy22 = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
                            <td width="16%" scope="col" align="right"><input  id="fechaI" name="fechaI" style="text-align:center;color:#333333; width:100px" onKeyUp="mascara(this, '/', true)" maxlength="10" value="<%=fecha_hoy22%>"/>
                                &nbsp;<input name="bfechaI" type="button" id="bfechaI" value="..." style="width:30px">
                                <SCRIPT type="text/javascript">
                                    Calendar.setup({
                                        inputField: "fechaI",
                                        ifFormat: "%d/%m/%Y",
                                        button: "bfechaI"
                                    });
                                </SCRIPT></td>
                            <td width="13%"  align="center"><label style="color:#333333"><span class="style5">FECHA&nbsp;FINAL</span></label>
                            </td>
                            <% String fecha_hoy23 = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
                            <td width="23%" scope="col"><input  id="fechaF" name="fechaF" style="text-align:center;color:#333333;width:100px" onKeyUp="mascara(this, '/', true)" maxlength="10" value="<%=fecha_hoy23%>"/>
                                &nbsp;<input name="bfechaF" type="button" id="bfechaF" value="..." style="width:30px">
                                <SCRIPT type="text/javascript">
                                    Calendar.setup({
                                        inputField: "fechaF",
                                        ifFormat: "%d/%m/%Y",
                                        button: "bfechaF"
                                    });
                                </SCRIPT></td>
                            <td width="8%" scope="col"><input id="consultar2"  name="consultar2" type="button" value="Reporte" style="color:#333333" onClick="buscarR()"/></td>
                        </tr>
                    </tbody>
                </table>

            </fieldset>
            <iframe src="#" width="100%" id="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe>
                <%} catch (Exception e) {%>
            Error <%=e%>
            <%}%>
        </form>
    </body>
</html>
