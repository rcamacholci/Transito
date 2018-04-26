<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Comparendo"  errorPage="" %>
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {

                String nComparendo = request.getParameter("numero") ;
                
                if ( nComparendo != null ){
                    
                    Model modelo = (Model) session.getAttribute("model") ;

                    Comparendo comparendo = modelo.consultar_Comparendo(nComparendo) ;
                    
                    if ( comparendo != null ){ %>
                    
                        <jsp:forward page="procesoContravencional.jsp">
                            <jsp:param name="idC" value="<%= comparendo.getId_comparendo()%>"/>
                        </jsp:forward> 
                    
                    <%
                    }
                }
                
%>

        

<%  } else {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<%  }
} else {%>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%                    }
} catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
    }%>
