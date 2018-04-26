<%-- 
    Document   : procesarSancionComparendo
    Created on : 26-ene-2012, 16:19:35
    Author     : dell
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" 
        import="java.sql.Date"
        import="modelo.Model"
        import="modelo.Usuario"
        import="modelo.Comparendo"
        import="modelo.Persona"
        import="modelo.Infraccion"
        import="modelo.Cartera"
        import="procesos.procesoContravencional" %>




<%-- 
     SimitResolucion 
     ResolucionComparendo
--%>

<%
    Model model = (Model) session.getAttribute("model");

    if (model != null) {

        try {
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            /*Se obtienen los valores pasados por la petición*/
            long fkProceso = (request.getParameter("fkProceso") != null) ? Long.parseLong(request.getParameter("fkProceso")) : -1;
            String resolucion = (request.getParameter("resolucion") != null) ? request.getParameter("resolucion") : null;
            String fecha = (request.getParameter("fechaResolucion") != null) ? request.getParameter("fechaResolucion") : null;
            String observacion = (request.getParameter("observacion") != null) ? request.getParameter("observacion") : null;
            float valor = (request.getParameter("valor") != null) ? Float.valueOf(request.getParameter("valor")) : -1;
            String[] arrIdCmp = request.getParameterValues("chkIdComparendo"); // Arreglo de IDS de comparendos a sancionar.
            System.out.println("SANCION MULTIPLE DE COMPARENDOS  " + arrIdCmp);
            String rows = "" ;
%>
<table name="detalle" id="detalle">
    <thead>
        <tr class="title_">
            <th align="center">&nbsp;</th>
            <th align="center">Numero</th>
            <th align="center">Infraccion</th>
            <th align="center">Nombre</th>
            <th align="center">Valor</th>
        </tr>
    </thead>
    <tbody>
    <%
        if (arrIdCmp != null && arrIdCmp.length > 0) {
            for (int i = 0; i < arrIdCmp.length; i++) {
                long idComparendo = Long.parseLong(arrIdCmp[i]);
                Comparendo comparendo = model.consultarComparendoById(idComparendo);
                if (comparendo != null) {
    %>

    <%
                    //(new java.util.Date(fecha).getTime()) ;
                    procesoContravencional procesoC = new procesoContravencional();
                    boolean sancionAplicada = procesoC.adicionarSimitResolucionXSancion(
                            model,
                            usuario,
                            comparendo,
                            resolucion,
                            new java.sql.Date(java.util.Calendar.getInstance().getTimeInMillis()),
                            valor,
                            observacion,
                            6);
                    
                    if ( !sancionAplicada ){
                        
                         
                        Persona persona = model.consultarPersona(comparendo.getFk_persona());
                        Infraccion infraccion = model.consultarInfraccion(comparendo.getFk_infraccion());
                        Cartera cartera = model.consultarCartera(comparendo.getFk_cartera());
                        
                        rows += "<tr>" ;
                        rows += "   <td>" + comparendo.getNumero() + "</td>" ;
                        rows += "   <td>" + infraccion.getNumero() + "</td>" ;
                        rows += "   <td>" + persona.getNombreCompleto() + "</td>" ;
                        rows += "   <td>" + cartera.getValor() + "</td>" ;
                        rows += "   </td>" ;
                        rows += "</tr>" ;
                    }
                }
           }
    %>

    <%
        }
    %>
    <jsp:forward page="listarComparendosParaSancion.jsp">
        <jsp:param name="msg" value="Se han sancionado exitosamente los comparendos"/>
    </jsp:forward> 
    <%
    } catch (Exception exc) {
    %>
    <jsp:forward page="listarComparendosParaSancion.jsp">
        <jsp:param name="msg" value="Error no han podido ser sancionados todos los comparendos seleccionados"/>
    </jsp:forward> 
    <%
                System.out.println("Error en el procesar sancion");
                exc.printStackTrace();

            }
        }
    %> 

