<%-- 
    Document   : listadoTramites
    Created on : 04-dic-2017, 11:25:54
    Author     : acadrasco
--%>

<%@page import="java.util.HashMap"%>
<%@page import="modelo.Model"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    System.out.println("aca");
    Model modelo = (Model) request.getSession().getAttribute("model");///
    String fecha_hoy = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
    if (request.getParameter("op") == null) {
        out.println("<h1>Debe seleccionar un valor de la lista de opciones.......</h1>");

    } else {
        try {
            System.out.println("aca");
            //se recibe el parametro enviado desde el select
            String opcion = request.getParameter("op");
            //se convierte a entero para mandarlo como parametro de entrada en el metodo que lista los tramites asociados a la clase.
            int id = Integer.parseInt(opcion);
%>

<label>Tramites Asociados a la Clase de Tramite</label>
<select id="listaT" onchange="cargarListaConceptos();">
    <option value="-1">Seleccione una opcion .... </option >
    <%
        //pasamos el id como parametro de entrada al metodo listarTramitesAsociados
        java.util.List hm = modelo.listarTramitesAsociados(id);
        java.util.Iterator it = hm.iterator();
        for (Object elem : hm) {
            HashMap hash = (HashMap<String, String>) elem;
            System.out.println(hash.get("FK_TRAMITE"));
            System.out.println(hash.get("NOMBRE"));
    %>
    <option value="<%= hash.get("FK_TRAMITE")%>"> <%=(hash.get("NOMBRE"))%></option >

    <%}

            } catch (Exception e) {
//falta manejar la excepcion...
}
            }
        }//fin else
    %>