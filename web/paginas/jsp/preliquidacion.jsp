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
        <meta http-equiv="Content-Type" contentreferiencia="text/html; charset=UTF-8">
        <title></title>
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script src="../html/scripts/personas.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript">
            function cambiarPago() {
                var tpago = document.getElementById('tipoPagos');
                var lreferencia = document.getElementById('lreferencia');
                var referencia = document.getElementById('referencia');
                var lbanco = document.getElementById('lbanco');
                var banco = document.getElementById('banco');
                opcion = tpago.options[tpago.options.selectedIndex].value;

                if (opcion == 1) {
                    lreferencia.style.display = 'none';
                    referencia.style.display = 'none';
                    //lanzador.style.display = 'none';
                    lbanco.style.display = 'none';
                    banco.style.display = 'none';
                } else {
                    if (opcion > 3) {
                        lbanco.style.display = 'block';
                        banco.style.display = 'block';
                    } else {
                        lbanco.style.display = 'none';
                        banco.style.display = 'none';
                    }
                    lreferencia.style.display = 'block';
                    referencia.style.display = 'block';
                }
            }

            function validarLiquidacion(idt) {
                var tpago = document.getElementById('tipoPagos');
                opcion = tpago.options[tpago.options.selectedIndex].value;
                var refer = document.getElementById("referencia").value;
                document.form.id_tiquete.value = idt;
                if (opcion == 1) {
                    if (confirm("Esta seguro que desea Aplicar esta Liquidacion?")) {
                        document.form.action = "procesarLiquidacion.jsp";
                        document.form.submit();
                        
                    }
                } else {
                    if (refer.length > 0) {
                        if (confirm("Esta seguro que desea Aplicar esta Liquidacion?")) {
                            document.form.action = "procesarLiquidacion.jsp";
                            document.form.submit();
                           // verReportePago();
                        }
                    } else {
                        alert("Ingresar referencia");
                    }
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
        <form name="form" id="form" method="post" action="#">
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
                        if (!usuario.getNombre().equals("ADMIN")) {
                            permisoAnularPago = false;
                        }
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
                <table width="100%" align="center">
                    <input type="hidden" name="id_tiquete" value=""/>
                    <tr bordercolor="#FFFFFF" class="style1">
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
                        <td><span class="Estilo5">FECHA
                                <input name="Input" readonly class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(tiq.getFecha())%>" >
                            </span></td>
                    </tr>
                    <!--  <tr class="style1">
                          <td colspan="1"><div align="center" class="Estilo5">OBSERVACION</div></td>
                          <td align="left" style="font-size:11px" colspan="5">
                              <input type="hidden" id="observacion" name="observacion" <%=readonly%> class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%=observacion%>" size="120" >
                          </td>
  
                    </tr> -->

                    <tr>
                        <td colspan="2" align="left">
                            <div id="opciones" align="center" style="width:430px;font-size:11px"></div>
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td rowspan="2">
                            <%if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("aplicarLiquidacion") && tiq.getEstado() == 4 && tiq.getEstado_preliquidacion() == 1) {%>
                            <input type="button"  style="width:100px; font-size:10px" value="Validar liquidacion" onclick="validarLiquidacion('<%=id_tiquete%>')">
                            <%} else {%>
                            <input type="button" disabled  style="width:100px; font-size:10px" value="Validar liquidacion" onclick="validarLiquidacion('<%=id_tiquete%>')">
                            <%}%>
                        </td>
                    </tr>

                    <tr>
                        <th align="center"><label id="ltipo" style="color:#CC0000"><span class="Estilo5"><span class="Estilo5">TIPO PAGO </span></span></label></th>
                        <th align="left" colspan="1">
                            <select name="tipoPagos" id="tipoPagos" size="1" style="width:170px;size:4;color:#333333; font-size:11px " onchange="cambiarPago()">
                                <%
                                    Usuario user = (Usuario) session.getAttribute("usuario");
                                    Taquilla taqu = modelo.consultar_Taquilla_Actual(user.getFk_sede(), user.getId_usuario());
                                    java.util.List listaTiposPagos = modelo.consultarTipoPagoByUsuario(user.getId_usuario(), taqu != null ? taqu.getFk_caja() : 0);
                                                    for (int i = 0; i < listaTiposPagos.size(); i++) {
                                                        Parametro parametro = (Parametro) listaTiposPagos.get(i);%>
                                <option value="<%=parametro.getCodigo() + ""%>" <%=(parametro.getCodigo() == 1 ? "selected" : "")%>><%=parametro.getNombre()%></option>
                                <%}%>
                            </select>
                        </th>

                        <th colspan="1" align="center">
                            <label id="lreferencia" style="color:#CC0000; display:none"><span class="Estilo5">REFERENCIA</span></label>
                        </th>
                        <th align="center">
                            <input name="referencia" type="text" id="referencia" value="" style="color:#333333; width:170px; display:none;font-size:11px "/><!-- onblur="buscarReferencia(this)" /-->
                        </th>
                    </tr>

                    <tr>

                        <th align="center">
                            <label id="lbanco" style="color:#CC0000;display:none"><span class="Estilo5">BANCO</span></label>
                        </th>
                        <td colspan="2" align="left">
                            <select name="banco" id="banco" size="1" style="width:350px;size:4;color:#333333;display:none;font-size:11px">
                                <%
                                    try {
                                        java.util.List listaBancos = modelo.listado_bancos();
                                                        for (int i = 0; i < listaBancos.size(); i++) {
                                                            Banco banco = (Banco) listaBancos.get(i);%>
                                <option value="<%=banco.getId_banco()%>"><%=banco.getNombre()%></option>
                                <%	}
                                                                        } catch (Exception exc) {
                                                                            out.println(exc.getMessage());
                                                                        }%>
                            </select>										</td>
                    </tr>

                    </tr>

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

                </table>

            </fieldset>



        </table>
        <%  modelo.getCon().commit();
            } %>
    </fieldset>

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
