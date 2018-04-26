<%-- 
    Document   : verFinanciacion
    Created on : 2/06/2011, 05:18:05 PM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" import="modelo.*" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                Model model = (Model) session.getAttribute("model");
                if(request.getParameter("idFinanciacion")!=null||request.getParameter("numeroF")!=null){
                    Financiacion financiacion = null;
                    long idFinanciacion = 0;
                    if(request.getParameter("idFinanciacion")!=null){
                        idFinanciacion = Long.parseLong(request.getParameter("idFinanciacion"));
                        financiacion = model.consultarFinanciacion(idFinanciacion);
                    }else{
                        if(request.getParameter("numeroF")!=null){
                            financiacion = model.consultarFinanciacion(request.getParameter("numeroF").trim().toUpperCase());
                        }
                    }
                    if(financiacion!=null){
                      idFinanciacion = financiacion.getId_financiacion();
                      String estado = model.consultarParametroName(59, financiacion.getEstado());
                      String placa = "";
                      Vehiculo vehiculo = model.consultarVehiculoById(financiacion.getFk_vehiculo());
                      if(vehiculo!=null)
                          placa = vehiculo.getPlaca();
                      Persona p = model.consultarPersona(financiacion.getFk_persona());
                      String persona = "";
                      if(p!=null){
                          String tipoD = model.crearHashParametrosAbreviatura(5).get(p.getTipo_documento()+"").toString();
                          persona = tipoD+" "+p.getDocumento()+" - "+p.getNombre_1()+" "+p.getApellido_1();
                      }
                      Tipo_Financiacion tipo = model.consultarTipoDeFinanciacion(financiacion.getFk_tipo_financiacion());
                      String tipoF = "";
                      if(tipo!=null)
                          tipoF = tipo.getNombre();
                          HashMap parametersN = new java.util.HashMap();
                          parametersN.put("ID_FINANCIACION",idFinanciacion);
                          session.setAttribute("AcuerdoPago", parametersN);
                          String direccionN = "financiaciones/AcuerdoPago.jasper";
                          String nombreN = "AcuerdoPago";


%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Financiacion</title>

        <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <meta http-equiv=Content-Type content="text/html; charset=windows-1252"/>
        <link title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script src="../html/scripts/motorAjax.js" type="text/javascript"></script>
        <script src="../html/scripts/financiacion.js" type="text/javascript"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <script type="text/javascript">
            
            function reporteAcuerdo(dir,nombre){
                ancho = 789;
                alto = 600;
                barra = 0;
                izquierda = (document.width) ? (document.width-ancho)/2 : 100;
                arriba = (document.height) ? (document.height-alto)/2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
                window.open(url, 'popUp', opciones);
            }

            function anularF(){
                //alert("id fin : "+document.getElementById("observaciones").value);
                 if(confirm("Desea Eliminar el Acuerdo de Pago")){
                    var fin = document.getElementById("idFinanc").value;
                    var Obs = document.getElementById("observaciones").value;
                     if(document.getElementById("observaciones").value.length!=0){
                         window.location.href = "procesar_anular_financiacion.jsp?idFinanciacion="+fin+"&observaciones="+Obs;
                     }else{
                         alert("Debe ingresar una Observacion");
                     }
                 }
            }






        </script>
        <style type="text/css">
            .label {font-size: 11px; color:#333333; text-align:left ; font-family:Arial; font-weight:bold ; width:100px}
            .text {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; width:100px; text-transform:uppercase}
            .column {font-size: 11px; color:#333333; text-align:center ; font-family:Arial; font-weight:bold ; width:70px}
            .detalle {font-size: 10px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; width:70px }
            .check { font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; }
            .title {font-size: 12px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; text-transform:uppercase}
        </style>
    </head>
    <body>
        <div align="center">
            <div style="width:840px" align="center">
                <table width="840px" border="0" align="center">
                    <tr>
                        <td colspan="2" align="center"><span class="title">DATOS DE LA FINANCIACION</span></td>
                    </tr>
                    <tr>
                        <td colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="2" scope="col" align="center">
                            <fieldset>
                                <form action="javascript:consultarDatosFinanciacion()">
                                    <input type="hidden" id="idFinanc" name="idFinanc" value="<%=idFinanciacion%>"/>
                                    <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                        <tr>
                                            <td scope="col" class="label">Numero</td>
                                            <td scope="col"><input name="text" type="text" class="text" value="<%=financiacion.getNumero()%>" readonly/></td>
                                            <td scope="col" class="label">Fecha</td>
                                            <td scope="col"><input name="fecha" type="text" class="text" value="<%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(financiacion.getFecha())%>" readonly/></td>
                                            <td scope="col" class="label">Valor</td>
                                            <td scope="col"><input name="valor" type="text" class="text" value="<%=new java.text.DecimalFormat("#,##0").format(financiacion.getValor())%>" readonly/></td>
                                        </tr>
                                        <tr>
                                            <td scope="col" class="label">Cuota Inicial</td>
                                            <td scope="col"><input name="text" type="text" class="text" value="<%=financiacion.getCuota_inicial()%>" readonly/></td>
                                            <td scope="col" class="label">Numero Cuotas</td>
                                            <td scope="col"><input name="fecha" type="text" class="text" value="<%=financiacion.getCuotas()%>" readonly/></td>
                                            <td scope="col" class="label">Observacion</td>
                                            <td scope="col"><input name="valor" type="text" class="text" value="" readonly/></td>
                                        </tr>
                                        <tr>
                                            <td scope="col" class="label">Estado</td>
                                            <td scope="col"><input name="text" type="text" class="text" value="<%=estado%>" readonly/></td>
                                            <td scope="col" class="label">Tipo Financiacion</td>
                                            <td scope="col" colspan="2">
                                                <input name="fecha" type="text" class="text" value="<%=tipoF%>" style="width:300px" readonly/>										</td>
                                            <td  align="center">
                                                <% if(financiacion.getEstado()!=3){ %>
                                                <input name="reporte" type="button" class="check" value="Ver Reporte" onclick="reporteAcuerdo('<%=direccionN%>','<%=nombreN%>')"/>
                                                <% } %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td scope="col" class="label">Placa</td>
                                            <td scope="col">
                                                <input id="placa" name="placa" type="text" class="text" maxlength="6" value="<%=placa%>" readonly/>										</td>
                                            <td scope="col" class="label">Persona</td>
                                            <td colspan="2" scope="col"><input type="text" readonly name="nombre_rs" id="nombre_rs" value="<%=persona%>" class="text" style="width:300px"/></td>
                                            <td  align="center">
                           <%                   if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("anularAcuerdos")&&financiacion.getEstado()!=3){ %>
                                            <input name="reporte" type="button" class="check" value="Anular Financiacion" onclick="anularF()"/></td>
                                                </td>
                                        </tr>
                                         <tr>
                                            <td scope="col" class="label">Observaciones</td>
                                            <td scope="col" colspan="4">
                                                <input id="observaciones" name="observaciones" style="width:530px;" type="text" class="text"/>										</td>

                                        </tr>
                           <%                   } %> 
                                    </tr>
                                        
                                    </table>
                                </form>
                            </fieldset>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td width="420px" valign="top">
                            <table width="420px" border="0" id="contenedor" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td valign="top" width="420px">
                                        <fieldset>
                                            <legend class="label">Detalle de Financiacion</legend>
                                            <table border="1" align="center" cellpadding="1" cellspacing="0" width="370px">
                                                <thead>
                                                    <tr>
                                                        <td class="column" style="width:40px">Cuota</td>
                                                        <td class="column">Fecha Pago</td>
                                                        <td class="column">Valor&nbsp;$</td>
                                                        <td class="column">Interes&nbsp;%</td>
                                                        <td class="column">Saldo&nbsp;$</td>
                                                        <td class="column">Estado</td>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                    java.util.List<Detalle_Financiacion> listaF = model.consultarDetalleFinanciacion(financiacion.getId_financiacion());
                                                    java.util.HashMap estadoDF = model.crearHashParametros(353);
                                                    for(Detalle_Financiacion df:listaF){ %>
                                                        <tr>
                                                            <td class="detalle" style="width:40px"><%=df.getCuota()%></td>
                                                            <td class="detalle"><%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(df.getFecha_pago())%></td>
                                                            <td class="detalle"><%=new java.text.DecimalFormat("#,##0").format(df.getValor())%></td>
                                                            <td class="detalle"><%=df.getIntereses()%></td>
                                                            <td class="detalle"><%=new java.text.DecimalFormat("#,##0").format(df.getSaldo())%></td>
                                                            <td class="detalle"><%=estadoDF.get(df.getEstado()+"")%></td>
                                                        </tr>
                                                 <% } %>
                                                </tbody>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="420px" valign="top">
                            <table width="420px" border="0" id="contenedor" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td valign="top" width="420px">
                                        <fieldset>
                                            <legend class="label">Carteras Financiadas</legend>
                                            <table border="1" align="center" cellpadding="1" cellspacing="0" width="370px">
                                                <thead>
                                                    <tr>
                                                        <td class="column" style="width:200px">Concepto</td>
                                                        <td class="column">Referencia</td>
                                                        <td class="column">Valor&nbsp;$</td>
                                                        <td class="column">Estado</td>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                    java.util.List<Financiacion_Cartera> listaC = model.consultarCarterasFinanciadas(financiacion.getId_financiacion());
                                                    java.util.HashMap estadoC = model.crearHashParametros(21);
                                                    for(Financiacion_Cartera dc:listaC){
                                                        Cartera cartera = model.consultarCartera(dc.getFk_cartera());
                                                        Concepto concepto = model.consultarConcepto(cartera.getFk_concepto()); %>
                                                        <tr>
                                                            <td class="detalle" style="width:200px"><%=concepto.getNombre()%></td>
                                                            <td class="detalle"><%=cartera.getReferencia()%></td>
                                                            <td class="detalle"><%=new java.text.DecimalFormat("#,##0").format(cartera.getSaldo())%></td>
                                                            <td class="detalle"><%=estadoC.get(cartera.getEstado_cartera()+"")%></td>
                                                        </tr>
                                                 <% } %>
                                                </tbody>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </body>
</html>
            <%      }else{ %>
                    <script type="text/javascript">
                        alert("No hay resultados para la consulta");
                   </script>
                <%  }
                }
            } else {%>
                <jsp:forward page="no_access.jsp">
                    <jsp:param name="tipo" value="1"></jsp:param>
                </jsp:forward>
       <%  }
      } else {%>
        <script type="text/javascript">
            window.parent.document.location.href = "../../index.jsp";
        </script>  <%
      }
   } catch (Exception mexe) {%>
        <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% }  %>