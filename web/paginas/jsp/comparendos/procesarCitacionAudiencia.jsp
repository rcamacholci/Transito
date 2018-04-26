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
        import="procesos.procesoContravencional"
        import="utility.MensajeBox"%>




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
            String fechaAudiencia = (request.getParameter("fecha_audiencia") != null) ? request.getParameter("fecha_audiencia") : null;
            String horas = (request.getParameter("horas") != null) ? request.getParameter("horas") : null;
            String minutos = (request.getParameter("minutos") != null) ? request.getParameter("minutos") : null;
            String estado = (request.getParameter("estado") != null) ? request.getParameter("estado") : null;
            String observacion = (request.getParameter("observacion") != null) ? request.getParameter("observacion") : null;
            
            
            if (request.getParameter("idComparendo") != null) {
                long idComparendo = Long.parseLong(request.getParameter("idComparendo"));
                Comparendo comparendo = model.consultarComparendoById(idComparendo);
                if (comparendo != null) {
                    //(new java.util.Date(fecha).getTime()) ;
                    procesoContravencional procesoC = new procesoContravencional();
                    MensajeBox msg = procesoC.citacionAudiencia(
                            model,
                            usuario,
                            comparendo,
                            observacion,
                            new Date(new java.text.SimpleDateFormat("dd/MM/yy").parse(fechaAudiencia).getTime()),
                            horas,
                            minutos,
                            Integer.parseInt(estado),
                            fkProceso
                            );        
                    if ( msg != null && msg.getCodigo()>0 ) {%>
                        <jsp:forward page="procesoContravencional.jsp">
                            <jsp:param name="msg" value="<%= msg %>"/>
                            <jsp:param name="idC" value="<%= comparendo.getId_comparendo() %>"/>
                        </jsp:forward> 
                    <%  
                    } else { %>
                        <jsp:forward page="procesoContravencional.jsp">
                            <jsp:param name="msg" value="No ha sido posible realizar el proceso de audiencia"/>
                            <jsp:param name="idC" value="<%= comparendo.getId_comparendo() %>"/>
                        </jsp:forward> 
                    <%  
                    }
                }
            }
        } catch (Exception exc) {
            System.out.println("Error en el procesar audiencia");
            exc.printStackTrace();
        }
    }
%> 


