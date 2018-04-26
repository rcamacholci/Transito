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
            
            if (request.getParameter("idComparendo") != null) {
                long idComparendo = Long.parseLong(request.getParameter("idComparendo"));
                Comparendo comparendo = model.consultarComparendoById(idComparendo);
                if (comparendo != null) {
                    //(new java.util.Date(fecha).getTime()) ;
                    procesoContravencional procesoC = new procesoContravencional();
                    boolean sancionAplicada = procesoC.adicionarSimitResolucionXSancion(
                            model,
                            usuario,
                            comparendo,
                            resolucion,
                            new Date(new java.text.SimpleDateFormat("DD/MM/yy").parse(fecha).getTime()),
                            valor,
                            observacion,
                            fkProceso
                            );        
                    if (sancionAplicada) {%>
                        <jsp:forward page="procesoContravencional.jsp">
                            <jsp:param name="msg" value="La sancion ha sido aplicada con exito"/>
                            <jsp:param name="numeroComparendo" value="<%= comparendo.getNumero() %>"/>
                        </jsp:forward> 
                    <%  
                    } else { %>
                        <jsp:forward page="procesoContravencional.jsp">
                            <jsp:param name="msg" value="No se ha podido aplicar la sancion"/>
                            <jsp:param name="numeroComparendo" value="<%= comparendo.getNumero() %>"/>
                        </jsp:forward> 
                    <%  System.out.println("La sancion no pudo ser aplicada");
                    }
                }
            }
        } catch (Exception exc) {
            System.out.println("Error en el procesar sancion");
            exc.printStackTrace();
        }
    }
%> 

