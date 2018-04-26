<%@page import="java.util.List"%>
<%@page import="com.heinsohn.runt.general.solicitudes.LiquidacionOutDTO"%>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="webservices.liquidacion.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    try {
        if (session.getAttribute("usuario") != null) {
            modelo.Model model = (modelo.Model) session.getAttribute("model");
            int swMsgx = 0;
            if (model != null) {
                modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
                UsuarioRunt userRunt = model.consultarUsuarioRunt(usuario.getId_usuario());
                int vigencia = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                String fec, hora, Gtm;
                Gtm = "";
                fec = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date()).toString();
                String tikec = "";
                int min;
                int hour;
                Persona usu = model.consultarPersona(usuario.getFk_persona());
                hour = (java.util.Calendar.getInstance().get(java.util.Calendar.HOUR_OF_DAY));
                min = (java.util.Calendar.getInstance().get(java.util.Calendar.MINUTE));

                if (hour >= 12) {
                    if (hour != 12) {
                        hour -= 12;
                    }
                    Gtm = "P.m";
                } else {
                    Gtm = "A.m";
                }

                String per = usu.getNombre_1() + " " + usu.getApellido_1();
                if (min <= 9) {
                    hora = hour + ":0" + min + " " + Gtm;
                } else {
                    hora = hour + ":" + min + " " + Gtm;
                }
                int factura = 0;
                String consecutivo = "";
                System.out.println("fecha: fact " + fec);
                // Sede sede = model.consultarSede(234);

                Sede sede = model.consultarSede(Long.parseLong(request.getParameter("sede")));
                System.out.println("---------");
                if (!request.getParameter("liqrunt").equals("1")) {
                    //  System.out.println("----------------------");
                    factura = model.consultarConsecutivo(sede.getId_sede(), 1, vigencia);

                    consecutivo = "C" + ("000000".substring(0, 6 - (factura + "").length())) + factura;
                    //   System.out.println("---------**************************");
                    tikec = consecutivo;
                    //       System.out.println("entro en si ");
                } else {
                    System.out.println("entro en sino ");
                }
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Documento sin t&iacute;tulo</title>
        <style type="text/css">
            <!--
            .Estilo5 {font-size: 12px; color: #FFFFFF; }
            .Estilo9 {color: #0066CC}
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
                color: #0066CC;
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
            function imprimir(id) {
                ancho = 789;
                alto = 500;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                url = "impresion_recibo.jsp?id=" + id;
                window.open(url, 'popUp', opciones);
            }
            function activar() {
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

            /*var f = new Date();
             //document.write(f.getDate() + "/" + (f.getMonth() +1) + "/" + f.getFullYear());
             if(f.getMonth()+1<=9){
             document.form.fecha1.value=f.getDate() + "/0" + (f.getMonth() +1) + "/" + f.getFullYear();
             }else{
             document.form.fecha1.value=f.getDate() + "/" + (f.getMonth() +1) + "/" + f.getFullYear();
             }*/

            function Codigo() {
                ancho = 789;
                alto = 500;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                url = "ImprimirCodigo.jsp";
                window.open(url, 'popUp', opciones);
            }

        </script>
    </head>

    <body>
        <%
            int gh = 1;
            System.out.println("*********");
            String mensajeRunt = "";
            boolean aplicacionRunt2 = false;
            boolean adicionarRunt = false;
            boolean reciboRunt = false;
            boolean liqrunt = false;
            boolean liqtransito = false;
//            try {
            String datos_persona = "";
            String nombrePersona = "";
            String documentoPersona = "";
            if (request.getParameter("persona") != null) {
                Persona persona = model.consultarPersona(Long.parseLong(request.getParameter("persona")));
                java.util.HashMap listaTipos = model.crearHashParametrosAbreviatura(5);

                if (persona != null) {%>
        <input type="hidden" id="fecha1" name="fecha1"/>
        <input type="hidden" value="<%=usu.getNombre_1()%> <%=usu.getApellido_1()%>" id="usu" name="usu"/>
        <input type="hidden" value="<%=consecutivo%>" id="con" name="con"/>
        <table width="100%" border="0" id="tabla_general" name="tabla_general" style="display:block">


            <tr style="border:none">
                <th colspan="4" scope="col" style="border:none"><span class="Estilo23"><span class="Estilo12"> <span class="Estilo13 Estilo14">
                                <label id="ltipo"><strong>RESUMEN LIQUIDACION</strong></label>
                            </span> </span></span></th>
            </tr>
            <tr>
                <th colspan="4"><span class="Estilo9"></span></th>

            </tr>
            <%
                if (!tikec.equals("")) {
            %>
            <tr>
                <td colspan="4" align="center"><strong><font color="#FF0000">PRELIQUIDACION</font></strong></td>
            </tr>
            <tr>
                <td colspan="4" align="center" style="font-size:24px"><font color="#FF0000"><%=tikec%></font></td>  </tr>
            <tr>
                <td colspan="4" align="center" style="font-size:24px"><input type="button" value="Imprimir Codigo" onclick="Codigo()"  /></td>


            </tr>
            <%}%>
            <tr>
                <td width="11%"><span style="color: #0066CC"> <span class="Estilo11">
                            <label id="lfecha"><strong><span class="Estilo24">FECHA</span></strong></label>
                        </span> </span></td>
                <td width="20%"><input name="fecha" type="text" readonly="true" style="text-align:center;color:#333333; width:100px" value="<%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date())%>"/></td>
                <td width="19%"><span style="color: #0066CC"> <span class="Estilo11">
                            <label id="lplaca"><strong><span class="Estilo24">VEHICULO</span></strong></label>
                        </span> </span></td>
                <td width="50%" colspan="3"><input name="placa" type="text" style="text-align:center; color:#333333; width:120px" readonly="true" value="<%=request.getParameter("placa")%>"/></td>
            </tr>
            <tr>
                <td width="11%"><span style="color: #0066CC"> <span class="Estilo11">
                            <span class="Estilo9"> <span class="Estilo14"> <span class="Estilo12">
                                        <label id="lpersona"><strong>CLIENTE </strong></label>
                                    </span> </span></span> </span> </span></td>
                <td colspan="87"><span class="Estilo9">
                        <%    datos_persona = listaTipos.get(persona.getTipo_documento() + "") + " " + persona.getDocumento() + " - " + persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "") + " " + persona.getNombre_1();
                            nombrePersona = persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "") + " " + persona.getNombre_1();
                            documentoPersona = listaTipos.get(persona.getTipo_documento() + "") + " " + persona.getDocumento();
                            java.util.HashMap listaPagos = model.crearHashParametros(301);
                            //Sede sede = model.consultarSede(Long.parseLong(request.getParameter("sede")));%>
                        <input name="persona" type="text" readonly="true" value="<%=datos_persona%>"  style="color:#333333; width:350px"/>
                    </span></td>
            </tr>
            <tr>
                <td width="11%"><span style="color: #0066CC"> <span class="Estilo11">
                            <label id="lpago"><strong><span class="Estilo24">PAGO</span></strong></label>
                        </span> </span></td>
                <td width="20%"><input name="pago" type="text"  style="text-align:center; color:#333333; width:100px" readonly="true" value="<%=request.getParameter("pago").length() > 0 ? listaPagos.get("" + Integer.parseInt(request.getParameter("pago"))) : ""%>"/></td>
                <td width="19%"><span style="color: #0066CC"> <span class="Estilo11">
                            <label id="lsede"><strong><span class="Estilo24">SEDE</span></strong></label>
                        </span> </span></td>
                <td width="50%"><input name="sede" type="text" readonly="true" value="<%=sede.getNombre().trim().length() > 30 ? sede.getNombre().substring(0, 30) : sede.getNombre()%>" style="text-align:center;color:#333333; width:160px"/></td>
            </tr>

            <tr>
                <td colspan="4" >
                    <table width="100%" border="1" cellpadding="1" cellspacing="0">
                        <tr style="border:none; background:url(../html/images/inicio_3.png)">
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
                        <%
                            com.heinsohn.runt.general.solicitudes.LiquidacionOutDTO liquidacionOut = null;
                            com.heinsohn.runt.general.solicitudes.LiquidacionProcesoTransversalOutDTO liquidacionProcesoTransOut = new com.heinsohn.runt.general.solicitudes.LiquidacionProcesoTransversalOutDTO();
                            int idTramite = 0;
                            boolean proceTr = false;
                            float sumatoria = Float.parseFloat(request.getParameter("valor"));
                            float valor_total = 0;
                            java.sql.Date actual = new java.sql.Date(new java.util.Date().getTime());
                            String stringfecha = new java.text.SimpleDateFormat("dd/MM/yyyy").format(actual);
                            if (session.getAttribute("listaLiquidacion") != null) {
                                java.util.List listaLiquidacion = (java.util.List) session.getAttribute("listaLiquidacion");
                                java.util.List no_repetibles = model.consultarConceptosbyAtributos(sede.getId_sede(), 2);
                                java.util.List existentes = new java.util.LinkedList();
                                if (listaLiquidacion.size() > 0) {
                                    //INICIO PROCESO DE INICIO DE LIQUIDACION RUNT
//                                    try {
                                    boolean paso = true;
                                    Vehiculo vehiculo = null;
                                    if (request.getParameter("placa") != null) {
                                        vehiculo = model.consultarVehiculo(request.getParameter("placa").toUpperCase());
                                    }
                                    liqrunt = request.getParameter("liqrunt") != null ? request.getParameter("liqrunt").equals("1") : false;
                                    liqtransito = request.getParameter("liqtransito") != null ? request.getParameter("liqtransito").equals("1") : false;
                                    if (model.requiereLiquidacionRUNT(listaLiquidacion) && liqrunt) {
                                        LiquidacionServicesClient liquidacionService = new LiquidacionServicesClient();
                                        liquidacionService.setTokenHuellaDigital("");
                                        liquidacionService.setUser(userRunt.getCodigo());
                                        Model.userHandler = userRunt.getCodigo();
                                        Model.passUserHandler = userRunt.getPassword();

                                        if (session.getAttribute("token2") != null) {

                                            reciboRunt = true;
                                            liquidacionService.setTokenHuellaDigital(session.getAttribute("token2").toString());

                                            String identificadorAT = "8634001";
                                            String nombreAT = "SABANAGRANDE - ATLANTICO(DPTAL)";
                                            String clasificacion = "";
                                            int claseV = 0;
                                            if (vehiculo != null) {
                                                claseV = (int) vehiculo.getClase_vehiculo();
                                            } else if (session.getAttribute("claseV") != null) {
                                                claseV = Integer.parseInt(session.getAttribute("claseV").toString());
                                            } else if (session.getAttribute("claseL") != null) {
                                                claseV = Integer.parseInt(session.getAttribute("claseL").toString());
                                                if (claseV > 2) {
                                                    claseV = 1;
                                                } else {
                                                    claseV = 10;
                                                }
                                            } else {
                                                claseV = 1;
                                            }
                                            System.out.println("Clase Vehiculo: " + claseV);
                                            clasificacion = model.consultarParametroCodigo(claseV);
                                            java.sql.Date fecha_liquidacion = new java.sql.Date(new java.util.Date().getTime());
                                            boolean generaPDF = true;
                                            String id_persona = null;
                                            String tipoDocumento = model.consultarParametro(persona.getTipo_documento(), 5).getNombreCorto();
                                            String numeroDocumento = persona.getDocumento();
                                            String numeroLiquidacion = "0001";
                                            String tipoLiquidacion = null;
                                            String multiLiquidacion = "N";

                                            System.out.println("ok factura");
                                            double valorOT = 0;
                                            java.util.List<String[]> tramites = new java.util.LinkedList();
                                            try {
                                                for (int i = 0; i < listaLiquidacion.size(); i++) {
                                                    Liquidacion liquidat = (Liquidacion) listaLiquidacion.get(i);
                                                    if (liquidat.getTipo() == 2) {
                                                        //Revisar en el caso que no haya tipificacion para el organismos y tramite
                                                        int claseTipificacion = model.consultarClaseTipificacionRUNT(claseV);
                                                        tramites.add(model.consultarTramiteRUNT(liquidat.getId_liquidacion(), claseTipificacion));
                                                        if (liquidat.getId_liquidacion() == 121 || liquidat.getId_liquidacion() == 122) {
                                                            idTramite = (int) liquidat.getId_liquidacion();
                                                            proceTr = true;
                                                            break;
                                                        }
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
                                                if (!proceTr) {
                                                    liquidacionOut = liquidacionService.registrarLiquidacion(placaLiquidacion, identificadorAT, nombreAT, clasificacion, fecha_liquidacion, generaPDF, id_persona, tipoDocumento, numeroDocumento, numeroLiquidacion, tipoLiquidacion, valorOT, tramites, cantidadLiquidacion, multiLiquidacion, userRunt.getCodigo(), userRunt.getPassword());
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
                                                            System.out.println("Error aca");
                                                            paso = false;
                                                        }
                                                    } else {
                                                        mensajeRunt = "Error en el Servicio o Token Vencido, Por favor Vuelva Autenticarse";
                                                        swMsgx = 1;
                                                        paso = false;
                                                    }
                                                } else {
                                                    String tipoConcepto = "";
                                                    System.out.print("Tramite :" + idTramite);
                                                    System.out.print("Tipo documento :" + tipoDocumento);
                                                    if (idTramite == 121) {
                                                        tipoConcepto = tipoDocumento.equals("N") ? "3" : "1";
                                                    } else if (idTramite == 122) {
                                                        tipoConcepto = tipoDocumento.equals("N") ? "4" : "2";
                                                    }
                                                    int cantidad = 1;
                                                    liquidacionProcesoTransOut = liquidacionService.registrarLiquidacionProcesoTransversal(identificadorAT, nombreAT, cantidad, tipoConcepto, id_persona, tipoDocumento, numeroDocumento, userRunt.getCodigo(), userRunt.getPassword());
                                                    if (liquidacionProcesoTransOut != null) {
                                                        if (liquidacionProcesoTransOut.getStatus().getStatusCode().equals("1")) {
                                                            try {
                                                                java.io.File fileL = new java.io.File("C:\\Civitrans\\LiquidacionesRUNT\\" + liquidacionProcesoTransOut.getNumeroLiquidacion() + ".pdf");
                                                                java.io.FileOutputStream fos = new java.io.FileOutputStream(fileL.getAbsolutePath());
                                                                fos.write(liquidacionProcesoTransOut.getLiquidacionPDF());
                                                                fos.close();
                                                            } catch (Exception fxe) {
                                                                fxe.printStackTrace();
                                                            }
                                                            session.setAttribute("reporteRUNT", liquidacionProcesoTransOut.getLiquidacionPDF());
                                                            mensajeRunt = "RUNT: " + liquidacionProcesoTransOut.getStatus().getStatusDesc();
                                                            adicionarRunt = true;
                                                        } else {
                                                            mensajeRunt = "RUNT: " + liquidacionProcesoTransOut.getStatus().getStatusDesc();
                                                            paso = false;
                                                        }
                                                    }
                                                }
                                            } else {
                                                for (int nr = 0; nr < 1; nr++) {
                                                    liquidacionOut = liquidacionService.registrarLiquidacion(placaLiquidacion, identificadorAT, nombreAT, clasificacion, fecha_liquidacion, generaPDF, id_persona, tipoDocumento, numeroDocumento, numeroLiquidacion, tipoLiquidacion, valorOT, tramites, cantidadLiquidacion, multiLiquidacion, userRunt.getCodigo(), userRunt.getPassword());
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
                                                        mensajeRunt = "RUNT: Intente nuevamente 2";
                                                        paso = false;
                                                    }
                                                }
                                            }
                                        } else {
                        %><script>alert("CIVITRANS: No se encuentra autenticado");</script><%
                                }
                            }
                            //FIN PROCESO DE LIQUIDACION RUNT
                            if (paso && liqtransito) {
                                if (Integer.parseInt(request.getParameter("pago")) != 7) {
                                    Tiquete tiquete = new Tiquete();
                                    tiquete.setEstado(4);
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
                                        tiquete.setFecha_referencia(new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha")).getTime()));
                                        if (request.getParameter("banco") != null) {
                                            tiquete.setFk_banco(Long.parseLong(request.getParameter("banco").toString()));
                                        }
                                    }
                                    model.getCon().setAutoCommit(false);
                                    factura = model.consultarConsecutivo(sede.getId_sede(), 1, vigencia);
                                    consecutivo = "C" + ("000000".substring(0, 6 - (factura + "").length())) + factura;
                                    tikec = consecutivo;
                                    model.actualizarConsecutivo(sede.getId_sede(), 1, vigencia);
                                    tiquete.setNumero_factura(consecutivo);
                                    Taquilla taquilla = model.consultar_Taquilla_Actual(usuario.getFk_sede(), usuario.getId_usuario());
                                    tiquete.setFk_taquilla(taquilla.getId_taquilla());
                                    tiquete.setEstado_preliquidacion(1);
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
                                        pago.setFecha_tipo_pago(new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha")).getTime()));
                                        if (request.getParameter("banco") != null) {
                                            pago.setFk_banco(Long.parseLong(request.getParameter("banco").toString()));
                                        }
                                    }
                                    pago.setValor_descuento(tiquete.getValor_total_descuento());
                                    pago.setValor_iva(tiquete.getValor_total_iva());
                                    pago.setValor_total(tiquete.getValor_total());
                                    pago.setEstado(5);

                                    for (int i = 0; i < listaLiquidacion.size(); i++) {
                                        Liquidacion liquidacion = (Liquidacion) listaLiquidacion.get(i);
                                        if (liquidacion.getTipo() == 2) {
                                            java.util.StringTokenizer st = new java.util.StringTokenizer(liquidacion.getReferencia(), "-");
                                            long v_sede = Long.parseLong(st.nextToken());
                                            int valor1 = Integer.parseInt(st.nextToken());
                                            int valor2 = Integer.parseInt(st.nextToken());
                                            java.util.List detalleT = model.consultarDetalleTramite(v_sede, (int) liquidacion.getFk_concepto(), valor1, valor2);
                                            for (Valor val : (java.util.List<Valor>) detalleT) {
                                                if (val.getFk_concepto() == 903) {
                                                    float vlr = model.consultarValorConceptoDescuento(v_sede, 1, valor1, valor2);
                                                    pago.setObservacion("Se ha aplicado un descuento de $" + vlr + " Segun resolucion No 006 2018 ");
                                                    break;
                                                }
                                            }
                                        } else {
                                            List<Detalle_Cartera> temp = model.consultarDetalleCarteraIntComp(liquidacion.getId_liquidacion());
                                            String fecha_hoy = new java.text.SimpleDateFormat("dd/MM/yyyy").format(pago.getFecha());
                                            for (Detalle_Cartera elem : temp) {
                                                Conf_Descuento des = new Conf_Descuento().getCnf_des(model, 1, elem.getFk_concepto(), fecha_hoy);
                                                if (des != null) {
                                                    pago.setObservacion(des.getDescripcion());
                                                }
                                            }
                                        }
                                    }/*next*/

                                    long idPago = model.adicionarPago(pago);

                                    PreLiquidacion pre = new PreLiquidacion();
                                    pre.setFk_pago(idPago);
                                    pre.setFk_Taquilla(taquilla.getId_taquilla());
                                    pre.setValor_factura(pago.getValor_total());
                                    pre.setFk_sede(sede.getId_sede());
                                    pre.setFk_usuario(usuario.getId_usuario());
                                    model.adicionarPreliquidacion(pre);

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
                                                    if (tramite.getId_tramite() == 19) {
                                                        Documento documento = new Documento();
                                                        int numeroF = model.consultarConsecutivo(sede.getId_sede(), 7, java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
                                                        String numeroReal = "0000000".substring(0, 7 - String.valueOf(numeroF).length()) + String.valueOf(numeroF);
                                                        documento.setNumero(numeroReal);
                                                        model.actualizarConsecutivo(sede.getId_sede(), 7, java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
                                                        documento.setEstado(1);
                                                        documento.setReferencia("" + tiquete.getId_tiquete());
                                                        documento.setFk_vehiculo(tiquete.getFk_vehiculo());
                                                        documento.setFecha_expedicion(tiquete.getFecha());
                                                        documento.setFk_Persona(tiquete.getFk_persona());
                                                        documento.setFk_usuario(tiquete.getFk_usuario());
                                                        documento.setTipo(1);
                                                        model.adicionarDocumento(documento);
                                                    }
                                                    /*if(tramite.getId_tramite()==15){
                                                                 Documento documento = new Documento();
                                                                 int numeroF = model.consultarConsecutivo(sede.getId_sede(), 7, java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
                                                                 String numeroReal = "0000000".substring(0,7-String.valueOf(numeroF).length())+String.valueOf(numeroF);
                                                                 documento.setNumero(numeroReal);
                                                                 model.actualizarConsecutivo(sede.getId_sede(), 7, java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
                                                                 documento.setEstado(1);
                                                                 documento.setReferencia(""+tiquete.getId_tiquete());
                                                                 documento.setFk_vehiculo(tiquete.getFk_vehiculo());
                                                                 documento.setFecha_expedicion(tiquete.getFecha());
                                                                 documento.setFk_Persona(tiquete.getFk_persona());
                                                                 documento.setFk_usuario(tiquete.getFk_usuario());
                                                                 documento.setTipo(3);
                                                                 model.adicionarDocumento(documento);
                                                                 }*/

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
                                                    Concepto concepto = model.consultarConcepto(liquidacion.getFk_concepto());
                                                    nombre = concepto.getNombre();
                                                    if (liquidacion.getFk_concepto() >= 32 && liquidacion.getFk_concepto() <= 35) {
                                                        int vigenciaInicial = 2010;
                                                        if (vigenciaInicial != 0) {
                                                            Cartera cartera = new Cartera();
                                                            cartera.setFk_persona(tiquete.getFk_persona());
                                                            cartera.setFk_sede(sede.getId_sede());
                                                            cartera.setTipo(2);
                                                            cartera.setFk_pago(idPago);
                                                            cartera.setFecha_creacion(tiquete.getFecha());
                                                            cartera.setFecha_ingreso(tiquete.getFecha());
                                                            cartera.setFecha_saldo(tiquete.getFecha());
                                                            cartera.setEstado_cartera(2);
                                                            cartera.setFecha_estado(tiquete.getFecha());
                                                            cartera.setEstado_vigencia(1);
                                                            cartera.setFecha_estado_vigencia(tiquete.getFecha());
                                                            cartera.setFk_usuario(usuario.getId_usuario());
                                                            int tipoFk = 0;
                                                            switch ((int) liquidacion.getFk_concepto()) {
                                                                case 32:
                                                                    tipoFk = 3;
                                                                    break;
                                                                case 33:
                                                                    tipoFk = 4;
                                                                    break;
                                                                case 34:
                                                                    tipoFk = 1;
                                                                    break;
                                                                case 35:
                                                                    tipoFk = 2;
                                                                    break;
                                                            }
                                                            java.util.HashMap<Long, Float> mapa = model.consultarDetallesCartera(tipoFk + "", vigenciaInicial + "");
                                                            java.util.Iterator<Long> iter = mapa.keySet().iterator();
                                                            cartera.setReferencia(vigenciaInicial + "");
                                                            cartera.setValor(dt.getValor_total());
                                                            cartera.setSaldo(dt.getValor_total());
                                                            cartera.setFk_concepto(tipoFk);
                                                            long fkCartera = model.adicionarCartera(cartera);
                                                            while (iter.hasNext()) {
                                                                long key = iter.next();
                                                                float valueK = mapa.get(key);
                                                                Detalle_Cartera detalle = new Detalle_Cartera();
                                                                detalle.setFk_cartera(fkCartera);
                                                                detalle.setFk_concepto(key);
                                                                detalle.setReferencia(vigenciaInicial + "");
                                                                detalle.setFecha(cartera.getFecha_creacion());
                                                                detalle.setFecha_sistema(new java.sql.Timestamp(new java.util.Date().getTime()));
                                                                detalle.setFk_usuario(usuario.getId_usuario());
                                                                detalle.setEstado(2);
                                                                detalle.setValor(valueK);
                                                                detalle.setFk_pago(idPago);
                                                                model.adicionarDetalleCartera(detalle);
                                                            }
                                                            dt.setFk_cartera(fkCartera);
                                                            model.adicionarDetalleTiquete(dt);
                                                            Detalle_Cartera detalle = new Detalle_Cartera();
                                                            detalle.setFk_cartera(fkCartera);
                                                            detalle.setFk_concepto(322);
                                                            detalle.setReferencia(idPago + "");
                                                            detalle.setFecha(cartera.getFecha_creacion());
                                                            detalle.setFecha_sistema(new java.sql.Timestamp(new java.util.Date().getTime()));
                                                            detalle.setFk_usuario(usuario.getId_usuario());
                                                            detalle.setEstado(2);
                                                            detalle.setValor(dt.getValor_total() * -1);
                                                            model.adicionarDetalleCartera(detalle);
                                                        }
                                                    } else {
                                                        dt.setFk_concepto(liquidacion.getFk_concepto());
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
                            // POR AQUI VOY
                            for (int i = 0; i < listaLiquidacion.size(); i++) {
                                Liquidacion liquidacion = (Liquidacion) listaLiquidacion.get(i);
                                if (liquidacion.getTipo() == 1) {
                                    System.out.println("ID - CARTERA : " + liquidacion.getId_liquidacion());
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
                                        sumatoria = sumatoria - liquidacion.getTotal();
                                        int sw = 0;
                                        if (cartera.getTipo() == 1 || cartera.getTipo() == 3 || cartera.getTipo() == 5 || tiquete.getTipo_pago() == 2) {
                                            model.actualizarCartera(liquidacion.getId_liquidacion(), 0, 2, idPago, tiquete.getFecha(), fechaMod, 1);
                                            java.util.List lista_dc = model.listarDetalleCartera(liquidacion.getId_liquidacion());
                                            for (int j = 0; j < lista_dc.size(); j++) {
                                                Detalle_Cartera dc = (Detalle_Cartera) lista_dc.get(j);
                                                model.actualizarDetalleCartera(dc.getId_detalle_cartera(), 2, idPago, 1);
                                            }
                                            model.actualizarEstadoTiqueteByID(tiquete.getId_tiquete(), 3);
                                            model.actualizarEstadoPagoByFk_tiquete(tiquete.getId_tiquete(), 3);
                                            model.actualizarEstadoPreliquidacion(2, tiquete.getId_tiquete());
                                            sw = 1;
                                        }

                                        if (cartera.getTipo() == 1) {
                                            procesos.procesoContravencional procesoContravencional = new procesos.procesoContravencional();
                                            boolean respuesta = procesoContravencional.adicionarRecaudoPago(model, usuario, tiquete, cartera, liquidacion.getTotal());

                                        }
                                        if (cartera.getTipo() == 3) {
                                            model.actualizarDetalleFinanciacion(cartera.getId_cartera(), 2);
                                            boolean cuotasCanceladas = model.consultarCuotasCanceladas(cartera.getId_cartera());
                                            if (cuotasCanceladas) {
                                                model.actualizarComparendoFinanciacion(cartera.getId_cartera(), 2);
                                                model.actualizarFinanciacion(cartera.getId_cartera(), 2);

                                            }
                                        }

                                        if (cartera.getTipo() == 5 && cartera.getFk_concepto() == 308) {
                                            Comparendo comparendo = model.consultar_Comparendo(cartera.getReferencia());
                                            if (comparendo != null) {
                                                Liquidacion_Cia liquidacionCia = model.consultarLiquidacionCIA(comparendo.getId_comparendo(), comparendo.getFk_persona());
                                                if (liquidacionCia != null) {
                                                    if (liquidacionCia.getEstado() == 1) {
                                                        liquidacionCia.setReferencia(tiquete.getNumero_factura());
                                                        liquidacionCia.setFecha_pago(tiquete.getFecha());
                                                        liquidacionCia.setEstado(2);
                                                        model.adicionarPagoCIA(liquidacionCia);

                                                    }
                                                }
                                            }
                                        }

                                        Detalle_Cartera dc = new Detalle_Cartera();
                                        dc.setFecha(tiquete.getFecha());
                                        dc.setEstado(2);
                                        dc.setFecha_sistema(new java.sql.Timestamp(new java.util.Date().getTime()));
                                        dc.setFk_cartera(cartera.getId_cartera());
                                        int codP = (cartera.getTipo() == 1 || cartera.getTipo() == 5) ? 320 : (cartera.getTipo() == 2 ? 322 : 321);
                                        dc.setFk_concepto(codP);
                                        dc.setFk_usuario(usuario.getId_usuario());
                                        dc.setReferencia(idPago + "");
                                        dc.setValor((float) (-1 * liquidacion.getTotal()));
                                        if (sw == 1) {
                                            model.adicionarDetalleCartera(dc);
                                        }
                                        model.adicionarDetalleTiquete(dt);
                        %>
                        <tr>
                            <td align="center"><span class="Estilo25"><%=liquidacion.getCantidad()%></span></td>
                            <td><span class="Estilo25"><%=nombre%></span></td>
                            <td align="center"><span class="Estilo25"><%=referency%></span></td>
                            <td align="right"><span class="Estilo25">$&nbsp;<%=liquidacion.getTotal()%></span></td>
                        </tr>
                        <%
                        } else if (sumatoria > 0) {
                            dt.setEstado(1);
                            java.util.List lista_dc = model.listarDetalleCartera(liquidacion.getId_liquidacion());
                            float acumulado = 0;
                            for (int j = 0; j < lista_dc.size(); j++) {
                                Detalle_Cartera dc = (Detalle_Cartera) lista_dc.get(j);
                                if (sumatoria >= dc.getValor()) {
                                    sumatoria = sumatoria - dc.getValor();
                                    acumulado = acumulado + dc.getValor();
                                    //Modificado
                                    model.actualizarDetalleCartera(dc.getId_detalle_cartera(), 2, idPago, 1);
                                    valor_total += dc.getValor();
                                } else if (sumatoria > 0) {
                                    float rest = dc.getValor() - sumatoria;
                                    acumulado = acumulado + sumatoria;
                                    valor_total += sumatoria;
                                    //Modificado
                                    model.actualizarValorDetalleCartera(dc.getId_detalle_cartera(), 2, sumatoria, idPago);
                                    Detalle_Cartera ndc = new Detalle_Cartera();
                                    dc.setFecha(tiquete.getFecha());
                                    dc.setEstado(1);
                                    dc.setFecha_sistema(new java.sql.Timestamp(new java.util.Date().getTime()));
                                    dc.setFk_cartera(dc.getFk_cartera());
                                    dc.setFk_concepto(dc.getFk_concepto());
                                    dc.setFk_usuario(usuario.getId_usuario());
                                    dc.setReferencia(dc.getReferencia());
                                    dc.setValor(rest);
                                    dc.setFk_pago(0);
                                    //Modificado
                                    model.adicionarDetalleCartera(dc);
                                    sumatoria = 0;
                                }
                            }
                            //Modificado
                            model.actualizarCartera(liquidacion.getId_liquidacion(), liquidacion.getTotal() - acumulado, 1, idPago, tiquete.getFecha(), fechaMod, 1);
                            Detalle_Cartera dc = new Detalle_Cartera();
                            dc.setFecha(tiquete.getFecha());
                            dc.setEstado(2);
                            dc.setFecha_sistema(new java.sql.Timestamp(new java.util.Date().getTime()));
                            dc.setFk_cartera(liquidacion.getId_liquidacion());
                            int codP = (cartera.getTipo() == 1 || cartera.getTipo() == 5) ? 320 : (cartera.getTipo() == 2 ? 322 : 321);
                            dc.setFk_concepto(codP);
                            dc.setFk_usuario(usuario.getId_usuario());
                            dc.setReferencia(idPago + "");
                            dc.setValor((float) (-1 * acumulado));
                            //Modificado
                            model.adicionarDetalleCartera(dc);
                            dt.setValor_descuento(acumulado);
                            dt.setValor_iva(acumulado);
                            dt.setValor_total(acumulado);
                            dt.setValor_unitario(acumulado);
                            model.adicionarDetalleTiquete(dt);
                            model.actualizarEstadoTiqueteByID(tiquete.getId_tiquete(), 3);
                            model.actualizarEstadoPagoByFk_tiquete(tiquete.getId_tiquete(), 3);
                            model.actualizarEstadoPreliquidacion(2, tiquete.getId_tiquete());
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
                                modelo.Saldo_Favor saldoFavor = new modelo.Saldo_Favor();
                                int numeroSF = model.consultarConsecutivo(sede.getId_sede(), 8, vigencia);
                                String consecutivoSF = ("00000").substring(0, 5 - (numeroSF + "").length()) + numeroSF;
                                model.actualizarConsecutivo(sede.getId_sede(), 8, vigencia);
                                saldoFavor.setNumero(consecutivoSF);
                                saldoFavor.setFk_persona(tiquete.getFk_persona());
                                saldoFavor.setTipo(1);
                                saldoFavor.setValor(sumatoria);
                                saldoFavor.setReferencia(tiquete.getId_tiquete() + "");
                                saldoFavor.setEstado(1);
                                saldoFavor.setFecha(tiquete.getFecha());
                                saldoFavor.setFecha_proceso(tiquete.getFecha_proceso());
                                saldoFavor.setFk_usuario(tiquete.getFk_usuario());
                                model.adicionarSaldoFavor(saldoFavor);

                            }
                            if (adicionarRunt) {
                                String placaLrunt = request.getParameter("placa") != null ? request.getParameter("placa").toUpperCase() : "";
                                for (int i = 0; i < listaLiquidacion.size(); i++) {
                                    Liquidacion liquidat = (Liquidacion) listaLiquidacion.get(i);
                                    if (liquidat.getTipo() == 2) {
                                        // model.registrarLiquidacionRUNT(liquidacionOut,idPago,placaLrunt,tiquete.getFk_persona(),1,liquidat.getId_liquidacion(),usuario.getId_usuario());
                                    }
                                }
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
                            String dir = "C:/Civitrans/transito/web/paginas/reports/recaudoycartera/pagos/multipleTiquetePagoReport.jasper";
                            parameters.put("SUBREPORT_DIR", dir.substring(0, dir.indexOf("reports") + 8));
                            session.setAttribute("reporteOT", parameters);
                            aplicacionRunt2 = true; %>
                        <script language="javascript" type="text/javascript">activar();</script> <%
                        } else { // fin sino de nota creditos
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
                                            mensajeRunt = "Codigo de securidad invalido, le restan " + (3 - intentos) + " intentos.";
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
                                    valor_total = Float.parseFloat(request.getParameter("valor")); %>
                        <script language="javascript" type="text/javascript">
                            activar();
                        </script> <%
                                    } else {
                                        mensajeRunt = "Error al aplicar la nota credito";
                                        model.getCon().rollback();
                                    }
                                }
                            }
                        } else if (adicionarRunt) {
                        %>
                        <script language="javascript" type="text/javascript">activar();</script> <%
                                        String placaLrunt = request.getParameter("placa") != null ? request.getParameter("placa").toUpperCase() : "";
                                        for (int i = 0; i < listaLiquidacion.size(); i++) {
                                            Liquidacion liquidat = (Liquidacion) listaLiquidacion.get(i);
                                            if (liquidat.getTipo() == 2) {
                                                //   model.registrarLiquidacionRUNT(liquidacionOut,0,placaLrunt,persona.getId_persona(),1,liquidat.getId_liquidacion(),usuario.getId_usuario());
                                            }
                                        }
//                              model.getCon().commit();
                                    }
                                    /* here    } catch (Exception exc) {
                                        mensajeRunt = "CIVITRANS: " + exc.getMessage();
                                        exc.printStackTrace();
                                        try {
                                            model.getCon().rollback();
                                        } catch (Exception exc2) {
                                            mensajeRunt = "CIVITRANS: No hay conexion de BBDD";
                                            exc2.printStackTrace();
}                                    }*/
                                }
                            }
                            if (adicionarRunt) {
                                if (!proceTr) {
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

                        <tr bgcolor="#FFFFFF" >
                            <td colspan="2">&nbsp;</td>
                            <td align="center"><span class="Estilo10">TOTAL:</span></td>
                            <td align="right"><span class="Estilo22">$&nbsp;<%=valor_total%></span></td>
                        </tr>
                        <% }

                            }%>

                        <%
                            java.util.HashMap param = new java.util.HashMap();
                            param.put("USUARIO", per);
                            param.put("FECHA", fec);
                            param.put("PRELIQUIDACION", consecutivo);
                            param.put("VALOR", valor_total);
                            param.put("HORA", hora);
                            param.put("PLACA", request.getParameter("placa").toUpperCase() != null ? request.getParameter("placa").toUpperCase() : " - ");
                            session.setAttribute("Codigo", param);
                        %>
                        <% if (adicionarRunt) {
                                if (liqtransito && liqrunt) { %>
                        <tr style="border:none">
                            <td colspan="2" align="center" style="border:none"><input type="button" name="imprimirOT" value="Imprimir Recibo OT" onclick="imprimir(1)"/></td>
                            <td colspan="2" align="center" style="border:none"><input type="button" name="imprimirRUNT" value="Imprimir Recibo RUNT" onclick="imprimir(2)"/></td>
                        </tr>
                        <%      } else if (liqrunt) { %>
                        <tr style="border:none">
                            <td colspan="4" align="center" style="border:none"><input type="button" name="imprimirRUNT" value="Imprimir Recibo RUNT" onclick="imprimir(2)"/></td>
                        </tr>
                        <%          } else { %>
                        <tr style="border:none">
                            <td colspan="4" align="center" style="border:none"><input type="button" name="imprimirOT" value="Imprimir Recibo OT" onclick="imprimir(1)"/></td>
                        </tr>
                        <%          }
                        } else if (!request.getParameter("pago").equals("7")) { %>
                        <tr style="border:none">
                            <td colspan="4" align="center" style="border:none"><input type="button" name="imprimirOT" value="Imprimir Recibo OT" onclick="imprimir(1)"/></td>
                        </tr>
                        <%  }%>

                    </table></td>
            </tr>
        </table>
        <input type="hidden" value="<%=valor_total%>" id="valor1" name="valor1"/>
        <%  }
            }
            /*            } catch (Exception exc) {
                mensajeRunt = "CIVITRANS: " + exc.getMessage();
                exc.printStackTrace();
                try {
//            model.getCon().rollback();
                } catch (Exception exc2) {
                    mensajeRunt = "CIVITRANS: No hay conexion de BBDD";
                    exc2.printStackTrace();
                }
            }*/
            if (mensajeRunt.length() > 0) {
                if (swMsgx == 1) {%>
        <script language='javascript' type='text/javascript'>
            window.parent.document.getElementById('autenticar').style.display = 'block';
        </script>
        <%      }
        %>
        <script language='javascript' type='text/javascript'>
            window.parent.document.getElementById('aplicar').style.display = 'block';
            window.parent.document.getElementById('limpiar').style.display = 'block';
            alert('<%=mensajeRunt%>');
        </script>
        <%   } %>
    </body>
</html>
<%  } else { %>
<script>window.parent.document.location.href = "../../index.jsp";</script>
<%  }
} else { %>
<script>window.parent.document.location.href = "../../index.jsp";</script>
<% }
} catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% }%>