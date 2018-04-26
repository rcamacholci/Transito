<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="modelo.*"%>
<html>
   <head>
        <title>Procesar&nbsp;Liquidacion</title>
   </head>
   <body>
   <%

    Model model= (Model)session.getAttribute("model");
    try{
        if(request.getParameter("id_comparendo")!=null){
            long idComparendo = Long.parseLong(request.getParameter("id_comparendo"));
            Comparendo comparendo = model.consultarComparendoById(idComparendo);
            if(comparendo!=null){
                Liquidacion_Cia liquidacion = model.consultarLiquidacionCIA(comparendo.getId_comparendo(),comparendo.getFk_persona());
                if(liquidacion!=null){
                    if(liquidacion.getEstado()==1){
                        model.getCon().setAutoCommit(false);
                        liquidacion.setReferencia(request.getParameter("referencia"));
                        java.util.Date fechaPago = new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_pago"));
                        liquidacion.setFecha_pago(new java.sql.Date(fechaPago.getTime()));
                        liquidacion.setEstado(1);//realmente es 2
                        model.adicionarPagoCIA(liquidacion);
                        model.getCon().commit(); %>
                        <script language="javascript"  type="text/javascript">
                              alert("La consignacion se ha registrado correctamente");
                              document.location.href= "formularioDescuentoComparendo.jsp?id=1";
                        </script>
                 <% }
                }
            }
        }
    }catch(Exception exc){
        exc.printStackTrace();
        model.getCon().rollback(); %>
        <script language="javascript"  type="text/javascript">
               alert("No se pudo adicionar la consignacion");
               location.href='buscarComparendo.jsp';
               history.back()
        </script>
<% } %>
    </body>
</html>
