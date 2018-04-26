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
            long fkDepartamento = (request.getParameter("departamento") != null) ? Long.parseLong(request.getParameter("departamento")) : -1;
            long fkMunicipio = (request.getParameter("dir_municipio") != null) ? Long.parseLong(request.getParameter("dir_municipio")) : -1;
            String direccion = (request.getParameter("direccion") != null) ? request.getParameter("direccion") : null;
            String email = (request.getParameter("email") != null) ? request.getParameter("email") : null;
            String telefono = (request.getParameter("telefono") != null) ? request.getParameter("telefono") : null;
            String celular = (request.getParameter("celular") != null) ? request.getParameter("celular") : null;
            String observacion = (request.getParameter("observacion") != null) ? request.getParameter("observacion") : null;
            
            
            if (request.getParameter("idComparendo") != null) {
                long idComparendo = Long.parseLong(request.getParameter("idComparendo"));
                Comparendo comparendo = model.consultarComparendoById(idComparendo);
                if (comparendo != null) {
                    //(new java.util.Date(fecha).getTime()) ;
                    procesoContravencional procesoC = new procesoContravencional();
                    /*notificar(Model model, 
                            Usuario usuario,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ1Q11111111111111111111111111111111111QQQQQQQQQQQQQQ1Q1Q11 
                            Comparendo comparendo, 
                            String direccion, 
                            Date fecha, 
                            String email, 
                            String telefono,
                            long fkProceso)*/
                    boolean notificacionEnviada = procesoC.notificar(
                            model,
                            usuario,
                            comparendo,
                            fkDepartamento,
                            fkMunicipio,
                            direccion,
                            new java.sql.Date(java.util.Calendar.getInstance().getTimeInMillis()),
                            email,
                            telefono,
                            celular,
                            observacion,
                            fkProceso
                            );  
                         
                    if (notificacionEnviada) {%>
                        <jsp:forward page="procesoContravencional.jsp">
                            <jsp:param name="msg" value="La notificacion se ha realizado con exito"/>
                            <jsp:param name="numeroComparendo" value="<%= comparendo.getNumero() %>"/>
                        </jsp:forward> 
                    <%  
                    } else { %>
                        <jsp:forward page="procesoContravencional.jsp">
                            <jsp:param name="msg" value="No ha sido posible enviar la notificacion"/>
                            <jsp:param name="numeroComparendo" value="<%= comparendo.getNumero() %>"/>
                        </jsp:forward> 
                    <%  
                    }
                }
            }
        } catch (Exception exc) {
            System.out.println("Error en el procesar anulacion");
            exc.printStackTrace();
        }
    }
%> 

