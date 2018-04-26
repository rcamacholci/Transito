<%-- 
    Document   : consultar_detalle_pago_persona
    Created on : 9/03/2010, 12:02:39 PM
    Author     : Jorge Lopez
--%>

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

<fieldset class="style2 style7 style6 style5">
    <legend align="center">DETALLES PAGO</legend>
    <table width="100%" border="1" cellpadding="1" cellspacing="0">
    <thead>
        <tr style="background:url(../html/images/inicio_3.png); border:none">
            <th width="65%" align="center" style="border:none"><span class="style19">CONCEPTO</span></th>
            <th width="10%" style="border:none"><span class="style19">REF.</span></th>
            <th width="10%" style="border:none"><span class="style19">CANT.</span></th>
            <th width="15%" style="border:none"><span class="style19">TOTAL</span></th>
        </tr>
    </thead>
    <tbody>

 <%
 Model modelo = (Model) session.getAttribute("model");
 long fk_tiquete = 0;

 if(!request.getParameter("id_tiquete").isEmpty())
     fk_tiquete = Long.parseLong(request.getParameter("id_tiquete"));
    List detTiquete = modelo.consultarDetalleTiquete(fk_tiquete);
    if(detTiquete!=null){
        for(int i=0;i<detTiquete.size();i++){
            Detalle_Tiquete tiquete  = (Detalle_Tiquete) detTiquete.get(i);
            Cartera cartera = null;
            Tramite tramite = null;
            String Concep = "";
            String Referencia = "";
            Concepto concep;

            if(tiquete.getFk_cartera()!=0){
                cartera = modelo.getCartera(tiquete.getFk_cartera());
                concep = modelo.consultarConcepto(cartera.getFk_concepto());
                Concep = concep.getNombre();
                Referencia = cartera.getReferencia();
            }else if(tiquete.getFk_tramite()!=0){
                tramite = modelo.consultarTramite(tiquete.getFk_tramite());
                Concep = tramite.getNombre();
            }else if(tiquete.getFk_concepto()!=0){
                concep = modelo.consultarConcepto(tiquete.getFk_concepto());
                Concep = concep.getNombre();
            }

            %>
            <tr>
                <td>
                    <span class="style22"><%=(Concep!=null?""+Concep:"")%>                </span></td>
                <td><span class="style22"><%=Referencia%></span></td>
                <td align="center"><span class="style22"><%=tiquete.getCantidad() %></span></td>
                <td><span class="style22"><%=tiquete.getValor_total()%></span></td>
            </tr>



        <%
            

        }
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