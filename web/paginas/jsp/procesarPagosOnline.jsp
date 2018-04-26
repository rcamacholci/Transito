<%--
    Document   : procesarPagosOnline
    Created on : 27/06/2013, 10:11:12 AM
    Author     : jjpadillag
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*" import="procesos.*" import="org.ita.webservice.Pago"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%

    Model model = (Model)session.getAttribute("model");
    Usuario usuario = (Usuario)session.getAttribute("usuario");
    model.getCon().setAutoCommit(false);

try{
    java.util.List pagosOnline = (java.util.List) session.getAttribute("listaPagosOnline");

    long idTaquilla = Long.parseLong(request.getParameter("idTaquilla"));
    long idUsuario = usuario.getId_usuario();
    long idSede = usuario.getFk_sede();

    for(int i=0;i<pagosOnline.size();i++){
        Pago p = (Pago)pagosOnline.get(i);

        Vehiculo vehiculo = model.consultarVehiculo(p.getPlaca());

        if(vehiculo!=null){

        long idVehiculo = vehiculo.getId_vehiculo();
        float valor = Float.parseFloat(p.getValorPagado());
        String referencia = p.getReferencia();

        String ano = p.getFechaProceso().substring(0,4);
        String mes = p.getFechaProceso().substring(6,7);
        String dia = p.getFechaProceso().substring(9,10);

        String fechaP = ano+"/"+mes+"/"+dia;

        java.sql.Date fechaReferencia = new java.sql.Date(new java.text.SimpleDateFormat("dd/mm/yyyy").parse(fechaP).getTime());
        java.sql.Date fechaPago = new java.sql.Date(new java.text.SimpleDateFormat("dd/mm/yyyy").parse(fechaP).getTime());
        long banco = 93;

        java.util.List listap = model.crearListaPropietarios(vehiculo.getId_vehiculo());
        Propietario propietario = (Propietario)listap.get(0);
        Persona persona = model.consultarPersona(propietario.getFk_persona());
        if(persona!=null){
            long idPersona=persona.getId_persona();
               Banco bancos = model.consultarBancosByNombre(p.getNombreBanco());
            if(bancos!=null){
                banco = bancos.getId_banco();
            }
            new aplicarPagoOnline().adicionarPagoOnline(model, idTaquilla, idSede, idUsuario, fechaPago, idPersona, idVehiculo, (long)valor, referencia, fechaReferencia, banco);
        }

        }
    }

    try {
	org.ita.webservice.PagosEnLinea_Service service = new org.ita.webservice.PagosEnLinea_Service();
	org.ita.webservice.PagosEnLinea port = service.getPagosEnLineaPort();
	 // TODO initialize WS operation arguments here

	java.util.List<java.lang.String> lstIdPagos = (java.util.List) session.getAttribute("listaidPagos");

	// TODO process result here
	org.ita.webservice.ProcessStatus result = port.actualizarPagosAplicados(lstIdPagos);

        if(result.isEstado()){
            model.getCon().commit();
%>
            <script>
                alert("Proceso Exitoso");
                window.document.location.href = "verPagosOnline.jsp";
            </script>
<%-- start web service invocation --%><hr/>
<%
        }else{
            System.out.println("Error: "+result.getMensaje());
            model.getCon().rollback();
        }

    } catch (Exception ex) {
	model.getCon().rollback();
        System.out.println("Error: "+ex);
    }
    session.removeAttribute("listaPagosOnline");
    session.removeAttribute("listaidPagos");
%>
    <%-- end web service invocation --%><hr/>
<%
}catch (Exception ex){
    session.removeAttribute("listaPagosOnline");
    session.removeAttribute("listaidPagos");
    model.getCon().rollback();
    System.out.println("Error: "+ex);
%>
<script>
                alert("Error al aplicar Pagos Online");
                window.document.location.href = "verPagosOnline.jsp";
            </script>
<%
}
%>
