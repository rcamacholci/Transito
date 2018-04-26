<%--
    Document   : editarCargos
    Created on : 23/10/2013, 11:05:11 AM
    Author     : Sistemas-Jefrey
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*"%>
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                Model model = (Model) session.getAttribute("model");
                long id_usuario = Long.parseLong(request.getParameter("id_usuario"));
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="../html/scripts/tablecloth.js"></script>

        <title>Editar Cargos</title>
    </head>
    <body>
        <form name="form" method="post" action="procesarCargos.jsp">
            <input type="hidden" name="id_usuario" id="id_usuario" value="<%=id_usuario%>" />
            <table>
                <tr>
                    <th>Grupo Cargos</th>
                    <th>Cargo</th>
                </tr>
                <tr>
                    <td><select name="grupoC" id="grupoC" style="font-size:11px; width:130px">
                            <%
                                java.util.List tipos = model.listadoParametros(358);
                                for (int j = 0; j < tipos.size(); j++) {
                                    Parametro param = (Parametro) tipos.get(j);
                            %>
                            <option value="<%=param.getCodigo()%>"><%=param.getNombre()%></option>
                            <%	 }
                            %>
                        </select></td>
                    <td><select name="cargo" id="cargo" style="font-size:11px; width:130px">
                            <%
                                java.util.List tipos2 = model.listadoParametros(359);
                                for (int j = 0; j < tipos2.size(); j++) {
                                    Parametro param = (Parametro) tipos2.get(j);
                            %>
                            <option value="<%=param.getCodigo()%>"><%=param.getNombre()%></option>
                            <%	 }
                            %>
                        </select></td>
                </tr>
                <tr>
                    <td><input type="submit" value="Guardar"/></td>
                </tr>
            </table>
        </form>
    </body>
</html>
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