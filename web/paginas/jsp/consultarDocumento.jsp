<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("consultarDatosPersona.jsp")) {
                Model modelo = (Model) session.getAttribute("model");
                modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
            <!--
            .Estilo3 {font-size: 12px; color: #FFFFFF; }
            .Estilo4 {
                color: #333333;
                font-weight: bold;
                font-size: 12px;
            }
            .style2 {font-weight: bold; color: #333333;}
            .style3 {font-size: 11px}
            -->
        </style>



        <script language="javascript" type="text/javascript">

            function sombrear(tr) {
                tr.style.backgroundColor = "#CCCCCC";
            }
            function renovar(tr) {
                tr.style.backgroundColor = "#FFFFFF";
            }

            function datosVehiculo(tr) {
                var nplaca = tr.id;
                window.location.href = "verDatosVehiculo.jsp?id=0&placa=" + nplaca;
            }

            function GenerarReporte() {
                //document.form.motor.value
                ancho = 789;
                alto = 250;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "certificados/RVehiculo.jasper";
                var nombre = "certificadoTradicion";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }

            function GenerarTraspasoIndeterminado() {
                //document.form.motor.value
                ancho = 789;
                alto = 250;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "certificados/traspasoIndeterminado.jasper";
                var nombre = "TraspasoIndeterminado";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }

            function GenerarCertificadoCancelacion() {
                //document.form.motor.value
                ancho = 789;
                alto = 250;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "certificados/CancelacionMatricula.jasper";
                var nombre = "certificadoCancelacion";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }

            function GenerarCertificadoTraslado() {
                //document.form.motor.value
                ancho = 789;
                alto = 250;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "certificados/TrasladoCuenta.jasper";
                var nombre = "certificadoTraslado";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }



            function GenerarReportePazYSalvo() {
                //document.form.motor.value
                ancho = 789;
                alto = 250;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "certificados/CertificadoPazYSalvo.jasper";
                var nombre = "certificadoPazYSalvo";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }

            function GenerarReporteComparendo() {
                //document.form.motor.value
                ancho = 789;
                alto = 250;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "certificados/DescuentoComparendo.jasper";
                var nombre = "descuentoComparendo";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }




        </script>
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
        <script type="text/javascript" src="../html/scripts/adicionarComparendo.js"></script>
        <script type="text/javascript" src="../html/scripts/consultasGenerales.js"></script>
        <script src="../html/scripts/insertObert.js" type="text/javascript"></script>
    </head>
    <body>
        <fieldset><div align="center">
                <legend class="Estilo4"  align="center">DATOS DEL VEHICULO</legend>
            </div>
            <table width="100%" border="1" cellpadding="1" align="center" cellspacing="0">
                <tr style="background:url(../html/images/inicio_3.png); border:none">
                    <th width="10%" style="border:none" scope="col"><span class="Estilo3">REFERENCIA</span></th>
                    <th width="30%" style="border:none" scope="col"><span class="Estilo3">TIPO DOC. </span></th>
                    <th width="15%" style="border:none" scope="col"><span class="Estilo3">NUMERO</span></th>
                    <th width="15%" style="border:none" scope="col"><span class="Estilo3">FECHA&nbsp;EXP. </span></th>
                    <th width="15%" style="border:none" scope="col"><span class="Estilo3">FECHA&nbsp;IMP.</span></th>
                    <th width="15%" style="border:none" scope="col"><span class="Estilo3">ESTADO</span></th>
                </tr>
                <%
                    Vehiculo vehiculo = null;
                    Documento documento = null;
                    Comparendo cprendo = null;
                    String mensaje = "";
                    String numComp = "";

                    try {
                        if ((request.getParameter("placa") != null) && (request.getParameter("documento") != null)) {
                            if (!request.getParameter("documento").equals("5")) {
                                vehiculo = modelo.consultarVehiculo(request.getParameter("placa").toUpperCase());
                                if (vehiculo != null) {
                                    documento = modelo.consultarDocumentoByFkVehiculo(vehiculo.getId_vehiculo(), Integer.parseInt(request.getParameter("documento")));
                                } else {
                                    mensaje = "NO HAY VEHICULO";
                                }
                            } else {
                                numComp = request.getParameter("placa");
                                cprendo = modelo.consultar_Comparendo(numComp);
                                if (cprendo != null) {
                                    documento = modelo.consultarDocumentoByFkPersona(cprendo.getFk_persona(), 5);
                                }
                            }
                            if (documento != null) {

                                if (documento.getTipo() == 1) {
                                    Licencia_Transito licencia = null;
                                    String licenciaTransito = "";
                                    licencia = modelo.consultarLicenciaTransito(vehiculo.getId_vehiculo());
                                    if (licencia != null) {
                                        licenciaTransito = licencia.getNumero();
                                    }
                                    String clase = modelo.consultarParametroName(1, (int) vehiculo.getClase_vehiculo());
                                    String servicio = modelo.consultarParametroName(3, (int) vehiculo.getServicio());
                                    DatosVehiculo dvModalidad = modelo.consultarDatosVehiculo(vehiculo.getId_vehiculo(), 1, 324);
                                    DatosVehiculo dvCombustible = modelo.consultarDatosVehiculo(vehiculo.getId_vehiculo(), 1, 75);
                                    String modalidad = "";
                                    if (dvModalidad != null) {
                                        modalidad = modelo.consultarParametroName(324, Integer.parseInt(dvModalidad.getValor()));
                                    }
                                    
                                    String combustible="" ;
                                    
                                    if(dvCombustible!=null)
                                    combustible=modelo.consultarParametroName(75, Integer.parseInt(dvCombustible.getValor()));

                                    String color = modelo.consultarColor(vehiculo.getPlaca()) != null ? modelo.consultarColor(vehiculo.getPlaca()) : "";
                                    java.util.HashMap especificaciones = modelo.listarEspecificacionesVehiculo(vehiculo.getPlaca().toUpperCase());
                                    java.util.HashMap caracteristicas = modelo.listarCaracteristicasVehiculo(vehiculo.getPlaca().toUpperCase());
                                    Linea linea = modelo.getLinea(vehiculo.getFk_linea());
                                    Marca marca = modelo.consultaMarca(vehiculo.getPlaca());
                                    Linea_Remolques li = null;
                                    Marcas_Remolques ma = null;
                                    if (vehiculo.getClase_vehiculo() == 41) {
                                        li = modelo.getLineaRNRYS(vehiculo.getFk_linea());
                                        if (li != null) {
                                            ma = modelo.getMarcaRNRYS(li.getFk_marca());
                                        }
                                    }

                                    String estadoV = modelo.consultarParametroName(66, (int) (vehiculo.getEstado()));

                                    String nro_tiquete = "";
                                    String solicitante = "";
                                    Tiquete tiquete = null;
                                    if (documento.getReferencia() != null) {
                                        tiquete = modelo.consultarTiquetePorID(Long.parseLong(documento.getReferencia()));
                                        if (tiquete != null) {
                                            nro_tiquete = tiquete.getNumero_factura();
                                            Persona persona = modelo.consultarPersona(tiquete.getFk_persona());
                                            if (persona != null) {
                                                solicitante = persona.getNombre_1() + " " + persona.getApellido_1();
                                            }
                                        }
                                    }
                                    if (especificaciones != null) {
                                        HashMap parameters = new java.util.HashMap();
                                        parameters.put("PERSONA", !solicitante.equals("") ? solicitante : "Peticionario");
                                        parameters.put("FECHAPAGO", documento.getFecha_expedicion());
                                        parameters.put("NRO_PAGO", !nro_tiquete.equals("") ? nro_tiquete : "");
                                        parameters.put("LICENCIA", !licenciaTransito.equals("") ? licenciaTransito : vehiculo.getPlaca());
                                        parameters.put("USUARIO", usuario.getNombre());
                                        parameters.put("NUMERO", documento.getNumero());
                                        parameters.put("EXPEDICION", documento.getFecha_expedicion());
                                        parameters.put("MATRICULA", vehiculo.getFecha_matricula());
                                        parameters.put("PLACA", vehiculo.getPlaca());
                                        parameters.put("CLASE", clase);
                                        parameters.put("ESTADO", estadoV);
                                        parameters.put("OBSERVACION", documento.getObservacion());
                                        parameters.put("SERVICIO", servicio);
                                        parameters.put("MANIFIESTO", vehiculo.getDocumento_importacion());
                                        parameters.put("FECHA_MANI", vehiculo.getFecha_importacion());
                                        parameters.put("MODELO", "" + vehiculo.getModelo());
                                        parameters.put("COLOR", color);
                                        parameters.put("PASAJEROS", especificaciones.get("1") != null ? especificaciones.get("1") : "");
                                        parameters.put("MOTOR", especificaciones.get("19") != null ? especificaciones.get("19") : "");
                                        parameters.put("LINEA", linea != null ? linea.getNombre() : li != null ? li.getNombre() : "");
                                        parameters.put("CHASIS", especificaciones.get("20") != null ? especificaciones.get("20") : "");
                                        parameters.put("CAPACIDAD", especificaciones.get("2") != null ? especificaciones.get("2") : "");
                                        parameters.put("SERIE", especificaciones.get("21") != null ? especificaciones.get("21") : "");
                                        parameters.put("TIPO", caracteristicas.get("2") != null ? modelo.consultarParametro(Integer.parseInt(caracteristicas.get("2").toString()), 2).getNombre() : "");
                                        parameters.put("MARCA", marca!=null?marca.getNombre():ma!=null?ma.getNombre():"");
                                        parameters.put("EJES", especificaciones.get("9") != null ? especificaciones.get("9") : "");
                                        parameters.put("COMBUSTIBLE", combustible);
                                        parameters.put("MODALIDAD", modalidad);
                                        parameters.put("VIN", especificaciones.get("25") != null ? especificaciones.get("25") : "");
                                        parameters.put("CILINDRADA", especificaciones.get("11") != null ? especificaciones.get("11") : "");

                                        Movimiento movimiento = modelo.ConsultarMovimientoVehiculo(vehiculo.getId_vehiculo());
                                        if (movimiento != null) {
                                            Sede sede = modelo.consultarSede(movimiento.getFk_sede());
                                            if (movimiento.getTipo_movimiento() == 1) {
                                                parameters.put("RADICADO", sede.getNombre_corto());
                                            } else {
                                                parameters.put("TRASLADADO", sede.getNombre_corto());
                                            }
                                        }
                                        session.setAttribute("certificadoTradicion", parameters);
                                    }
                                    String certificado = modelo.consultarParametroName(332, documento.getTipo());
                                    String estado = modelo.consultarParametroName(333, documento.getEstado());
                %>
                <tr id="<%=vehiculo.getId_vehiculo()%>"  bgcolor="#FFFFFF"  style="cursor:pointer;"  onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                    <td><div align="center" class="style3"><span class="style2"><%= vehiculo.getPlaca()%></span></div></td>
                    <td><div align="center" class="style3"><span class="style2"><%=certificado%></span></div></td>
                    <td><div align="center" class="style3"><span class="style2"><%=documento.getNumero() != null ? documento.getNumero() : ""%></span></div></td>
                    <td><div align="center" class="style3"><span class="style2"><%= documento.getFecha_expedicion() != null ? documento.getFecha_expedicion() : ""%></span></div></td>
                    <td><div align="center" class="style3"><span class="style2"><%= documento.getFecha_impresion() != null ? documento.getFecha_impresion() : ""%></span></div></td>
                    <td><div align="center" class="style3"><span class="style2"><%=estado != null ? estado : ""%></span></div></td>
                </tr>
            </table>
            <form name="form" method="post" class="style3">
                <input id="placa" name="placa" type="hidden" value="<%=vehiculo.getPlaca()%>"/>
                <input id="tipodocu" name="tipodocu" type="hidden" value="<%=request.getParameter("documento")%>"/>
                <table width="100%" border="0"  align="right" >
                    <tr>
                        <td colspan="2" width="10%" align="right">Observaciones</td>
                        <td align="left" width="10%">
                            <%if (documento.getObservacion() != null) {%>
                            <TEXTAREA onkeyPress="return contar(this.value, event)" ID="observaciones" NAME="observaciones" ROWS="1" COLS="50"><%=documento.getObservacion()%></TEXTAREA>
                                <%} else { %>
                                        <TEXTAREA onkeyPress="return contar(this.value, event)" ID="observaciones" NAME="observaciones" ROWS="1" COLS="50"></TEXTAREA>
                                <%}%>
                                    </td>
                                    <td align="left" width="10%">
                                        <input name="adicionar" type="button" id="adicionar" value="Agregar Observacion" onclick="insertObserr()" >
                                    </td>
                                <!--<input type="button" value="Agregar Observacion" onclick="insertObserr()"/>-->
                                </tr>
                            </form>
                                <tr>
                                    <td colspan="6" align="center"><input id="generar"  name="generar" type="button" value="Generar" style="color:#333333; width:100px" onClick="GenerarReporte()"/></td>
                                </tr>
                        </table>





        <% }
            if (documento.getTipo() == 3) {
                Licencia_Transito licencia = null;
                String licenciaTransito = "";
                licencia = modelo.consultarLicenciaTransito(vehiculo.getId_vehiculo());
                if (licencia != null) {
                    licenciaTransito = licencia.getNumero();
                }
                String clase = modelo.consultarParametroName(1, (int) vehiculo.getClase_vehiculo());
                String servicio = modelo.consultarParametroName(3, (int) vehiculo.getServicio());
                DatosVehiculo dvModalidad = modelo.consultarDatosVehiculo(vehiculo.getId_vehiculo(), 1, 324);
                DatosVehiculo dvCombustible = modelo.consultarDatosVehiculo(vehiculo.getId_vehiculo(), 1, 75);
                String modalidad = "";
                if (dvModalidad != null) {
                    modalidad = modelo.consultarParametroName(324, Integer.parseInt(dvModalidad.getValor()));
                }
                String combustible = modelo.consultarParametroName(75, Integer.parseInt(dvCombustible.getValor()));
                String color = modelo.consultarColor(vehiculo.getPlaca());
                java.util.HashMap especificaciones = modelo.listarEspecificacionesVehiculo(vehiculo.getPlaca().toUpperCase());
                java.util.HashMap caracteristicas = modelo.listarCaracteristicasVehiculo(vehiculo.getPlaca().toUpperCase());
                Linea linea = modelo.getLinea(vehiculo.getFk_linea());
                Marca marca = modelo.consultaMarca(vehiculo.getPlaca());
                String nro_tiquete = "";
                String solicitante = "";
                Tiquete tiquete = null;
                if (documento.getReferencia() != null) {
                    tiquete = modelo.consultarTiquetePorID(Long.parseLong(documento.getReferencia()));
                    if (tiquete != null) {
                        nro_tiquete = tiquete.getNumero_factura();
                        Persona persona = modelo.consultarPersona(tiquete.getFk_persona());
                        if (persona != null) {
                            solicitante = persona.getNombre_1() + " " + persona.getApellido_1();
                        }
                    }
                }
                if (especificaciones != null) {
                    HashMap parameters = new java.util.HashMap();
                    parameters.put("ID_VEHICULO", vehiculo.getId_vehiculo());
                    //parameters.put("PERSONA", !solicitante.equals("")?solicitante:"Peticionario");
                    // parameters.put("FECHAPAGO", documento.getFecha_expedicion());
                    //parameters.put("NRO_PAGO", !nro_tiquete.equals("")?nro_tiquete:"");
                    parameters.put("LICENCIAT", !licenciaTransito.equals("") ? licenciaTransito : vehiculo.getPlaca());
                    //parameters.put("USUARIO", usuario.getNombre());
                    parameters.put("NUMERO", documento.getNumero());
                    parameters.put("OBSERVACION", documento.getObservacion());
                    parameters.put("EXPEDICION", documento.getFecha_expedicion());
                    parameters.put("MATRICULA", vehiculo.getFecha_matricula());
                    parameters.put("PLACA", vehiculo.getPlaca());
                    parameters.put("CLASE", clase);
                    parameters.put("SERVICIO", servicio);
                    parameters.put("MANIFIESTO", vehiculo.getDocumento_importacion());
                    parameters.put("FECHA_MANI", vehiculo.getFecha_importacion().toString());
                    parameters.put("MODELO", "" + vehiculo.getModelo());
                    parameters.put("COLOR", color);
                    parameters.put("MOTOR", especificaciones.get("19") != null ? especificaciones.get("19") : "");
                    parameters.put("LINEA", linea.getNombre());
                    parameters.put("CHASIS", especificaciones.get("20") != null ? especificaciones.get("20") : "");
                    parameters.put("CAPACIDAD", especificaciones.get("2") != null ? especificaciones.get("2") : "");
                    parameters.put("SERIE", especificaciones.get("21") != null ? especificaciones.get("21") : "");
                    parameters.put("TIPO", caracteristicas.get("2") != null ? modelo.consultarParametro(Integer.parseInt(caracteristicas.get("2").toString()), 2).getNombre() : "");
                    parameters.put("MARCA", marca.getNombre());
                    parameters.put("EJES", especificaciones.get("9") != null ? especificaciones.get("9") : "");
                    parameters.put("COMBUSTIBLE", combustible);
                    parameters.put("MODALIDAD", modalidad);
                    parameters.put("VIN", especificaciones.get("25") != null ? especificaciones.get("25") : "");
                    parameters.put("CILINDRADA", especificaciones.get("11") != null ? especificaciones.get("11") : "");

                    Movimiento movimiento = modelo.ConsultarMovimientoVehiculo(vehiculo.getId_vehiculo());
                    if (movimiento != null) {
                        Sede sede = modelo.consultarSede(movimiento.getFk_sede());
                        if (movimiento.getTipo_movimiento() == 1) {
                            parameters.put("RADICADO", sede.getNombre_corto());
                        } else {
                            parameters.put("TRASLADADO", sede.getNombre_corto());
                        }
                    }
                    session.setAttribute("certificadoCancelacion", parameters);
                }
                String certificado = modelo.consultarParametroName(332, documento.getTipo());
                String estado = modelo.consultarParametroName(333, documento.getEstado());
        %>
                        <tr id="<%=vehiculo.getId_vehiculo()%>"  bgcolor="#FFFFFF"  style="cursor:pointer;"  onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                        <td><div align="center" class="style3"><span class="style2"><%= vehiculo.getPlaca()%></span></div></td>
                        <td><div align="center" class="style3"><span class="style2"><%=certificado%></span></div></td>
                        <td><div align="center" class="style3"><span class="style2"><%=documento.getNumero() != null ? documento.getNumero() : ""%></span></div></td>
                        <td><div align="center" class="style3"><span class="style2"><%= documento.getFecha_expedicion() != null ? documento.getFecha_expedicion() : ""%></span></div></td>
                        <td><div align="center" class="style3"><span class="style2"><%= documento.getFecha_impresion() != null ? documento.getFecha_impresion() : ""%></span></div></td>
			<td><div align="center" class="style3"><span class="style2"><%=estado != null ? estado : ""%></span></div></td>
                        </tr>
                        </table>
            		<table width="100%" border="0"  align="center" >
			<tr>
			<td colspan="6" align="center"><input id="generar"  name="generar" type="button" value="Generar" style="color:#333333; width:100px" onClick="GenerarCertificadoCancelacion()"/></td>
			</tr>
                        </table>





    <% }
        if (documento.getTipo() == 4) {

            String clase = modelo.consultarParametroName(1, (int) vehiculo.getClase_vehiculo());
            String servicio = modelo.consultarParametroName(3, (int) vehiculo.getServicio());
            DatosVehiculo dvModalidad = modelo.consultarDatosVehiculo(vehiculo.getId_vehiculo(), 1, 324);
            DatosVehiculo dvCombustible = modelo.consultarDatosVehiculo(vehiculo.getId_vehiculo(), 1, 75);
            String modalidad = "";
            if (dvModalidad != null) {
                modalidad = modelo.consultarParametroName(324, Integer.parseInt(dvModalidad.getValor()));
            }
            String combustible = modelo.consultarParametroName(75, Integer.parseInt(dvCombustible.getValor()));
            String color = modelo.consultarColor(vehiculo.getPlaca());
            java.util.HashMap especificaciones = modelo.listarEspecificacionesVehiculo(vehiculo.getPlaca().toUpperCase());
            java.util.HashMap caracteristicas = modelo.listarCaracteristicasVehiculo(vehiculo.getPlaca().toUpperCase());
            Linea linea = modelo.getLinea(vehiculo.getFk_linea());
            Marca marca = modelo.consultaMarca(vehiculo.getPlaca());

            if (especificaciones != null) {
                HashMap parameters = new java.util.HashMap();
                parameters.put("ID_VEHICULO", vehiculo.getId_vehiculo());
                parameters.put("USUARIO", usuario.getNombre());
                parameters.put("NUMERO", documento.getNumero());
                parameters.put("EXPEDICION", documento.getFecha_expedicion());
                parameters.put("PLACA", vehiculo.getPlaca());
                parameters.put("CLASE", clase);
                parameters.put("SERVICIO", servicio);
                parameters.put("MODELO", "" + vehiculo.getModelo());
                parameters.put("COLOR", color);
                parameters.put("MOTOR", especificaciones.get("19") != null ? especificaciones.get("19") : "");
                parameters.put("LINEA", linea.getNombre());
                parameters.put("CHASIS", especificaciones.get("20") != null ? especificaciones.get("20") : "");
                parameters.put("SERIE", especificaciones.get("21") != null ? especificaciones.get("21") : "");
                parameters.put("TIPO", caracteristicas.get("2") != null ? modelo.consultarParametro(Integer.parseInt(caracteristicas.get("2").toString()), 2).getNombre() : "");
                parameters.put("MARCA", marca.getNombre());
                parameters.put("EJES", especificaciones.get("9") != null ? especificaciones.get("9") : "");
                parameters.put("COMBUSTIBLE", combustible);
                parameters.put("MODALIDAD", modalidad);
                parameters.put("VIN", especificaciones.get("25") != null ? especificaciones.get("25") : "");
                parameters.put("CILINDRADA", especificaciones.get("11") != null ? especificaciones.get("11") : "");

                Movimiento movimiento = modelo.ConsultarMovimientoVehiculo(vehiculo.getId_vehiculo());
                if (movimiento != null) {
                    Sede sede = modelo.consultarSede(movimiento.getFk_sede());
                    if (movimiento.getTipo_movimiento() == 2) {
                        parameters.put("TRASLADO", sede.getNombre());
                    }
                }
                session.setAttribute("certificadoTraslado", parameters);
            }
            String certificado = modelo.consultarParametroName(332, documento.getTipo());
            String estado = modelo.consultarParametroName(333, documento.getEstado());
    %>
                        <tr id="<%=vehiculo.getId_vehiculo()%>"  bgcolor="#FFFFFF"  style="cursor:pointer;"  onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                        <td><div align="center" class="style3"><span class="style2"><%= vehiculo.getPlaca()%></span></div></td>
                        <td><div align="center" class="style3"><span class="style2"><%=certificado%></span></div></td>
                        <td><div align="center" class="style3"><span class="style2"><%=documento.getNumero() != null ? documento.getNumero() : ""%></span></div></td>
                        <td><div align="center" class="style3"><span class="style2"><%= documento.getFecha_expedicion() != null ? documento.getFecha_expedicion() : ""%></span></div></td>
                        <td><div align="center" class="style3"><span class="style2"><%= documento.getFecha_impresion() != null ? documento.getFecha_impresion() : ""%></span></div></td>
			<td><div align="center" class="style3"><span class="style2"><%=estado != null ? estado : ""%></span></div></td>
                        </tr>
                        </table>
            		<table width="100%" border="0"  align="center" >
			<tr>
			<td colspan="6" align="center"><input id="generar"  name="generar" type="button" value="Generar" style="color:#333333; width:100px" onClick="GenerarCertificadoTraslado()"/></td>
			</tr>
                        </table>





<% }

    if (documento.getTipo() == 6) {
        Licencia_Transito licencia = null;
        String licenciaTransito = "";
        licencia = modelo.consultarLicenciaTransito(vehiculo.getId_vehiculo());
        if (licencia != null) {
            licenciaTransito = licencia.getNumero();
        }
        String clase = modelo.consultarParametroName(1, (int) vehiculo.getClase_vehiculo());
        String servicio = modelo.consultarParametroName(3, (int) vehiculo.getServicio());
        DatosVehiculo dvModalidad = modelo.consultarDatosVehiculo(vehiculo.getId_vehiculo(), 1, 324);
        DatosVehiculo dvCombustible = modelo.consultarDatosVehiculo(vehiculo.getId_vehiculo(), 1, 75);
        String modalidad = "";
        if (dvModalidad != null) {
            modalidad = modelo.consultarParametroName(324, Integer.parseInt(dvModalidad.getValor()));
        }
        String combustible = modelo.consultarParametroName(75, Integer.parseInt(dvCombustible.getValor()));
        String color = modelo.consultarColor(vehiculo.getPlaca());
        java.util.HashMap especificaciones = modelo.listarEspecificacionesVehiculo(vehiculo.getPlaca().toUpperCase());
        java.util.HashMap caracteristicas = modelo.listarCaracteristicasVehiculo(vehiculo.getPlaca().toUpperCase());
        Linea linea = modelo.getLinea(vehiculo.getFk_linea());
        Marca marca = modelo.consultaMarca(vehiculo.getPlaca());

        if (especificaciones != null) {
            HashMap parameters = new java.util.HashMap();
            parameters.put("ID_VEHICULO", vehiculo.getId_vehiculo());
            parameters.put("LICENCIAT", !licenciaTransito.equals("") ? licenciaTransito : vehiculo.getPlaca());
            parameters.put("USUARIO", usuario.getNombre());
            parameters.put("NUMERO", documento.getNumero());
            parameters.put("EXPEDICION", documento.getFecha_expedicion());
            parameters.put("MATRICULA", vehiculo.getFecha_matricula());
            parameters.put("PLACA", vehiculo.getPlaca());
            parameters.put("CLASE", clase);
            parameters.put("SERVICIO", servicio);
            parameters.put("MANIFIESTO", vehiculo.getDocumento_importacion());
            parameters.put("FECHA_MANI", vehiculo.getFecha_importacion().toString());
            parameters.put("MODELO", "" + vehiculo.getModelo());
            parameters.put("COLOR", color);
            parameters.put("MOTOR", especificaciones.get("19") != null ? especificaciones.get("19") : "");
            parameters.put("LINEA", linea.getNombre());
            parameters.put("CHASIS", especificaciones.get("20") != null ? especificaciones.get("20") : "");
            parameters.put("CAPACIDAD", especificaciones.get("2") != null ? especificaciones.get("2") : "");
            parameters.put("SERIE", especificaciones.get("21") != null ? especificaciones.get("21") : "");
            parameters.put("TIPO", caracteristicas.get("2") != null ? modelo.consultarParametro(Integer.parseInt(caracteristicas.get("2").toString()), 2).getNombre() : "");
            parameters.put("MARCA", marca.getNombre());
            parameters.put("EJES", especificaciones.get("9") != null ? especificaciones.get("9") : "");
            parameters.put("COMBUSTIBLE", combustible);
            parameters.put("MODALIDAD", modalidad);
            parameters.put("VIN", especificaciones.get("25") != null ? especificaciones.get("25") : "");
            parameters.put("CILINDRADA", especificaciones.get("11") != null ? especificaciones.get("11") : "");

            session.setAttribute("TraspasoIndeterminado", parameters);
        }
        String certificado = modelo.consultarParametroName(332, documento.getTipo());
        String estado = modelo.consultarParametroName(333, documento.getEstado());
%>
                        <tr id="<%=vehiculo.getId_vehiculo()%>"  bgcolor="#FFFFFF"  style="cursor:pointer;"  onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                        <td><div align="center" class="style3"><span class="style2"><%= vehiculo.getPlaca()%></span></div></td>
                        <td><div align="center" class="style3"><span class="style2"><%=certificado%></span></div></td>
                        <td><div align="center" class="style3"><span class="style2"><%=documento.getNumero() != null ? documento.getNumero() : ""%></span></div></td>
                        <td><div align="center" class="style3"><span class="style2"><%= documento.getFecha_expedicion() != null ? documento.getFecha_expedicion() : ""%></span></div></td>
                        <td><div align="center" class="style3"><span class="style2"><%= documento.getFecha_impresion() != null ? documento.getFecha_impresion() : ""%></span></div></td>
			<td><div align="center" class="style3"><span class="style2"><%=estado != null ? estado : ""%></span></div></td>
                        </tr>
                        </table>
            		<table width="100%" border="0"  align="center" >
			<tr>
			<td colspan="6" align="center"><input id="generar"  name="generar" type="button" value="Generar" style="color:#333333; width:100px" onClick="GenerarTraspasoIndeterminado()"/></td>
			</tr>
                        </table>
<% } %>
<%
    if (documento.getTipo() == 5) {
        Persona persona = modelo.consultarPersona(cprendo.getFk_persona());
        String certificado = modelo.consultarParametroName(332, documento.getTipo());
        String estado = modelo.consultarParametroName(333, documento.getEstado());
        HashMap parameters = new java.util.HashMap();
        parameters.put("NUMERO", cprendo.getNumero());
        session.setAttribute("descuentoComparendo", parameters);
%>
                      <tr id=""  bgcolor="#FFFFFF"  style="cursor:pointer;"  onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                        <td><div align="center" class="style3"><span class="style2"><%= persona.getId_persona() != 0 ? "COMPARENDO" : ""%></span></div></td>
                        <td><div align="center" class="style3"><span class="style2"><%=certificado%></span></div></td>
                        <td><div align="center" class="style3"><span class="style2"><%=documento.getNumero() != null ? documento.getNumero() : ""%></span></div></td>
                        <td><div align="center" class="style3"><span class="style2"><%= documento.getFecha_expedicion() != null ? documento.getFecha_expedicion() : ""%></span></div></td>
                        <td><div align="center" class="style3"><span class="style2"><%= documento.getFecha_impresion() != null ? documento.getFecha_impresion() : ""%></span></div></td>
			<td><div align="center" class="style3"><span class="style2"><%=estado != null ? estado : ""%></span></div></td>
                        </tr>
                        </table>
            		<table width="100%" border="0"  align="center" >
			<tr>
			<td colspan="6" align="center"><input id="generar"  name="generar" type="button" value="Generar" style="color:#333333; width:100px" onClick="GenerarReporteComparendo()"/></td>
			</tr>
                        </table>
<%   }
            if (documento.getTipo() == 3) {
                HashMap parameters = new java.util.HashMap();
                /*parameters.put("CONSECUTIVO", !solicitante.equals("")?solicitante:"Peticionario");
        parameters.put("PLACA", documento.getFecha_expedicion());
        parameters.put("PROPIETARIO", !nro_tiquete.equals("")?nro_tiquete:"");
        parameters.put("DOCUMENTO",!licenciaTransito.equals("")?licenciaTransito:vehiculo.getPlaca());
        parameters.put("FECHA_PAGO", usuario.getNombre());
        parameters.put("VALOR_PAGO",documento.getNumero());
        parameters.put("RECIBO", documento.getFecha_expedicion());
        parameters.put("FECHA", vehiculo.getFecha_matricula());
        parameters.put("FIRMA",vehiculo.getPlaca());*/
                session.setAttribute("certificadoPazYSalvo", parameters);
            }

        } else {
            mensaje = "No se encontraron Registros";
        }
    }

} catch (Exception exc) {
%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=exc.getMessage()%>"></jsp:param></jsp:forward>
<%
        exc.printStackTrace();
    }

    if (!mensaje.equals("")) {
%>
            <script>
                alert("No se encontraron Documentos Para Imprimir");
</script>
<%
    }
%>

    </fieldset>
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