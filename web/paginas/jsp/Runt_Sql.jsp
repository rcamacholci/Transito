<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    <%
            try {
                if (session.getAttribute("model") != null) {
                    if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                        modelo.Model modelo = (modelo.Model) session.getAttribute("model");
    %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="../html/scripts/calendar.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<html>
    <head>
    </head>
    <body>
        <form id="form"  name="form" action="Procesar_Run_Sql.jsp" method="POST" onsubmit="return Validar()">
            <table width="75%" border="0" align="center">
                <tr style="background:url(../html/images/inicio_3.png); border:none">
                    <td colspan="2" align="center"><span class="style1">EJECUTAR SQL</span></td>
                </tr>
                <tr>
                    <td align="center">
                        <textarea name="sql" id="sql" rows="25" cols="150"></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <input name="adicionar" type="submit" id="adicionar" value="Enviar Solicitud" style="width:120px; text-align:center"/>
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>





<%  } else {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<%  }
                } else {%>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%    }
            } catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%            }%>