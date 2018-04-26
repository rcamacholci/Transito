<%--
    Document   : procesarLiquidacion
    Created on : 10/08/2012, 11:15:08 AM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" import="modelo.*" import="java.sql.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%
    Model model = (Model) session.getAttribute("model");
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    try {
        if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("aplicarLiquidacion")) {
            if (session.getAttribute("model") != null) {
                java.sql.Date fechaR = null;
                boolean paso = true;
                if (request.getParameter("id_tiquete") != null) {
                    long tiq = Long.parseLong(request.getParameter("id_tiquete"));
                    Tiquete tiquete = model.consultarTiquetePorID(tiq);
                    model.getCon().setAutoCommit(false);
                    if (tiquete != null) {
                        if (tiquete.getEstado_preliquidacion() == 1) {
                            Pago pago = model.consultarPagoByTiquete(tiquete.getId_tiquete());
                            java.util.List listat = model.consultarDetalleTiquete(tiquete.getId_tiquete());
                            for (int i = 0; i < listat.size(); i++) {
                                if (pago != null) {
                                    Detalle_Tiquete dtt = (Detalle_Tiquete) listat.get(i);
                                    if (dtt != null) {
                                        Cartera cartera = model.consultarCartera(dtt.getFk_cartera());
                                        if (cartera != null) {
                                            if (cartera.getTipo() == 2 && cartera.getEstado_cartera() == 1) {
                                                java.sql.Date fechaMod = cartera.getFecha_saldo();
                                                model.actualizarCartera(cartera.getId_cartera(), 0, 2, pago.getId_pago(), tiquete.getFecha(), fechaMod, 1);

                                                //INSERCION DE CONCEPTO DESCUENTO 1093 y 1094
                                                java.util.Date fechaActual = (new java.util.Date());
                                                if ((new java.text.SimpleDateFormat("dd/MM/yyyy").parse(new java.text.SimpleDateFormat("dd/MM/yyyy").format(fechaActual)).getTime() <= new java.text.SimpleDateFormat("dd/MM/yyyy").parse("26/09/2013").getTime())
                                                        && (!cartera.getReferencia().equals("2011") && !cartera.getReferencia().equals("2012") && !cartera.getReferencia().equals("2013"))) {
                                                    int valdescontado = 0;
                                                    int valdescontadoExtempo = 0;
                                                    int valinteres = 0;
                                                    int valextempo = 0;
                                                    String numresol = "375";
                                                    String fecharesol = "21/08/2013";
                                                    java.sql.Date fecha_actual = new java.sql.Date(new java.util.Date().getTime());
                                                    modelo.Detalle_Cartera detalle_cartera = new modelo.Detalle_Cartera();
                                                    Detalle_Cartera dtcartera = model.consultarDetalleCartera(cartera.getId_cartera(), 249);
                                                    if (dtcartera != null) {
                                                        float valor_interes = dtcartera.getValor();
                                                        int interesD = (int) ((valor_interes * 80) / 100);
                                                        valinteres = (int) valor_interes - interesD;
                                                        valdescontado = valinteres - (int) valor_interes;
                                                    }
                                                    modelo.Detalle_Cartera dcEx = model.consultarDetalleCarteraExtempo(cartera.getId_cartera());
                                                    if (dcEx != null) {
                                                        float valor_extempo = dcEx.getValor();
                                                        int extempoD = (int) ((valor_extempo * 80) / 100);
                                                        valextempo = (int) valor_extempo - extempoD;
                                                        valdescontadoExtempo = valextempo - (int) valor_extempo;
                                                    }

                                                    detalle_cartera.setFk_cartera(cartera.getId_cartera());
                                                    detalle_cartera.setEstado(1);
                                                    detalle_cartera.setFecha(cartera.getFecha_creacion());
                                                    detalle_cartera.setFecha_sistema(new java.sql.Timestamp(new java.util.Date().getTime()));
                                                    detalle_cartera.setFk_concepto(1093);
                                                    detalle_cartera.setFk_usuario(usuario.getId_usuario());
                                                    detalle_cartera.setReferencia(cartera.getReferencia());
                                                    detalle_cartera.setValor(Math.round(valdescontado));
                                                    model.adicionarDetalleCartera(detalle_cartera);
                                                    model.InsertarValorDescuento(cartera.getFk_vehiculo(), cartera.getId_cartera(), cartera.getReferencia(), (long) valdescontado, (long) 1, (long) valinteres, usuario.getId_usuario(), numresol, fecharesol, fecha_actual, 1093);
                                                    model.getCon().commit();

                                                    if (!cartera.getReferencia().equals("2007") && !cartera.getReferencia().equals("2008") && !cartera.getReferencia().equals("2009")
                                                            && !cartera.getReferencia().equals("2010") && !cartera.getReferencia().equals("2011") && !cartera.getReferencia().equals("2012") && !cartera.getReferencia().equals("2013")) {
                                                        detalle_cartera.setFk_cartera(cartera.getId_cartera());
                                                        detalle_cartera.setEstado(1);
                                                        detalle_cartera.setFecha(cartera.getFecha_creacion());
                                                        detalle_cartera.setFecha_sistema(new java.sql.Timestamp(new java.util.Date().getTime()));
                                                        detalle_cartera.setFk_concepto(1094);
                                                        detalle_cartera.setFk_usuario(usuario.getId_usuario());
                                                        detalle_cartera.setReferencia(cartera.getReferencia());
                                                        detalle_cartera.setValor(Math.round(valdescontadoExtempo));
                                                        model.adicionarDetalleCartera(detalle_cartera);
                                                        model.InsertarValorDescuento(cartera.getFk_vehiculo(), cartera.getId_cartera(), cartera.getReferencia(), (long) valdescontado, (long) 1, (long) valextempo, usuario.getId_usuario(), numresol, fecharesol, fecha_actual, 1094);
                                                        model.getCon().commit();
                                                    }
                                                }

                                                java.util.List lista_dc = model.listarDetalleCartera(cartera.getId_cartera());

                                                for (int j = 0; j < lista_dc.size(); j++) {
                                                    Detalle_Cartera dcc = (Detalle_Cartera) lista_dc.get(j);
                                                    model.actualizarDetalleCartera(dcc.getId_detalle_cartera(), 2, pago.getId_pago(), 1);
                                                }
                                                Detalle_Cartera dc = new Detalle_Cartera();
                                                dc.setFecha(tiquete.getFecha());
                                                dc.setEstado(2);
                                                dc.setFecha_sistema(new java.sql.Timestamp(new java.util.Date().getTime()));
                                                dc.setFk_cartera(cartera.getId_cartera());
                                                int codP = 322;
                                                dc.setFk_concepto(codP);
                                                dc.setFk_usuario(usuario.getId_usuario());
                                                dc.setReferencia("" + pago.getId_pago());
                                                dc.setValor((float) (-1 * tiquete.getValor_total()));
                                                model.adicionarDetalleCartera(dc);
                                            } else {
                                                if (cartera.getEstado_cartera() != 1) {
                                                    paso = false;
%><script>
    alert("La Cartera <%=cartera.getReferencia()%> Se encuentra en un estado diferente a activa, El pago no puede ser Aplicado");
    window.location.href = "detallePago.jsp?id_tiquete=" +<%=request.getParameter("id_tiquete")%>;
</script>><%
                        }
                    }
                }
            }
        }
    }

    if (paso) {
        Taquilla taquilla = new Taquilla();
        taquilla = model.consultarTaquillaActivaByUsuario(usuario.getId_usuario());
        model.actualizarEstadoTiqueteByID(Long.parseLong(request.getParameter("id_tiquete")), 3);
        model.actualizarEstadoPagoByFk_tiquete(Long.parseLong(request.getParameter("id_tiquete")), 3);
        model.validarLiquidacion(2, taquilla.getId_taquilla(), Long.parseLong(request.getParameter("id_tiquete")), usuario.getId_usuario());
        model.validarPagoLiquidacion(taquilla.getId_taquilla(), Long.parseLong(request.getParameter("id_tiquete")), usuario.getId_usuario());

        if (request.getParameter("tipoPagos") != null) {
            System.out.println("Pago: " + request.getParameter("tipoPagos"));
            int tipopago = Integer.parseInt(request.getParameter("tipoPagos"));
            if (tipopago != 7) {
                if (tipopago != 1) {
                    String referencia = request.getParameter("referencia");
                    fechaR = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("Input")).getTime());
                    long banco = Long.parseLong(request.getParameter("banco").toString());;

                    model.actualizarTipoPagoTiquete(Long.parseLong(request.getParameter("id_tiquete")), tipopago, referencia, fechaR, banco);
                    model.actualizarTipoPagos(Long.parseLong(request.getParameter("id_tiquete")), tipopago, referencia, fechaR, banco);
                }
            }
        }
        model.getCon().commit();
%><script>
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
    verReportePago();
</script>><%
    } else {
        model.getCon().rollback();
    }
} else {
%><script>
    alert("La factura ya se encuentra liquidada");
    window.location.href = "detallePago.jsp?id_tiquete=" +<%=request.getParameter("id_tiquete")%>;
</script>><%
        }
    }

%><script>
    window.location.href = "detallePago.jsp?id_tiquete=" +<%=request.getParameter("id_tiquete")%>;
</script>><%
    }

} else { %>
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
    model.getCon().rollback();
    mexe.printStackTrace();
%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
    }%>