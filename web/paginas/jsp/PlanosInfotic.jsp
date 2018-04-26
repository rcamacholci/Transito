<%--
    Document   : PlanosInfoTic2
    Created on : 4/11/2015, 01:19:10 PM
    Author     : Jefrey
--%>

<%@page import="modelo.Parametro"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Model"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style type="text/css">
        .label {font-size: 11px; color:#666666; text-align:center ; font-family:Arial; font-weight:bold ; width:110px}
        .text {font-size: 10px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; width:120px; text-transform:uppercase}
        .date {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; width:100px }
        .bdate {font-size: 10px; color:#666666; text-align:center ; font-family:Arial; font-weight:bold; width:20px }
        .select {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; width:60px }
        .input { width:130px }
        .check { font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; }
    </style>
    <script>
        function validar() {
            var vi = parseInt(document.getElementById("vinicial").value);
            var vf = parseInt(document.getElementById("vfinal").value);
            if (vf < vi) {
                document.getElementById("vinicial").selectedIndex = 0;
                document.getElementById("vfinal").selectedIndex = 0;
                alert("La Vigencia Final no puede ser inferior a la Vigencia Inicial");
            }
        }

        function descargar() {
            document.getElementById('info').style.display = 'block'
            document.getElementById("btndescargar").disabled = true;
            document.getElementById("btndescargar").value = 'Procesando...';
            document.form.action = "ProcesarPlanoInfotic.jsp"
            document.form.submit();
        }

    </script>
    <%
        Model model = (Model) session.getAttribute("model");
    %>
    <body>
        <form name="form" id="form" method="post" action="">
            <h3>Descargar Planos InfoTic</h3>
            <hr>
            <fieldset style="text-align: center">
                <legend>Este proceso se recomienda realizarlo al final de la jornada de trabajo</legend>

                <p>

                <table align='center'>
                    <tr>
                        <th class="label" align="center">Servicio</th>
                        <td>
                            <select id="Servicio" name="Servicio" class="select" style="width: 140px">
                                <%
                                    List listparametros = model.listadoParametros(3);
                                    for (int i = 0; i < listparametros.size(); i++) {
                                        Parametro par = (Parametro) listparametros.get(i);
                                        if (par.getCodigo() == 1) {
                                %><option selected="selected" value="<%=par.getCodigo()%>"><%=par.getNombre()%></option><%
                                            } else {
                                %><option value="<%=par.getCodigo()%>"><%=par.getNombre()%></option><%
                                                    }
                                                }
                                    %>
                            </select>
                        </td>
                        <th class="label" align="center">Vigencia Inicial</th>
                        <td>
                            <select name="vinicial" id="vinicial" class="select" style="width: 140px" onchange="validar()">
                                <%
                                    int vigencia = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                                    for (int x = 2000; x <= vigencia; x++) {
                                %>
                                <option value="<%=x%>"><%=x%></option>
                                <%
                                    }
                                %>
                            </select>
                        </td>
                        <th class="label" align="center">Vigencia Final</th>
                        <td>
                            <select name="vfinal" id="vfinal" class="select" style="width: 140px" onchange="validar()">
                                <%for (int x = vigencia; x >= 2000; x--) {%>
                                <option value="<%=x%>"><%=x%></option>
                                <%}%>
                            </select>
                        </td>
                        <td>&nbsp;</td>
                        <td><input type="button" value="Descargar" name="btndescargar" id="btndescargar" onclick="descargar()"/></td>
                    </tr>
                    <tr>
                        <td colspan="8">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="8"><label id="info" style="display: none;">El proceso puede tardar varios minutos. Espere...</label></td>
                    </tr>
                </table>

            </fieldset>
        </form>
    </body>
</html>
