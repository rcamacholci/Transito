<%-- 
    Document   : verPagosInfotic
    Created on : 17/11/2015, 03:49:24 AM
    Author     : Desarrollo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table width="100%" border="1" cellpadding="1" cellspacing="0">
       <%
           try{
                    Model model = (Model) session.getAttribute("model");
                    response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.                             
                    if(request.getParameter("tipo").equals("2")){
                        response.setHeader("Content-Disposition", "attachment;filename=\"ReportePagosInfoticDetallado.xls\"");
                    %>
                    <tr>
                        <td>PLACA</td>
                        <td>REFERENCIA</td>
                        <td>FACTURA</td>
                        <td>VALOR</td>
                        <td>COSTAS</td>
                        <td>INTERES</td>
                        <td>EXTEMPORANIEDAD</td>
                    </tr>
                    <%
                        String fecha_ini = request.getParameter("fi");
                        String fecha_fin = request.getParameter("ff");
                        java.util.List<DetPagoInfotic> tempd = model.DetPagoinfoticList(fecha_ini, fecha_fin);
                        for(DetPagoInfotic dpi : tempd){
                            %>
                            <tr>
                        <td><%=dpi.getPlaca()%></td>
                        <td><%=dpi.getReferencia()%></td>
                        <td><%=dpi.getFactura()%></td>
                        <td><%=dpi.getValor()%></td>
                        <td><%=dpi.getValorCosta()%></td>
                        <td><%=dpi.getValorInteres()%></td>
                        <td><%=dpi.getValorExtemp()%></td>
                            </tr>
                            <%
                        }//next
}else{
 response.setHeader("Content-Disposition", "attachment;filename=\"ReportePagosInfoticGeneral.xls\"");
                    %>
                    <tr>
                        <td>PLACA</td>
                        <td>FACTURA</td>
                        <td>FECHA</td>
                        <td>VALOR</td>
                        <td>VALOR  TOTAL</td>
                        <td>COD. BANCO</td>
                        <td>TIPO FACTURA</td>
                        <td>VIGENCIA INICIAL</td>
                        <td>VIGENCIA FINAL</td>
                    </tr>
                    <%
                        String fecha_ini = request.getParameter("fi");
                        String fecha_fin = request.getParameter("ff");
                        java.util.List<PagoInfotic> tempd = model.PagoinfoticList(fecha_ini, fecha_fin);
                        for(PagoInfotic dpi : tempd){
                            %>
                            <tr>
                         <td><%=dpi.getPlaca()%></td>
                        <td><%=dpi.getFactura()%></td>
                        <td><%=dpi.getFecha()%></td>
                        <td><%=dpi.getValor()%></td>
                        <td><%=dpi.getValoraCartera()%></td>
                        <td><%=dpi.getBanco()%></td>
                        <td><%=dpi.getTipo_factura()%></td>
                        <td><%=dpi.getMin_referencia()%></td>
                        <td><%=dpi.getMax_referencia()%></td>
                            </tr>
                            <%
}//next
}
%>
    </table>
<%
}catch(Exception ex){
    ex.printStackTrace();
}
%>

       </table>
    </body>
</html>
