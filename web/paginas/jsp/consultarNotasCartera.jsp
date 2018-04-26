<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*,java.util.*"%>

<style type="text/css">
<!--
.style7 {
	color: #333333;
	font-size: 11px;
	font-weight: bold;
	font-family: Tahoma;
}
.Estilo12 {color: #333333}
.style19 {color: #FFFFFF; font-size: 11px; }
.style22 {font-size: 11px}
-->
</style>

 <%
 Model modelo = (Model) session.getAttribute("model");
 long notaCredito = 0;

 if(!request.getParameter("id_nota_credito").isEmpty()){
     notaCredito = Long.parseLong(request.getParameter("id_nota_credito"));
     List detalles = modelo.listarNotasCartera(notaCredito);
     if(detalles.size()>0){ %>
        <fieldset class="style2 style7 style6 style5">
            <legend align="center">NOTAS CARTERAS</legend>
            <table width="100%" border="1" cellpadding="1" cellspacing="0">
            <thead>
                <tr style="background:url(../html/images/inicio_3.png); border:none">
                    <th width="40%" align="center" style="border:none"><span class="style19">CONCEPTO&nbsp;CARTERA</span></th>
                    <th width="40%" align="center" style="border:none"><span class="style19">CONCEPTO&nbsp;DETALLE</span></th>
                    <th width="10%" style="border:none"><span class="style19">REF.</span></th>
                    <th width="10%" style="border:none"><span class="style19">TOTAL</span></th>
                </tr>
            </thead>
            <tbody>
           <%   for(int i=0;i<detalles.size();i++){
                    Detalle_Cartera detalleCartera  = (Detalle_Cartera) detalles.get(i);
                    Cartera cartera = modelo.getCartera(detalleCartera.getFk_cartera());
                    String conceptoCartera = modelo.consultarConcepto(cartera.getFk_concepto()).getNombre();
                    String conceptoDetalle = modelo.consultarConcepto(detalleCartera.getFk_concepto()).getNombre();
                    String referencia = cartera.getReferencia();
                    float valor = detalleCartera.getValor(); %>
                    <tr>
                        <td>
                            <span class="style22"><%=conceptoCartera%>                </span></td>
                        <td><span class="style22"><%=conceptoDetalle%></span></td>
                        <td align="center"><span class="style22"><%=referencia %></span></td>
                        <td><span class="style22"><%=valor%></span></td>
                    </tr>
                <%
                }
       %>
        </table>
        <table border="0" width="100%">
        <tr>
            <td align="center">
                <input value="Cerrar" style="width:100px" type="button" onclick="cerrarAnterior()">    </td>
        </tr>
        </tbody>
    </table>
    </fieldset>
<%
        }


     detalles = modelo.listarNotasConcepto(notaCredito);
     if(detalles.size()>0){ %>
        <fieldset class="style2 style7 style6 style5">
            <legend align="center">NOTAS CONCEPTOS</legend>
            <table width="100%" border="1" cellpadding="1" cellspacing="0">
            <thead>
                <tr style="background:url(../html/images/inicio_3.png); border:none">
                    <th width="10%" align="center" style="border:none"><span class="style19">CONCEPTO</span></th>
                    <th width="75%" style="border:none"><span class="style19">NOMBRE CONCEPTO</span></th>
                    <th width="15%" style="border:none"><span class="style19">TOTAL</span></th>
                </tr>
            </thead>
            <tbody>
           <%   for(int i=0;i<detalles.size();i++){
                    Nota_Concepto notaConcepto  = (Nota_Concepto) detalles.get(i);
                    String concepto = modelo.consultarConcepto(notaConcepto.getFk_concepto()).getNombre();
                    float valor = notaConcepto.getValor(); %>
                    <tr>
                        <td>
                            <span class="style22"><%=notaConcepto.getFk_concepto()%>                </span></td>
                        <td><span class="style22"><%=concepto%></span></td>
                        <td><span class="style22"><%=valor%></span></td>
                    </tr>
                <%
                }
       %>
        </table>
        <table border="0" width="100%">
        <tr>
            <td align="center">
                <input value="Cerrar" style="width:100px" type="button" onclick="cerrarAnterior()">    </td>
        </tr>
        </tbody>
    </table>
    </fieldset>
<%
        }
 }
%>
