<%--
    Document   : procesarPagoOnline
    Created on : 3/10/2013, 04:08:07 PM
    Author     : jjpadillag
--%>

<%@page import="procesos.aplicarPagosOnline"%>
<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*" import="procesos.*"%>
<!DOCTYPE html>
<%
    try {
        Model model = (Model) session.getAttribute("model");
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (model != null) {

            aplicarPagosOnline aplicarPagos = new aplicarPagosOnline();
            boolean respuesta = aplicarPagos.adicionarPagoOnline(model, request, usuario);

            if (respuesta) {%>
<script language="javascript" type="text/javascript">
    alert("Proceso exitoso");
    window.document.location.href = "verPagosOnline.jsp";

</script>
<%      } else {%>
<script language="javascript" type="text/javascript">
    alert("Error al procesar la información: "+"<%=aplicarPagos.getMensaje() %>");
    window.document.location.href = "verPagosOnline.jsp";
</script>
<%      }

            }
        } catch (Exception exe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=exe.getMessage()%>"></jsp:param>
</jsp:forward>
<%  }%>