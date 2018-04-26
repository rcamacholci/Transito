<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                modelo.Model modelo = (modelo.Model) session.getAttribute("model");

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Untitled Document</title>
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script type="text/javascript" src="../html/scripts/calendar.js"></script>
        <script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
        <script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
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




            function mostrar() {
                if (document.getElementById("tipo").value == 1) {
                    document.getElementById('tramites').style.display = "block";
                    document.getElementById('modif').style.display = "none";
                    document.getElementById('lbtramites').style.display = "block";
                    document.getElementById('lbmodificaciones').style.display = "none";
                    document.getElementById('lbnumeroR').style.display = "block";
                    document.getElementById('numeroR').style.display = "block";
                } else {
                    if (document.getElementById("tipo").value == 2) {
                        document.getElementById('tramites').style.display = "none";
                        document.getElementById('modif').style.display = "block";
                        document.getElementById('lbtramites').style.display = "none";
                        document.getElementById('lbmodificaciones').style.display = "block";
                        document.getElementById('lbnumeroR').style.display = "none";
                        document.getElementById('numeroR').style.display = "none";
                    } else {
                        document.getElementById('tramites').style.display = "none";
                        document.getElementById('lbtramites').style.display = "none";
                        document.getElementById('lbnumeroR').style.display = "none";
                        document.getElementById('numeroR').style.display = "none";
                        document.getElementById('lbmodificaciones').style.display = "none";
                        document.getElementById('modif').style.display = "none";
                    }
                }
            }

            function validar() {
                if (document.getElementById("numeroA").value.length > 0) {
                    var NumA = document.getElementById("numeroA").value;
                    if (document.getElementById("fecha").value.length > 0) {
                        var Fecha = document.getElementById("fecha").value;
                        if (document.getElementById("placa").value.length > 0) {
                            var Placa = document.getElementById("placa").value;
                            if (document.getElementById("propietario").value.length > 0) {
                                if (document.getElementById("observacion").value.length > 0) {
                                    var Obser = document.getElementById("observacion").value;
                                    if (document.getElementById("tipo").value != 0) {
                                        var Tipo = document.getElementById("tipo").value;
                                        if (document.getElementById("tipo").value == 1) {
                                            if (document.getElementById("tramites").value != 0) {
                                                var Tramite = document.getElementById("tramites").value;
                                                if (document.getElementById("numeroR").value.length > 0) {
                                                    var NumR = document.getElementById("numeroR").value;
                                                    window.frames[0].location.href = "verActosAdministrativosTramites.jsp?numA=" + NumA
                                                            + "&fecha=" + Fecha + "&placa=" + Placa + "&observacion=" + Obser + "&tipo=" + Tipo + "&tramite=" + Tramite + "&numR=" + NumR;
                                                } else {
                                                    alert("Digite el numero de Radicacion del tramite");
                                                }
                                            } else {
                                                alert("Seleccione un tramite");
                                            }
                                        } else {
                                            if (document.getElementById("tipo").value == 2) {
                                                if (document.getElementById("modif").value != 0) {
                                                    var mod = document.getElementById("modif").value;
                                                    window.frames[0].location.href = "verActosAdministrativosTramites.jsp?numA=" + NumA
                                                            + "&fecha=" + Fecha + "&placa=" + Placa + "&observacion=" + Obser + "&tipo=" + Tipo + "&modif=" + mod + "&tramite=" + 0 + "&numR=" + 0;

                                                } else {
                                                    alert("Seleccione un modificacion");
                                                }
                                            } else {
                                                alert("Seleccione tipo");
                                            }

                                        }
                                    } else {
                                        alert("Seleccione un tipo");
                                    }
                                } else {
                                    alert("Digite una observacion");
                                }
                            } else {
                                alert("Falta propietario del Vehiculo");
                            }
                        } else {
                            alert("Digite la placa");
                        }
                    } else {
                        alert("Digite la fecha del Acto Administrativo");
                    }
                } else {
                    alert("Digite el Numero del Acto Administrativo");
                }
            }

            function buscarPropietario() {
                var placaS = document.getElementById('placa').value;
                var opcion = document.getElementById('divper');
                ajax2 = nuevoAjax();
                ajax2.open("POST", "getPropietario.jsp", true);
                ajax2.onreadystatechange = function () {

                    if (ajax2.readyState == 4) {
                        opcion.innerHTML = ajax2.responseText
                    }
                }
                ajax2.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                ajax2.send("placa=" + placaS);
            }




        </script>

        <style type="text/css">

            .style1 {
                font-family: Tahoma;
                font-size: 12px;
                color: #FFFFFF;
                font-weight: bold;
            }
            .style7 {
                font-size: 12px;
                font-weight: bold;
            }
            .style9 {color: #333333; font-family: Tahoma; font-size: 12px; font-weight: bold; }
            .Estilo8 {color: #333333; font-weight: bold; font-size: 12px; }
            .style10 {font-family: Tahoma; font-size: 12px; font-weight: bold; }

        </style>
    </head>
    <%    modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");

    %>
    <body> <form id="form"  name="form" method="post" action="">
            <fieldset>
                <table width="90%" border="0" align="center" >
                    <tr style="background:url(../html/images/inicio_3.png); border:none">
                        <td colspan="6" align="center"><span class="style1">REGISTRO DE ACTOS ADMINISTRATIVOS</span></td>
                    </tr>
                    <tr>
                        <td width="15%">&nbsp;</td>
                        <td width="14%"  align="left" >&nbsp;</td>
                        <td width="21%">&nbsp;</td>
                        <td width="25%">&nbsp;</td>
                        <td width="21%">&nbsp;</td>
                        <td width="11%">&nbsp;</td>
                    </tr>
                    <tr class="style9">
                        <td width="15%" align="center" >NUMERO</td>
                        <td width="14%"  align="left" ><span style="border:none">
                                <input type="text" name="numeroA"  id="numeroA" style="width:155px" />
                            </span></td>
                        <td width="21%" align="center">FECHA</td>
                        <td width="25%"> <input  id="fecha" name="fecha"  style="text-align:center;width:120px" onkeyup="mascara(this, '/', true)" maxlength="10"/> <input name="button" type="button" id="lanzador2" style="width:25px; color:#000000" value="<<" />
                            <SCRIPT type="text/javascript">
                                Calendar.setup({
                                    inputField: "fecha", // id del campo de texto
                                    ifFormat: "%d/%m/%Y", // formato de la fecha, cuando se escriba en el campo de texto
                                    button: "lanzador2"   // el id del botón que lanzará el calendario
                                });
                            </SCRIPT>

                        </td>
                        <td align="center">PLACA</td>
                        <td align="center"><span style="border:none">
                                <input type="text" maxlength="6" name="placa" id="placa" style="width:120px;text-transform:uppercase" onblur="buscarPropietario()"/>
                            </span></td>
                    </tr>
                    <tr class="style9">
                        <td width="15%" align="center">PROPIETARIO</td>
                        <td  align="justify" colspan="3" ><span style="border:none">
                                <div id="divper" name="divper">
                            </span></td>


                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr class="style9">
                        <td align="center" width="15%">TIPO</td>
                        <td align="left"><span style="font-size: 10px">
                                <select name="tipo" onchange="mostrar()" id="tipo"  style="width:160px;  font-size:12px; color:#333333">
                                    <option value="0"> Seleccione Tipo </option>
                                    <option  value="1"> Revocatoria de tramite</option>
                                    <option  value="2"> Modificacion de datos</option>
                                </select>
                            </span></td>
                        <td colspan=""  align="center" class="style9"><label id="lbtramites" style="display:none"> TRAMITE</label><label id="lbmodificaciones" style="display:none"> MODIFICACION</label>
                        </td>
                        <td align="left">
                            <select name="tramites" id="tramites"  style="width:155px; font-size:12px; color:#333333; display:none">
                                <option value="0"> Seleccione Tramite </option>
                                <% java.util.List tramites = modelo.consultarTramites(1, usuario.getFk_sede());
                                    for (int i = 0; i < tramites.size(); i++) {
                                        Tramite tramite = (Tramite) tramites.get(i);
                                %>
                                <option value="<%=tramite.getId_tramite()%>"><%= tramite.getNombre()%> </option>
                                <%  }
                                    tramites = modelo.consultarTramites(2, usuario.getFk_sede());
                                    for (int i = 0; i < tramites.size(); i++) {
                                        Tramite tramite = (Tramite) tramites.get(i);%>
                                <option value="<%= tramite.getId_tramite()%>"><%= tramite.getNombre()%> </option>
                                <%  } %>
                            </select>
                            <select name="modif" id="modif">
                                <option selected value="0"><- Opciones -></option>
                                <option value="1">modif estado</option>
                                <option value="2">modif documento</option>
                                <option value="3">modif linea</option>
                                <option value="4">modif Cilindrage</option>
                                <option value="5">modif Marca</option>

                            </select>

                            </span></td>
                        <td align="center"><label id="lbnumeroR" style="display:none"> RADICACION</label></td>
                        <td align="center">  <input s type="text" name="numeroR" id="numeroR" style="width:120px; display:none"/></td>
                    </tr>


                    <tr class="style9">
                        <td align="center" width="15%">OBSERVACION</td>
                        <td colspan="4" align="justify"><span class="style10" style="color: #333333">
                                <textarea name="observacion" id="observacion" style="width:600px; height:20x; font-size:11px"></textarea>
                            </span></td>
                        <td><span style="border:none">
                                <input name="adicionar" type="button" id="adicionar" value="Enviar Solicitud" style="width:120px; text-align:center" onclick="validar()"/>
                            </span></td>


                    </tr>

                </table>


            </fieldset>
            <fieldset>
                <iframe src="#" width="100%" id="respuesta" height="300"  align="center" frameborder="0" scrolling="auto"></iframe>
            </fieldset>
    </body>
</form>
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