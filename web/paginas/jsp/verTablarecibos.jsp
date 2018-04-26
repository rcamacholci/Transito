<%--
    Document   : verTablaDescuento
    Created on : 15/02/2013, 02:25:53 PM
    Author     : Jefrey
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("saldoFavorRecibo.jsp")){
                    modelo.Model modelo = (modelo.Model)session.getAttribute("model");
                    Usuario usuario = (Usuario)session.getAttribute("usuario");
                    Sede sede = (Sede)session.getAttribute("sede");
                    long valorT = 0;
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="../html/scripts/tablecloth.js"></script>
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
        <script type="text/javascript" src="../html/scripts/descuentoConcepto.js"></script>
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script type="text/javascript" src="../html/scripts/calendar.js"></script>
        <script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
        <script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <title>Ver Tabla Descuento</title>
    </head>
    <body>
        <form name="form" method="post" action="procesarTablaRecibos.jsp">

            <table border="1">

                <tr>
                    <th colspan="8" scope="col">DETALLE TIQUETES</th>
                </tr>
                <tr>
                    <th scope="col">NO.</th>
                    <th scope="col" colspan="2">REFERENCIA</th>
                    <th scope="col">VR CONCEPTO 1</th>
                    <th scope="col">VR CONCEPTO 2</th>
                    <th scope="col">VALOR TOTAL</th>
                    <th scope="col">Act.</th>
                </tr>
                <%
                if(request.getParameter("noreciboANT")!=null && request.getParameter("norecibo")!=null){
                    
                Tiquete tiq1 = modelo.consultarTiqueteByFactura(request.getParameter("noreciboANT"));
                Tiquete tiq2 = modelo.consultarTiqueteByFactura(request.getParameter("norecibo"));
                %>
                <input type="hidden" name="recibo" id="recibo" value="<%=tiq2.getId_tiquete() %>" />
                <input type="hidden" name="reciboANT" id="reciboANT" value="<%=tiq1.getId_tiquete() %>" />

                <%
                java.util.List dt1 = modelo.consultarDetalleTiquete(tiq1.getId_tiquete());
                java.util.List dt2 = modelo.consultarDetalleTiquete(tiq2.getId_tiquete());

                for(int i =0;i<dt1.size();i++){
                    Detalle_Tiquete dt = (Detalle_Tiquete)dt1.get(i);
                    Detalle_Tiquete detalleT = modelo.consultarDetalleTiqueteVAL(tiq2.getId_tiquete(), dt.getFk_concepto(), dt.getFk_tramite());
                    if(detalleT!=null){
%>
                <tr>
                    <td scope="col"><center><%=i+1 %></center></th>
                    <%
                    if(dt.getFk_concepto()!=0){
                    Concepto conc = modelo.consultarConcepto(dt.getFk_concepto());
                    %>
                    <td scope="col" colspan="2"><center><%=conc.getNombre() %></center></th>
                        <%
                    }%>
<%
                    if(dt.getFk_tramite()!=0){
                    Tramite tra = modelo.consultarTramite(dt.getFk_tramite());
%>
                    <td scope="col" colspan="2"><center><%=tra.getNombre() %></center></th>
<%}%>
                    <td scope="col"><center>$ <%=dt.getValor_total() %></center></th>
                    <td scope="col"><center>$ <%=detalleT.getValor_total() %></center></th>
                    <% float valor =  dt.getValor_total() - detalleT.getValor_total();
                       valor = (Math.abs(valor));
                       valorT += valor;
%>
                    <td scope="col"><center>$ <%=valor %></center></th>
                    <td scope="col"><center>
                            <input type="checkbox" name="concep" value="<%=dt.getId_det_tiquete()%>" checked id="concep" />
                    </td></center>
                </tr>
<%}}%>
            </table>
            <table>
                <tr>
                    <td scope="col">TOTAL A PAGAR</td>
                    <td scope="col">$ <%=valorT %></td>
                    <td scope="col">OBSERVACION</td>
                    <td scope="col">
                        <input type="text" name="observacion" id="observacion" value="Excedente Recibo" >
                    </td>
                </tr>
            </table>
            <input type="submit" value="Aplicar" style="position:absolute; right:15px" />
            <% }else{
                System.out.println("No recibio parametros");
} %>
        </form>
    </body>
</html>
<%  }else{ %>
			   <jsp:forward page="no_access.jsp">
				 <jsp:param name="tipo" value="1"></jsp:param>
			   </jsp:forward>
	<%  }
	}else{ %>
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>