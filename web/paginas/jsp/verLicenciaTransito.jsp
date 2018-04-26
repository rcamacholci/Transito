<%-- 
    Document   : verLicenciaTransito
    Created on : 18/04/2011, 06:26:19 PM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try{
        if(session.getAttribute("model")!=null){
            if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                modelo.Model model = (modelo.Model) session.getAttribute("model");
                modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                if(request.getParameter("idRadicacion")!=null){
                    if(!request.getParameter("idRadicacion").equals("")){
                        java.util.Map parameters = new java.util.HashMap();
                        parameters.put("RADICACION",Long.parseLong(request.getParameter("idRadicacion")));
                        String dir = application.getRealPath("/paginas/reports/radicaciones/tramites/licenciaTransito.jasper");
                        parameters.put("SUBREPORT_DIR",dir.substring(0,dir.indexOf("reports")+8));
                        modelo.Reports reporte = new modelo.Reports(model,parameters,dir,response);
                    }
                }
            }else{ %>
               <jsp:forward page="no_access.jsp">
                     <jsp:param name="tipo" value="1"></jsp:param>
               </jsp:forward>
         <% }
        }else{ %>
            <script>
                    window.parent.parent.document.location.href = "../../index.jsp";
            </script>
<%      }
    }catch(Exception mexe){
        mexe.printStackTrace(); %>
        <jsp:forward page="no_access.jsp">
            <jsp:param name="tipo" value="2"></jsp:param>
            <jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param>
        </jsp:forward>
<%  } %>
    
        