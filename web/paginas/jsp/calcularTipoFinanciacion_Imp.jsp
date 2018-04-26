<%--
    Document   : calcularTipoFinanciacion
    Created on : 1/06/2011, 04:27:57 PM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
            float total = 0;
            modelo.Model model = (modelo.Model) session.getAttribute("model");
            if (request.getParameter("id") != null) {
                if (request.getParameter("add") != null) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    long add = Long.parseLong(request.getParameter("add"));
                    modelo.Cartera cartera = model.consultarCartera(add);
                    java.util.List<modelo.Cartera> listaF = new java.util.LinkedList<modelo.Cartera>();
                    if (cartera != null) {
                        if (session.getAttribute("carteraF") != null) {
                            listaF = (java.util.List<modelo.Cartera>) session.getAttribute("carteraF");
                        }
                        if (id == 1) {
                            listaF.add(cartera);
                        } else {
                            for (int ic = 0;ic<listaF.size();ic++) {
                                if(listaF.get(ic).getId_cartera()==add)
                                    listaF.remove(ic);
                            }
                        }
                        session.setAttribute("carteraF", listaF);
                    }
                    for (modelo.Cartera c : listaF) {
                       java.util.Date fechaActual =(new java.util.Date());
                       float saldo = (float)c.getSaldo();
                        if(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(new java.text.SimpleDateFormat("dd/MM/yyyy").format(fechaActual)).getTime() <= new java.text.SimpleDateFormat("dd/MM/yyyy").parse("26/09/2013").getTime()){
                        if (!c.getReferencia().equals("2011") && !c.getReferencia().equals("2012") && !c.getReferencia().equals("2013")) {
                            modelo.Detalle_Cartera dc = model.consultarDetalleCartera(c.getId_cartera(), 249);
                            if(dc!=null){
                                int interesR = (int)dc.getValor();
                                int interesD =(int)((interesR*50)/100);
                                saldo = saldo-interesD;
                            }
                            if(c.getReferencia().equals("2004") || c.getReferencia().equals("2005") || c.getReferencia().equals("2006")){
                                modelo.Detalle_Cartera dcEx = model.consultarDetalleCarteraExtempo(c.getId_cartera());
                                if(dcEx!=null){
                                    int extempoR = (int)dcEx.getValor();
                                    int extempoD =(int)((extempoR*50)/100);
                                    saldo = saldo-extempoD;
                                }
                            }
                        }else{
                            saldo = Math.round(c.getSaldo());
                            }
                        total += saldo;
                    }else{
                        total += c.getSaldo();
                    }
                  }
                }
            }

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <link title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <style type="text/css">
            .label {font-size: 11px; color:#333333; text-align:center ; font-family:Arial; font-weight:bold ; width:70px}
            .text {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; width:100px; text-transform:uppercase}
            .date {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; width:100px }
            .bdate {font-size: 10px; color:#333333; text-align:left ; font-family:Arial; font-weight:bold; width:20px }
            .select {font-size: 11px; color:#003366; text-align:left ; font-family:Arial; font-weight:bold; width:120px }
            .input { width:130px }
            .check { font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; }
            .title {font-size: 12px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; text-transform:uppercase}
        </style>
    </head>
    <body style="margin:0px">
        <form name="form" action="calcularFinanciacionCartera_Imp.jsp" target="amortizar" method="post">
            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                <tr>
                    <td width="83" class="label">T.&nbsp;Financiacion </td>
                    <td colspan="3">
                        <%
                long idF = 0;
                String nombreF = "";
                float cuotaInicial = 0;
                int nCuotas = 0;
                String fechaI = "";
                modelo.Tipo_Financiacion tipoF = model.consultarTipoDeFinanciacion2ByTotal(total);
                if (tipoF != null) {
                    idF = tipoF.getId_tipoFinanciacion();
                    nombreF = tipoF.getNombre();
                    cuotaInicial = (float)tipoF.getInicial_desde();
                    nCuotas = tipoF.getCuotas_hasta();
                    fechaI = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
            }%>

                        <input type="hidden" name="idF" value="<%=idF%>"/>
                        <input name="tiposfinanciacion" id="tiposfinanciacion" class="text" style="width:310px" value="<%=nombreF%>"/>
                    </td>
                </tr>
                <tr>
                    <td class="label">Cuota&nbsp;inicial </td>
                    <td width="105" ><input name="cuota_inicial" class="text" id="cuota_inicial" value="<%=cuotaInicial%>"/></td>
                    <td width="74" class="label">Fecha&nbsp;Inicial</td>
                    <td width="146" class="label">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <input name="fecha_inicio" id="fecha_inicio" onkeyup="mascara(this,'/',true)" class="text" maxlength="10" value="<%=fechaI%>" readonly/></td>
                                <td>
                                    <input type="button" class="bdate" value="<" id="bfecha" name="bfecha"/>
                                    <!--script type="text/javascript">
                                        Calendar.setup({
                                            inputField     :    "fecha_inicio",
                                            ifFormat       :    "%d/%m/%Y",
                                            button         :    "bfecha"
                                        });
                                    </script-->
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="label">Valor&nbsp;Total </td>
                    <td>
                        <input type="text" readonly name="total_finan" class="text" id="total_finan" value="<%=total%>"/>
                    </td>
                    <td colspan="2">
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td class="label">#&nbsp;Cuotas </td>
                                <td><select name="ncuotas"  class="text" style="width:50px">
                                        <% for (int i = 1; i < nCuotas; i++) {%>
                                        <option value="<%=i%>"><%=i%></option>
                                        <% }%>
                                    </select>
                                </td>
                                <td align="center">
                                    <input type="submit" value="Calcular" name="calcular" id="calcular" class="check"/>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <fieldset>
                            <legend class="label">Detalle Amortizacion</legend>
                            <iframe src="calcularFinanciacionCartera_Imp.jsp" name="amortizar" frameborder="0" width="100%" height="270px">
                            </iframe>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>
