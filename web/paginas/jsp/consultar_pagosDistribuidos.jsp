<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html;charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <style type="text/css">
            <!--
            .Estilo1 {
                color: #CC0000;
                font-weight: bold;
            }
            -->
        </style>
        <script language="javascript" type="text/javascript">


            function validarFechaInicio(date) {
                if (date.value == "") {
                    alert("       Digite Fecha de Inicio");
                    return false;
                } else
                    return true;
            }
            function validarFechaFinal(date2) {
                if (date2.value == "") {
                    alert("       Digite Fecha Final ");
                    return false;
                } else
                    return true;
            }

            function validarFechaMayor() {
                var dia_ini = document.form.date.value.substr(0, 2);
                var mes_ini = document.form.date.value.substr(3, 2);
                var ano_ini = document.form.date.value.substr(6, 4);
                var dia_fin = document.form.date2.value.substr(0, 2);
                var mes_fin = document.form.date2.value.substr(3, 2);
                var ano_fin = document.form.date2.value.substr(6, 4);
                fecha_ini = new Date(ano_ini, mes_ini - 1, dia_ini).getTime();
                fecha_fin = new Date(ano_fin, mes_fin - 1, dia_fin).getTime();
                if (fecha_ini <= fecha_fin) {

                } else {
                    alert("  Error, La Fecha de Inicio es Mayor ");
                    return false;
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


            function validarFormulario(form) {
                with (form) {

                    if (validarFechaInicio(date) == false) {
                        date.focus();
                        return false;
                    }
                    if (validarFechaFinal(date2) == false) {
                        date2.focus();
                        return false;
                    }
                    if (validarFechaMayor() == false) {
                        date.focus();
                        return false;
                    }

                }
            }
            function buscarUsuarios() {
                var caja = document.form.caja.options[document.form.caja.selectedIndex].value;
                ajax2 = nuevoAjax();
                ajax2.open("POST", "consultarUsuariosCaja.jsp", true);
                ajax2.onreadystatechange = function () {
                    if (ajax2.readyState == 4) {
                        document.getElementById("usuarios").innerHTML = ajax2.responseText;
                    }
                }
                ajax2.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                ajax2.send("caja=" + caja);

            }
        </script>
        <META http-equiv=Content-Type content="text/html; charset=windows-1252">
            <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
            <script src="../html/scripts/calendar.js" type="text/javascript"></script>
            <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
            <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
            <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
            <title>Taquilla</title>
            <style type="text/css">
                <!--
                .Estilo3 {color: #0066CC}
                .style1 {font-size: 12px}
                .style2 {color: #CC0000; }
                .style3 {
                    color: #333333;
                    font-family: Tahoma;
                }
                .style4 {
                    color: #333333;
                    font-family: Tahoma;
                    font-size: 12px;
                    font-weight: bold;
                }
                -->
            </style>
    </head>

    <body>
        <center>
            <%@ page import="modelo.*"%>
            <%@page import="java.util.*"%>

            <form id="form" name="form" method="post" action="listarPagosDistribuidos.jsp" onsubmit="return validarFormulario(this)" style="width:90%" target="distribucion">
                <p>&nbsp;</p>

                <fieldset><div align="center">
                        <legend class="style4" align="center">CONSULTAR DISTRIBUCION </legend>
                    </div>
                    <table width="646" border="0" align="center">
                        <tr>
                            <td colspan="4"><div align="center" class="Estilo1 Estilo3">&nbsp;</div></td>
                        </tr>
                        <tr>
                            <%  String fecha = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
                            <td width="100"><span class="Estilo1 Estilo3 style1"><span class="style4">FECHA&nbsp;DESDE </span></span></td>
                            <td width="207"><input type="text" name="date" id="fecha_desde" onkeyup="mascara(this, '/', true)" style="text-align:center;width:120px" maxlength="10" value="<%=fecha%>"/>
                                <input name="button" type="button" id="lanzador" value="<<" style="width:20px" />
                                <script type="text/javascript">
                                    Calendar.setup({
                                        inputField: "fecha_desde", // id del campo de texto
                                        ifFormat: "%d/%m/%Y", // formato de la fecha, cuando se escriba en el campo de texto
                                        button: "lanzador"   // el id del bot&iuml;&iquest;&frac12;n que lanzar&iuml;&iquest;&frac12; el calendario
                                    });
                                </script>      </td>
                            <td width="80"><span class="style4">FECHA&nbsp;HASTA </span></td>
                            <td width="231"><input type="text" name="date2" id="fecha_hasta" onkeyup="mascara(this, '/', true)" style="text-align:center;width:120px" maxlength="10" value="<%=fecha%>" />
                                <input name="button" type="button" id="lanzador2" value="<<" style="width:20px"/>
                                <script type="text/javascript">
                                    Calendar.setup({
                                        inputField: "fecha_hasta", // id del campo de texto
                                        ifFormat: "%d/%m/%Y", // formato de la fecha, cuando se escriba en el campo de texto
                                        button: "lanzador2"   // el id del bot&iuml;&iquest;&frac12;n que lanzar&iuml;&iquest;&frac12; el calendario
                                    });
                                </script>      </td>
                        </tr>
                        <tr>
                            <td class="style4">CAJA</td>
                            <td class="style4">
                                <% Model model = (Model) session.getAttribute("model");
                                    Sede sede = (Sede) session.getAttribute("sede");%>
                                    <select name="caja" id="caja" style="color:#333333; width:150px" onblur="buscarUsuarios()" onchange="buscarUsuarios()">

                                    <%
                                        if (model.tienePermiso(usuario.getId_usuario(), 136)) {
                                    %>
                                    <option value="0"><<--General-->></option>
                                    <%
                                        }
                                        java.util.List cajas = model.listarCajaBySede(sede.getId_sede());
                                        java.util.List<UsuarioCaja> Userbox = model.ListarUsuarioCajas(usuario.getId_usuario());

                                        for (UsuarioCaja ubox : Userbox) {
                                            Caja box = model.consultarCaja(ubox.getFk_caja());
                                    %>
                                    <option value="<%=box.getId_caja()%>"><%=box.getNombre()%></option>
                                    <%}%>
                                </select>
                            </td>
                            <td class="style4">USUARIO</td>
                            <td class="style4">
                                <div id="usuarios"></div>
                            </td>
                        </tr>
                        <tr>
                            <td class="style4">ENTIDAD</td>
                            <td class="style4" colspan="3">
                                <select name="entidad" id="entidad" style="color:#333333; width:460px">
                                    <option value="0"><<--General-->></option>
                                    <%	java.util.List entidades = model.listado_entidades_distribucion();
                                        for (int i = 0; i < entidades.size(); i++) {
                                            Entidad_Distribucion entidad = (Entidad_Distribucion) entidades.get(i);
                                            Persona empresa = model.consultarPersona(entidad.getFk_persona());
                                            String nombre = empresa.getNombre_1() + " " + empresa.getApellido_1();%>
                                    <option value="<%=entidad.getId_entidad_distribucion()%>"><%=nombre%></option>
                                    <%	 } %>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4"><div align="center">
                                    <label>
                                        <input type="submit" name="Submit" value="Consultar" />
                                    </label>
                                </div></td>
                        </tr>
                        <tr>
                            <td colspan="4">&nbsp;</td>		
                        </tr>
                        <tr>
                            <td colspan="4" align="center" valign="top">
                                <iframe src="#" id="distribucion" name="distribucion" width="100%" height="300" style="border:none" frameborder="0" scrolling="auto"></iframe>		</td>
                        </tr>
                    </table>
                </fieldset>
            </form>
        </center>
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

