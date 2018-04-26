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
            long idAudiencia = (request.getParameter("idAudiencia") != null) ? Long.parseLong(request.getParameter("idAudiencia")) : -1;
            int  asistencia = ( request.getParameter("asistencia")!=null ) ? Integer.parseInt(request.getParameter("asistencia")) : 0 ; 
            String observacion = ( request.getParameter("observacion")!=null ) ? request.getParameter("observacion") : "" ; 
            
            System.out.println("ASISTENCIA  "+  asistencia);
            System.out.println("OBSERVACION  "+  observacion);
            
            
            
            System.out.println("ID_AUDIENCIA  " + idAudiencia) ;
            System.out.println("ID_COMPARENDO  " + request.getParameter("idComparendo")) ;
            
            
            if (request.getParameter("idComparendo") != null) {
                long idComparendo = Long.parseLong(request.getParameter("idComparendo"));
                System.out.println("COMPARENDO III   " + idComparendo);
                Comparendo comparendo = model.consultarComparendoById(idComparendo);
                if (comparendo != null) {
                    //(new java.util.Date(fecha).getTime()) ;
                    procesoContravencional procesoC = new procesoContravencional();
                    boolean audienciaRealizada = procesoC.adicionarResolucionXAudiencia(
                            model,
                            usuario,
                            comparendo,
                            idAudiencia,
                            observacion,
                            fkProceso,
                            asistencia
                            );        
                    if (audienciaRealizada) {%>
                        <jsp:forward page="procesoContravencional.jsp">
                            <jsp:param name="msg" value="La audiencia ha sido realizada con exito"/>
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


