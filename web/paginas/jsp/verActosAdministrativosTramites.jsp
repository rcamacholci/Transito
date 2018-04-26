<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("actosAdministrativos.jsp")) {
%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Alertas</title>
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <link rel=StyleSheet href="../html/css/msj.css" Ttype="text/css" media=screen>
            <script type="text/javascript" src="../html/scripts/calendar.js"></script>
            <script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
            <script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
            <script type="text/javascript" src="../html/scripts/alertas.js"></script>
            <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
            <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
            <style type="text/css">

                <!--
                .Estilo13 {color: #FFFFFF; font-weight: bold; }
                .Estilo20 {font-size: 12px; font-weight: bold; color: #333333; }
                .style1 {
                    color: #333333;
                    font-size: 12px;
                    font-family: Tahoma;
                }
                .style4 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
                .style6 {font-size: 12px; font-weight: bold; color: #333333; }

                .style3 {
                    color: #333333;
                    font-size: 12px;
                }
                .style7 {
                    color: #333333;
                    font-size: 12px;
                    font-weight: bold;
                    font-family: Tahoma;
                }
                .style9 {color: #333333; font-size: small; font-weight: bold; font-family: Tahoma; }
                .style10 {font-size: small}
                .Estilo12 {
                    color: #333333;
                    font-size: 10px;
                }
                .Estilo15 {color: #333333; font-size: 10px; font-weight: bold; font-family: Tahoma; }
                .Estilo16 {font-size: 10px}



                -->
            </style>
            <script language="javascript" type="text/javascript">

                function sombrear(tr) {
                    tr.style.backgroundColor = "#CCCCCC";
                }
                function renovar(tr) {
                    tr.style.backgroundColor = "#FFFFFF";
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


                function validarPersona() {

                    valor = document.form.documento.value;
                    if (valor.length > 0) {

                        valor2 = document.form.tipos.options[document.form.tipos.selectedIndex].value;
                        //valor2=tipo.options[tipo.options.selectedIndex].value

                        ajax = nuevoAjax();
                        ajax.open("POST", "getPersona.jsp", true);
                        ajax.onreadystatechange = function () {
                            if (ajax.readyState == 4) {
                                if (ajax.responseText.indexOf("nueva") == -1) {
                                    document.form.nombre.value = ajax.responseText;
                                } else {
                                    viewPersona(valor2, valor);
                                }
                            }
                        }
                        ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

                        ajax.send("documento=" + valor + "&tipo=" + valor2);
                    }
                }

                function viewPersona(tipo, numero) {
                    var ancho = 689;
                    var alto = 250;
                    var barra = 0;
                    var izquierda = (screen.width) ? (screen.width - ancho) / 2 : 100;
                    var arriba = (screen.height) ? (screen.height - alto) / 2 : 100;
                    var opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba;
                    var url = "adicionarPersona.jsp?tipo=" + tipo + "&documento=" + numero;
                    window.open(url, 'popUp', opciones);
                }

            </script>
    </head>
    <%@ page import="modelo.*"%>
    <%@page import="java.util.*"%>


    <%
        Model modelo = (Model) session.getAttribute("model");
        String placa = "";
        String numA = "";
        String observacion = "";
        String tipo = "";
        int tramite = 0;
        String numR = "";
        String fecha = null;
        if (request.getParameter("fecha") != null) {
            fecha = request.getParameter("fecha");
            System.out.println("fecha : " + fecha);

        }
        if (request.getParameter("numA") != null) {
            numA = request.getParameter("numA");
        }
        if (request.getParameter("placa") != null) {
            placa = request.getParameter("placa");
        }
        if (request.getParameter("observacion") != null) {
            observacion = request.getParameter("observacion");
        }
        if (request.getParameter("tipo").equals("1") && request.getParameter("tipo") != null) {
            tipo = request.getParameter("tipo");
            if (request.getParameter("numR") != null) {
                numR = request.getParameter("numR");
            }
            if (request.getParameter("tramite") != null) {
                tramite = Integer.parseInt(request.getParameter("tramite"));
            }

            if (!placa.equals("") && !numA.equals("") && !observacion.equals("") && !tipo.equals("") && !numR.equals("") && tramite != 0) {
                if (tipo.equals("1")) {
                    Radicacion radicacion = modelo.consultarRadicacionPlacaTramite(numR, placa.toUpperCase(), tramite);
                    if (radicacion != null) {
    %>
    <body>
        <form name="form" action="procesarActoAdministrativo.jsp" method="post">
            <input type="hidden" id="placa" name="placa" value="<%=placa%>">
                <input type="hidden" id="numA" name="numA" value="<%=numA%>">
                    <input type="hidden" id="observacion" name="observacion" value="<%=observacion%>">
                        <input type="hidden" id="tipo" name="tipo" value="<%=tipo%>">
                            <input type="hidden" id="numR" name="numR" value="<%=numR%>">
                                <input type="hidden" id="tramite" name="tramite" value="<%=tramite%>">
                                    <input type="hidden" id="fecha" name="fecha" value="<%=fecha%>">

                                        <table width="100%" border="0" cellpadding="1" cellspacing="0">
                                            <tr  style="border:none; background:url(../html/images/inicio_3.png)">
                                                <td width="10%" style="border:none"><div align="center" class="style4">NUMERO&nbsp;R</div></td>
                                                <td width="10%" style="border:none"><div align="center" class="style4">PLACA</div></td>
                                                <td width="40%" style="border:none"><div align="center" class="style4">TRAMITE</div></td>
                                                <td width="20%" style="border:none"><div align="center" class="style4">FECHA</div></td>
                                                <td width="20%" style="border:none"><div align="center" class="style4">ESTADO</div></td>
                                            </tr>
                                            <tr bgcolor="#66CCFF">
                                                <td colspan="5">&nbsp;</td>
                                            </tr>
                                            <%
                                                Tramite tramit = modelo.consultarTramite(tramite);
                                                Parametro estado = modelo.consultarParametro(radicacion.getEstado(), 52);
                                                if (tramit != null && estado != null) {%>
                                            <tr bgcolor="#FFFFFF"  onMouseOver="sombrear(this)" onMouseOut="renovar(this)" style="cursor:pointer">
                                                <td align="center"><span class="style6"><%=radicacion.getNumero()%></span></td>
                                                <td align="center"><span class="style6"><%=placa%></span></td>
                                                <td align="center"><span class="style6"><%=tramit.getNombre()%></span></td>
                                                <td align="center"><span class="style6"><%=radicacion.getFecha() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(radicacion.getFecha()) : ""%></span></td>
                                                <td align="center"><span class="style6"><%=estado.getNombre()%></span></td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="5"><span class="style6">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="5"><span class="style6"><span style="border:none">
                                                            <input name="adicionar" type="submit" id="adicionar" value="Aplicar Revocatoria" style="width:160px; text-align:center" onclick="validar()"/>
                                                        </span></span></td>
                                            </tr>
                                            <% } %>
                                        </table>
                                        </form>
                                        <%          }
                                                }
                                            }
                                        } else {
                                            tipo = request.getParameter("tipo");
                                            String modif = request.getParameter("modif");
                                            if (1 == 1) {
                                        %>
                                        <body>
                                            <form name="form" action="procesarActoAdministrativo.jsp" method="post">
                                                <input type="hidden" id="placa" name="placa" value="<%=placa%>">
                                                    <input type="hidden" id="numA" name="numA" value="<%=numA%>">
                                                        <input type="hidden" id="observacion" name="observacion" value="<%=observacion%>">
                                                            <input type="hidden" id="tipo" name="tipo" value="<%=tipo%>">
                                                                <input type="hidden" id="numR" name="numR" value="0">
                                                                    <input type="hidden" id="tramite" name="tramite" value="<%=tramite%>">
                                                                        <input type="hidden" id="modif" name="modif" value="<%=modif%>">
                                                                            <input type="hidden" id="fecha" name="fecha" value="<%=fecha%>">

                                                                                <table width="100%" border="0" cellpadding="1" cellspacing="0">
                                                                                    <%
                                                                                        Vehiculo veh = modelo.consultarVehiculo(placa.toUpperCase());
                                                                                        Parametro temppa1 = modelo.consultarParametro((int) veh.getEstado(), 66);
                                                                                        LinkedList<Parametro> temp = modelo.listadoParametros(66);
                                                                                        Propietario prop = modelo.getUnicoPropietarioVehiculo(veh.getId_vehiculo());
                                                                                        Persona per = modelo.consultarPersona(prop.getFk_persona());

                                                                                        if (modif.equals("1")) {%>
                                                                                    <tr  style="border:none; background:url(../html/images/inicio_3.png)">
                                                                                        <td width="9%" style="border:none"><div align="center" class="style4">NUMERO&nbsp;VEH</div></td>
                                                                                        <td width="9%" style="border:none"><div align="center" class="style4">PLACA</div></td>
                                                                                        <td width="29%" style="border:none"><div align="center" class="style4">ESTADO ACTUAL</div></td>
                                                                                        <td width="10%" style="border:none"><div align="center" class="style4">NUMERO ACTO</div></td>
                                                                                        <td width="14%" style="border:none"><div align="center" class="style4">NUEVO ESTADO</div></td>
                                                                                    </tr>
                                                                                    <tr bgcolor="#66CCFF">
                                                                                        <td colspan="5">&nbsp;</td>
                                                                                    </tr>

                                                                                    <tr bgcolor="#FFFFFF"  onMouseOver="sombrear(this)" onMouseOut="renovar(this)" style="cursor:pointer">
                                                                                        <td align="center"><span class="style6"><%=veh.getId_vehiculo()%></span></td>
                                                                                        <td align="center"><span class="style6"><%=placa.toUpperCase()%></span></td>
                                                                                        <td align="center"><span class="style6"><%=temppa1.getNombre()%></span></td>
                                                                                        <td align="center"><span class="style6"><%=numA%></span></td>
                                                                                        <td align="center"><span class="style6"><select id="estado" name="estado">
                                                                                                    <option value="0" selected><--- ---></option>
                                                                                                    <%
                                                                                                        for (int i = 0; i < temp.size(); i++) {
                                                                                                            Parametro para = temp.get(i);
                                                                                                    %>
                                                                                                    <option value="<%=para.getCodigo()%>"><%=para.getNombre()%></option>
                                                                                                    <%}
                                                                                                    %>
                                                                                                </select></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="center" colspan="5"><span class="style6">&nbsp;</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="center" colspan="5"><span class="style6"><span style="border:none">
                                                                                                    <input name="adicionar" type="submit" id="adicionar" value="Modificar" style="width:160px; text-align:center"/> <!--onclick="validar()-->
                                                                                                </span></span></td>
                                                                                    </tr>
                                                                                    <% } else {
                                                                                        if (modif.equals("2")) {
                                                                                    %>


                                                                                    <tr  style="border:none; background:url(../html/images/inicio_3.png)">
                                                                                        <td width="9%" style="border:none"><div align="center" class="style4">T.&nbsp;DOCUMENTO</div></td>
                                                                                        <td width="9%" style="border:none"><div align="center" class="style4">DOCUMENTE</div></td>
                                                                                        <td width="29%" style="border:none"><div align="center" class="style4">NOMBRES&nbsp;PROP. ACTUAL</div></td>
                                                                                        <td width="10%" style="border:none"><div align="center" class="style4">T. DOCUMENTO</div></td>
                                                                                        <td width="14%" style="border:none"><div align="center" class="style4">DOCUEMNTO</div></td>
                                                                                        <td width="29%" style="border:none"><div align="center" class="style4">NOMBRE NUEVO PROPIETAROIO</div></td>
                                                                                    </tr>
                                                                                    <tr bgcolor="#66CCFF">
                                                                                        <td colspan="6">&nbsp;</td>
                                                                                    </tr>
                                                                                    <tr bgcolor="#FFFFFF"  onMouseOver="sombrear(this)" onMouseOut="renovar(this)" style="cursor:pointer">
                                                                                        <td align="center"><span class="style6"><select id="Td1" name="Td1" >
                                                                                                    <%
                                                                                                        LinkedList<Parametro> temp1 = modelo.listadoParametros(5);
                                                                                                        for (int i = 0; i < temp1.size(); i++) {
                                                                                                            Parametro para = temp1.get(i);

                                                                                                            if (per.getTipo_documento() == para.getCodigo()) {
                                                                                                    %>
                                                                                                    <option value="<%=para.getCodigo()%>" selected><%=para.getNombre()%></option>
                                                                                                    <%}
                                                                                                        }
                                                                                                    %>
                                                                                                </select></td>
                                                                                        <td align="center"><span class="style6">
                                                                                                <input name="document" type="text" id="document" value="<%=per.getDocumento()%>" size="15" readonly />
                                                                                            </span></td>
                                                                                        <td align="center"><span class="style6"><input name="nom1" type="text" id="nom1" value="<%=per.getNombre_1()%> <%=per.getApellido_1()%> <%=per.getApellido_2()%>" size="50" readonly></span></td>
                                                                                        <td align="center"><span class="style6">        <select name="tipos" style="width:160px;font-size:11px">
                                                                                                    <%
                                                                                                        List list = modelo.listadoParametros(5);
                                                                                                        Parametro parametro = null;
                                                                                                        Iterator it = null;
                                                                                                        it = list.iterator();
                                                                                                        while (it.hasNext()) {
                                                                                                            parametro = (Parametro) it.next();

                                                                                                    %>
                                                                                                    <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
                                                                                                    <%}%>
                                                                                                </select></td>
                                                                                        <td> <input type="text" name="documento"  id="documento" onblur="validarPersona()" style="width:160px; text-align:center; font-size:11px"/></td>
                                                                                        <td align="center"><span class="style6">        <label>
                                                                                                    <input name="nombre" type="text"  style="width:160px; text-align:center; font-size:11px" id="nombre" readonly="" />
                                                                                                </label></span></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="center" colspan="5"><span class="style6">&nbsp;</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="center" colspan="5"><span class="style6"><span style="border:none">
                                                                                                    <input name="adicionar" type="submit" id="adicionar" value="Modificar" style="width:160px; text-align:center"/> <!--onclick="validar()-->
                                                                                                </span></span></td>
                                                                                    </tr>
                                                                                    <%
                                                                                    } else {
                                                                                        if (modif.equals("3")) {

                                                                                            Linea lin = modelo.consultaLinea(veh.getPlaca().toUpperCase());
                                                                                    %>
                                                                                    <tr  style="border:none; background:url(../html/images/inicio_3.png)">
                                                                                        <td width="9%" style="border:none"><div align="center" class="style4">NUMERO&nbsp;VEH</div></td>
                                                                                        <td width="9%" style="border:none"><div align="center" class="style4">PLACA</div></td>
                                                                                        <td width="29%" style="border:none"><div align="center" class="style4">LINEA ACTUAL</div></td>
                                                                                        <td width="10%" style="border:none"><div align="center" class="style4">NUMERO ACTO</div></td>
                                                                                        <td width="14%" style="border:none"><div align="center" class="style4">NUEVA LINEA</div></td>
                                                                                    </tr>
                                                                                    <tr bgcolor="#66CCFF">
                                                                                        <td colspan="5">&nbsp;</td>
                                                                                    </tr>

                                                                                    <tr bgcolor="#FFFFFF"  onMouseOver="sombrear(this)" onMouseOut="renovar(this)" style="cursor:pointer">
                                                                                        <td align="center"><span class="style6"><%=veh.getId_vehiculo()%></span></td>
                                                                                        <td align="center"><span class="style6"><%=placa.toUpperCase()%></span></td>
                                                                                        <td align="center"><span class="style6"><%=lin.getNombre()%></span></td>
                                                                                        <td align="center"><span class="style6"><%=numA%></span></td>
                                                                                        <td align="center"><span class="style6"><select id="estado" name="estado">
                                                                                                    <%
                                                                                                        Marca marca_veh = null;

                                                                                                        long marca_cod = 0;
                                                                                                        long linea_cod = 0;
                                                                                                        java.util.List marcas = modelo.listadoMarcas();
                                                                                                        if (veh != null) {
                                                                                                            marca_veh = modelo.consultaMarca(veh.getPlaca().toUpperCase());
                                                                                                            if (marca_veh != null) {
                                                                                                                marca_cod = marca_veh.getCodigo();
                                                                                                            }
                                                                                                            linea_cod = veh.getFk_linea();
                                                                                                        }
                                                                                                        java.util.List lineas = modelo.listaLineas(marca_cod);
                                                                                                    %>

                                                                                                    <option value="0" selected><--- ---></option>

                                                                                                    <%  for (int i = 0; i < lineas.size(); i++) {
                                                                                                            Linea linea = (Linea) lineas.get(i);
                                                                                                            if (linea.getId_linea() == lin.getId_linea()) {
                                                                                                    %>
                                                                                                    <option value="<%=linea.getId_linea()%>" selected><%= linea.getNombre()%></option>
                                                                                                    <%} else {
                                                                                                    %>
                                                                                                    <option value="<%=linea.getId_linea()%>"><%= linea.getNombre()%> </option>
                                                                                                    <%

                                                                                                            }
                                                                                                        }
                                                                                                    %>

                                                                                                    %>
                                                                                                </select>

                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="center" colspan="5"><span class="style6">&nbsp;</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="center" colspan="5"><span class="style6"><span style="border:none">
                                                                                                    <input name="adicionar" type="submit" id="adicionar" value="Modificar" style="width:160px; text-align:center"/> <!--onclick="validar()-->
                                                                                                </span></span></td>
                                                                                    </tr>
                                                                                    <%} else {
                                                                                        if (modif.equals("4")) {
                                                                                            Linea lin = modelo.consultaLinea(veh.getPlaca().toUpperCase());
                                                                                            java.util.List lista = modelo.listarDatosVehiculo(veh.getId_vehiculo());
                                                                                            long c = 0;
                                                                                            for (int i = 0; i < lista.size(); i++) {
                                                                                                DatosVehiculo dv = (DatosVehiculo) lista.get(i);
                                                                                                if (dv.getSub_grupo_codigo() == 40) {
                                                                                                    if (dv.getGrupo_codigo() == 2) {
                                                                                                        if (dv.getParam_codigo() == 11) {
                                                                                                            c = Long.parseLong(dv.getValor().toString());
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                    %>

                                                                                    <tr  style="border:none; background:url(../html/images/inicio_3.png)">
                                                                                        <td width="9%" style="border:none"><div align="center" class="style4">NUMERO&nbsp;VEH</div></td>
                                                                                        <td width="9%" style="border:none"><div align="center" class="style4">PLACA</div></td>
                                                                                        <td width="29%" style="border:none"><div align="center" class="style4">CILINDRAJE ACTUAL</div></td>
                                                                                        <td width="10%" style="border:none"><div align="center" class="style4">NUMERO ACTO</div></td>
                                                                                        <td width="14%" style="border:none"><div align="center" class="style4">NUEVA CILINDRAJE</div></td>
                                                                                    </tr>
                                                                                    <tr bgcolor="#66CCFF">
                                                                                        <td colspan="5">&nbsp;</td>
                                                                                    </tr>

                                                                                    <tr bgcolor="#FFFFFF"  onMouseOver="sombrear(this)" onMouseOut="renovar(this)" style="cursor:pointer">
                                                                                        <td align="center"><span class="style6"><%=veh.getId_vehiculo()%></span></td>
                                                                                        <td align="center"><span class="style6"><%=placa.toUpperCase()%></span></td>
                                                                                        <td align="center"><span class="style6"><%=c%></span></td>
                                                                                        <td align="center"><span class="style6"><%=numA%></span></td>
                                                                                        <td align="center"><span class="style6"><input type="text" id="estado" name="estado" /></td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="center" colspan="5"><span class="style6">&nbsp;</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="center" colspan="5"><span class="style6"><span style="border:none">
                                                                                                    <input name="adicionar" type="submit" id="adicionar" value="Cilindrage" style="width:160px; text-align:center"/> <!--onclick="validar()-->
                                                                                                </span></span></td>
                                                                                    </tr>
                                                                                    <%} else {
                                                                                        Linea lin = modelo.consultaLinea(veh.getPlaca().toUpperCase());
                                                                                        Marca arca_veh = modelo.consultaMarca(veh.getPlaca().toUpperCase());
                                                                                    %>
                                                                                    <tr  style="border:none; background:url(../html/images/inicio_3.png)">
                                                                                        <td width="9%" style="border:none"><div align="center" class="style4">NUMERO&nbsp;VEH</div></td>
                                                                                        <td width="9%" style="border:none"><div align="center" class="style4">PLACA</div></td>
                                                                                        <td width="29%" style="border:none"><div align="center" class="style4">MARCA ACTUAL</div></td>
                                                                                        <td width="10%" style="border:none"><div align="center" class="style4">NUMERO ACTO</div></td>
                                                                                        <td width="14%" style="border:none"><div align="center" class="style4">NUEVA MARCA</div></td>
                                                                                    </tr>
                                                                                    <tr bgcolor="#66CCFF">
                                                                                        <td colspan="5">&nbsp;</td>
                                                                                    </tr>

                                                                                    <tr bgcolor="#FFFFFF"  onMouseOver="sombrear(this)" onMouseOut="renovar(this)" style="cursor:pointer">
                                                                                        <td align="center"><span class="style6"><%=veh.getId_vehiculo()%></span></td>
                                                                                        <td align="center"><span class="style6"><%=placa.toUpperCase()%></span></td>
                                                                                        <td align="center"><span class="style6"><%=arca_veh.getNombre()%></span></td>
                                                                                        <td align="center"><span class="style6"><%=numA%></span></td>
                                                                                        <td align="center"><span class="style6"><select id="estado" name="estado">
                                                                                                    <%
                                                                                                        Marca marca_veh = null;

                                                                                                        long marca_cod = 0;
                                                                                                        long linea_cod = 0;
                                                                                                        java.util.List lineas = modelo.listadoMarcas();
                                                                                                        if (veh != null) {
                                                                                                            marca_veh = modelo.consultaMarca(veh.getPlaca().toUpperCase());
                                                                                                            if (marca_veh != null) {
                                                                                                                marca_cod = marca_veh.getCodigo();
                                                                                                            }
                                                                                                            linea_cod = veh.getFk_linea();
                                                                                                        }
                                                                                                        //java.util.List lineas = modelo.listaLineas(marca_cod);
                                                                                                    %>

                                                                                                    <option value="0" selected><--- ---></option>

                                                                                                    <%  for (int i = 0; i < lineas.size(); i++) {
                                                                                                            Marca linea = (Marca) lineas.get(i);
                                                                                                            if (linea.getCodigo() == marca_cod) {
                                                                                                    %>
                                                                                                    <option value="<%=linea.getId_marca()%>" selected><%= linea.getNombre()%></option>
                                                                                                    <%} else {
                                                                                                    %>
                                                                                                    <option value="<%=linea.getCodigo()%>"><%= linea.getNombre()%> </option>
                                                                                                    <%

                                                                                                            }
                                                                                                        }
                                                                                                    %>

                                                                                                    %>
                                                                                                </select>

                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="center" colspan="5"><span class="style6">&nbsp;</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="center" colspan="5"><span class="style6"><span style="border:none">
                                                                                                    <input name="adicionar" type="submit" id="adicionar" value="Modificar" style="width:160px; text-align:center"/> <!--onclick="validar()-->
                                                                                                </span></span></td>
                                                                                    </tr>
                                                                                    }%>


                                                                                    <% }
                                                                                        }%>
                                                                                </table>
                                                                                </form>

                                                                                <% }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                %>
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
                                                                                } catch (Exception mexe) {
                                                                                    mexe.printStackTrace();%>
                                                                                <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
                                                                                <%
                                                                                    }%>