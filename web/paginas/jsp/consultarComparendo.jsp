<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
        if(session.getAttribute("model")!=null){
                if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("buscarComparendo.jsp")){
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Mostrar Comparendo</title>
        <style type="text/css">
            <!--
            .Estilo1 {
                color: #333333;
                font-weight: bold;
                font-size: 11px;
            }
            .Estilo2 {color: #333333;font-size: 11px;}
            .Estilo8 {
                color: #333333;
                font-weight: bold;
                font-size: 11px;
            }
            .style2 {color: #333333; font-weight: bold; font-size: 11px; font-family: Tahoma; }
            .Estilo9 {font-size: 11px}
            .style3 {
                font-size: 12px;
                color: #FFFFFF;
            }
            .style4 {color: #FFFFFF}
            .style5 {color: #FFFFFF; font-weight: bold; font-size: 11px; }
.style7 {color: #333333; font-weight: bold; font-size: 9px; font-family: Tahoma; }
            -->
        </style>


<script language="javascript">

	function verReporte(dir,nombre){
            ancho = 789;
            alto = 600;
            barra = 0;
            izquierda = (document.width) ? (document.width-ancho)/2 : 100;
            arriba = (document.height) ? (document.height-alto)/2 : 100;
            opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
            url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
            window.open(url, 'popUp', opciones);
        }
        </script>

    </head>
    <%@ page import="modelo.*"%>
    <%@page import="java.util.*"%>
    <%
                        String comparendo = "";
                        Model modelo = (Model) session.getAttribute("model");
                        HashMap parameters = new java.util.HashMap();
                        if (request.getParameter("id").equals("0")) {
                            comparendo = request.getParameter("comparendo");
                        } else {
                            comparendo = session.getAttribute("comparendo") + "";
                        }
                        if (comparendo != null) {
                            if (!comparendo.equals("")) {
                                Comparendo cparendo = modelo.consultar_Comparendo(comparendo);
                                if (cparendo != null) {
                                    session.setAttribute("comparendo", comparendo);
                                    parameters.put("COMPARENDO", comparendo);
                                    session.setAttribute("reporteComparendo", parameters);
                                    String direccion = "comparendos/comparendo.jasper";
                                    String nombreR = "reporteComparendo";
                                    Persona persona = new Persona();
                                    Cartera cartera = new Cartera();

                                    Sede sede = new Sede();
                                    Agente agente = new Agente();
                                    Parametro parametro = new Parametro();
                                    Parametro parametro1 = new Parametro();
                                    Infraccion infraccion = new Infraccion();

                                    Detalle_Cartera detalle = new Detalle_Cartera();
                                    Detalle_Concepto det_concepto = new Detalle_Concepto();
                                    Valor_Infraccion valor_infraccion = new Valor_Infraccion();

                                    long id_persona = cparendo.getFk_persona();
                                    persona = modelo.consultarPersona(id_persona);
                                    agente = modelo.consultar_Agente_PorId(cparendo.getFk_agente());
                                    parametro = modelo.consultarParametro(cparendo.getClase(), 1);

                                    Licencia_Conduccion licenciaConduccion = null;
                                    if (false) {
                                        //licenciaConduccion = modelo.consultarLicencia(cparendo.getFk_licencia());
                                    }
    %>
    <body>
        <table width="59%" align="center" border="0">
            <tr>
                <td width="100%">
                    <fieldset>

                        <table width="100%" border="0" align="center">
						<tr>
            <td colspan="6" align="right">
			<img src="../html/images/reporte.png" width="22" height="22" style="cursor:pointer" onclick="verReporte('<%=direccion%>','<%=nombreR%>')"/><span class="style7">REPORTE</span></td>
  </tr>
                            <tr class="style2" style="border:none; background:url(../html/images/inicio_3.png)">
                                <td colspan="5" align="center"> <span class="style7 style3">DATOS DEL COMPARENDO</span></td>
                            </tr>
                            <tr>
                                <td class="style2" colspan="4">
                                    <table width="100%" border="0" align="center">
                                        <tr>
                                            <td width="19%" align="right"><span class="Estilo2">Nº&nbsp;COMPARENDO </span></td>
                                            <td width="81%" class="style2"><input name="textfield2" type="text"  readonly="" value="<%=cparendo.getNumero()%>" style="text-align:center; width:150px"/></td>
                                        </tr>
                                    </table>	 </td>
                            </tr>
                            <tr class="style2">
                                <td width="134" class="style2"><span class="Estilo2">FECHA&nbsp;COMPARENDO </span></td>
                                <td width="259"><span class="Estilo2">
                                        <label>
                                            <input name="textfield" type="text" readonly="" value="<%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(cparendo.getFecha())%>" style="text-align:center; width:150px"/>
                                        </label>
                                    </span> </td>
                                <td width="102"><span class="Estilo2">HORA </span> </td>
                                <td width="208" colspan="3" class="style2"><span class="Estilo2">
                                        <label>
                                            <input name="textfield3" type="text" readonly="" value="<%= new java.text.SimpleDateFormat("H:mm").format(cparendo.getFecha())%>" style="text-align:center; width:150px"/>
                                        </label>
                                    </span> </td>
                            </tr>
                            <tr>
                                <td class="style2"><span class="Estilo2">LUGAR&nbsp;COMPARENDO </span></td>
                                <td colspan="4" class="style2"><input name="textfield4"  readonly="" type="text" value="<%=cparendo.getLugar()%>" style="width:520px"/></td>
                            </tr>
                            <tr>
                                <td class="style2"><span class="Estilo2">PLACA VEHICULO </span></td>
                                <td class="style2"><span class="Estilo2">
                                        <label>
                                            <input name="textfield5" type="text"  readonly="" value="<%=cparendo.getPlaca()%>" style="text-align:center; width:150px"/>
                                        </label>
                                    </span></td>
                                <td><span class="style2">LIC.&nbsp;TRANSITO </span></td>
                                <td colspan="2" class="style2"><span class="Estilo2">
                                        <label>
                                            <input name="textfield6" type="text" readonly="" value="<%=licenciaConduccion != null ? cparendo.getLicencia_transito() : ""%>" style="text-align:center; width:150px"/>
                                        </label>
                                    </span></td>
                            </tr>
                            <tr>
                                <td class="style2"><span class="Estilo2">CLASE VEHICULO </span></td>
                                <td class="style2"><span class="Estilo2">
                                        <label>
                                            <input name="textfield7" type="text" readonly="" value="<%=parametro != null ? parametro.getNombre() : ""%>" style="text-align:center; width:150px" />
                                        </label>
                                    </span></td>
                                <td><span class="style2">SERVICIO</span></td>
                                <%parametro = null;

                    parametro1 = modelo.consultarParametro(cparendo.getServicio(), 3);%>
                                <td colspan="2" class="style2"><span class="Estilo2">
                                        <label>
                                            <input type="text" name="textfield8"  readonly="" value="<%=parametro1 != null ? parametro1.getNombre() : ""%>" style="text-align:center; width:150px"/>
                                        </label>
                                    </span></td>
                            </tr>
                        </table>
                    </fieldset>

                    <fieldset>
                        <table width="100%" border="0" align="center">
                            <tr class="style2" style="border:none; background:url(../html/images/inicio_3.png)">
                                <td colspan="5" align="center"> <span class="style7 style3">DATOS DEL INFRACTOR </span></td>
                            </tr>
                            <tr>
                                <td class="style2"><span class="Estilo2">TIPO&nbsp;DOCUMENTO </span></td>
                                <td><span class="Estilo2">
                                        <% parametro = null;
                    parametro = modelo.consultarParametro(persona.getTipo_documento(), 5);%>
                                        <label>
                                            <input name="textfield9" type="text" readonly="" value="<%=parametro.getNombre()%>" style="text-align:center; width:150px; font-size:11px"/>
                                        </label>
                                    </span></td>
                                <td><span class="style2">DOCUMENTO</span></td>
                                <td colspan="2"><span class="Estilo2">
                                        <label>
                                            <input name="textfield10" type="text" readonly="" value="<%=persona.getDocumento()%>" style="text-align:center; width:150px" />
                                        </label>
                                    </span></td>
                            </tr>
                            <tr>
                                <td class="style2"><span class="Estilo2">NOMBRE&nbsp;INFRACTOR</span></td>
                                <td colspan="4"><span class="Estilo2">
                                        <label>
                                            <input name="textfield11" type="text"  readonly="" value="<%= persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "") + " " + persona.getNombre_1() + " " + (persona.getNombre_2() != null ? persona.getNombre_2() : "")%>" size="84" style="width:520px"/>
                                        </label>
                                    </span></td>
                            </tr>
                            <tr>
                                <td class="style2"><span class="Estilo2">TIPO&nbsp; INFRACTOR </span></td>
                                <% parametro = null;
                    parametro = modelo.consultarParametro(cparendo.getTipo_infractor(), 6);%>
                                <td><span class="Estilo2">
                                        <label>
                                            <input type="text" name="textfield12" readonly="" value="<%=parametro.getNombre()%>" style="text-align:center; width:150px"/>
                                        </label>
                                    </span></td>
                                <td><span class="Estilo2"></span></td>
                                <td colspan="2"><span class="Estilo2"></span></td>
                            </tr>
                            <tr>
                                <td class="style2"><span class="Estilo2">INFRACCION</span></td>
                                <%             infraccion = modelo.consultarInfraccion(cparendo.getFk_infraccion());
                    String cadena_infraccion = infraccion.getDescripcion();%>
                                <td colspan="4"><span class="Estilo2">
                                        <label>
                                            <input name="textfield13" type="text" readonly="" value="<%=infraccion.getNumero() + " " + cadena_infraccion%>" style="width:520px; font-size:11px"/>
                                        </label>
                                    </span></td>
                            </tr>

                            <%  String numero_licencia = "";
                                         String nombre_sede = "";
                                         String categoria = "";
                                         String fecha = "";
                                         if (licenciaConduccion != null) {
                                             numero_licencia = licenciaConduccion.getNumeroLicencia();
                                             categoria = licenciaConduccion.getCategoria();
                                             sede = modelo.consultarSede(licenciaConduccion.getFk_sede());

                                             if (sede != null) {
                                                 nombre_sede = sede.getNombre_corto();
                                             }

                                             if (licenciaConduccion.getFechaVencimiento() != null) {
                                                 fecha = new java.text.SimpleDateFormat("dd/MM/yyyy").format(licenciaConduccion.getFechaVencimiento());
                                             }

                                         }
                            %>


                        </table>
                    </fieldset>
                    <fieldset>

                        <table width="100%" border="0" align="center">
                            <tr class="style2" style="border:none; background:url(../html/images/inicio_3.png)">
                                <td colspan="5" align="center"> <span class="style7 style3">DATOS DEL AGENTE </span></td>
                            </tr>
                            <tr>
                                <td width="133" class="style2"><span class="Estilo2">PLACA </span></td>
                                <td width="222"><span class="Estilo2">
                                        <label>
                                            <input name="textfield16" type="text" readonly="" value="<%=agente.getPlaca()%>" style="text-align:center; width:150px"/>
                                        </label>
                                    </span></td>
                                <td width="129">&nbsp;</td>
                                <td width="206"><span class="Estilo2">
                                        <label></label>
                                    </span></td>
                            </tr>
                            <tr>
                                <td class="style2">NOMBRE</td>
                                <td colspan="4"><span class="Estilo2">
                                        <label>
                                            <input name="textfield17" type="text" readonly="" value="<%= agente.getNombre()%>" style="width:520px"/>
                                        </label>
                                    </span></td>
                            </tr>
                            <tr>
                                <td class="style2">OBSERVACIONES</td>
                                <td colspan="4"><span class="Estilo2">
                                        <label>
                                            <input name="textfield18" type="text" readonly="" value="<%=cparendo.getObservaciones() != null ? cparendo.getObservaciones() : ""%>" style="width:520px"/>
                                        </label>
                                    </span></td>
                            </tr>
                            <%  if (cparendo.getInmovilizacion() == 1) {
                        Patio patio = modelo.consultarPatioComparendo(cparendo.getId_comparendo());%>
                            <tr>
                                <td class="style2">PARQUEADERO</td>
                                <td colspan="4"><span class="Estilo2">
                                        <label>
                                            <input name="textfield19" type="text" readonly="" value="<%=patio != null ? patio.getNombre() : ""%>" style="width:520px"/>
                                        </label>
                                    </span></td>
                            </tr>
                            <% }%>
                            <tr class="style2">
                                <td colspan="5"><table width="100%" border="0" align="center">
                                        <tr class="style2" style="border:none; background:url(../html/images/inicio_3.png)">
                                            <td width="15%"><div align="center" class="Estilo2 Estilo9 style4">FUGA</div></td>
                                            <td width="15%"><div align="center" class="style5">ACCIDENTE</div></td>
                                            <td width="15%"><div align="center" class="style5">INMOVILIZACION</div></td>
                                            <td width="15%"><div align="center" class="style5">POLICIA&nbsp;CARRETERA </div></td>
                                            <td width="15%"><div align="center" class="style5">FIRMA&nbsp;INFRACTOR </div></td>
                                        </tr>
                                        <tr>
                                            <td><div align="center" class="Estilo8"><%=cparendo.getFuga() == 1 ? "SI" : "NO"%></div></td>
                                            <td><div align="center" class="Estilo8"><%=cparendo.getAccidente() == 1 ? "SI" : "NO"%></div></td>
                                            <td><div align="center" class="Estilo8"><%=cparendo.getInmovilizacion() == 1 ? "SI" : "NO"%></div></td>
                                            <td><div align="center" class="Estilo8"><%=cparendo.getPolca() == 1 ? "SI" : "NO"%></div></td>
                                            <td><div align="center" class="Estilo8"><%=cparendo.getFirmado() == 1 ? "SI" : "NO"%></div></td>
                                        </tr>
                                    </table></td>
                            </tr>
                        </table>
                    </fieldset></td>
            </tr>
        </table>
    </body>
    <%
                    } else {
    %>
    <script  language="javascript" type="text/javascript">
        alert("El Comparendo No Existe, Por Favor Verifique !");
    </script>
    <%                }
                }
            } else {%>
    <script  language="javascript" type="text/javascript">
        alert("El Comparendo No Existe, Por Favor Verifique !");
    </script>
    <%                    }
                } else {%>
    <jsp:forward page="no_access.jsp">
        <jsp:param name="tipo" value="1"></jsp:param>
    </jsp:forward>
    <%  }
        } else {%>
    <script>
        window.parent.document.location.href = "../../../index.jsp";
    </script>  <%    }
} catch (Exception mexe) {
    mexe.printStackTrace();%>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
    <%
            }%>


