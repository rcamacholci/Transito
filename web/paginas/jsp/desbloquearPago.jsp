<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
<% Model modelo = (Model)session.getAttribute("model");
    Formulario_Licencia formularioL = new Formulario_Licencia();
    Pago pago = new Pago();
if (!request.getParameter("idRadicacionL").equals(null)){
    try{
        modelo.getCon().setAutoCommit(false);
        formularioL = modelo.consultarFormularioLicencia(Long.parseLong(request.getParameter("idRadicacionL")));
        if(formularioL!=null){
            pago = modelo.consultarPago(formularioL.getFk_pago());
            if(pago!=null){
                modelo.actualizarEstadoDetalleTiqueteTramite(pago.getFk_tiquete(), formularioL.getFk_tramite(), 1);
                modelo.getCon().commit();
                %>
                <result>1</result>
                <numPago><%=pago.getNumero_factura()%></numPago>
           <% }
        }
  }catch(Exception ex){
     ex.printStackTrace();
     modelo.getCon().rollback();%>
       <result>2</result>
       <%}%>
       <% }else{ %>

          <result>2</result>
    <% }           %>

</root>