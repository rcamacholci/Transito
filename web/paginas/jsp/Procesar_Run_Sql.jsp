<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" errorPage="" import="java.text.SimpleDateFormat"%>
<%
            Model modelo = (Model) session.getAttribute("model");
            try {
                modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
                if (modelo != null) {
                    modelo.getCon();
                    modelo.getCon().setAutoCommit(false);
                    String sql = request.getParameter("sql");
                    if (!(sql.equals(null))) {
                        modelo.EjecutarSql(sql);
                        modelo.AdicionarSql(usuario.getId_usuario(), sql);
%>
<script language="javascript" type="text/javascript">
    alert("Registro Exitoso");
    document.location.href = "Runt_Sql.jsp";
    <%modelo.getCon().commit();%>
</script>
<%} else {%>
<script language="javascript" type="text/javascript">
    alert("Ocurrio Un Error Al Guardar");
    <%modelo.getCon().rollback();%>
</script>
<%}
                } else {%>
<script language="javascript" type="text/javascript">
    alert("Ocurrio Un Error Al Guardar");
    <%modelo.getCon().rollback();%>
</script>
<%}

} catch (Exception exe) {%>
<script language="javascript" type="text/javascript">
    alert("Ocurrio Un Error Al Guardar");
    <% modelo.getCon().rollback();%>
</script>
<%}%>

