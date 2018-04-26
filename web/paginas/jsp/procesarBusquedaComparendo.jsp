

<%


    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {

                modelo.Model model = (modelo.Model) request.getAttribute("model");

                String nComparendo = (request.getParameter("comparendo") != null) ? request.getParameter("comparendo") : "";

                if (!"".equals(nComparendo)) {

                    modelo.Comparendo comparendo = model.consultar_Comparendo(nComparendo);

                    if (comparendo != null) {
                           long idC = comparendo.getId_comparendo() ;
%>
<jsp:forward page="buscarComparendo.jsp">
    <jsp:param name="id_comparendo" value="<%= idC %>"></jsp:param>
</jsp:forward>
<%        }

    }

} else {%>
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
