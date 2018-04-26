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
            
            
            if (request.getParameter("idComparendo") != null) {
                long idComparendo = Long.parseLong(request.getParameter("idComparendo"));
                Comparendo comparendo = model.consultarComparendoById(idComparendo);
                if (comparendo != null) {
                    //(new java.util.Date(fecha).getTime()) ;
                    procesoContravencional procesoC = new procesoContravencional();
                    boolean aplazamientoAplicado = procesoC.adicionarSimitResolucionXCaducidad(
                            model,
                            usuario,
                            comparendo,
                            resolucion,
                            new Date(new java.text.SimpleDateFormat("dd/MM/yy").parse(fecha).getTime()),
                            0,
                            observacion,
                            fkProceso
                            );        
                    if (aplazamientoAplicado) {%>
                        <jsp:forward page="procesoContravencional.jsp">
                            <jsp:param name="msg" value="La caducidad ha sido realizada con exito"/>
                            <jsp:param name="idC" value="<%= comparendo.getId_comparendo() %>"/>
                        </jsp:forward> 
                    <%  
                    } else { %>
                        <jsp:forward page="procesoContravencional.jsp">
                            <jsp:param name="msg" value="No ha sido posible realizar el proceso de caducidad"/>
                            <jsp:param name="idC" value="<%= comparendo.getId_comparendo() %>"/>
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

