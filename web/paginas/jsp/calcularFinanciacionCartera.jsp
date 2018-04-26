<%--
    Document   : calcularFinanciacionCartera
    Created on : 17/02/2010, 11:03:46 AM
    Author     : Jorge Lopez
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%


%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <script type="text/javascript">
            function sombrear(tr){
                tr.style.backgroundColor="#CCCCCC";
            }
            function renovar(tr){
                tr.style.backgroundColor="#FFFFFF";
            }
        </script>
        <style type="text/css">
            .label {font-size: 11px; color:#333333; text-align:center ; font-family:Arial; font-weight:bold ;}
            .text {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ;}
            .check { font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; }
			.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
        </style>
    </head>
    <body>
            <%
            modelo.Model model = (modelo.Model) session.getAttribute("model");
            double intereses = 0;
            if(session.getAttribute("carteraF")!=null){
                if (request.getParameter("idF")!=null&&request.getParameter("cuota_inicial")!=null&&request.getParameter("fecha_inicio")!=null&&request.getParameter("ncuotas")!=null) {
                    java.util.List<modelo.Cartera> listaF = (java.util.List<modelo.Cartera>) session.getAttribute("carteraF");
                    float cI = Float.parseFloat(request.getParameter("cuota_inicial"));
                    int nC = Integer.parseInt(request.getParameter("ncuotas"));
                    java.sql.Date fI = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_inicio")).getTime());

                    float total = 0;
                    for (modelo.Cartera c : listaF) {
                        total += c.getSaldo();
                    }
                    if(total>=0){
                        modelo.Tipo_Financiacion tipoF = model.consultarTipoDeFinanciacionByTotal(total);
                        if (tipoF != null) {
                            long idF = tipoF.getId_tipoFinanciacion();
                            double cuotaInicial = (float)tipoF.getInicial_desde();
                            int nCuotas = tipoF.getCuotas_hasta();
                            if((long)cI>=(long)cuotaInicial){
                                if(nC<=nCuotas){
                                    procesos.calcularAmortizacion amortizacion = new procesos.calcularAmortizacion(3,nC, (double)total, (double)cI, intereses, fI);
                                    utility.Cuota[] cuotas = amortizacion.getCuotas();
                                    double sumaAbonos = 0;
                                    double sumaInteres = 0;
                                    if(cuotas!=null){ %>
                                     <form name="form" method="post" target="proceso" action="adicionarFinanciacion.jsp">
                                        <input type="hidden" name="idF" value="<%=idF%>"/>
                                        <input type="hidden" name="nCuotas" value="<%=nC%>"/>
                                        <input type="hidden" name="cInicial" value="<%=cI%>"/>
                                        <input type="hidden" name="fInicial" value="<%=request.getParameter("fecha_inicio")%>"/>
                                         <table border="1" width="100%" cellpadding="1" cellspacing="0">
                                            <thead style="position:relative;">
                                                <tr>
                                                        <td class="label">CUOTA&nbsp;#</td>
                                                        <td class="label">FECHA PAGO</td>
                                                        <td class="label">VALOR</td>
                                                        <td class="label">INTERES</td>
                                                        <td class="label">TOTAL</td>
                                                </tr>
                                            </thead>
                                            <tfoot>
                                                <tr>
                                                    <td colspan="5">
                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                            <tr>
                                                                <td class="label">Observacion</td>
                                                                <td><input type="text" class="text" style="width:150px" readonly name="observacion" id="observacion"/></td>
                                                                <td scope="col">
                                                                    <% if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("aplicarFinanciacion")) {%>
<button type="submit" class="check" onclick="registrarFinanciacion()"><span class="style2">Financiar </span><img src="../html/images/financiar.jpg" width="19" height="18"/></button>																	
           <!-- <input type="submit" class="check" value="Financiar" onclick="registrarFinanciacion()"/> -->
                                                                    <% } else {%>
<button type="submit" class="check" disabled="disabled" onclick="registrarFinanciacion()"><span class="style2">Financiar </span><img src="../html/images/financiar.jpg" width="19" height="18"/></button>																	
           <!-- <input type="submit" class="check" value="Financiar" onclick="registrarFinanciacion()" disabled/>-->
                                                                    <% }%>
                                                                    <iframe src="#" name="proceso" id="proceso" style="display:none"></iframe>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </tfoot>
                                            <tbody>
                            <%               for(int i=0;i<cuotas.length;i++){
                                                utility.Cuota cuota = cuotas[i];
                                                sumaAbonos += Math.round(cuota.obtenerAbonoCapital());
                                                sumaInteres += Math.round(cuota.obtenerIntGenerados()); %>
                                                <tr class="Estilo1" onMouseOver="sombrear(this)" onMouseOut="renovar(this)" style="cursor:pointer;">
                                                    <td class="text"><%=((cuota.obtenerPeriodo()==0)?"Inicial":cuota.obtenerPeriodo())%></td>
                                                    <td class="text"><%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(cuota.obtenerFecha())%></td>
                                                    <td class="text"><%=Math.round(cuota.obtenerAbonoCapital())%></td>
                                                    <td class="text"><%=Math.round(cuota.obtenerIntGenerados())%></td>
                                                    <td class="text"><%=Math.round(cuota.obtenerAbonoCapital())%></td>
                                                </tr>
                                          <%  }%>
                                                <tr>
                                                    <td class="label" colspan="2">TOTAL</td>
                                                    <td class="label"><%=sumaAbonos%></td>
                                                    <td class="label"><%=sumaInteres%></td>
                                                    <td class="label"><%=sumaAbonos+sumaInteres%></td>
                                                </tr>
                                                <tr>
                                                    <td class="label" colspan="5">&nbsp;</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                     </form>
                                 <%  }
                                }
                            }
                        }
                    }
                }
            } %>
    </body>
</html>
