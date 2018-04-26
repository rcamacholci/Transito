<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("verDatosVehiculo.jsp")) {
                modelo.Model modelo = (modelo.Model) session.getAttribute("model");
                modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");

%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%@ page import="modelo.*"%>
        <%@page import="java.util.*"%>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Vehiculo</title>
        <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript">


            function paso() {
                if (document.form.fecha_ini.value.length > 0) {
                    if (document.form.fecha_fin.value.length > 0) {
                        document.form.action = 'reportes.jsp'
                        document.form.submit();
                    } else {
                        alert("Digite la fecha final del reporte Genearal");
                    }
                } else {
                    alert("Digite la fecha inicial del reporte General");
                }
            }

            function paso2() {
                if (document.form.fecha_ini2.value.length > 0) {
                    if (document.form.fecha_fin2.value.length > 0) {
                        if (document.getElementById("tramite").value != 0) {
                            document.form.action = 'reportes.jsp'
                            document.form.submit();
                        } else {
                            alert("Seleccione un tramite");
                        }
                    } else {
                        alert("Digite la fecha final del reporte Detallado");
                    }
                } else {
                    alert("Digite la  inicial del reporte Detallado");
                }
            }

            function paso3() {
                if (document.form.fecha_iniCon.value.length > 0) {
                    if (document.form.fecha_finCon.value.length > 0) {
                        if (document.getElementById("concepto").value != 0) {
                            document.form.action = 'reportes.jsp'
                            document.form.submit();
                        } else {
                            alert("Seleccione un Concepto");
                        }
                    } else {
                        alert("Digite la fecha final del reporte General por Concepto");
                    }
                } else {
                    alert("Digite la fecha inicial del reporte Genarl por Concepto");
                }
            }

            function paso4() {
                if (document.form.fecha_iniCon2.value.length > 0) {
                    if (document.form.fecha_finCon2.value.length > 0) {
                        if (document.getElementById("concepto2").value != 0) {
                            document.form.action = 'reportes.jsp'
                            document.form.submit();
                        } else {
                            alert("Seleccione un concepto");
                        }
                    } else {
                        alert("Digite la fecha final del reporte Detallado por Concepto");
                    }
                } else {
                    alert("Digite la fecha inicial del reporte Detallado por Concepto");
                }
            }

            function paso5() {
                if (document.form.modelo_ini.value.length > 0) {
                    if (document.form.modelo_fin.value.length > 0) {
                        document.form.action = 'reportes.jsp'
                        document.form.submit();

                    } else {
                        alert("Digite el modelo final del reporte General de Cartera por modelo");
                    }
                } else {
                    alert("Digite el modelo inicial del reporte General de Cartera por modelo");
                }
            }

            function paso6() {
                if (document.form.fecha_iniTer.value.length > 0) {
                    if (document.form.fecha_finTer.value.length > 0) {
                        document.form.action = 'reportes.jsp'
                        document.form.submit();
                    } else {
                        alert("Digite la fecha final del reporte General de Distribucion");
                    }
                } else {
                    alert("Digite la fecha inicial del reporte General de Distribucion");
                }
            }

            function paso7() {
                if (document.form.fecha_iniTer2.value.length > 0) {
                    if (document.form.fecha_finTer2.value.length > 0) {
                        if (document.getElementById("entidad").value != 0) {
                            document.form.action = 'reportes.jsp'
                            document.form.submit();
                        } else {
                            alert(" Por favor seleccione una entidad o tercero");
                        }

                    } else {
                        alert("Digite la fecha final del reporte Detallado por Entidad");
                    }
                } else {
                    alert("Digite la fecha inicial del reporte Detallado por Entidad");
                }
            }

            function paso8() {
                if (document.form.ano.value.length > 0) {
                    document.form.action = 'reportes.jsp'
                    document.form.submit();
                } else {
                    alert("Digite el año del reporte Estadistico de Tramites");
                }
            }
            function paso9() {
                if (document.form.anoTotal.value.length > 0) {
                    document.form.action = 'reportes.jsp'
                    document.form.submit();
                } else {
                    alert("Digite el año del reporte Cantidad de Tramites");
                }
            }
            function paso10() {
                if (document.form.anoTotalLiq.value.length > 0) {
                    document.form.action = 'reportes.jsp'
                    document.form.submit();
                } else {
                    alert("Digite el año del reporte Cantidad de Tramites Liquidados y Realizados");
                }
            }

            function paso11() {
                if (document.form.fecha_iniPag.value.length > 0) {
                    if (document.form.fecha_finPag.value.length > 0) {
                        document.form.action = 'reportes.jsp'
                        document.form.submit();
                    } else {
                        alert("Digite la fecha final de los pagos anulados");
                    }
                } else {
                    alert("Digite la fecha inicial de los pagos anulados");
                }
            }

            function paso12() {
                if (document.form.anoCT.value.length > 0) {
                    document.form.action = 'reportes.jsp'
                    document.form.submit();
                } else {
                    alert("Digite el año del reporte Recaudado Anual por Conceptos");
                }
            }
            function paso13() {
                if (document.form.anoCT2.value.length > 0) {
                    document.form.action = 'reportes.jsp'
                    document.form.submit();
                } else {
                    alert("Digite el año del reporte Total Anual por Conceptos");
                }
            }


            function verReporteTramiteGeneral() {
                //document.form.motor.value
                ancho = 789;
                alto = 600;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "tramites/cantidadtramitesFechas.jasper";
                var nombre = "tramiteGeneral";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }

            function verReporteTramiteDetallado() {
                //document.form.motor.value
                ancho = 789;
                alto = 600;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "tramites/tramitesFechas.jasper";
                var nombre = "tramiteDetallado";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }

            function verReporteTramiteEstadistico() {
                //document.form.motor.value
                ancho = 789;
                alto = 600;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "tramites/estadisticaAnualTramites.jasper";
                var nombre = "tramiteEstadistico";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }

            function verReporteTramiteCantidadAnual() {
                //document.form.motor.value
                ancho = 789;
                alto = 600;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "tramites/cantidadTramitesAnuales.jasper";
                var nombre = "tramiteCantidad";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }

            function verReporteTramiteCantidadLiquidadosAnual() {
                //document.form.motor.value
                ancho = 789;
                alto = 600;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "tramites/cantidadTramitesTotales.jasper";
                var nombre = "tramiteCantidadLiquidados";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }


            function verReporteConceptoGeneral() {
                //document.form.motor.value
                ancho = 789;
                alto = 600;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "conceptos/conceptosGeneralFechas.jasper";
                var nombre = "conceptosGeneral";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }

            function verReporteConceptoDetallado() {
                //document.form.motor.value
                ancho = 789;
                alto = 600;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "conceptos/conceptosFechas.jasper";
                var nombre = "conceptosDetallado";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }

            function verReporteAnualConceptos() {
                //document.form.motor.value
                ancho = 789;
                alto = 600;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "conceptos/totalConceptosAnuales.jasper";
                var nombre = "RecaudoAnualConceptos";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }

            function verReporteCantidadAnualConceptos() {
                //document.form.motor.value
                ancho = 789;
                alto = 600;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "conceptos/cantidadConceptosAnuales.jasper";
                var nombre = "cantidadAnualConceptos";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }

            function verReporteCarteraModelo() {
                //document.form.motor.value
                ancho = 789;
                alto = 600;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "cartera/carteraPorModelo.jasper";
                var nombre = "modeloCartera";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }


            function verReporteEntidadDetallado() {
                //document.form.motor.value
                ancho = 789;
                alto = 600;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "recaudoycartera/distribucion/conceptosTercerosFechas.jasper";
                var nombre = "entidadDetallado";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }

            function verReporteEntidadGeneral() {
                //document.form.motor.value
                ancho = 789;
                alto = 600;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "recaudoycartera/distribucion/distribucionGeneralEntidades.jasper";
                var nombre = "entidadGeneral";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }



            function  verReportePagosAnulados() {
                //document.form.motor.value
                ancho = 789;
                alto = 600;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "recaudoycartera/taquillas/tiquetesTaquillaAnulados.jasper";
                var nombre = "pagosAnulados";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }

            function verReporteTramiteEstadisticoExcel() {
                if (document.getElementById("ano").value != 0) {
                    if (confirm("¿Esta seguro que desea generar el reporte?")) {

                        ancho = 800;
                        alto = 640;
                        barra = 0;
                        izquierda = (screen.width) ? (screen.width - ancho) / 2 : 100;
                        arriba = (screen.height) ? (screen.height - alto) / 2 : 100;
                        opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=no,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba;
                        url = "ReporteTramiteExcel.jsp?year=" + document.getElementById("ano").value+"&opcion=1";
                        window.open(url, 'popUp', opciones);


                    }
                } else {
                    alert("Por favor digite el año sobre el cual desea generar el reporte");
                }
            }
            function verReporteTramiteExcel() {
                if (document.form.fecha_ini2.value.length > 0) {
                    if (document.form.fecha_fin2.value.length > 0) {
                        if (document.getElementById("tramite").value != 0) {
                            if (confirm("¿Esta seguro que desea generar el reporte?")) {
                                ancho = 800;
                                alto = 640;
                                barra = 0;
                                izquierda = (screen.width) ? (screen.width - ancho) / 2 : 100;
                                arriba = (screen.height) ? (screen.height - alto) / 2 : 100;
                                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=no,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba;
                                url = "ReporteTramiteExcelDetallado.jsp?fecha_ini="+document.form.fecha_ini2.value+"&fecha_fin="+document.form.fecha_fin2.value+"&tramite="+document.getElementById("tramite").value;
                                //?year=" + document.getElementById("ano").value;
                                window.open(url, 'popUp', opciones);
                            }

                        } else {
                            alert("Seleccione un tramite");
                        }
                    } else {
                        alert("Digite la fecha final del reporte Detallado");
                    }
                } else {
                    alert("Digite la  inicial del reporte Detallado");
                }
            }



            function ver() {
                if (document.form.busqueda[0].checked) {
                    document.getElementById('Ttabla1').style.display = "block";
                    document.getElementById('Ttabla2').style.display = "none";
                    document.getElementById('Ttabla3').style.display = "none";
                    document.getElementById('Ttabla4').style.display = "none";
                    document.getElementById('Ttabla5').style.display = "none";
                } else {
                    if (document.form.busqueda[1].checked) {
                        document.getElementById('Ttabla1').style.display = "none";
                        document.getElementById('Ttabla2').style.display = "block";
                        document.getElementById('Ttabla3').style.display = "none";
                        document.getElementById('Ttabla4').style.display = "none";
                        document.getElementById('Ttabla5').style.display = "none";
                    } else {
                        if (document.form.busqueda[2].checked) {
                            document.getElementById('Ttabla1').style.display = "none";
                            document.getElementById('Ttabla2').style.display = "none";
                            document.getElementById('Ttabla3').style.display = "block";
                            document.getElementById('Ttabla4').style.display = "none";
                            document.getElementById('Ttabla5').style.display = "none";
                        } else {
                            if (document.form.busqueda[3].checked) {
                                document.getElementById('Ttabla1').style.display = "none";
                                document.getElementById('Ttabla2').style.display = "none";
                                document.getElementById('Ttabla3').style.display = "none";
                                document.getElementById('Ttabla4').style.display = "block";
                                document.getElementById('Ttabla5').style.display = "none";
                            } else {
                                document.getElementById('Ttabla1').style.display = "none";
                                document.getElementById('Ttabla2').style.display = "none";
                                document.getElementById('Ttabla3').style.display = "none";
                                document.getElementById('Ttabla4').style.display = "none";
                                document.getElementById('Ttabla5').style.display = "block";
                            }
                        }

                    }

                }
            }

            function ver2() {
                if (document.form.busqueda2[0].checked) {
                    document.getElementById('Ctabla1').style.display = "block";
                    document.getElementById('Ctabla2').style.display = "none";
                    document.getElementById('Ctabla3').style.display = "none";
                    document.getElementById('Ctabla4').style.display = "none";
                } else {
                    if (document.form.busqueda2[1].checked) {
                        document.getElementById('Ctabla1').style.display = "none";
                        document.getElementById('Ctabla2').style.display = "block";
                        document.getElementById('Ctabla3').style.display = "none";
                        document.getElementById('Ctabla4').style.display = "none";
                    } else {
                        if (document.form.busqueda2[2].checked) {
                            document.getElementById('Ctabla1').style.display = "none";
                            document.getElementById('Ctabla2').style.display = "none";
                            document.getElementById('Ctabla3').style.display = "block";
                            document.getElementById('Ctabla4').style.display = "none";
                        } else {
                            document.getElementById('Ctabla1').style.display = "none";
                            document.getElementById('Ctabla2').style.display = "none";
                            document.getElementById('Ctabla3').style.display = "none";
                            document.getElementById('Ctabla4').style.display = "block";

                        }
                    }

                }
            }
            function ver3() {
                if (document.form.distribucion[0].checked) {
                    document.getElementById('tabla6').style.display = "block";
                    document.getElementById('tabla7').style.display = "none";
                } else {
                    document.getElementById('tabla6').style.display = "none";
                    document.getElementById('tabla7').style.display = "block";

                }
            }


        </script>
        <STYLE>
            <!--
            A.ssmItems:link		{color:black;text-decoration:none;}
            A.ssmItems:hover	{color:black;text-decoration:none;}
            A.ssmItems:active	{color:black;text-decoration:none;}
            A.ssmItems:visited	{color:black;text-decoration:none;}
            .style5 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
            .Estilo11 {
                color: #0066CC;
                font-weight: bold;
                font-size: 10px;
            }
            .style7 {font-family: Tahoma; font-weight: bold; color: #333333; }
            .style8 {color: #333333}
            .style9 {font-size: 10px}
            .style10 {
                font-size: 10px;
                color: #333333;
                font-weight: bold;
                font-family: Tahoma;
            }
            .style13 {font-size: 11px; color: #333333; font-weight: bold; font-family: Tahoma; }
            .style14 {
                color: #FFFFFF;
                font-family: Tahoma;
                font-weight: bold;
                font-size: 12px;
            }
            -->
        </STYLE>


    </head>
    <%    //---------------------------- reporte de tramites -------------------------------
        if (request.getParameter("fecha_ini") != null && request.getParameter("fecha_fin") != null && !request.getParameter("fecha_ini").isEmpty() && !request.getParameter("fecha_fin").isEmpty()) {
            HashMap parameters = new java.util.HashMap();
            parameters.put("USUARIO", usuario.getNombre());
            parameters.put("FECHA_INI", request.getParameter("fecha_ini"));
            parameters.put("FECHA_FIN", request.getParameter("fecha_fin"));
            session.setAttribute("tramiteGeneral", parameters);
    %>
    <script language="javascript" type="text/javascript">
        verReporteTramiteGeneral();
        document.location = "reportes.jsp";
    </script>

    <%  } else if (request.getParameter("fecha_ini2") != null && request.getParameter("fecha_fin2") != null && !request.getParameter("fecha_ini2").isEmpty() && !request.getParameter("fecha_fin2").isEmpty()) {
        HashMap parameters = new java.util.HashMap();
        parameters.put("USUARIO", usuario.getNombre());
        parameters.put("ID_TRAMITE", request.getParameter("tramite"));
        parameters.put("FECHA_INI", request.getParameter("fecha_ini2"));
        parameters.put("FECHA_FIN", request.getParameter("fecha_fin2"));
        session.setAttribute("tramiteDetallado", parameters);
    %>
    <script language="javascript" type="text/javascript">
        verReporteTramiteDetallado();
        document.location = "reportes.jsp";
    </script>

    <%} else if (request.getParameter("ano") != null && !request.getParameter("ano").isEmpty()) {
        HashMap parameters = new java.util.HashMap();
        parameters.put("USUARIO", usuario.getNombre());
        parameters.put("ANO", request.getParameter("ano"));
        session.setAttribute("tramiteEstadistico", parameters);
    %>
    <script language="javascript" type="text/javascript">
        verReporteTramiteEstadistico();
        document.location = "reportes.jsp";
    </script>

    <%} else if (request.getParameter("anoTotal") != null && !request.getParameter("anoTotal").isEmpty()) {
        HashMap parameters = new java.util.HashMap();
        parameters.put("USUARIO", usuario.getNombre());
        parameters.put("ANO", request.getParameter("anoTotal"));
        session.setAttribute("tramiteCantidad", parameters);
    %>
    <script language="javascript" type="text/javascript">
        verReporteTramiteCantidadAnual();
        document.location = "reportes.jsp";
    </script>

    <%} else if (request.getParameter("anoTotalLiq") != null && !request.getParameter("anoTotalLiq").isEmpty()) {
        HashMap parameters = new java.util.HashMap();
        parameters.put("USUARIO", usuario.getNombre());
        parameters.put("ANO", request.getParameter("anoTotalLiq"));
        session.setAttribute("tramiteCantidadLiquidados", parameters);
    %>
    <script language="javascript" type="text/javascript">
        verReporteTramiteCantidadLiquidadosAnual();
        document.location = "reportes.jsp";
    </script>

    <%}
        //---------------------------------------------------------
        //------------------- reporte de concepto---------------------
        if (request.getParameter("fecha_iniCon") != null && request.getParameter("fecha_finCon") != null && !request.getParameter("fecha_iniCon").isEmpty() && !request.getParameter("fecha_finCon").isEmpty()) {
            HashMap parameters = new java.util.HashMap();
            parameters.put("ID_CONCEPTO", request.getParameter("concepto"));
            parameters.put("USUARIO", usuario.getNombre());
    %>
    <script language="javascript" type="text/javascript">
        alert("<%=request.getParameter("fecha_iniCon")%> O <%=request.getParameter("fecha_finCon")%>");
    </script>
    <%
        parameters.put("FECHA_INI", request.getParameter("fecha_iniCon"));
        parameters.put("FECHA_FIN", request.getParameter("fecha_finCon"));
        session.setAttribute("conceptosGeneral", parameters);
    %>
    <script language="javascript" type="text/javascript">
        verReporteConceptoGeneral();
        document.location = "reportes.jsp";
    </script>
    <%  } else if (request.getParameter("fecha_iniCon2") != null && request.getParameter("fecha_finCon2") != null && !request.getParameter("fecha_iniCon2").isEmpty() && !request.getParameter("fecha_finCon2").isEmpty()) {
        HashMap parameters = new java.util.HashMap();
        parameters.put("ID_CONCEPTO", request.getParameter("concepto2"));
        parameters.put("USUARIO", usuario.getNombre());
        parameters.put("FECHA_INI", request.getParameter("fecha_iniCon2"));
        parameters.put("FECHA_FIN", request.getParameter("fecha_finCon2"));
        session.setAttribute("conceptosDetallado", parameters);
    %>
    <script language="javascript" type="text/javascript">
        verReporteConceptoDetallado();
        document.location = "reportes.jsp";
    </script>
    <%  } else if (request.getParameter("anoCT") != null && !request.getParameter("anoCT").isEmpty()) {
        HashMap parameters = new java.util.HashMap();
        parameters.put("USUARIO", usuario.getNombre());
        parameters.put("ANO", request.getParameter("anoCT"));
        session.setAttribute("RecaudoAnualConceptos", parameters);
    %>
    <script language="javascript" type="text/javascript">
        verReporteAnualConceptos();
        document.location = "reportes.jsp";
    </script>
    <%  } else if (request.getParameter("anoCT2") != null && !request.getParameter("anoCT2").isEmpty()) {
        HashMap parameters = new java.util.HashMap();
        parameters.put("USUARIO", usuario.getNombre());
        parameters.put("ANO", request.getParameter("anoCT2"));
        session.setAttribute("cantidadAnualConceptos", parameters);
    %>
    <script language="javascript" type="text/javascript">
        verReporteCantidadAnualConceptos();
        document.location = "reportes.jsp";
    </script>
    <%  }
        //---------------------------------------
        //------------ reporte de cartera
        if (request.getParameter("modelo_ini") != null && request.getParameter("modelo_fin") != null && !request.getParameter("modelo_ini").isEmpty() && !request.getParameter("modelo_fin").isEmpty()) {
            HashMap parameters = new java.util.HashMap();
            parameters.put("USUARIO", usuario.getNombre());
            parameters.put("MODELO_INI", request.getParameter("modelo_ini"));
            parameters.put("MODELO_FIN", request.getParameter("modelo_fin"));
            session.setAttribute("modeloCartera", parameters);
    %>
    <script language="javascript" type="text/javascript">
        verReporteCarteraModelo();
        document.location = "reportes.jsp";
    </script>
    <%  }
        //------------------------------------
        //-------------------------- reporte de entidades -------------------

        if (request.getParameter("fecha_iniTer2") != null && request.getParameter("fecha_finTer2") != null && !request.getParameter("fecha_iniTer2").isEmpty() && !request.getParameter("fecha_finTer2").isEmpty()) {
            HashMap parameters = new java.util.HashMap();
            parameters.put("USUARIO", usuario.getNombre());
            parameters.put("ID_TERCERO", request.getParameter("entidad"));
            parameters.put("FECHA_INI", request.getParameter("fecha_iniTer2"));
            parameters.put("FECHA_FIN", request.getParameter("fecha_finTer2"));
            session.setAttribute("entidadDetallado", parameters);
    %>
    <script language="javascript" type="text/javascript">
        verReporteEntidadDetallado();
        document.location = "reportes.jsp";
    </script>
    <%  } else if (request.getParameter("fecha_iniTer") != null && request.getParameter("fecha_finTer") != null && !request.getParameter("fecha_iniTer").isEmpty() && !request.getParameter("fecha_finTer").isEmpty()) {
        HashMap parameters = new java.util.HashMap();
        parameters.put("USUARIO", usuario.getNombre());
        parameters.put("FECHA_INI", new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date(request.getParameter("fecha_iniTer"))));
        parameters.put("FECHA_FIN", new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date(request.getParameter("fecha_finTer"))));
        session.setAttribute("entidadGeneral", parameters);


    %>
    <script language="javascript" type="text/javascript">
        verReporteEntidadGeneral();
        document.location = "reportes.jsp";
    </script>
    <%  }

        if (request.getParameter("fecha_iniPag") != null && request.getParameter("fecha_finPag") != null && !request.getParameter("fecha_iniPag").isEmpty() && !request.getParameter("fecha_finPag").isEmpty()) {
            HashMap parameters = new java.util.HashMap();
            parameters.put("USUARIO", usuario.getNombre());
            parameters.put("FECHA_INI", request.getParameter("fecha_iniPag"));
            parameters.put("FECHA_FIN", request.getParameter("fecha_finPag"));
            session.setAttribute("pagosAnulados", parameters);
    %>
    <script language="javascript" type="text/javascript">
        verReportePagosAnulados();
        document.location = "reportes.jsp";
    </script>
    <%  }


    %>


    <body>

        <form name="form" id="form" method="post" action="">
            <fieldset>		    
                <table width="100%" border="0" align="center">
                    <tr style="border:none; background:url(../html/images/inicio_3.png)">
                        <td colspan="11" align="center"><span class="style2 style14">TRAMITES</span></td>
                    </tr>

                    <td colspan="2" valign="middle" align="center" width="20%"><span class="Estilo11">
                            <input type="radio" name="busqueda" id="busqueda" value="1" checked="checked" onClick="ver()">
                                &nbsp;GENERAL</span></td>
                    <td colspan="2" valign="middle" align="center" width="20%"><span class="Estilo11">
                            <input type="radio" name="busqueda" value="2" onClick="ver()">
                                &nbsp;DETALLADO</span></td>
                    <td colspan="2" valign="middle" align="center" width="20%"><span class="Estilo11">
                            <input type="radio" name="busqueda" value="3" onClick="ver()">
                                RECAUDADO ANUAL</span></td>
                    <td colspan="2" valign="middle" align="center" width="20%"><span class="Estilo11">
                            <input type="radio" name="busqueda" value="4" onClick="ver()">
                                &nbsp;ANUAL-CANTIDAD</span></td>
                    <td colspan="2" valign="middle" align="center" width="20%"><span class="Estilo11">
                            <input type="radio" name="busqueda" value="5" onClick="ver()">
                                &nbsp;LIQUIDADOS-REALIZADOS</span></td>

                    </tr>
                    <tr>
                        <td colspan="9">
                            <table border="0" width="90%" id="Ttabla1" align="center">
                                <tr valign="middle">
                                    <td width="15%" scope="col"  align="center" colspan="2"><span class="style7" style="font-size: 11px">
                                            <label style="color:#333333">FECHA&nbsp;INICIAL </label>
                                        </span></td>
                                    <td width="30%" scope="col" align="center" colspan="2"><span class="style7" style="font-size: 11px"><span class="style7" style="font-size: 11px">
                                                <input id="fecha_ini" name="fecha_ini" type="text" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; color:#333333;font:bold; width:100px"/>
                                            </span>&nbsp;
                                            <input name="bfecha" type="button" id="bfechaIT" value="..." style="width:20px">
                                                <SCRIPT type="text/javascript">
                                                    Calendar.setup({
                                                        inputField: "fecha_ini",
                                                        ifFormat: "%d/%m/%Y",
                                                        button: "bfechaIT"
                                                    });
                                                </SCRIPT>

                                        </span></td>
                                    <td width="15%" scope="col"  align="center" colspan="2"><span class="style7" style="font-size: 11px">
                                            <label style="color:#666666"><span class="style8">FECHA&nbsp;FIN </span></label>
                                        </span></td>
                                    <td width="30%" scope="col" align="center" colspan="2"><span class="style7" style="font-size: 11px">
                                            <input id="fecha_fin" name="fecha_fin" type="text" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; color:#333333;font:bold; width:100px"/>
                                            &nbsp;
                                            <input name="bfechaFT" type="button" id="bfechaFT" value="..." style="width:20px">
                                                <SCRIPT type="text/javascript">
                                                    Calendar.setup({
                                                        inputField: "fecha_fin",
                                                        ifFormat: "%d/%m/%Y",
                                                        button: "bfechaFT"
                                                    });
                                                </SCRIPT>

                                        </span></td>


                                    <td width="10%" scope="col" align="center"><input  name="generar1" type="button" id="generar1" style="width:100px" onClick="paso()" value="Generar"/></td>
                                </tr>
                            </table>



                            <table border="0" width="90%" id="Ttabla2" align="center" style=" display:none">
                                <tr valign="middle">
                                    <td width="10%" scope="col"  align="center" colspan="2"><label style="color:#666666"><span class="style5"><span class="style9">FECHA&nbsp;INICIAL</span></span></label></td>
                                    <td width="20%" scope="col" align="center" colspan="2"><input id="fecha_ini2" name="fecha_ini2" type="text" style="text-align:center;color:#333333;font:bold; width:100px"/>&nbsp;
                                        <input name="bfechaIT2" type="button" id="bfechaIT2" value="..." style="width:20px">
                                            <SCRIPT type="text/javascript">
                                                Calendar.setup({
                                                    inputField: "fecha_ini2",
                                                    ifFormat: "%d/%m/%Y",
                                                    button: "bfechaIT2"
                                                });
                                            </SCRIPT>

                                    </td>
                                    <td width="10%" align="center"><span class="style10">TRAMITE</span></td>
                                    <td width="20%"><span style="font-size: 10px">
                                            <select name="tramite" id="tramite"  style="width:160px; font-size:10px; color:#333333">
                                                <option value="0"><<--Seleccione Tramite-->></option>
                                                <%                                                Sede sede = (Sede) session.getAttribute("sede");
                                                    java.util.List tramites = modelo.consultarTramites(1, sede.getId_sede());
                                                    for (int i = 0; i < tramites.size(); i++) {
                                                        Tramite tramite = (Tramite) tramites.get(i);
                                                %>
                                                <option value="<%=tramite.getId_tramite()%>"><%= tramite.getNombre()%> </option>
                                                <%   }
                                                    tramites = modelo.consultarTramites(2, sede.getId_sede());
                                                    for (int i = 0; i < tramites.size(); i++) {
                                                        Tramite tramite = (Tramite) tramites.get(i);
                                                %>
                                                <option value="<%=tramite.getId_tramite()%>"><%= tramite.getNombre()%> </option>
                                                <%   } %>
                                            </select>
                                        </span></td>
                                    <td width="10%" scope="col"  align="center" colspan="2"><label style="color:#666666"><span class="style5 style9">FECHA&nbsp;FIN </span></label></td>
                                    <td width="20%" scope="col" align="center" colspan="2"><input id="fecha_fin2" name="fecha_fin2" type="text" style="text-align:center;color:#333333;font:bold; width:100px"/>&nbsp;
                                        <input name="bfechaFT2" type="button" id="bfechaFT2" value="..." style="width:20px">
                                            <SCRIPT type="text/javascript">
                                                Calendar.setup({
                                                    inputField: "fecha_fin2",
                                                    ifFormat: "%d/%m/%Y",
                                                    button: "bfechaFT2"
                                                });
                                            </SCRIPT>

                                    </td>
                                    <td width="10%" scope="col" align="center"><input id="generar2"  name="generar2" type="button" value="Generar" style="color:#333333; width:100px" onClick="paso2()"/></td>
                                    <td><div align="right"><a href="#" onclick="verReporteTramiteExcel()"><img src="../html/images/excel.png" height="25px" width="25px" title="Generar Reporte Excel"></a></div></td>
                                </tr>


                            </table>

                            <table border="0" width="90%" id="Ttabla3" align="center" style=" display:none">
                                <tr valign="middle">
                                    <td width="15%">&nbsp;</td>
                                    <td width="30%" align="center" colspan="2"><span class="style10">ESCRIBA&nbsp;EL A&Ntilde;O</span></td>
                                    <td width="30%" colspan="3" align="center"><span style="font-size: 10px"><span class="style7" style="font-size: 11px">
                                                <input id="ano" name="ano" type="text" style="text-align:center;color:#333333;font:bold; width:100px"/>
                                            </span>

                                        </span></td>
                                    <td width="15%">&nbsp;</td>
                                    <td><div align="right"><a href="#" onclick="verReporteTramiteEstadisticoExcel()"><img src="../html/images/excel.png" height="25px" width="25px" title="Generar Reporte Excel"></a></div></td>
                                    <td width="10%" scope="col" align="center"><input id="generar2"  name="generar2" type="button" value="Generar" style="color:#333333; width:100px" onClick="paso8()"/></td>
                                </tr>


                            </table>
                            <table border="0" width="90%" id="Ttabla4" align="center" style=" display:none">
                                <tr valign="middle">
                                    <td width="15%">&nbsp;</td>
                                    <td width="30%" align="center" colspan="2"><span class="style10">DIGITE &nbsp;EL A&Ntilde;O</span></td>
                                    <td width="30%" colspan="3" align="center"><span style="font-size: 10px"><span class="style7" style="font-size: 11px">
                                                <input id="anoTotal" name="anoTotal" type="text" style="text-align:center;color:#333333;font:bold; width:100px"/>
                                            </span>

                                        </span></td>
                                    <td width="15%">&nbsp;</td>
                                    <td width="10%" scope="col" align="center"><input id="generar2"  name="generar2" type="button" value="Generar" style="color:#333333; width:100px" onClick="paso9()"/></td>
                                </tr>


                            </table>

                            <table border="0" width="90%" id="Ttabla5" align="center" style=" display:none">
                                <tr valign="middle">
                                    <td width="15%">&nbsp;</td>
                                    <td width="30%" align="center" colspan="2"><span class="style10">DIGITE &nbsp;EL A&Ntilde;O</span></td>
                                    <td width="30%" colspan="3" align="center"><span style="font-size: 10px"><span class="style7" style="font-size: 11px">
                                                <input id="anoTotalLiq" name="anoTotalLiq" type="text" style="text-align:center;color:#333333;font:bold; width:100px"/>
                                            </span></span></td>
                                    <td width="15%">&nbsp;</td>
                                    <td width="10%" scope="col" align="center"><input id="generar2"  name="generar2" type="button" value="Generar" style="color:#333333; width:100px" onClick="paso10()"/></td>
                                </tr>
                            </table>



                        </td>
                    </tr>
                </table>
            </fieldset>
            </br>
            <fieldset>
                <table width="100%" border="0" align="center">
                    <tr style="border:none; background:url(../html/images/inicio_3.png)">
                        <td colspan="11" align="center"><span class="style2 style14">CONCEPTOS</span></td>
                    </tr>
                    <tr>
                        <td colspan="2" valign="middle" align="center" width="25%"><span class="Estilo11">
                                <input type="radio" name="busqueda2" id="busqueda2" value="1" checked="checked" onClick="ver2()">
                                    &nbsp;REPORTE GENERAL </span></td>
                        <td colspan="2" valign="middle" align="center" width="25%"><span class="Estilo11">
                                <input type="radio" name="busqueda2" value="3" onClick="ver2()">
                                    &nbsp;REPORTE DETALLADO </span></td>
                        <td colspan="2" valign="middle" align="center" width="25%"><span class="Estilo11">
                                <input type="radio" name="busqueda2" value="3" onClick="ver2()">
                                    RECAUDADO ANUAL</span></td>              	  
                        <td colspan="2" valign="middle" align="center" width="25%"><span class="Estilo11">
                                <input type="radio" name="busqueda2" value="3" onClick="ver2()">
                                    CANTIDAD ANUAL</span></td>              	  

                    </tr>
                    <tr>
                        <td colspan="7">
                            <table border="0" width="90%" id="Ctabla1" align="center">
                                <tr valign="middle">
                                    <td width="10%" scope="col"  align="center" colspan="2"><span class="style7" style="font-size: 11px">
                                            <label style="color:#333333">FECHA&nbsp;INICIAL </label>
                                        </span></td>
                                    <td width="20%" scope="col" align="center" colspan="2"><span class="style7" style="font-size: 11px">
                                            <input id="fecha_iniCon" name="fecha_iniCon" type="text" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; color:#333333;font:bold; width:100px"/>
                                            &nbsp;
                                            <input name="bfechaIC" type="button" id="bfechaIC" value="..." style="width:20px">
                                                <SCRIPT type="text/javascript">
                                                    Calendar.setup({
                                                        inputField: "fecha_iniCon",
                                                        ifFormat: "%d/%m/%Y",
                                                        button: "bfechaIC"
                                                    });
                                                </SCRIPT>

                                        </span></td>
                                    <td width="8%" align="center"><span class="style13">CONCEPTO</span></td>
                                    <td width="22%" align="center"><span style="font-size: 10px">
                                            <select name="concepto" id="concepto"  style="width:160px; font-size:10px; color:#333333">
                                                <option value="0"><<--Seleccione Concepto-->></option>
                                                <% java.util.List conceptos = modelo.listadoConceptosSedeTramite(234);
                                                    for (int i = 0; i < conceptos.size(); i++) {
                                                        Concepto concepto = (Concepto) conceptos.get(i);
                                                %>
                                                <option value="<%=concepto.getId_concepto()%>"><%= concepto.getNombre()%> </option>
                                                <%   } %>
                                            </select>
                                        </span></td>
                                    <td width="10%" scope="col"  align="center" colspan="2"><span class="style7" style="font-size: 11px">
                                            <label style="color:#666666"><span class="style8">FECHA&nbsp;FIN </span></label>
                                        </span></td>
                                    <td width="20%" scope="col" align="center" colspan="2"><span class="style7" style="font-size: 11px">
                                            <input id="fecha_finCon" name="fecha_finCon" type="text" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; color:#333333;font:bold; width:100px"/>
                                            &nbsp;
                                            <input name="bfechaFC" type="button" id="bfechaFC" value="..." style="width:20px">
                                                <SCRIPT type="text/javascript">
                                                    Calendar.setup({
                                                        inputField: "fecha_finCon",
                                                        ifFormat: "%d/%m/%Y",
                                                        button: "bfechaFC"
                                                    });
                                                </SCRIPT>

                                        </span></td>


                                    <td width="10%" scope="col" align="center"><input  name="generarConGen" type="button" id="generarConGen" style="width:100px" onClick="paso3()" value="Generar"/></td>
                                </tr>
                            </table>



                            <table border="0" width="90%" id="Ctabla2" align="center" style=" display:none">
                                <tr valign="middle">
                                    <td width="10%" scope="col"  align="center" colspan="2"><label style="color:#666666"><span class="style5"><span class="style9">FECHA&nbsp;INICIAL</span></span></label></td>
                                    <td width="20%" scope="col" align="center" colspan="2"><input id="fecha_iniCon2" name="fecha_iniCon2" type="text" style="text-align:center;color:#333333;font:bold; width:100px"/>&nbsp;
                                        <input name="bfechaIC2" type="button" id="bfechaIC2" value="..." style="width:20px">
                                            <SCRIPT type="text/javascript">
                                                Calendar.setup({
                                                    inputField: "fecha_iniCon2",
                                                    ifFormat: "%d/%m/%Y",
                                                    button: "bfechaIC2"
                                                });
                                            </SCRIPT>

                                    </td>
                                    <td width="8%" align="center"><span class="style10">CONCEPTO</span></td>
                                    <td width="22%" align="center"><span style="font-size: 10px">
                                            <select name="concepto2" id="concepto2"  style="width:160px; font-size:10px; color:#333333">
                                                <option value="0"><<--Seleccione Concepto-->></option>
                                                <% java.util.List conceptos2 = modelo.listadoConceptosSedeTramite(234);
                                                    for (int i = 0; i < conceptos2.size(); i++) {
                                                        Concepto concepto2 = (Concepto) conceptos2.get(i);
                                                %>
                                                <option value="<%=concepto2.getId_concepto()%>"><%= concepto2.getNombre()%> </option>
                                                <%   } %>
                                            </select>

                                        </span></td>
                                    <td width="10%" scope="col"  align="center" colspan="2"><label style="color:#666666"><span class="style5 style9">FECHA&nbsp;FIN </span></label></td>
                                    <td width="20%" scope="col" align="center" colspan="2"><input id="fecha_finCon2" name="fecha_finCon2" type="text" style="text-align:center;color:#333333;font:bold; width:100px"/>&nbsp;
                                        <input name="bfechaFC2" type="button" id="bfechaFC2" value="..." style="width:20px">
                                            <SCRIPT type="text/javascript">
                                                Calendar.setup({
                                                    inputField: "fecha_finCon2",
                                                    ifFormat: "%d/%m/%Y",
                                                    button: "bfechaFC2"
                                                });
                                            </SCRIPT>

                                    </td>


                                    <td width="10%" scope="col" align="center"><input id="generar2"  name="generar2" type="button" value="Generar" style="color:#333333; width:100px" onClick="paso4()"/></td>
                                </tr>


                            </table>
                            <table border="0" width="90%" id="Ctabla3" align="center" style=" display:none">
                                <tr valign="middle">
                                    <td width="15%">&nbsp;</td>
                                    <td width="30%" align="center" colspan="2"><span class="style10">ESCRIBA&nbsp;EL A&Ntilde;O</span></td>
                                    <td width="30%" colspan="3" align="center"><span style="font-size: 10px"><span class="style7" style="font-size: 11px">
                                                <input id="anoCT" name="anoCT" type="text" style="text-align:center;color:#333333;font:bold; width:100px"/>
                                            </span>

                                        </span></td>
                                    <td width="15%">&nbsp;</td>
                                    <td width="10%" scope="col" align="center"><input id="generar2"  name="generar2" type="button" value="Generar" style="color:#333333; width:100px" onClick="paso12()"/></td>
                                </tr>


                            </table>
                            <table border="0" width="90%" id="Ctabla4" align="center" style=" display:none ">
                                <tr valign="middle">
                                    <td width="15%">&nbsp;</td>
                                    <td width="30%" align="center" colspan="2"><span class="style10">ESCRIBA&nbsp;EL A&Ntilde;O</span></td>
                                    <td width="30%" colspan="3" align="center"><span style="font-size: 10px"><span class="style7" style="font-size: 11px">
                                                <input id="anoCT2" name="anoCT2" type="text" style="text-align:center;color:#333333;font:bold; width:100px"/>
                                            </span>

                                        </span></td>
                                    <td width="15%">&nbsp;</td>
                                    <td width="10%" scope="col" align="center"><input id="generar2"  name="generar2" type="button" value="Generar" style="color:#333333; width:100px" onClick="paso13()"/></td>
                                </tr>


                            </table>




                        </td>
                    </tr>
                </table>
            </fieldset>

            </br>
            <fieldset>
                <table width="100%" border="0" align="center">
                    <tr style="border:none; background:url(../html/images/inicio_3.png)">
                        <td colspan="11" align="center"><span class="style2 style14">CARTERA</span></td>
                    </tr>          

                    <tr>
                        <td colspan="4" valign="middle" align="center" width="50%"><span class="Estilo11">
                                POR &nbsp;MODELO - GENERAL </span></td>


                    </tr>
                    <tr>
                        <td colspan="7">
                            <table border="0" width="90%" id="tabla5" align="center">
                                <tr valign="middle">
                                    <td width="10%" scope="col"  align="center" colspan="2"><span class="style7" style="font-size: 11px">
                                            <label style="color:#333333">MODELO&nbsp;INICIAL </label>
                                        </span></td>
                                    <td width="20%" scope="col" align="center" colspan="2"><span class="style7" style="font-size: 11px">
                                            <input id="modelo_ini" name="modelo_ini" type="text" style="text-align:center;color:#333333;font:bold; width:100px"/>

                                        </span></td>


                                    <td width="10%" scope="col"  align="center" colspan="2"><span class="style7" style="font-size: 11px">
                                            <label style="color:#666666"><span class="style8">MODELO&nbsp;FINAL </span></label>
                                        </span></td>
                                    <td width="20%" scope="col" align="center" colspan="2"><span class="style7" style="font-size: 11px">
                                            <input id="modelo_fin" name="modelo_fin" type="text" style="text-align:center;color:#333333;font:bold; width:100px"/>
                                        </span></td>


                                    <td width="10%" scope="col" align="center"><input  name="modelo" type="button" id="modelo" style="width:100px" onClick="paso5()" value="Generar"/></td>
                                </tr>
                            </table>








                        </td>
                    </tr>
                </table>
            </fieldset>
            </br>
            <fieldset>
                <table width="100%" border="0" align="center">
                    <tr style="border:none; background:url(../html/images/inicio_3.png)">
                        <td colspan="11" align="center"><span class="style2 style14">PAGOS</span></td>
                    </tr>

                    <tr>
                        <td colspan="2" valign="middle" align="center" width="50%"><span class="Estilo11">&nbsp;ANULADOS</span></td>


                    </tr>
                    <tr>
                        <td colspan="7">
                            <table border="0" width="90%" id="Ptabla1" align="center">
                                <tr valign="middle">
                                    <td width="10%" scope="col"  align="center" colspan="2"><span class="style7" style="font-size: 11px">
                                            <label style="color:#333333">FECHA&nbsp;INICIAL </label>
                                        </span></td>
                                    <td width="20%" scope="col" align="center" colspan="2"><span class="style7" style="font-size: 11px">
                                            <input id="fecha_iniPag" name="fecha_iniPag" type="text" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; color:#333333;font:bold; width:100px"/>
                                            &nbsp;
                                            <input name="bfechaIPag" type="button" id="bfechaIPag" value="..." style="width:20px">
                                                <SCRIPT type="text/javascript">
                                                    Calendar.setup({
                                                        inputField: "fecha_iniPag",
                                                        ifFormat: "%d/%m/%Y",
                                                        button: "bfechaIPag"
                                                    });
                                                </SCRIPT>

                                        </span></td>

                                    <td width="10%" scope="col"  align="center" colspan="2"><span class="style7" style="font-size: 11px">
                                            <label style="color:#666666"><span class="style8">FECHA&nbsp;FIN </span></label>
                                        </span></td>
                                    <td width="20%" scope="col" align="center" colspan="2"><span class="style7" style="font-size: 11px">
                                            <input id="fecha_finPag" name="fecha_finPag" type="text" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; color:#333333;font:bold; width:100px"/>
                                            &nbsp;
                                            <input name="bfechaFPag" type="button" id="bfechaFPag" value="..." style="width:20px">
                                                <SCRIPT type="text/javascript">
                                                    Calendar.setup({
                                                        inputField: "fecha_finPag",
                                                        ifFormat: "%d/%m/%Y",
                                                        button: "bfechaFPag"
                                                    });
                                                </SCRIPT>

                                        </span></td>


                                    <td width="10%" scope="col" align="center"><input  name="generarConGen2" type="button" id="generarConGen2" style="width:100px" onClick="paso11()" value="Generar"/></td>
                                </tr>
                            </table>






                        </td>
                    </tr>
                </table>
            </fieldset>

            </br>






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
