<%--
    Documento   : detalleTaquilla
    Creado      : 10-mar-2010, 11:41:22
    Autor       : Desarrollo
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*,java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
//modelo.Model model = null;

    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                Model modelo = (Model) session.getAttribute("model");
                Usuario usuario = (Usuario) session.getAttribute("usuario");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <script language="javascript" type="text/javascript">

            function verReportePago() {
                ancho = 789;
                alto = 500;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                url = "impresion_tiquete.jsp";
                window.open(url, 'popUp', opciones);
            }

            function anularPago(idt) {

                if (document.getElementById('observacion').value.length > 1) {
                    if (confirm("Esta seguro de anular este pago?")) {
                        //document.location.href = "detallePago.jsp?id_tiquete="+idt+"&anular=1&motivo="+document.getElementById('observacion').value;
                        viewanular(idt);
                        act(idt);
                    }
                } else {
                    alert("Debe ingresar un motivo para la anulacion del pago.");
                }
            }


            function act(idt) {
                document.location.href = "verPagos.jsp";
            }

            function viewanular(idt) {
                ancho = 789;
                alto = 250;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "comparendos/Comparendos_por_Dias.jasper";
                var nombre = "Co-anumparendos_por_Dias";
                url = "Verificar_anulacion.jsp?id_tiquete=" + idt + "&anular=1&motivo=" + document.getElementById('observacion').value + "&user=1&password=1";
                window.open(url, 'popUp', opciones);
            }

            function validarLiquidacion(idt) {
                if (confirm("Esta seguro que desea Aplicar esta Liquidacion?")) {
                    document.location.href = "procesarLiquidacion.jsp?id_tiquete=" + idt;
                }
            }
            function editarPago(idt) {
                var tipoP = document.getElementById("tipoPago").value;
                var ref = document.getElementById("referencia").value;
                if (confirm("Esta seguro que desea Editar esta Liquidacion?")) {
                    document.location.href = "editarPago.jsp?id_tiquete=" + idt + "&tipoP=" + tipoP + "&referencia=" + ref;
                }
            }

            function activarPago(idt) {
                var observacion = document.getElementById("observacion").value;
                if (observacion.length > 1) {
                    if (confirm("Esta seguro que desea Activar el Pago?")) {
                        document.location.href = "ActivarPago.jsp?id_tiquete=" + idt + "&observacion=" + observacion;
                    }
                } else {
                    alert("Digite observacion para la Activación del pago")
                }
            }

        </script>
        <style type="text/css">

            <!--
            .style1 {
                font-size: 12px;
                font-family: Tahoma;
                font-weight: bold;
                color: #333333;
            }
            .style3 {font-weight: bold}
            .style4 {color: #333333}
            .style4 {color: #333333; font-size:10px; text-align:center}
            .Estilo1 {color: #FFFFFF}
            .Estilo3 {font-size: 10px; font-family: Tahoma; font-weight: bold; color: #333333; }
            .Estilo4 {font-size: 10px}
            .Estilo5 {color: #333333; font-size: 10px; }
            .Estilo6 {font-size: 10px; color:#333333;}
            -->
        </style>
    </head>
    <body>
        <fieldset>
            <legend><span class="Estilo3">DETALLE TIQUETE</span></legend>
            <%  long id_tiquete = 0;

                if (request.getParameter("id_tiquete") != null) {
                    id_tiquete = Long.parseLong(request.getParameter("id_tiquete"));
                    Persona persona = new Persona();
                    Parametro param = new Parametro();
                    Parametro pmetro = new Parametro();
                    java.util.HashMap listaTipos = modelo.crearHashParametrosAbreviatura(5);
                    String nombre = "";
                    String observacion = "";
                    boolean permisoAnularPago = true;
                    Tiquete tiq = modelo.consultarTiquetePorID(id_tiquete);
                    Taquilla taq = modelo.consultarTaquillaActivaByUsuario(usuario.getId_usuario());
                    if (request.getParameter("anular") != null) {
                        if (request.getParameter("anular").equals("1")) {
                            observacion = request.getParameter("motivo");

                            java.util.List dte = modelo.consultarDetalleTiquete(tiq.getId_tiquete());
                            long EstadoPago = 0;
                            for (int i = 0; i < dte.size(); i++) {
                                Detalle_Tiquete dt = (Detalle_Tiquete) dte.get(i);
                                if (dt.getEstado() == 2) {
                                    EstadoPago = 1;
                                }
                            }
                            if (EstadoPago != 1) {
                                if ((tiq.getEstado() == 3 && taq.getEstado() == 1) || (tiq.getEstado() == 3 && usuario.getId_usuario() == 1)) {
                                    try {
                                        Pago pago = modelo.consultarPagoByTiquete(tiq.getId_tiquete());
                                        if (pago != null) {
                                            modelo.getCon().setAutoCommit(false);
                                            java.util.List listat = modelo.consultarDetalleTiquete(tiq.getId_tiquete());
                                            for (int i = 0; i < listat.size(); i++) {
                                                Detalle_Tiquete dt = (Detalle_Tiquete) listat.get(i);
                                                if (dt.getFk_concepto() != 0 || dt.getFk_tramite() != 0) {
                                                    for (int d = 1; d <= dt.getCantidad(); d++) {
                                                        modelo.actualizarEstadoDetalleTiqueteConcepto(dt.getId_det_tiquete(), 2, d);
                                                    }
                                                }
                                                if (dt.getFk_cartera() != 0) {
                                                    Cartera cartera = modelo.consultarCartera(dt.getFk_cartera());
                                                    if (cartera != null) {
                                                        modelo.renovarCartera(cartera.getId_cartera(), pago.getId_pago());
                                                        modelo.actualizarComparendo(cartera.getId_cartera(), 1);
                                                        modelo.eliminarPagoDetalleCartera(cartera.getId_cartera(), pago.getId_pago() + "");
                                                        modelo.actualizarValoresCartera(cartera.getId_cartera());
                                                        if (cartera.getTipo() == 3) {
                                                            modelo.actualizarDetalleFinanciacion(cartera.getId_cartera(), 1);
                                                            boolean cuotasCanceladas = modelo.consultarCuotasCanceladas(cartera.getId_cartera());
                                                            if (!cuotasCanceladas) {
                                                                modelo.actualizarComparendoFinanciacion(cartera.getId_cartera(), 1);
                                                                modelo.actualizarFinanciacion(cartera.getId_cartera(), 1);
                                                            }
                                                        }
                                                    }
                                                }
                                                modelo.actualizarEstadoDetalleTiquete(dt.getId_det_tiquete(), 2);
                                            }
                                            tiq.setEstado(2);
                                            tiq.setFk_taquilla(taq.getId_taquilla());
                                            tiq.setFk_usuario(usuario.getId_usuario());
                                            modelo.actualizarEstadoTiquete(tiq);
                                            modelo.actualizarEstadoPago(pago.getId_pago(), 2, observacion, taq.getId_taquilla(), usuario.getId_usuario());
                                            modelo.actualizarSaldosAFavorxReferencia(1, tiq.getId_tiquete() + "");
                                            modelo.getCon().commit();
                                        }
                                    } catch (Exception exc) {
                                        modelo.getCon().rollback();
                                        exc.printStackTrace();
                                    }
                                }
                            } else {
            %>
            <script>
                alert("El pago no puede Anularse porque ya se encuentra utilizado");
            </script>
            <%
                        }
                    }
                }
                persona = modelo.consultarPersona(tiq.getFk_persona());
                nombre = persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "") + " " + persona.getNombre_1();

                java.util.HashMap parameters = new java.util.HashMap();
                parameters.put("TIQUETE", tiq.getId_tiquete());
                parameters.put("NUMERO", tiq.getNumero_factura());
                parameters.put("FECHA", new java.text.SimpleDateFormat("dd/MM/yyyy").format(tiq.getFecha()));
                parameters.put("NOMBRE", nombre);
                parameters.put("NRO_DOC", listaTipos.get(persona.getTipo_documento() + "") + " " + persona.getDocumento());
                Persona personaUsuario = modelo.consultarPersona(usuario.getFk_persona());
                String nombreU = personaUsuario.getNombre_1() + " " + personaUsuario.getApellido_1() + " " + (personaUsuario.getApellido_2() != null ? personaUsuario.getApellido_2() : "");
                parameters.put("USUARIO", nombreU);
                parameters.put("SEGURIDAD", ((int) tiq.getValor_total_descuento()) + " Re-Impresion ");

                String placa = "";
                if (tiq.getFk_vehiculo() != 0) {
                    placa = modelo.consultarVehiculoById(tiq.getFk_vehiculo()).getPlaca();
                } else {
                    placa = tiq.getDescripcion();
                }
                if (!new java.text.SimpleDateFormat("dd/MM/yyyy").format(tiq.getFecha()).equals(new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date()))) {
                    if (!usuario.getNombre().equals("ADMIN") || usuario.getId_usuario() != 75) {
                        permisoAnularPago = false;
                    }
                    permisoAnularPago = (usuario.getId_usuario()==75);
                }

                String readonly = "";
                if (tiq != null) {
                    if (tiq.getEstado() == 2) {
                        Pago pago = modelo.consultarPagoByTiquete(tiq.getId_tiquete());
                        if (pago != null) {
                            observacion = pago.getObservacion() != null ? pago.getObservacion() : "";
                            readonly = "readonly";
                        }
                    }
                }
                parameters.put("PLACA", placa);
                parameters.put("VALOR", tiq.getValor_total());
                //String dir = application.getRealPath("paginas/reports/recaudoycartera/pagos/multipleTiquetePagoReport.jasper");
                String dir = "C:/Civitrans/transito/web/paginas/reports/recaudoycartera/pagos/multipleTiquetePagoReport.jasper";
                parameters.put("SUBREPORT_DIR", dir.substring(0, dir.indexOf("reports") + 8));
                session.setAttribute("reporteOT", parameters);
                param = modelo.consultarParametro(tiq.getTipo_pago(), 301);
                pmetro = modelo.consultarParametro(tiq.getEstado(), 77);
            %>



            <form name="forma"  method="post" action="">
                <table width="100%" align="center">
                    <tr bordercolor="#FFFFFF" class="style1">
                        <th width="78" align="center"><div align="center" class="Estilo7 style3 Estilo4">TIPO&nbsp;PAGO </div></th>
                        <td width="149" align="left" style="font-size:11px"><input readonly class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%= param.getNombre()%>" ></td>
                        <th width="63" align="center"><div align="center" class="Estilo5">FACTURA</div></th>
                        <th width="144" align="left" style="font-size:11px"><input readonly  class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%= tiq.getNumero_factura()%>" ></th>
                        <th width="43" ><div align="center" class="Estilo5">PLACA</div></th>
                        <td width="154" align="left" style="font-size:11px"><input class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%= placa != null ? placa : ""%>" readonly ></td>
                    </tr>
                    <tr class="style1">
                        <th ><div align="center" class="Estilo5">DOCUMENTO</div></th>
                        <td align="left" style="font-size:11px"><input name="Input2" readonly class="style5" style="font-size:10px; text-align:center; color:#333333" value = "<%=listaTipos.get(persona.getTipo_documento() + "") + " " + persona.getDocumento()%>"></td>
                        <th ><div align="center" class="Estilo5">NOMBRE</div></th>
                        <td align="left" style="font-size:11px" colspan="3"><input name="Input3" readonly class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%=nombre%>" size="70" ></td>
                    </tr>
                    <tr class="style1">
                        <th ><div align="center" class="Estilo5">ESTADO</div></th>
                        <td align="left" style="font-size:11px"><input readonly class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%= pmetro.getNombre()%>"></td>
                        <td ><div align="center" class="Estilo5">VALOR</div></td>
                        <td align="left" style="font-size:11px"><input readonly class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%= tiq.getValor_total()%>"></td>
                        <td><span class="Estilo5">FECHA</span></td>
                        <td align="left"><span style="font-size:11px">
                                <input name="Input" readonly class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(tiq.getFecha())%>" >
                            </span></td>
                    </tr>
                    <tr class="style1">
                        <th ><div align="center" class="Estilo5">PRELIQUIDADO&nbsp;POR</div></th>
                            <%
                                PreLiquidacion pre = new PreLiquidacion();
                                pre = modelo.ConsultarPreliquidacionBYfk_Pago(tiq.getNumero_factura());

                                if (pre != null) {
                                    Usuario us = modelo.consultarUsuario(pre.getFk_usuario());
                            %>
                        <td align="left" style="font-size:11px"><input readonly class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%= us.getNombre()%>"></td>
                            <% } else {
                            %>
                        <td align="left" style="font-size:11px">&nbsp;</td>
                        <% }%>
                        <td colspan="1"><div align="center" class="Estilo5">OBSERVACION</div></td>
                        <td align="left" style="font-size:11px" colspan="3">
                            <input id="observacion" name="observacion" class="style5" style="font-size:10px; width:800px; text-align:center; color:#333333" value="<%=observacion%>">
                        </td>
                    </tr>


                    <%  if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("editarPago") && tiq.getEstado() == 3) {%>
                    <tr class="style1">
                        <td colspan="1"><div align="center" class="Estilo5">REFERENCIA</div></td>
                        <td align="left" style="font-size:11px" colspan="5">
                            <input id="referencia" name="referencia" class="style5" style="font-size:10px; width:180px; text-align:center; color:#333333" value="<%=observacion%>">
                        </td>
                    </tr>
                    <tr class="style1">
                        <td colspan="1"><div align="center" class="Estilo5">NUEVO TIPO DE PAGO</div></td>
                        <td align="left" colspan="1">
                            <select name="tipoPago" id="tipoPago"  style=" width:180px; color:#333333; font-size:11px">
                                <%
                                    Model model = (Model) session.getAttribute("model");
                                    Parametro parametro = null;
                                    java.util.List lista = model.listadoParametros(301);
                                    java.util.Iterator iterator = lista.iterator();
                                    while (iterator.hasNext()) {
                                        parametro = (Parametro) iterator.next();
                                %>
                                <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
                                <%
                      }%>
                            </select>
                        </td>
                    </tr>
                    <% } %>

                    <tr>
                        <td colspan="6">
                            <table align="center" cellpadding="1" cellspacing="0" border="1" width="100%">
                                <tr class="style1" style="border:none; background:url(../html/images/inicio_3.png)">
                                    <th style="border:none"><span class="Estilo1 Estilo4">CODIGO</span></th>
                                    <th style="border:none"><span class="Estilo1 Estilo4">CANTIDAD</span></th>
                                    <th style="border:none"><span class="Estilo1 Estilo4">CONCEPTO</span></th>
                                    <th style="border:none"><span class="Estilo1 Estilo4">REFERENCIA</span></th>
                                    <th style="border:none"><span class="Estilo1 Estilo4">VALOR</span></th>
                                </tr>
                                <%
                                      List<java.util.HashMap> det_tiquete = modelo.listarDetalleTiquete(tiq.getId_tiquete());
                                      for (java.util.HashMap hash : det_tiquete) {%>
                                <tr>
                                    <td align="center"><span class="Estilo6"><%=hash.get("CODIGO")%></span></td>
                                    <td align="center"><span class="Estilo6"><%=hash.get("CANTIDAD")%></span></td>
                                    <td align="left"><span class="Estilo6"><%=hash.get("CONCEPTO")%></span></td>
                                    <td align="center"><span class="Estilo6"><%=hash.get("REFERENCIA")%></span></td>
                                    <td align="right"><span class="Estilo6"><%=hash.get("VALOR")%></span></td>
                                </tr>
                                <%}%>
                            </table>			</td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <%if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("reImprimir")) { %>
                            <input type="button"  style="width:100px; font-size:10px" value="Re-Imprimir" onclick="verReportePago()">
                            <%} else {%>
                            <input type="button"  style="width:100px; font-size:10px" value="Re-Imprimir" onclick="verReportePago()" disabled>
                            <%}%>

                        </td>

                        <td align="center" colspan="2">
                            <%if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("anularPago") && tiq.getEstado() == 3 && permisoAnularPago) {%>
                            <input type="button" value="Anular"  style="width:100px; font-size:10px" onclick="anularPago('<%=id_tiquete%>')"></td>
                            <%} else {%>
                    <input type="button" value="Anular"  style="width:100px; font-size:10px" onclick="anularPago('<%=id_tiquete%>')" disabled></td>
                    <%}%>

                    <td align="center">
                        <%if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("editarPago") && tiq.getEstado() == 3) {%>
                        <input type="button" value="Editar Pago"  style="width:100px; font-size:10px" onclick="editarPago('<%=id_tiquete%>')">
                        <%} else {%>
                        <input type="button" value="editar"  style="width:100px; font-size:10px" disabled>
                        <%}%>
                    </td>

                    <td align="center">
                        <%if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("activarPago") && tiq.getEstado() == 3) {%>
                        <input type="button" value="Activar Pago"  style="width:100px; font-size:10px" onclick="activarPago('<%=id_tiquete%>')">
                        <%} else {%>
                        <input type="button" value="Activar Pago"  style="width:100px; font-size:10px" disabled>
                        <%}%>
                    </td>


                    </tr>
                </table>
            </form>
            <%  modelo.getCon().commit();
            } %>
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
} catch (Exception mexe) {
                    mexe.printStackTrace(); %>
mexe.p
<%
    }%>