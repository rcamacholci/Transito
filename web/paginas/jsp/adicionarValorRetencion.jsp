<%--
    Document   : adicionarRetencion
    Created on : 17/05/2016, 05:05:32 PM
    Author     : Andres
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <%
            try {
                Model model = (Model) session.getAttribute("model");
    %>
    <head>
        <title>Seleccionar Valor Avaluo Vehiculo</title>

        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
        <script type="text/javascript" src="../html/scripts/Retencion.js"></script>
        <META http-equiv=Content-Type content="text/html; charset=windows-1252" />

        <style type="text/css">
            <!--
            .style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
            .style3 {color: #FFFFFF}
            .style31 {color: #333333; font-size: 12px; font-weight: bold; font-family: Tahoma; }
            .Estilo2 {color: #FFFFFF; 	font-family: Tahoma; 	font-size: 12px; 	font-weight: bold; }
            -->
        </style>
        <script language="javascript" type="text/javascript">

        </script>

    </head>
    <body>
        <%
                long idVehiculo = Long.parseLong(request.getParameter("id"));
                Vehiculo vehiculo = model.consultarVehiculoById(idVehiculo);

                if (vehiculo != null) {
                    String placaVeh = vehiculo.getPlaca();
                    long claseVeh = 0;
                    long servicioVeh = 0;
                    long codMarca = 0;
                    String marcaVeh = "";
                    long codLinea = 0;
                    String lineaVeh = "";
                    
                    long cilindrajeVeh = 0;
                    long modeloVeh = 0;
                    long modalidadVeh = 0;
                    long carroceriaVeh = 0;
                    long subServicioVeh = 0;

                    int codTablaAvaluo = 0;
                    
                    long codClase = 0;

                    String campoTabla = "";

                    claseVeh = vehiculo.getClase_vehiculo();

                    servicioVeh = vehiculo.getServicio();

                    Linea lineaRunt = model.consultaLinea(vehiculo.getPlaca());
                    if (!lineaRunt.getNombre().equals("SIN LINEA")) {
                        Marca MarcaRunt = model.consultaMarcaCodigo(lineaRunt.getFk_marca());
                        if (!MarcaRunt.getNombre().equals("SIN MARCA")) {
                            codMarca = MarcaRunt.getCodigo();
                            marcaVeh = MarcaRunt.getNombre();
                            codLinea = lineaRunt.getId_linea();
                            lineaVeh = lineaRunt.getNombre();
                        }
                    }

                    DatosVehiculo datoCilindraje = model.consultarDatosVehiculoRete(idVehiculo, 11, 40);
                    if (datoCilindraje != null && datoCilindraje.getValor() != null) {
                        cilindrajeVeh = Long.parseLong(datoCilindraje.getValor());
                    }

                    if (vehiculo.getModelo() > 0) {
                        modeloVeh = vehiculo.getModelo();
                        if (modeloVeh < 1991) {
                            modeloVeh = 1991;
                        }
                    }

                    DatosVehiculo datoModalidad = model.consultarDatosVehiculo(idVehiculo, 1, 324);
                    if (datoModalidad != null && datoModalidad.getValor() != null) {
                        modalidadVeh = Long.parseLong(datoModalidad.getValor());
                    }

                    if (claseVeh != 0 && claseVeh != 10 && claseVeh != 14 && claseVeh != 19) {
                        DatosVehiculo datoCarroceria = model.consultarDatosVehiculo(idVehiculo, 1, 2);
                        if (datoCarroceria != null && !datoCarroceria.getValor().equals("0")) {
                            carroceriaVeh = Long.parseLong(datoCarroceria.getValor());
                        }
                    }

                    if (servicioVeh == 2) {
                        DatosVehiculo datoSubServicio = model.consultarDatosVehiculo(idVehiculo, 1, 362);
                        if (datoSubServicio != null && !datoSubServicio.getValor().equals("0")) {
                            subServicioVeh = Long.parseLong(datoSubServicio.getValor());
                        }
                    }

                    //VEHICULOS CLASE MOTOCICLETAS, MOTOCARRO, CUATRIMOTO
                    if (claseVeh == 10 || claseVeh == 14 || claseVeh == 19) {
                        codTablaAvaluo = 5;
                    } else {
                        //VEHICULOS CON CARROCERIA DOBLECABINA
                        if (carroceriaVeh == 25 || carroceriaVeh == 234 || carroceriaVeh == 235 || carroceriaVeh == 243 || carroceriaVeh == 241 ||
                                carroceriaVeh == 391 || carroceriaVeh == 402 || carroceriaVeh == 403 || carroceriaVeh == 405 || carroceriaVeh == 443 ||
                                carroceriaVeh == 472 || carroceriaVeh == 476 || carroceriaVeh == 838) {
                            codTablaAvaluo = 3;
                        } else {
                            //VEHICULOS CLASE AUTOMOVIL, BUS, BUSETA,CAMIONETA,CAMPERO,MICROBUS
                            //DE SERVICO PUBLICO Y MODALIDAD PASAJEROS
                            if (servicioVeh == 2 && modalidadVeh == 1 &&
                                    (claseVeh == 1 || claseVeh == 2 || claseVeh == 3 || claseVeh == 5 || claseVeh == 6 || claseVeh == 7)) {
                                codTablaAvaluo = 6;
                            } else {
                                //VEHICULOS CLASE CAMION, CAMIONETA, TRACTOCAMION,VOLQUETA
                                //DE MODALIDAD CARGA
                                if (modalidadVeh == 2 && (claseVeh == 4 || claseVeh == 5 || claseVeh == 8 || claseVeh == 42)) {
                                    codTablaAvaluo = 7;
                                } else {
                                    //VEHICULOS SUBSERVICIO AMBULANCIA
                                    if (subServicioVeh == 1) {
                                        codTablaAvaluo = 8;
                                    } else {
                                        //VEHICULOS CLASE AUTOMOVIL
                                        if (claseVeh == 1) {
                                            codTablaAvaluo = 1;
                                        } else {
                                            //VEHICULOS CLASE CAMIONETAS, CAMPEROS
                                            if (claseVeh == 5 || claseVeh == 6) {
                                                codTablaAvaluo = 2;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }



        %>
        <form  name="form"  method="post" action="">
            <input type="hidden" id="idVehiculo" name="idVehiculo" value="<%= idVehiculo %>" />
            <input type="hidden" id="placaVeh" name="placaVeh" value="<%= placaVeh %>" />
            <input type="hidden" id="marcaVeh" name="marcaVeh" value="<%=marcaVeh %>" />
            <input type="hidden" id="codClase" name="codClase" value="<%=claseVeh %>" />
            <input type="hidden" id="codServicio" name="codServicio" value="<%=servicioVeh %>" />
            <input type="hidden" id="codMarca" name="codMarca" value="<%=codMarca %>" />
            <input type="hidden" id="codLinea" name="codLinea" value="<%=codLinea %>" />
            <input type="hidden" id="modalidadVeh" name="modalidadVeh" value="<%=modalidadVeh %>" />
            <input type="hidden" id="carroceriaVeh" name="carroceriaVeh" value="<%=carroceriaVeh %>" />
            <input type="hidden" id="subServicioVeh" name="subServicioVeh" value="<%=subServicioVeh %>" />
            <input type="hidden" id="cilindrajeVeh" name="cilindrajeVeh" value="<%=cilindrajeVeh %>" />
            <input type="hidden" id="modeloVeh" name="modeloVeh" value="<%=modeloVeh %>" />
            <input type="hidden" id="codTablaAvaluo" name="codTablaAvaluo"  value="<%= codTablaAvaluo %>">

            <fieldset>
                <table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr style="border:none; background:url(../html/images/inicio_3.png)">
                        <td align="center"><span class="Estilo2">AVALUO COMERCIAL</span> </td>
                        <td align="left"><a href="adicionarValorAvaluo.jsp?id=<%=idVehiculo%>"><span class="Estilo2">Avaluo Manual</span></a></td>
                    </tr>
                    <tr>
                        <td width="30%" scope="col" align="right"><label><span class="style2">TABLA&nbsp;</span></label></td>
                        <%
                        Parametro parametroTablaAvaluo = new Parametro();
                        if (codTablaAvaluo == 0) {
                        %>
                        <td width="50%">
                            <select name="tablasAvaluo" id="tablasAvaluo" onchange="verComboRetencion('TablaAvaluo')" style="width:250px;">
                                <option value="0"><<--Seleccione Tabla-->></option>
                                <%
                           java.util.List list = model.listadoParametros(371);
                           java.util.Iterator it = list.iterator();
                            while (it.hasNext()) {
                                parametroTablaAvaluo = (Parametro) it.next();%>
                                <option value="<%=parametroTablaAvaluo.getCodigo() + ""%>"><%=parametroTablaAvaluo.getNombre()%></option>
                                <%}%>
                            </select>
                        </td>
                        <%
                        } else {
                        Parametro parametroTabla = model.consultarParametro(codTablaAvaluo, 371);
                        if(parametroTabla!=null){
                            if(codTablaAvaluo==2){
                                campoTabla = "CAMIONETAS";
                            }else{
                                if(codTablaAvaluo==5){
                                    campoTabla = "MOTOCICLETAS";
                                }else{
                                    campoTabla = parametroTabla.getNombre();
                                }
                            }
                        }
                        %>
                        <td width="50%">
                            <select name="tablasAvaluo" id="tablasAvaluo" style="width:250px;" disabled >
                                <%
                           parametroTablaAvaluo = model.consultarParametro(codTablaAvaluo, 371);
                           if (parametroTablaAvaluo != null) {
                                %>
                                <option value="<%=parametroTablaAvaluo.getCodigo() + ""%>"><%=parametroTablaAvaluo.getNombre()%></option>
                                <%
                          }
                                %>
                            </select>
                        </td>
                        <%
                    }
                        %>
                    </tr>

                    <tr id="TRClaseVeh" style="display:none">
                        <td width="30%" scope="col" align="right"><label><span class="style2">CLASE&nbsp;</span></label></td>
                        <td width="50%" scope="col" align="left">
                            <div id="clasesdiv" style="width:300px">
                                <select name="clases" id="clases" style="width:250px;" >
                                    <option value="0"><<--Seleccione Clase-->></option>
                                </select>
                            </div>
                        </td>
                    </tr>

                    <tr id="TRMarcas" style="display:none">
                        <td width="30%" scope="col" align="right"><label><span class="style2">MARCA&nbsp;</span></label></td>
                        <td width="50%" scope="col" align="left">
                            <div id="marcasdiv" style="width:300px">
                                <select name="marcas" id="marcas" style="width:250px;" >
                                    <option value="0"><<--Seleccione Marca-->></option>
                                </select>
                            </div>
                        </td>

                    </tr>

                    <tr id="TRLineas" style="display:none">
                        <td width="30%" scope="col" align="right"><label><span class="style2">LINEA&nbsp;</span></label></td>
                        <td width="50%" scope="col" align="left">
                            <div id="lineasdiv" style="width:300px">
                                <select name="lineas" id="lineas" style="width:250px;" >
                                    <option value="0"><<--Seleccione Linea-->></option>
                                </select>
                            </div>
                        </td>
                    </tr>

                    <tr id="TRCilindrajes" style="display:none">
                        <td width="30%" scope="col" align="right"><label><span class="style2">CILINDRAJE&nbsp;</span></label></td>
                        <td width="50%" scope="col" align="left">
                            <div id="cilindrajediv" style="width:300px">
                                <select name="cilindrajes" id="cilindrajes" style="width:250px;" >
                                    <option value="0"><<--Seleccione Cilindraje-->></option>
                                </select>
                            </div>
                        </td>
                    </tr>

                    <tr id="TRCantPasajeros" style="display:none">
                        <td width="30%" scope="col" align="right"><label><span class="style2">CANT.&nbsp;PASAJEROS&nbsp;</span></label></td>
                        <td width="50%" scope="col" align="left">
                            <div id="pasajerosdiv" style="width:300px">
                                <select name="pasajeros" id="pasajeros" style="width:250px;" >
                                    <option value="0"><<--Seleccione Cant. Pasajeros-->></option>
                                </select>
                            </div>
                        </td>
                    </tr>

                    <tr id="TRCapaTonelaje" style="display:none">
                        <td width="30%" scope="col" align="right"><label><span class="style2">CAP.&nbsp;TONELAJE&nbsp;</span></label></td>
                        <td width="50%" scope="col" align="left">
                            <div id="tonelajediv" style="width:300px">
                                <select name="toneladas" id="toneladas" style="width:250px;" >
                                    <option value="0"><<--Seleccione Cap. Toneladas-->></option>
                                </select>
                            </div>
                        </td>
                    </tr>

                    <tr id="TRModelos" style="display:none">
                        <td width="30%" scope="col" align="right"><label><span class="style2">MODELO&nbsp;</span></label></td>
                        <td width="50%" scope="col" align="left">
                            <div id="modelodiv" style="width:300px">
                                <select name="modelos" id="modelos" style="width:250px;" disabled >
                                    <option value="0"><<--Seleccione Modelo-->></option>
                                </select>
                            </div>
                        </td>
                    </tr>

                    <tr id="TRValorAvaluo" style="display:none">
                        <td width="100%" colspan="4" scope="col" align="center">
                            <div id="valoresdiv" style="width:500px"></div>
                        </td>
                    </tr>

                    <tr id="TRValorAvaluoM" style="display:none">
                        <td width="30%" scope="col" align="right"><label><span class="style2">&nbsp;VALOR&nbsp;AVALUO&nbsp;</span></label><br>
                        <td width="50%" colspan="2" scope="col" align="left">
                            <input name="valorAvaluoM" id="valorAvaluoM" style="width:195px;" >
                        </td>
                    </tr>

                    <tr id="TRGuardar" style="display:none">
                        <td width="80%" colspan="2" align="center">
                            <input type="button" name="adicionar" id="adicionar" value="Registrar" onclick="verComboRetencion('ValorAvaluo')" >
                        </td>
                    </tr>
                    <script language="javascript" type="text/javascript">verComboRetencion('TablaAvaluo');</script>
                </table>
            </fieldset>
        </form>
    </body>
</html>
<%
        }
} catch (Exception mexe) { %>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% }%>