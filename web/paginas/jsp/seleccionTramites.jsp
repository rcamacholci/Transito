<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*"  import="java.util.*"  errorPage="" %>

<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                LinkedList tipoDocumentos = new LinkedList();
                Parametro parametro = new Parametro();
                Model modelo = (Model) session.getAttribute("model");
                tipoDocumentos = modelo.listadoParametros(5);

                boolean rn = false;
                String placaRN = "";
                String tramite = "";

                session.removeAttribute("rn");
                if (request.getParameter("rn") != null && request.getParameter("placaRN") != null) {
                    System.out.println(" /*tramite " + request.getParameter("rn"));
                    session.setAttribute("rn", request.getParameter("rn"));
                    rn = true;
                    if (request.getParameter("rn").equals("4")) {
                        tramite = "RNMA";
                    } else if (request.getParameter("rn").equals("5")) {
                        tramite = "RNRYS";
                    } else if (request.getParameter("rn").equals("1")) {
                        tramite = "RNA";
                    }
                    placaRN = request.getParameter("placaRN");
                    System.out.println("Entro: " + placaRN);
                    System.out.println("Registro Nacional: " + request.getParameter("rn"));
                }

%>
<html>
    <head>
        <title>Seleccion Tramites</title>
        <script src="../html/scripts/personas.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript">
            function consultarTramites() {

                if (document.form.documento.value.length > 0) {
                    if (document.form.placa.value.length > 2 && document.form.placa.value.length < 7 || document.form.placa.value.length > 2 && document.form.placa.value.length < 9 && document.form.rn.value == "4" || document.form.placa.value.length > 2 && document.form.placa.value.length < 9 && document.form.rn.value == "5") {
                        if (document.form.rn.value == "4") {
                            window.frames[0].location.href = "tramitesDisponibles.jsp?id=3&placa=" + document.form.placa.value;
                            queryPerson();
                        } else {
                            if (document.form.rn.value == "5") {
                                alert("RNYS");
                                window.frames[0].location.href = "tramitesDisponibles.jsp?id=4&placa=" + document.form.placa.value;
                                queryPerson();
                            } else {
                                alert("Rna");
                                window.frames[0].location.href = "tramitesDisponibles.jsp?id=1&placa=" + document.form.placa.value;
                                queryPerson();
                            }
                        }
                    } else {
                        if (document.form.placa.value.length > 0) {
                            alert("Digite un numero de placa valida");
                        } else {
                            queryPerson();
                            window.frames[0].location.href = "tramitesDisponibles.jsp?id=2&tipo=" + document.form.tipo.value + "&documento=" + document.form.documento.value;
                        }
                    }
                } else {
                    alert("Digite un numero de documento valido");
                }
            }

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

            function queryPerson() {
                var doc = document.form.documento.value;
                var tipo = document.form.tipo.value;
                if (doc.length > 0 && tipo.length > 0) {
                    ajax = nuevoAjax();
                    ajax.open("POST", "getPersona.jsp", true);
                    ajax.onreadystatechange = function () {
                        if (ajax.readyState == 4) {
                            var respuesta = "";
                            for (var i = 0; i < ajax.responseText.length; i++) {
                                if (isNaN(ajax.responseText.charAt(i)) || ajax.responseText.charAt(i) == ' ')
                                    respuesta += ajax.responseText.charAt(i);
                            }
                            if (respuesta == "nueva") {
                                viewPersona(tipo, doc);
                            } else {
                                consultaCartera(tipo, doc, respuesta);
                            }
                        }
                    }
                    ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    ajax.send("documento=" + doc + "&tipo=" + tipo);
                }
            }

            function limpiarSeleccion() {
                document.form.consultaTramite.disabled = false;
                document.location.href = "seleccionTramites.jsp";
            }

            function consultaCartera(tipo, doc, nombre) {
                ajax2 = new nuevoAjax();
                ajax2.open("POST", "verificarPersona.jsp", true);
                ajax2.onreadystatechange = function () {
                    if (ajax2.readyState == 4) {
                        var respuesta = "";
                        for (var i = 0; i < ajax2.responseText.length; i++) {
                            if (!isNaN(ajax2.responseText.charAt(i)) || ajax2.responseText.charAt(i) == '.')
                                respuesta += ajax2.responseText.charAt(i);
                        }
                        if (parseInt(respuesta) == 0) {
                            document.form.nombre.value = nombre;
                            document.form.consultaTramite.disabled = true;
                        } else {
                            alert("La persona " + nombre + " posee multas por valor de " + parseInt(respuesta));
                            document.form.nombre.value = "";
                        }
                    }
                }
                ajax2.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                ajax2.send("documento=" + doc + "&tipo=" + tipo);
            }
        </script>
        <style type="text/css">
            <!--
            .Estilo1 {font-size: 12px}
            .Estilo2 {
                font-size: 12px;
                color: #333333;
                font-weight: bold;
            }
            .Estilo3 {
                font-size: 14px;
                font-weight: bold;
                color: #333333;
            }
            -->
        </style>
    </head>
    <body >
        <form name="form" id = "form" method="post" action="formularioFUN.jsp">
            <table width="100%" border="0">
                <tr>
                    <td><div align="center" class="Estilo3">SELECCION DE TRAMITES PARA SOLICITUD ANTE EL RUNT - <%=tramite%></div></td>
                </tr>
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <fieldset>
                            <table width="100%" border="0">
                                <tr>
                                    <%if (rn) {%>
                                    <th width="4%" scope="col"><span class="Estilo1">IDENTIFICACION</span></th>
                                    <th width="10%" scope="col">

                                        <input name="placa" type="text"  value="<%=placaRN!=null?placaRN:"" %>" id="placa" style="text-align:center;color:#333333;text-transform:uppercase; width:100px" maxlength="10"/></th>
                                <input type="hidden" name="rn" id="rn" value="<%=request.getParameter("rn")%>">
                                <%} else {%><%
                                    session.setAttribute("rn", "1");
                                %>

                                <input type="hidden" name="rn" id="rn" value="0">
                                <input type="hidden" name="rnrys" id="rnrys" value="0">
                                <th width="4%" scope="col"><span class="Estilo1">PLACA</span></th>
                                <th width="10%" scope="col">
                                    <input name="placa" type="text" id="placa" style="text-align:center;color:#333333;text-transform:uppercase; width:100px" maxlength="6"/></th>
                                    <%
                                                }%>
                                <th width="13%" scope="col"><span class="Estilo1">TIPO&nbsp;DOC.</span></th>
                                <th width="18%" scope="col">
                                    <span style="font-size: 12px">
                                        <select name="tipo" id="tipo" size="1" style="color:#333333; width:160px; font-size:11px">
                                            <%  session.removeAttribute("seleccionados");
                                                long fk_grupo = 5;
                                                java.util.List listaTipos = modelo.listadoParametros(fk_grupo);
                                                for (int i = 0; i < listaTipos.size(); i++) {
                                                    parametro = (Parametro) listaTipos.get(i);%>
                                            <option value="<%=parametro.getCodigo()%>"><%=parametro.getNombre()%></option>
                                            <%  }  %>
                                        </select>
                                    </span>
                                </th>
                                <th width="8%" scope="col"><span class="Estilo1">DOCUMENTO</span></th>
                                <th width="11%" scope="col">
                                    <input name="documento" type="text" id="documento" style="text-align:center; color:#333333; width:100px" maxlength="11"></th>
                                <th width="26%" scope="col">
                                    <input name="nombre" type="text" id="nombre" style="color:#333333; width:240px" readonly>
                                </th>
                                <th width="10%" scope="col">
                                    <input name="consultaTramite" type="button" id="consultaTramite" onClick="consultarTramites()" value="Consultar" /></th>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%" border="0">
                            <tr style="border:none">
                                <td width="50%" valign="top">
                                    <fieldset>
                                        <legend class="Estilo2">LISTADO DE TRAMITES DISPONIBLES</legend>
                                        <table width="100%" border="0">
                                            <tr>
                                                <td width="100%" valign="top">
                                                    <iframe src="#" width="100%" height="400" scrolling="auto" frameborder="0"></iframe>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                                <td width="50%" valign="top">
                                    <fieldset>
                                        <legend class="Estilo2">LISTADO DE TRAMITES SELECCIONADOS</legend>
                                        <table width="100%" border="0">
                                            <tr>
                                                <td width="100%" valign="top" colspan="2">
                                                    <iframe src="#" width="100%" height="370" scrolling="auto" frameborder="0"></iframe>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="50%" align="center">
                                                    <input type="button" name="limpiar" value="Limpiar" onClick="limpiarSeleccion()"/>
                                                </td>
                                                <td width="50%" align="center">
                                                    <input type="submit" name="enviar" value="Enviar Tramites"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
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
