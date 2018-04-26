<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" %>

<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Vehiculo</title>
        <style type="text/css">
            <!--
            .Estilo8 {color: #333333; font-weight: bold; font-size: 12px; }
            .Estilo13 {color: #333333}
            .Estilo14 {color: #333333; font-size: 12px; }
            .style1 {font-family: Tahoma}
            .style2 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
            .Estilo18 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
            .Estilo19 {color: #FF0000}
            .Estilo15 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
            .Estilo16 {color: #000000; font-weight: bold; font-size: 12px; font-family: Tahoma; }
            .style4 {
                color: #FFFFFF;
                font-size: 12px;
                font-weight: bold;
            }
            -->
        </style>
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
            function editarV() {
                window.parent.frames[0].location.href = "editarDatosVehiculo.jsp?id=1";
            }

            function datosPersona(doc, tipo) {
                var documento = doc;
                var paso = 1;
                var tipoDoc = tipo;
                window.location.href = "consultarPersonaRUNT.jsp?paso=" + paso + "&documento=" + documento + "&tipo=" + tipoDoc;
            }

            function ActualizarEstado(placa) {

                //alert("estoy aqui: "+ placa)
                window.location.href = "procesarSincronizacion.jsp?placa=" + placa;
            }

            function consultaPlacaRunt(placa, idv) {
                ajax2 = new nuevoAjax();
                ajax2.open("POST", "verificarPlacaVehiculo.jsp", true);
                ajax2.onreadystatechange = function () {
                    if (ajax2.readyState == 4) {
                        var respuesta = ajax2.responseText;
                        if (respuesta.indexOf("Vehiculo SI") != -1) {
                            if (navigator.appName == "Microsoft Internet Explorer") {
                                document.getElementById("trrunt").style.display = "block";
                            } else {
                                document.getElementById("trrunt").style.display = "table-row";
                            }
                            document.getElementById("trrunt").style.backgroundColor = "#009933";
                            document.getElementById("respuestarunt").innerHTML = "<div class='Estilo15'>" + respuesta + ".</div>";
                        } else
                        if (respuesta.indexOf("Vehiculo NO") != -1) {
                            if (navigator.appName == "Microsoft Internet Explorer") {
                                document.getElementById("trrunt").style.display = "block";
                            } else {
                                document.getElementById("trrunt").style.display = "table-row";
                            }
                            document.getElementById("trrunt").style.backgroundColor = "#FFCC33";
                            document.getElementById("respuestarunt").innerHTML = "<div class='Estilo16'>" + respuesta + "</div>";
                        } else {
                            document.getElementById("trrunt").style.display = "none";
                        }
                    }
                }
                ajax2.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                ajax2.send("placa=" + placa + "&idv=" + idv);
            }

            function actualizarV(idv) {
                document.getElementById("actualizar").disabled = true;
                document.location.href = "actualizarVehiculoRunt.jsp?vehiculo=" + idv;
            }
        </script>
    </head>
    <%@ page import="modelo.*"%>
    <%@page import="java.util.*"%>
    <%
        Model modelo = (Model) session.getAttribute("model");
        String placa = "";
        float total = 0;
        int sw = 0;
        java.util.Date fechaActual = (new java.util.Date());
        if (request.getParameter("id") != null) {
            if (request.getParameter("id").equals("0")) {
                placa = request.getParameter("placa");
            } else {
                placa = session.getAttribute("placa") + "";
            }
            if (placa != null) {
                Vehiculo vehiculo = new Vehiculo();
                placa = placa.toUpperCase();
                vehiculo = modelo.consultarVehiculo(placa);
                if (vehiculo == null) {
                    if (placa.length() == 6) {
                        if (Character.isLetter(placa.charAt(2))) {
                            if (placa.charAt(2) <= 'J') {
                                int newDgto = (((int) placa.charAt(2)) - 64) % 10;
                                placa = new StringBuffer(placa).replace(2, 3, newDgto + "").toString();
                                vehiculo = modelo.consultarVehiculo(placa);
                            }
                        } else {
                            char newChar = (char) (74 - ((10 - Integer.valueOf((placa.charAt(2) + ""))) % 10));
                            placa = new StringBuffer(placa).replace(2, 3, newChar + "").toString();
                            vehiculo = modelo.consultarVehiculo(placa);
                        }
                    }
                }
                if (vehiculo != null) {
                    session.setAttribute("placa", vehiculo.getPlaca());
                    Sede sede = modelo.consultarSede(vehiculo.getFk_sede());
                    java.util.HashMap caract = modelo.listarCaracteristicasVehiculo(vehiculo.getPlaca().toUpperCase());
                    java.util.HashMap especif = modelo.listarEspecificacionesVehiculo(vehiculo.getPlaca().toUpperCase());
                    String carroceria = caract.get("2") != null ? modelo.consultarParametro(Integer.parseInt(caract.get("2").toString()), 2).getNombre() : "";
                    Parametro param = modelo.consultarParametro(Integer.parseInt(vehiculo.getClase_vehiculo() + ""), 1);
                    Parametro param2 = modelo.consultarParametro(Integer.parseInt(vehiculo.getServicio() + ""), 3);
                    Parametro param3 = modelo.consultarParametro(Integer.parseInt(vehiculo.getEstado() + ""), 66);
                    String modalidad = "";
                    boolean swAcualizoInteres = modelo.actualizarInteresesCostasVehiculos(vehiculo.getId_vehiculo(), usuario.getId_usuario());
                    if (!swAcualizoInteres) {
                        // Colocar alerta cuando no se genero intereses
    %><script>alert('Há ocurrido un error al actualizar intereses, intente nuevamente')</script><%
        }

        String carteraSum = modelo.consultarCarteraTotal(vehiculo.getId_vehiculo());
        String periodo = modelo.consultarPeriodo(vehiculo.getId_vehiculo());

        //DESCUENTO
        if ((new java.text.SimpleDateFormat("dd/MM/yyyy").parse(new java.text.SimpleDateFormat("dd/MM/yyyy").format(fechaActual)).getTime() <= new java.text.SimpleDateFormat("dd/MM/yyyy").parse("26/09/2013").getTime())) {
            java.util.List lista = modelo.consultarCarteraVehiculo(vehiculo.getId_vehiculo());
            if (lista == null) {
                lista = new java.util.LinkedList();
            }

            long id_cart = 0;
            for (int v = 0; v < lista.size(); v++) {
                Cartera cart = (Cartera) lista.get(v);
                if (cart.getTipo() == 2) {
                    if (!cart.getReferencia().equals("2011") && !cart.getReferencia().equals("2012") && !cart.getReferencia().equals("2013")) {
                        sw = 1;
                    }
                    float saldo = Math.round((float) cart.getSaldo());
                    System.out.println("Saldo antes= " + saldo);
                    id_cart = cart.getId_cartera();
                    String vigencia = cart.getReferencia();
                    long vigenciaA = Long.parseLong(vigencia);
                    if ((new java.text.SimpleDateFormat("dd/MM/yyyy").parse(new java.text.SimpleDateFormat("dd/MM/yyyy").format(fechaActual)).getTime() <= new java.text.SimpleDateFormat("dd/MM/yyyy").parse("26/09/2013").getTime())
                            && (!cart.getReferencia().equals("2011") && !cart.getReferencia().equals("2012") && !cart.getReferencia().equals("2013"))) {
                        modelo.Detalle_Cartera detalle_cartera = new modelo.Detalle_Cartera();
                        Detalle_Cartera dtcartera = modelo.consultarDetalleCartera(cart.getId_cartera(), 249);
                        Detalle_Cartera dtcartera1 = modelo.consultarDetalleCartera(cart.getId_cartera(), 87);
                        Detalle_Cartera dtcartera2 = modelo.consultarDetalleCartera(cart.getId_cartera(), 257);
                        Detalle_Cartera dtcartera3 = modelo.consultarDetalleCartera(cart.getId_cartera(), 258);
                        float con87 = 0;
                        float con257 = 0;
                        float con258 = 0;
                        float ext = 0;
                        if (dtcartera1 != null) {
                            con87 = dtcartera1.getValor();
                            float interesD = (float) ((con87 * 80) / 100);
                            float valinteres = (float) con87 - interesD;
                            ext = ext + interesD;
                        }
                        if (dtcartera2 != null) {
                            con257 = dtcartera2.getValor();
                            float interesD = (float) ((con257 * 80) / 100);
                            float valinteres = (float) con257 - interesD;
                            ext = ext + interesD;
                        }
                        if (dtcartera3 != null) {
                            con258 = dtcartera3.getValor();
                            float interesD = (float) ((con258 * 80) / 100);
                            float valinteres = (float) con258 - interesD;
                            ext = ext + interesD;
                        }

                        if (dtcartera != null) {
                            float valor_interes = dtcartera.getValor();
                            float interesD = (float) ((valor_interes * 80) / 100);
                            float valinteres = (float) valor_interes - interesD;
                            interesD += ext;
                            saldo = saldo - interesD;
                            //saldo+=-75200;
                            System.out.println("Saldo desp= " + saldo);
                        }
                    } else {
                        saldo = (float) cart.getSaldo();
                    }
                    total = Math.round((float) (total + saldo));
                }

            }
        }

        if (caract.get("324") != null) {
            modalidad = modelo.consultarParametroName(324, Integer.parseInt(caract.get("324").toString()));
        }
        java.util.List lista_colores = modelo.lista_historico_color(vehiculo.getPlaca());
        String color = "";
        for (int l = 0; l < lista_colores.size(); l++) {
            Historico_Color hc = (Historico_Color) lista_colores.get(l);
            if (hc.getFecha_fin() == null) {
                Color cl = modelo.getColor(hc.getFk_color());
                color += cl.getNombre();
            }
        }

        Licencia_Transito licenciaTransito = modelo.consultarLicenciaTransito(vehiculo.getId_vehiculo());
        String numeroLt = "";
        if (licenciaTransito != null) {
            numeroLt = licenciaTransito.getNumero();
        }

        Linea_Remolques lineaR = new Linea_Remolques();
        Marcas_Remolques marcaR = new Marcas_Remolques();

        Linea linea = null;
        Marca marca = null;
        String marcaV = "";
        String lineaV = "";

        Parametro chkClasevehiculo = modelo.consultarParametro((int) vehiculo.getClase_vehiculo(), 1);

        if (chkClasevehiculo.getNombreCorto().equals("5")) {
            lineaR = modelo.getLineaRNRYSMarca(vehiculo.getFk_linea(), vehiculo.getFk_marca());
            if (lineaR != null) {
                lineaV = lineaR.getNombre();
                marcaR = modelo.getMarcaRNRYS(vehiculo.getFk_marca());
                if (marcaR != null) {
                    marcaV = marcaR.getNombre();
                } else {
                    marcaV = "SIN MARCA";
                }

            } else {
                lineaV = "SIN LINEA";
            }
        } else if (chkClasevehiculo.getNombreCorto().equals("4")) {
            Linea_maquinaria lineaM = modelo.getLineaMaquinaria(vehiculo.getFk_linea());
            lineaV = (lineaM != null ? lineaM.getDescripcion() : "SIN LINEA");
            if (lineaM != null) {
                Marcas_maquinaria marcaM = modelo.getMarcaMaquinaria(lineaM.getCodigo_marca());
                marcaV = (marcaM != null ? marcaM.getDescripcion() : "SIN MARCA");
            } else {
                marcaV = "SIN MARCA";
            }
        } else {
            linea = modelo.consultaLinea(vehiculo.getPlaca().toUpperCase());
            if (linea != null) {
                lineaV = linea.getNombre();
                marca = modelo.consultaMarca(vehiculo.getPlaca().toUpperCase());
                if (marca != null) {
                    marcaV = marca.getNombre();
                } else {
                    marcaV = "SIN MARCA";
                }
            } else {
                lineaV = "SIN LINEA";
            }
        }

        String estadoLegal = ""; %>
    <body>
        <%
            long ev = vehiculo.getEstado();
            if (ev == 1 || ev == 5 || ev == 6) {%>
        <script language="javascript" type="text/javascript"> consultaPlacaRunt("<%=placa%>", "<%=vehiculo.getId_vehiculo()%>");</script>
        <% } %>


        <table width="100%" border="0" align="center">
            <tr>
                <td width="7%">&nbsp;</td>
                <td width="86%" class="style2" align="center">INFORMACION GENERAL DEL VEHICULO</td>

                <td width="7%" align="center" valign="bottom">
                    <img src="../html/images/editar.png"  width="22" height="22"  style="cursor:pointer" onclick="editarV()"/><span class="style2">EDITAR</span>
                </td>

            </tr>
            <% if (vehiculo.getEstado() == 6 || vehiculo.getEstado() == 7 || vehiculo.getEstado() == 8) {%>
            <tr bgcolor="#000000">
                <td colspan="3">
                    <div align="center" class="style4">EL VEHICULO SE ENCUENTRA ACTUALMENTE EN ESTADO&nbsp;<%=param3.getNombre()%></div>                  </td>
            </tr>
            <% } %>
            <tr id="trrunt" style="display:none">
                <td colspan="3" align="center"><div id="respuestarunt"></div></td>
            </tr>
            <tr>
                <td colspan="3">
                    <table border="0" width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <%   boolean haveA = modelo.tieneAlertas(vehiculo.getId_vehiculo());
                                boolean haveE = modelo.tieneEmbargos(vehiculo.getId_vehiculo());
                                int haveP = (haveA ? 1 : 0) + (haveE ? 1 : 0);
                                estadoLegal = haveE ? (haveA ? "EMBARGADO/PIGNORADO" : "EMBARGADO") : (haveA ? "PIGNORADO" : "NORMAL");
                                if (haveE) {%>
                            <td width="<%=100 / haveP%>%" bgcolor="#FF0000"><div align="center"><span style="color:#FFFFFF; font-size:12px; font-weight:bold">EXISTEN EMBARGOS PENDIENTES A LA FECHA </span></div></td>
                            <% }
                                if (haveA) {%>
                            <td width="<%=100 / haveP%>%" bgcolor="#FF6600"><div align="center"><span style="color:#FFFFFF; font-size:12px; font-weight:bold">EXISTEN ALERTAS PENDIENTES A LA FECHA </span></div></td>
                            <% }%>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <fieldset class="style1">


                        <table width="100%" border="0" align="center">
                            <tr style="border:none; background:url(../html/images/inicio_3.png)">
                                <td colspan="6" align="center" valign="middle"><span class="Estilo18">DATOS DEL VEHICULO </span></td>
                            </tr>

                            <tr>
                                <td width="7%"><span class="Estilo8">PLACA</span></td>
                                <td width="22%">
                                    <span class="Estilo8">
                                        <input type="text" name="textfield" value="<%=vehiculo.getPlaca()%>" style="width:150px; color:#333333; text-align:center" readonly/>
                                    </span>					  </td>
                                <td width="7%"><span class="Estilo8">MARCA</span></td>
                                <td width="26%">
                                    <span class="Estilo8">
                                        <input name="" type="text" value="<%=marcaV%>" style=" width:170px;color:#333333; text-align:center" readonly/>
                                    </span>					  </td>
                                <td width="12%"><span class="Estilo8">LINEA</span></td>
                                <td width="25%"><span class="Estilo8">
                                        <input name="Input" type="text"  value="<%=lineaV%>" style=" width:170px;color:#333333; text-align:center" readonly/>
                                    </span>					  </td>
                            </tr>
                            <tr>
                                <td width="7%"><span class="Estilo8">CLASE</span></td>
                                <td width="22%"><span class="Estilo8">
                                        <input name="" type="text"  value="<%= param.getNombre()%>" style=" width:150px;color:#333333; text-align:center" readonly/></span>						</td>
                                <td width="7%"><span class="Estilo8">SERVICIO</span></td>
                                <td width="26%"><span class="Estilo8">
                                        <input name="" type="text" value="<%=param2.getNombre()%>" style=" width:170px;color:#333333; text-align:center" readonly/></span>						</td>
                                <td width="12%"><span class="Estilo8">ESTADO</span></td>
                                <td width="25%"><span class="Estilo8">
                                        <input name="" type="text"  value="<%=param3.getNombre()%>" style=" width:170px;color:#333333; text-align:center" readonly/></span>						</td>
                            </tr>
                            <tr>
                                <td><span class="Estilo8">MODELO</span></td>
                                <td><span class="Estilo8">
                                        <input name="" type="text"  value="<%=vehiculo.getModelo()%>" style=" width:150px;color:#333333; text-align:center" readonly/></span>						</td>
                                <td><span class="Estilo8">COLOR</span></td>
                                <td><span class="Estilo14">
                                        <input name="" type="text"  value="<%=color%>" style=" width:170px;color:#333333; text-align:center" readonly/></span>						</td>
                                <td><span class="Estilo8">CARROCERIA</span></td>
                                <td><span class="Estilo8">
                                        <input name="" type="text"  value="<%=carroceria%>" style=" width:170px;color:#333333; text-align:center" readonly/></span>						</td>
                            </tr>
                            <tr>
                                <td><span class="Estilo8">L.&nbsp;TRANSITO</span></td>
                                <td><span class="Estilo8">
                                        <input name="" type="text"  value="<%= numeroLt%>" style=" width:150px;color:#333333; text-align:center" readonly/></span>						</td>
                                <td><span class="Estilo8">F.&nbsp;MATRICULA </span></td>
                                <td><span class="Estilo8">
                                        <input name="" type="text"  value="<%= vehiculo.getFecha_matricula() != null ? (new java.text.SimpleDateFormat("dd/MM/yyyy").format(vehiculo.getFecha_matricula())) : ""%>" style=" width:170px;color:#333333; text-align:center" readonly/></span>						</td>
                                <td><span class="Estilo8">CARTERA&nbsp;<span class="Estilo19"><%=periodo%></span></span></td>
                                <td><span class="Estilo8">
                                        <input name="" type="text"  value="<%=carteraSum%>" style=" width:170px;color:#FF0000;font-weight:bold; text-align:center" readonly/></span>
                                </td>
                                <%
                                    if (sw == 1) {
                                %>
                                <tr><td colspan="5" align="right">
                                    </td>
                                    <td colspan="1" align="left">
                                        <span class="Estilo19"><%="Total Con Descuento: " + total%></span>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>



                        </table>
                    </fieldset>          </td>
            </tr>

            <tr>
                <td colspan="3">
                    <fieldset class="style1">

                        <table width="100%" border="0" align="center">
                            <tr style="border:none; background:url(../html/images/inicio_3.png)">
                                <td colspan="6" align="center" valign="middle"><span class="Estilo18">CARACTERISTICAS DEL VEHICULO</span></td>
                            </tr>


                            <tr>
                                <td width="7%"><span class="Estilo8">MOTOR</span></td>
                                <td width="26%"><span class="Estilo8">
                                        <input type="text" value="<%=especif.get("19") != null ? especif.get("19") : ""%>" style="width:170px;color:#333333;text-align:center" readonly/>
                                    </span>						</td>


                                <% if (vehiculo.getClase_vehiculo() == 41 || vehiculo.getClase_vehiculo() == 24) {%>

                                <td width="7%"><span class="Estilo8">VIN</span></td>
                                <td width="26%"><span class="Estilo8">
                                        <input type="text" value="<%=especif.get("25") != null ? especif.get("25") : ""%>" style="width:170px;color:#333333;text-align:center" readonly/>
                                    </span></td>

                                <%  } else {%>

                                <td width="7%"><span class="Estilo8">CHASIS</span></td>
                                <td width="26%"><span class="Estilo8">
                                        <input type="text" value="<%=especif.get("20") != null ? especif.get("20") : ""%>" style="width:170px;color:#333333;text-align:center" readonly/>
                                    </span></td>
                                    <% }%>

                                <td width="7%"><span class="Estilo8">SERIE</span></td>
                                <td width="27%"><span class="Estilo8">
                                        <input type="text" value="<%=especif.get("21") != null ? especif.get("21") : ""%>" style="width:170px;color:#333333;text-align:center" readonly/>
                                    </span>						</td>
                            </tr>
                            <tr>
                                <td width="7%"><span class="Estilo8">CILINDRAJE</span></td>
                                <td width="26%"><span class="Estilo8">
                                        <input type="text" value="<%=especif.get("11") != null ? especif.get("11") : ""%>" style="width:170px;color:#333333;text-align:center" readonly/>
                                    </span>						</td>
                                <td><span class="Estilo8">PASAJEROS</span></td>
                                <td><span class="Estilo8">
                                        <input type="text" value="<%=especif.get("1") != null ? especif.get("1") : ""%>" style="width:170px;color:#333333; text-align:center" readonly/>
                                    </span>						</td>
                                <td><span class="Estilo8">TONELADAS</span></td>
                                <td><span class="Estilo8">
                                        <input type="text" value="<%=especif.get("2") != null ? especif.get("2") : ""%>" style="width:170px;color:#333333;text-align:center" readonly/>
                                    </span>						</td>
                            </tr>
                            <%
                                Movimiento movimiento = modelo.ConsultarMovimientoVehiculo(vehiculo.getId_vehiculo());

                                String NoGuia = "";
                                String ResponsableEnvio = "";
                                String FechaEnvio = "";
                                String traslado = "";
                                String f_traslado = "";
                                String radicado = "";
                                String f_radicado = "";

                                try {

                                    NoGuia = movimiento.getNumero_guia();
                                    FechaEnvio = new java.text.SimpleDateFormat("dd/MM/yyyy").format(movimiento.getFecha_envio());
                                    ResponsableEnvio = movimiento.getResponsable_envio();

                                } catch (Exception mexe) {

                                }

                                if (movimiento != null) {
                                    if (movimiento.getEstado() == 1) {
                                        Sede sede1 = new Sede();
                                        if (movimiento.getTipo_movimiento() == 1) {
                                            sede1 = modelo.consultarSede(movimiento.getFk_sede());
                                            radicado = sede1.getNombre_corto();
                                            f_radicado = new java.text.SimpleDateFormat("dd/MM/yyyy").format(movimiento.getFecha_movimiento());
                                        } else {
                                            sede1 = modelo.consultarSede(movimiento.getFk_sede());
                                            traslado = sede1.getNombre_corto();
                                            f_traslado = new java.text.SimpleDateFormat("dd/MM/yyyy").format(movimiento.getFecha_movimiento());
                                        }
                                    }
                                }


                            %>
                            <tr>
                                <td width="7%"><span class="Estilo8">D.&nbsp;IMPORTACION</span></td>
                                <td width="26%"><span class="Estilo8">
                                        <input name="" type="text"  value="<%= vehiculo.getDocumento_importacion() != null ? vehiculo.getDocumento_importacion() : ""%>" style=" width:170px;color:#333333; text-align:center" readonly/></span>						</td>
                                <td width="7%"><span class="Estilo8">TRASLADO&nbsp;A </span></td>
                                <td width="26%"><span class="Estilo8">
                                        <input type="text" value="<%=traslado%>" style="width:170px;color:#333333;text-align:center" readonly/>
                                    </span>						</td>
                                <td width="7%"><span class="Estilo8">RADICADO.&nbsp;DE</span></td>
                                <td width="27%"><span class="Estilo8">
                                        <input type="text" value="<%=radicado%>" style="width:170px;color:#333333; text-align:center" readonly/>
                                    </span>						</td>
                            </tr>
                            <tr>
                                <td><span class="Estilo8">F.&nbsp;IMPORTACION </span></td>
                                <td><span class="Estilo8">
                                        <input name="" type="text"  value="<%= vehiculo.getFecha_importacion() != null ? (new java.text.SimpleDateFormat("dd/MM/yyyy").format(vehiculo.getFecha_importacion())) : ""%>" style=" width:170px;color:#333333; text-align:center" readonly/></span>						</td>
                                <td><span class="Estilo8">F.&nbsp;TRASLADO </span></td>
                                <td><span class="Estilo8"><input type="text" name="textfield3" style=" width:170px;color:#333333; text-align:center" value="<%=f_traslado%>" readonly/></span></td>
                                <td><span class="Estilo8">F..&nbsp;RADICADO </span></td>
                                <td><span class="Estilo14"><input type="text" name="textfield4" style=" width:170px;color:#333333; text-align:center" value="<%=f_radicado%>" readonly/></span></td>
                            </tr>

                            <tr>
                                <td><span class="Estilo8">No.&nbsp;GUIA </span></td>
                                <td><span class="Estilo8"><input type="text" name="textfield3" style=" width:170px;color:#333333; text-align:center" value="<%=NoGuia%>" readonly/></span></td>
                                <td><span class="Estilo8">FECHA&nbsp;ENVIO </span></td>
                                <td><span class="Estilo8"><input type="text" name="textfield3" style=" width:170px;color:#333333; text-align:center" value="<%=FechaEnvio%>" readonly/></span></td>
                                <td><span class="Estilo8">RESPONSABLE&nbsp;ENVIO </span></td>
                                <td><span class="Estilo14"><input type="text" name="textfield4" style=" width:170px;color:#333333; text-align:center" value="<%=ResponsableEnvio%>" readonly/></span></td>
                            </tr>

                        </table>
                    </fieldset>		  </td>
            </tr>

            <tr>
                <td colspan="3">
                    <fieldset class="style1">
                        <table width="100%" border="0" align="center">
                            <tr style="border:none; background:url(../html/images/inicio_3.png)">
                                <td colspan="6" align="center" valign="middle"><span class="Estilo18">PROPIETARIOS DEL VEHICULO</span></td>
                            </tr>





                            <%      Propietario propietario = new Propietario();
                                java.util.List listapropietario = modelo.crearListaPropietarios(vehiculo.getId_vehiculo());
                                Iterator itt = listapropietario.iterator();
                                java.util.HashMap listaTipos = modelo.crearHashParametrosAbreviatura(5);
                                while (itt.hasNext()) {
                                    propietario = (Propietario) itt.next();
                                    Persona persona = modelo.consultarPersona(propietario.getFk_persona());%>
                            <tr>
                                <td width="7%"><span class="Estilo8">DOCUMENTO</span></td>
                                <td width="26%"><span class="Estilo8">
                                        <input name="" type="text"  ondblclick="datosPersona('<%=persona.getDocumento()%>', '<%=persona.getTipo_documento()%>')" value="<%=listaTipos.get(persona.getTipo_documento() + "") + " " + persona.getDocumento()%>" style=" width:170px;color:#333333; text-align:center" readonly/></span>					  </td>
                                <td width="7%"><span class="Estilo13"><span class="Estilo8">NOMBRE</span></span></td>
                                <td width="60%">
                                    <span class="Estilo8">
                                        <input type="text"  value="<%=persona.getNombre_1() + " " + (persona.getNombre_2() != null ? persona.getNombre_2() : "") + " " + persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "")%>"  style=" width:420px;color:#333333; text-align:center" readonly/>
                                    </span>
                                </td>
                            </tr>
                            <% } %>

                        </table>
                    </fieldset>		  </td>
            </tr>
            <tr>
                <td colspan="6" width="7%" align="center" style="border:none; background:url(../html/images/inicio_3.png)">
                    <% if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("habilitarSincronizacion")) {%>
                    <input id="estadorunt"  name="estadorunt" type="button" value="Actualizar Runt Sincronización" title="Acción con restricciones" onclick="ActualizarEstado(this.placa = '<%=placa%>')" />
                    <%
                    } else {%>
                    <input id="estadorunt"  name="estadorunt" type="button" value="Actualizar Runt Sincronización" title="Acción con restricciones" disabled onclick="ActualizarEstado(this.placa = '<%=placa%>')" />
                    <% } %>
                </td>
            </tr>
        </table>
        </fieldset>		  </td>
        </tr>
        <tr>
            <td colspan="3">
                <div align="center">
                    <%
                        try {
                            Sincronizacion sincronizacion = modelo.consultarSincronizacion(1, vehiculo.getId_vehiculo());
                            String textB = "";
                            int actId = 0;
                            if (sincronizacion != null) {
                                if (sincronizacion.getEstado() == 1) {
                                    textB = "Actualizado " + new java.text.SimpleDateFormat("dd/MM/yyy hh:mm:ss aa").format(sincronizacion.getFecha());
                                    actId = 1;
                                }
                            } else {
                                textB = "Actualizar Vehiculo RUNT";
                            }
                            if (actId == 0) {
                                if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("actualizarVehiculoRunt.jsp")) {%>
                    <input type="button" name="actualizar" id="actualizar" value="<%=textB%>" style="background-color:#009966; font-weight:bold; color:#FFFFFF" onclick="actualizarV(<%= vehiculo.getId_vehiculo()%>)"/>
                    <%      }
                    } else {%>
                    <input type="button" name="actualizar" id="actualizar" style="background-color:#003399; font-weight:bold; border-color:#003399;color:#FFFFFF" value="<%=textB%>" disabled/>
                    <% }
                        } catch (Exception exc) {
                            exc.printStackTrace();
                        }%>
                </div>
            </td>
        </tr>
        </table>
        <%     } else {
            session.removeAttribute("placa");%>
        <script>
            alert("El vehiculo no se encuentra Registrado  <%=placa%>");
            window.href = "consultar_Vehiculo.jsp";
        </script>
        <% }
        } else { %>
        <script>
            alert("Digite numero de placa");
            window.href = "consultar_Vehiculo.jsp";
        </script>
        <% }
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
    window.parent.parent.document.location.href = "../../index.jsp";
</script>  <%
    }
} catch (Exception mexe) {
    mexe.printStackTrace();%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
    }%>