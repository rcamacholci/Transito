<%-- 
    Document   : prefactura
    Created on : 20-ago-2012, 11:28:48
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="webservices.liquidacion.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    try {
        if (session.getAttribute("usuario") != null) {
            modelo.Model model = (modelo.Model) session.getAttribute("model");
            if (model != null) {
                modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Documento sin t&iacute;tulo</title>
        <link rel="stylesheet" type="text/css" href='../html/css/style.css' />
        <style type="text/css">
            <!--
            .Estilo5 {font-size: 12px; color: #FFFFFF; }
            .Estilo9 {color: #000000}
            .Estilo10 {
                font-size: 12px;
                font-weight: bold;
                color: #333333;
            }
            .Estilo11 {color: #333333}
            .Estilo12 {color: #333333}
            .Estilo13 {font-size: 14px}
            .Estilo14 {font-size: 12px}
            .Estilo15 {font-size: 10px}
            .Estilo21 {font-size: 11px}
            .Estilo22 {
                color: #000000;
                font-weight: bold;
                font-size: 14px;
            }
            .Estilo23 {font-size: 13px}
            .Estilo24 {color: #333333; font-size: 12px; }
            .Estilo25 {
                font-size: 10px;
                color: #333333;
                font-weight: bold;
            }
            -->
        </style>
        <script language="javascript" type="text/javascript">
            function imprimir(id){
                ancho = 789;
                alto = 500;
                barra = 0;
                izquierda = (document.width) ? (document.width-ancho)/2 : 100;  
                arriba = (document.height) ? (document.height-alto)/2 : 100;  
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';  
                url = "impresion_recibo.jsp?id="+id;
                window.open(url, 'popUp', opciones);
            }
            function activar(){
                window.parent.document.getElementById('propieta_sede').style.display = 'none';
                window.parent.document.getElementById('totalizador').style.display = 'none';
                window.parent.document.getElementById('consultarPlaca').disabled = true;
                window.parent.document.getElementById('consultarDocumento').disabled = true;
                window.parent.document.getElementById('contenedor').style.border = '0';
                window.parent.document.getElementById('liquidacion').style.display = 'none';
                window.parent.document.getElementById('liquidacionf').style.display = 'block';
                window.parent.document.getElementById('impresion').style.display = 'block';
                document.getElementById("tabla_general").style.display = "block";
                window.parent.frames[0].location.href = "verCarteraLiquidacion.jsp?id=0";
                window.parent.frames[1].location.href = "verCarteraLiquidacion.jsp?id=0";
                window.parent.frames[2].location.href = "verCarteraLiquidacion.jsp?id=0";
                window.parent.frames[3].location.href = "verCarteraLiquidacion.jsp?id=0";
            }
        </script>
    </head>

    <body>
        <%
            int gh = 1;
            String mensajeRunt = "";
            boolean aplicacionRunt2 = false;
            boolean adicionarRunt = false;
            boolean reciboRunt = false;
            boolean liqrunt = false;
            boolean liqtransito = false;
            try {
                String datos_persona = "";
                String nombrePersona = "";
                String documentoPersona = "";
                if (request.getParameter("persona") != null) {
                    Persona persona = model.consultarPersona(Long.parseLong(request.getParameter("persona")));
                    java.util.HashMap listaTipos = model.crearHashParametrosAbreviatura(5);
                    if (persona != null) {%>
        <table width="100%" border="0" id="tabla_general" name="tabla_general" style="display:block">

            <tr style="border:none">
                <th colspan="4" scope="col" style="border:none"><span class="Estilo23"><span class="Estilo12"> <span class="Estilo13 Estilo14">
                                <label id="ltipo"><strong>RESUMEN LIQUIDACION</strong></label>
                            </span> </span></span></th>
            </tr>
            <tr>
                <th colspan="4"><span class="Estilo9"></span></th>
            </tr>
            <tr>
                <td width="5%"><span style="color:#000000"> <span class="Estilo11">
                            <label id="lfecha"><strong><span class="Estilo24">FECHA</span></strong></label>
                        </span> </span></td>
                <td width="10%"><input name="fecha" type="text" readonly="true" style="text-align:center;color:#333333; width:100px" value="<%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date())%>"/></td>
                <td width="6%"><span style="color:#000000"> <span class="Estilo11">
                            <label id="lplaca"><strong><span class="Estilo24">VEHICULO</span></strong></label>
                        </span> </span></td>
                <td width="79%" colspan="3"><input name="placa" type="text" style="text-align:center; color:#333333; width:120px" readonly="true" value="<%=request.getParameter("placa")%>"/></td>
            </tr>
            <tr>
                <td width="5%"><span style="color:#000000"> <span class="Estilo11">
                            <span class="Estilo9"> <span class="Estilo14"> <span class="Estilo12">
                                        <label id="lpersona"><strong>CLIENTE </strong></label>
                                    </span> </span></span> </span> </span></td>
                <td colspan="87"><span class="Estilo9">
                        <%    datos_persona = listaTipos.get(persona.getTipo_documento() + "") + " " + persona.getDocumento() + " - " + persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "") + " " + persona.getNombre_1();
                            nombrePersona = persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "") + " " + persona.getNombre_1();
                            documentoPersona = listaTipos.get(persona.getTipo_documento() + "") + " " + persona.getDocumento();
                            java.util.HashMap listaPagos = model.crearHashParametros(301);
                            Sede sede = model.consultarSede(Long.parseLong(request.getParameter("sede")));%>
                        <input name="persona" type="text" readonly="true" value="<%=datos_persona%>"  style="color:#333333; width:350px"/>
                    </span></td>
            </tr>
            <tr>
                <td width="5%"><span style="color:#000000"> <span class="Estilo11">
                            <label id="lpago"><strong><span class="Estilo24">PAGO</span></strong></label>
                        </span> </span></td>
                <td width="10%"><input name="pago" type="text"  style="text-align:center; color:#333333; width:100px" readonly="true" value="<%=request.getParameter("pago").length() > 0 ? listaPagos.get("" + Integer.parseInt(request.getParameter("pago"))) : ""%>"/></td>
                <td width="6%"><span style="color:#000000"> <span class="Estilo11">
                            <label id="lsede"><strong><span class="Estilo24">SEDE</span></strong></label>
                        </span> </span></td>
                <td width="79%"><input name="sede" type="text" readonly="true" value="<%=sede.getNombre().trim().length() > 30 ? sede.getNombre().substring(0, 30) : sede.getNombre()%>" style="text-align:center;color:#333333; width:160px"/></td>
            </tr>
            <tr>
                <td colspan="4" >
                    <table width="100%" border="1" cellpadding="1" cellspacing="0">
                        <tr class="title_">
                            <td width="12%" align="center" bgcolor="#CCCCCC"><span class="Estilo5 Estilo12 Estilo15"><span class="Estilo21">
                                        <label id="lcant"><strong>CANT.</strong></label>
                                    </span></span></td>
                            <td width="48%" align="center" bgcolor="#CCCCCC"><span class="Estilo5 Estilo12 Estilo15"><span class="Estilo21">
                                        <label id="lnomb"><strong>NOMBRE&nbsp;CONCEPTO</strong></label>
                                    </span></span></td>
                            <td width="20%" align="center" bgcolor="#CCCCCC"><span class="Estilo5 Estilo12 Estilo15"><span class="Estilo21">
                                        <label id="lrefe"><strong>REFERENCIA</strong></label>
                                    </span></span></td>
                            <td width="20%" align="center" bgcolor="#CCCCCC"><span class="Estilo5 Estilo12 Estilo15"><span class="Estilo21">
                                        <label id="lvalo"><strong>VALOR</strong></label>
                                    </span></span></td>
                        </tr>
                        <%  com.heinsohn.runt.general.solicitudes.LiquidacionOutDTO liquidacionOut = null;
                            float sumatoria = Float.parseFloat(request.getParameter("valor"));
                            float valor_total = 0;
                            int vigencia = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                            java.sql.Date actual = new java.sql.Date(new java.util.Date().getTime());
                            String stringfecha = new java.text.SimpleDateFormat("dd/MM/yyyy").format(actual);
                            if (session.getAttribute("listaLiquidacion") != null) {
                                java.util.List listaLiquidacion = (java.util.List) session.getAttribute("listaLiquidacion");
                                java.util.List no_repetibles = model.consultarConceptosbyAtributos(sede.getId_sede(), 2);
                                java.util.List existentes = new java.util.LinkedList();
                                if (listaLiquidacion.size() > 0) {
                                    //INICIO PROCESO DE INICIO DE LIQUIDACION RUNT
                                    try {
                                        boolean paso = true;
                                        Vehiculo vehiculo = null;
                                        if (request.getParameter("placa") != null) {
                                            vehiculo = model.consultarVehiculo(request.getParameter("placa").toUpperCase());
                                        }
                                        liqrunt = request.getParameter("liqrunt") != null ? request.getParameter("liqrunt").equals("1") : false;
                                        liqtransito = request.getParameter("liqtransito") != null ? request.getParameter("liqtransito").equals("1") : false;
                                        if (model.requiereLiquidacionRUNT(listaLiquidacion) && liqrunt &&false) {
                                            reciboRunt = true;
                                            LiquidacionServicesClient liquidacionService = new LiquidacionServicesClient();
                                            liquidacionService.setUser(modelo.Model.userHandler);
                                            liquidacionService.setTokenHuellaDigital(modelo.Model.userToken);
                                            String identificadorAT = "8634001";
                                            String nombreAT = "SABANAGRANDE - ATLANTICO(DPTAL)";
                                            String clasificacion = "";
                                            int claseV = 0;
                                            if (vehiculo != null) {
                                                claseV = (int) vehiculo.getClase_vehiculo();
                                            } else {
                                                if (session.getAttribute("claseV") != null) {
                                                    claseV = Integer.parseInt(session.getAttribute("claseV").toString());
                                                } else {
                                                    if (session.getAttribute("claseL") != null) {
                                                        claseV = Integer.parseInt(session.getAttribute("claseL").toString());
                                                        if (claseV > 2) {
                                                            claseV = 1;
                                                        } else {
                                                            claseV = 10;
                                                        }
                                                    } else {
                                                        claseV = 1;
                                                    }
                                                }
                                            }
                                            String resultClase = model.consultarParametroName(1, claseV);
                                            if (resultClase != null) {
                                                clasificacion = (resultClase.indexOf("MOTOCARRO") != -1) ? "MOTOCARRO" : (resultClase.indexOf("MOTO") != -1 ? "MOTO" : "AUTOMOVIL");
                                            }
                                            java.sql.Date fecha_liquidacion = new java.sql.Date(new java.util.Date().getTime());
                                            boolean generaPDF = true;
                                            String id_persona = null;
                                            String tipoDocumento = model.consultarParametro(persona.getTipo_documento(), 5).getNombreCorto();
                                            String numeroDocumento = persona.getDocumento();
                                            String numeroLiquidacion = "0001";
                                            String tipoLiquidacion = null;
                                            String multiLiquidacion = "N";
                                            double valorOT = 0;
                                            java.util.List<String[]> tramites = new java.util.LinkedList();
                                            try {
                                                for (int i = 0; i < listaLiquidacion.size(); i++) {
                                                    Liquidacion liquidat = (Liquidacion) listaLiquidacion.get(i);
                                                    if (liquidat.getTipo() == 2) {
                                                        //Revisar en el caso que no haya tipificacion para el organismos y tramite
                                                        int claseTipificacion = model.consultarClaseTipificacionRUNT(claseV);
                                                        tramites.add(model.consultarTramiteRUNT(liquidat.getId_liquidacion(), claseTipificacion));
                                                    }
                                                }
                                            } catch (Exception texc) {
                                                tramites = new java.util.LinkedList();
                                                texc.printStackTrace();
                                            }
                                            for (int i = 0; i < tramites.size(); i++) {
                                                String[] dupla = tramites.get(i);
                                            }
                                            int cantidadLiquidacion = 1;
                                            String placaLiquidacion = vehiculo != null ? vehiculo.getPlaca() : request.getParameter("placa").toUpperCase();
                                            if (usuario.getId_usuario() != 42) {
                                                liquidacionOut = liquidacionService.registrarLiquidacion(placaLiquidacion, identificadorAT, nombreAT, clasificacion, fecha_liquidacion, generaPDF, id_persona, tipoDocumento, numeroDocumento, numeroLiquidacion, tipoLiquidacion, valorOT, tramites, cantidadLiquidacion, multiLiquidacion);
                                                if (liquidacionOut != null) {
                                                    if (liquidacionOut.getStatus().getStatusCode().equals("1")) {
                                                        Liquidacion valorMT = new Liquidacion();
                                                        try {
                                                            java.io.File fileL = new java.io.File("C:\\Civitrans\\LiquidacionesRUNT\\" + liquidacionOut.getNumeroLiquidacion() + ".pdf");
                                                            java.io.FileOutputStream fos = new java.io.FileOutputStream(fileL.getAbsolutePath());
                                                            fos.write(liquidacionOut.getLiquidacionPDF());
                                                            fos.close();
                                                        } catch (Exception fxe) {
                                                        }
                                                        session.setAttribute("reporteRUNT", liquidacionOut.getLiquidacionPDF());
                                                        mensajeRunt = "RUNT: " + liquidacionOut.getStatus().getStatusDesc();
                                                        adicionarRunt = true;
                                                    } else {
                                                        mensajeRunt = "RUNT: " + liquidacionOut.getStatus().getStatusDesc();
                                                        paso = false;
                                                    }
                                                } else {
                                                    mensajeRunt = "RUNT: Intente nuevamente";
                                                    paso = false;
                                                }
                                            } else {
                                                for (int nr = 0; nr < 10; nr++) {
                                                    liquidacionOut = liquidacionService.registrarLiquidacion(placaLiquidacion, identificadorAT, nombreAT, clasificacion, fecha_liquidacion, generaPDF, id_persona, tipoDocumento, numeroDocumento, numeroLiquidacion, tipoLiquidacion, valorOT, tramites, cantidadLiquidacion, multiLiquidacion);
                                                    if (liquidacionOut != null) {
                                                        if (liquidacionOut.getStatus().getStatusCode().equals("1")) {
                                                            Liquidacion valorMT = new Liquidacion();
                                                            try {
                                                                java.io.File fileL = new java.io.File("C:\\Civitrans\\LiquidacionesRUNT2\\" + liquidacionOut.getNumeroLiquidacion() + "-" + nr + ".pdf");
                                                                java.io.FileOutputStream fos = new java.io.FileOutputStream(fileL.getAbsolutePath());
                                                                fos.write(liquidacionOut.getLiquidacionPDF());
                                                                fos.close();
                                                            } catch (Exception fxe) {
                                                            }
                                                            session.setAttribute("reporteRUNT", liquidacionOut.getLiquidacionPDF());
                                                            mensajeRunt = "RUNT: " + liquidacionOut.getStatus().getStatusDesc();
                                                            adicionarRunt = true;
                                                        } else {
                                                            mensajeRunt = "RUNT: " + liquidacionOut.getStatus().getStatusDesc();
                                                            paso = false;
                                                        }
                                                    } else {
                                                        mensajeRunt = "RUNT: Intente nuevamente";
                                                        paso = false;
                                                    }
                                                }
                                            }
                                        }
                                        //FIN PROCESO DE LIQUIDACION RUNT
                                        if (paso && liqtransito) {
                                            if (Integer.parseInt(request.getParameter("pago")) != 7) {
                                                Tiquete tiquete = new Tiquete();
                                                tiquete.setEstado(1);
                                                tiquete.setFecha(actual);
                                                tiquete.setFecha_proceso(new java.sql.Timestamp(new java.util.Date().getTime()));
                                                tiquete.setFk_persona(persona.getId_persona());
                                                if (vehiculo != null) {
                                                    tiquete.setFk_vehiculo(vehiculo.getId_vehiculo());
                                                } else {
                                                    tiquete.setDescripcion(request.getParameter("placa").toUpperCase());
                                                }
                                                tiquete.setTipo_pago(Integer.parseInt(request.getParameter("pago")));
                                                if (tiquete.getTipo_pago() != 1) {
                                                    tiquete.setReferencia(request.getParameter("referencia"));

                                                    if (request.getParameter("fecha") != null && !request.getParameter("fecha").trim().equals("")) {
                                                        tiquete.setFecha_referencia(new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha")).getTime()));
                                                    }
                                                    if (request.getParameter("banco") != null) {
                                                        tiquete.setFk_banco(Long.parseLong(request.getParameter("banco").toString()));
                                                    }
                                                }
                                                model.getCon().setAutoCommit(false);
                                                int factura = model.consultarConsecutivo(sede.getId_sede(), 1, vigencia);
                                                String consecutivo = "C" + ("000000".substring(0, 6 - (factura + "").length())) + factura;
                                                model.actualizarConsecutivo(sede.getId_sede(), 1, vigencia);
                                                tiquete.setNumero_factura(consecutivo);
                                                Taquilla taquilla = model.consultar_Taquilla_Actual(usuario.getFk_sede(), usuario.getId_usuario());
                                                tiquete.setFk_taquilla(taquilla.getId_taquilla());
                                                tiquete.setFk_usuario(usuario.getId_usuario());
                                                tiquete.setValor_total(sumatoria);
                                                int security = ((int) (Math.random() * 100000));
                                                tiquete.setValor_total_descuento(security);
                                                tiquete.setValor_total_iva(sumatoria);
                                                tiquete.setId_tiquete(model.adicionarTiquete(tiquete));
                                                Pago pago = new Pago();
                                                pago.setFecha(tiquete.getFecha());
                                                pago.setFk_sede(sede.getId_sede());
                                                pago.setFk_taquilla(tiquete.getFk_taquilla());
                                                pago.setFk_tiquete(tiquete.getId_tiquete());
                                                pago.setNumero_factura(consecutivo);
                                                pago.setTipo_pago(tiquete.getTipo_pago());
                                                pago.setFk_usuario(tiquete.getFk_usuario());
                                                pago.setFk_persona(tiquete.getFk_persona());
                                                if (tiquete.getFk_vehiculo() != 0) {
                                                    pago.setFk_vehiculo(tiquete.getFk_vehiculo());
                                                }
                                                if (tiquete.getTipo_pago() != 1) {
                                                    pago.setNumero_tipo_pago(request.getParameter("referencia"));
                                                    if (request.getParameter("fecha") != null && !request.getParameter("fecha").trim().equals("")) {
                                                        pago.setFecha_tipo_pago(new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha")).getTime()));
                                                    }
                                                    if (request.getParameter("banco") != null) {
                                                        pago.setFk_banco(Long.parseLong(request.getParameter("banco").toString()));
                                                    }
                                                }
                                                pago.setValor_descuento(tiquete.getValor_total_descuento());
                                                pago.setValor_iva(tiquete.getValor_total_iva());
                                                pago.setValor_total(tiquete.getValor_total());
                                                pago.setEstado(4);
                                                pago.setObservacion("");
                                                long idPago = model.adicionarPago(pago);
                                                for (int i = 0; i < listaLiquidacion.size(); i++) {
                                                    Liquidacion liquidacion = (Liquidacion) listaLiquidacion.get(i);
                                                    if (liquidacion.getTipo() == 2 || liquidacion.getTipo() == 3) {
                                                        if (sumatoria >= liquidacion.getTotal()) {
                                                            sumatoria = sumatoria - liquidacion.getTotal();
                                                            Detalle_Tiquete dt = new Detalle_Tiquete();
                                                            dt.setCantidad(liquidacion.getCantidad());
                                                            dt.setFk_tiquete(tiquete.getId_tiquete());
                                                            dt.setValor_descuento(liquidacion.getTotal());
                                                            dt.setValor_iva(liquidacion.getTotal());
                                                            dt.setValor_total(liquidacion.getTotal());
                                                            dt.setValor_unitario(liquidacion.getValor());
                                                            dt.setEstado(1);
                                                            String nombre = "";
                                                            String referency = "";

                                                            valor_total += liquidacion.getTotal();
                                                            if (liquidacion.getTipo() == 2) {
                                                                Tramite tramite = model.consultarTramite(liquidacion.getFk_concepto());
                                                                dt.setFk_tramite(liquidacion.getId_liquidacion());
                                                                nombre = tramite.getNombre();
                                                                long idDetTiquete = model.adicionarDetalleTiquete(dt);
                                                                int month = java.util.Calendar.getInstance().get(java.util.Calendar.MONTH);
                                                                java.util.StringTokenizer div = new java.util.StringTokenizer(liquidacion.getReferencia(), "-");
                                                                long lsede = Long.parseLong(div.nextToken());
                                                                int lvalor1 = Integer.parseInt(div.nextToken());
                                                                int lvalor2 = Integer.parseInt(div.nextToken());
                                                                java.util.List detalleT = model.consultarDetalleTramite(lsede, (int) dt.getFk_tramite(), lvalor1, lvalor2);
                                                                java.util.List auxExistentes = new java.util.LinkedList();
                                                                
                                                                for (int sec = 1; sec <= liquidacion.getCantidad(); sec++) {
                                                                    auxExistentes = existentes.subList(0, existentes.size());
                                                                    float sumaTramite = 0;
                                                                    for (int ldt = 0; ldt < detalleT.size(); ldt++) {
                                                                        Valor lvalor = (Valor) detalleT.get(ldt);
                                                                        float valorc = lvalor.getValor();
                                                                        Concepto lconcepto = model.consultarConcepto(lvalor.getFk_concepto());
                                                                        if (!(no_repetibles.contains(lconcepto.getId_concepto()) && auxExistentes.contains(lconcepto.getId_concepto()))) {
                                                                            if (lconcepto.getTipo() == 2 && lconcepto.getClase() == 2) {
                                                                                float valorc2 = (float) (valorc - ((valorc / 12.0) * (12 - month)));
                                                                                valorc = valorc - Math.round(valorc2);
                                                                            }
                                                                            sumaTramite += valorc;
                                                                            Tiquete_Concepto tiqueteConcepto = new Tiquete_Concepto();
                                                                            tiqueteConcepto.setFk_detalleTiquete(idDetTiquete);
                                                                            tiqueteConcepto.setFk_concepto(lvalor.getFk_concepto());
                                                                            tiqueteConcepto.setValor(valorc);
                                                                            tiqueteConcepto.setEstado(1);
                                                                            tiqueteConcepto.setSecuencia(sec);
                                                                            model.adicionarTiqueteConcepto(tiqueteConcepto);
                                                                            auxExistentes.add(lconcepto.getId_concepto());
                                                                        } else {
                                                                            auxExistentes.add(lconcepto.getId_concepto());
                                                                        }
                                                                    }
                                                                }
                                                                existentes = auxExistentes.subList(0, auxExistentes.size());
                                                            } else {
                                                                dt.setFk_concepto(liquidacion.getFk_concepto());
                                                                Concepto concepto = model.consultarConcepto(liquidacion.getFk_concepto());
                                                                nombre = concepto.getNombre();
                                                                long idDetTiquete = model.adicionarDetalleTiquete(dt);
                                                                referency = liquidacion.getReferencia();
                                                                for (int sec = 1; sec <= liquidacion.getCantidad(); sec++) {
                                                                    Tiquete_Concepto tiqueteConcepto = new Tiquete_Concepto();
                                                                    tiqueteConcepto.setFk_detalleTiquete(idDetTiquete);
                                                                    tiqueteConcepto.setFk_concepto(dt.getFk_concepto());
                                                                    tiqueteConcepto.setValor(liquidacion.getValor());
                                                                    tiqueteConcepto.setEstado(1);
                                                                    tiqueteConcepto.setSecuencia(sec);
                                                                    model.adicionarTiqueteConcepto(tiqueteConcepto);
                                                                }
                                                            }

                        %>
                        <tr>
                            <td align="center"><span class="Estilo25"><%=liquidacion.getCantidad()%></span></td>
                            <td><span class="Estilo25"><%=nombre%></span></td>
                            <td align="center"><span class="Estilo25"><%=referency%></span></td>
                            <td align="right"><span class="Estilo25">$&nbsp;<%=liquidacion.getTotal()%></span></td>
                        </tr>
                        <%
                                    }
                                }
                            }
                            for (int i = 0; i < listaLiquidacion.size(); i++) {
                                Liquidacion liquidacion = (Liquidacion) listaLiquidacion.get(i);
                                if (liquidacion.getTipo() == 1) {
                                    Cartera cartera = model.consultarCartera(liquidacion.getId_liquidacion());
                                    Detalle_Tiquete dt = new Detalle_Tiquete();
                                    dt.setCantidad(liquidacion.getCantidad());
                                    dt.setFk_cartera(liquidacion.getId_liquidacion());
                                    dt.setFk_tiquete(tiquete.getId_tiquete());
                                    Concepto concepto = model.consultarConcepto(liquidacion.getFk_concepto());
                                    String nombre = concepto.getNombre();
                                    String referency = liquidacion.getReferencia();
                                    java.sql.Date fechaMod = cartera.getFecha_saldo();
                            
                                    if (sumatoria >= liquidacion.getTotal()) {
                                        valor_total += liquidacion.getTotal();
                                        dt.setValor_descuento(liquidacion.getTotal());
                                        dt.setValor_iva(liquidacion.getTotal());
                                        dt.setValor_total(liquidacion.getTotal());
                                        dt.setValor_unitario(liquidacion.getTotal());
                                        dt.setEstado(1);
                                        long idDetTiquete = model.adicionarDetalleTiquete(dt);
                                        sumatoria = sumatoria - liquidacion.getTotal();
                                        
                                        Tiquete_Concepto tiqueteConcepto = new Tiquete_Concepto();
                                        tiqueteConcepto.setFk_detalleTiquete(idDetTiquete);
                                        tiqueteConcepto.setFk_concepto(liquidacion.getFk_concepto());
                                        tiqueteConcepto.setValor(liquidacion.getTotal());
                                        tiqueteConcepto.setEstado(1);
                                        tiqueteConcepto.setSecuencia(1);
                                        model.adicionarTiqueteConcepto(tiqueteConcepto);
                        %>
                        <tr>
                            <td align="center"><span class="Estilo25"><%=liquidacion.getCantidad()%></span></td>
                            <td><span class="Estilo25"><%=nombre%></span></td>
                            <td align="center"><span class="Estilo25"><%=referency%></span></td>
                            <td align="right"><span class="Estilo25">$&nbsp;<%=liquidacion.getTotal()%></span></td>
                        </tr>
                        <%
                        } else {
                            if (sumatoria > 0) {
                                dt.setEstado(1);
                                dt.setValor_descuento(sumatoria);
                                dt.setValor_iva(sumatoria);
                                dt.setValor_total(sumatoria);
                                dt.setValor_unitario(sumatoria);
                                long idDetTiquete = model.adicionarDetalleTiquete(dt);
                                
                                java.util.List lista_dc = model.listarDetalleCartera(liquidacion.getId_liquidacion());
                                float acumulado = 0;
                                for (int j = 0; j < lista_dc.size(); j++) {
                                    Detalle_Cartera dc = (Detalle_Cartera) lista_dc.get(j);

                                    if (sumatoria >= dc.getValor()) {
                                        sumatoria = sumatoria - dc.getValor();
                                        acumulado = acumulado + dc.getValor();
                                        valor_total += dc.getValor();
                                        Tiquete_Concepto tiqueteConcepto = new Tiquete_Concepto();
                                        tiqueteConcepto.setFk_detalleTiquete(idDetTiquete);
                                        tiqueteConcepto.setFk_concepto(dc.getFk_concepto());
                                        tiqueteConcepto.setValor(dc.getValor());
                                        tiqueteConcepto.setEstado(1);
                                        tiqueteConcepto.setSecuencia(j+1);

                                    } else {
                                        if (sumatoria > 0) {
                                            acumulado = acumulado + sumatoria;
                                            valor_total += sumatoria;
                                            
                                            Tiquete_Concepto tiqueteConcepto = new Tiquete_Concepto();
                                            tiqueteConcepto.setFk_detalleTiquete(idDetTiquete);
                                            tiqueteConcepto.setFk_concepto(dc.getFk_concepto());
                                            tiqueteConcepto.setValor(sumatoria);
                                            tiqueteConcepto.setEstado(1);
                                            tiqueteConcepto.setSecuencia(j+1);
                                            
                                            sumatoria = 0;
                                            
                                        }
                                    }
                                }
                                %>
                        <tr>
                            <td align="center"><span class="Estilo25"><%=liquidacion.getCantidad()%></span></td>
                            <td><span class="Estilo25"><%=nombre%></span></td>
                            <td align="center"><span class="Estilo25"><%=referency%></span></td>
                            <td align="right"><span class="Estilo25">$&nbsp;<%=acumulado%></span></td>
                        </tr>
                        <%
                                        }
                                    }
                                }
                            }
                            if (sumatoria > 0) {
                                Detalle_Tiquete dt = new Detalle_Tiquete();
                                dt.setCantidad(1);
                                dt.setFk_tiquete(tiquete.getId_tiquete());
                                dt.setValor_descuento(sumatoria);
                                dt.setValor_iva(sumatoria);
                                dt.setValor_total(sumatoria);
                                dt.setValor_unitario(sumatoria);
                                dt.setEstado(1);
                                dt.setFk_concepto(281);
                                long idDetTiquete = model.adicionarDetalleTiquete(dt);
                                Tiquete_Concepto tiqueteConcepto = new Tiquete_Concepto();
                                tiqueteConcepto.setFk_detalleTiquete(idDetTiquete);
                                tiqueteConcepto.setFk_concepto(dt.getFk_concepto());
                                tiqueteConcepto.setValor(dt.getValor_total());
                                tiqueteConcepto.setEstado(1);
                                tiqueteConcepto.setSecuencia(1);
                                model.adicionarTiqueteConcepto(tiqueteConcepto);

                            }
                            model.getCon().commit();
                            java.util.HashMap parameters = new java.util.HashMap();
                            parameters.put("TIQUETE", tiquete.getId_tiquete());
                            parameters.put("NUMERO", tiquete.getNumero_factura());
                            parameters.put("FECHA", new java.text.SimpleDateFormat("dd/MM/yyyy").format(tiquete.getFecha()));
                            parameters.put("NOMBRE", nombrePersona);
                            parameters.put("NRO_DOC", documentoPersona);
                            Persona personaUsuario = model.consultarPersona(usuario.getFk_persona());
                            String nombreU = personaUsuario.getNombre_1() + " " + personaUsuario.getApellido_1() + " " + (personaUsuario.getApellido_2() != null ? personaUsuario.getApellido_2() : "");
                            parameters.put("USUARIO", nombreU);
                            parameters.put("SEGURIDAD", security + " Impresion ");
                            parameters.put("PLACA", request.getParameter("placa") != null ? request.getParameter("placa").toUpperCase() : "");
                            parameters.put("VALOR", tiquete.getValor_total());
                            String dir = application.getRealPath("paginas/reports/recaudoycartera/pagos/multipleTiquetePagoReport.jasper");
                            parameters.put("SUBREPORT_DIR", dir.substring(0, dir.indexOf("reports") + 8));
                            session.setAttribute("reporteOT", parameters);
                            aplicacionRunt2 = true;%>
                        <script language="javascript" type="text/javascript">activar();</script> <%
                        } else {
                            java.sql.Date fechaR = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha")).getTime());
                            boolean accesoNC = false;
                            if (request.getParameter("scnc") != null) {
                                String securityCode = Encrypt.getSecurityCode(new java.util.Date());
                                int intentos = model.verParametroConfiguracion(2) + 1;
                                if (intentos < 4) {
                                    if (securityCode.equals(request.getParameter("scnc"))) {
                                        accesoNC = true;
                                    } else {
                                        if (3 - intentos == 0) {
                                            mensajeRunt = "El numero de intentos ha sido superado, proceso ha sido bloqueado";
                                        } else {
                                            mensajeRunt = "Codigo de seguridad invalido, le restan " + (3 - intentos) + " intentos.";
                                        }
                                        model.actualizarParametroConfiguracion(2, intentos);
                                    }
                                } else {
                                    mensajeRunt = "El numero de intentos ha sido superado, proceso ha sido bloqueado";
                                }
                            }
                            if (vehiculo != null && accesoNC) {
                                model.getCon().setAutoCommit(false);
                                procesos.aplicarNotasCredito notaCredito = new procesos.aplicarNotasCredito(model, usuario, vehiculo.getId_vehiculo(), fechaR, persona.getId_persona(), request.getParameter("referencia"), Float.parseFloat(request.getParameter("valor")));
                                if (notaCredito.getResultado() == 1) {
                                    model.getCon().commit();
                                    valor_total = Float.parseFloat(request.getParameter("valor"));%>
                        <script language="javascript" type="text/javascript">
                            activar();
                        </script> <%
                                    } else {
                                        mensajeRunt = "Error al aplicar la nota credito";
                                        model.getCon().rollback();
                                    }
                                }
                            }
                        } else {
                            if (adicionarRunt) {
                        %>
                        <script language="javascript" type="text/javascript">activar();</script> <%
                                                String placaLrunt = request.getParameter("placa") != null ? request.getParameter("placa").toUpperCase() : "";
                                                for (int i = 0; i < listaLiquidacion.size(); i++) {
                                                    Liquidacion liquidat = (Liquidacion) listaLiquidacion.get(i);
                                                    if (liquidat.getTipo() == 2) {
                                                        model.registrarLiquidacionRUNT(liquidacionOut, 0, placaLrunt, persona.getId_persona(), 1, liquidat.getId_liquidacion(), usuario.getId_usuario());
                                                    }
                                                }
//                              model.getCon().commit();
                                            }
                                        }
                                    } catch (Exception exc) {
                                        mensajeRunt = "NEOTRANS: " + exc.getMessage();
                                        exc.printStackTrace();
                                        try {
                                            model.getCon().rollback();
                                        } catch (Exception exc2) {
                                            mensajeRunt = "NEOTRANS: No hay conexion de BBDD";
                                            exc2.printStackTrace();
                                        }
                                    }
                                }
                            }
                            if (adicionarRunt) {
                                valor_total += liquidacionOut.getValorTotal();%>
                        <tr>
                            <td align="center"><span class="Estilo25">1</span></td>
                            <td><span class="Estilo25">CONCEPTO RUNT</span></td>
                            <td align="center"><span class="Estilo25">&nbsp;</span></td>
                            <td align="right"><span class="Estilo25">$&nbsp;<%=liquidacionOut.getValorRUNT()%></span></td>
                        </tr>
                        <tr>
                            <td align="center"><span class="Estilo25">1</span></td>
                            <td><span class="Estilo25">CONCEPTO MINTRANSPORTE</span></td>
                            <td align="center"><span class="Estilo25">&nbsp;</span></td>
                            <td align="right"><span class="Estilo25">$&nbsp;<%=liquidacionOut.getValorMT()%></span></td>
                        </tr>
                        <% }%>
                        <tr bgcolor="#FFFFFF" >
                            <td colspan="2">&nbsp;</td>
                            <td align="center"><span class="Estilo10">TOTAL:</span></td>
                            <td align="right"><span class="Estilo22">$&nbsp;<%=valor_total%></span></td>
                        </tr>
                        <% if (adicionarRunt) {
                                if (liqtransito && liqrunt) {%>
                        <tr style="border:none">
                            <td colspan="2" align="center" style="border:none"><input type="button" name="imprimirOT" value="Imprimir Recibo OT" onclick="imprimir(1)"/></td>
                            <td colspan="2" align="center" style="border:none"><input type="button" name="imprimirRUNT" value="Imprimir Recibo RUNT" onclick="imprimir(2)"/></td>
                        </tr>
                        <%      } else {
                            if (liqrunt) {%>
                        <tr style="border:none">
                            <td colspan="4" align="center" style="border:none"><input type="button" name="imprimirRUNT" value="Imprimir Recibo RUNT" onclick="imprimir(2)"/></td>
                        </tr>
                        <%          } else {%>
                        <tr style="border:none">
                            <td colspan="4" align="center" style="border:none"><input type="button" name="imprimirOT" value="Imprimir Recibo OT" onclick="imprimir(1)"/></td>
                        </tr>
                        <%          }
                            }
                        } else {
                            if (!request.getParameter("pago").equals("7")) {%>
                        <tr style="border:none">
                            <td colspan="4" align="center" style="border:none"><input type="button" name="imprimirOT" value="Imprimir Recibo OT" onclick="imprimir(1)"/></td>
                        </tr>
                        <%  }
                            }%>
                    </table></td>
            </tr>
        </table>
        <%  }
                }
            } catch (Exception exc) {
                mensajeRunt = "NEOTRANS: " + exc.getMessage();
                exc.printStackTrace();
                try {
//            model.getCon().rollback();
                } catch (Exception exc2) {
                    mensajeRunt = "NEOTRANS: No hay conexion de BBDD";
                    exc2.printStackTrace();
                }
            }
            if (mensajeRunt.length() > 0) {%>
        <script language='javascript' type='text/javascript'>
            window.parent.document.getElementById('aplicar').style.display = 'block';
            window.parent.document.getElementById('limpiar').style.display = 'block';
            alert('<%=mensajeRunt%>');
        </script>
        <%   }%>
    </body>
</html>
<%  } else {%>
<script>window.parent.document.location.href = "../../index.jsp";</script>
<%  }
} else {%>
<script>window.parent.document.location.href = "../../index.jsp";</script>
<% }
} catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% }%>