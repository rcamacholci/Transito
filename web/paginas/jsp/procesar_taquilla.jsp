<%@page import="procesos.Distribuir"%>
<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/java" pageEncoding="UTF-8"%>
<%@ page import="modelo.*"%>
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                Model modelo = (Model) session.getAttribute("model");
                int f = 0;

                modelo.getCon().setAutoCommit(false);
                long taquilla = Long.parseLong(request.getParameter("taquilla"));
                String estado = request.getParameter("estado");
                Taquilla taq = modelo.consultarTaquillaById(taquilla);
                if (estado.equals("CERRADA")) {
                   Distribuir ds = new Distribuir();
                              ds.setDistribucion(modelo, taq);
                              
                }
%>
<%  } else { %>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<%  }
} else { %>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%
    }
} catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
    }%>
