<%--
    Documento   : consultaFinanfrm
    Creado      : 23-mar-2010, 13:54:18
    Autor       : Desarrollo
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*,java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
            try {
                if (session.getAttribute("model") != null) {
                    if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <style type="text/css">
            .label {font-size: 11px; color:#333333; text-align:center ; font-family:Arial; font-weight:bold ; width:70px}
            .text {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; width:200px; text-transform:uppercase}
            .check { font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; }
            .title {font-size: 12px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; text-transform:uppercase}
        </style>
    </head>
    <body>
        <form target="financiacion" action="verFinanciacion.jsp" name="form" method="post">
            <fieldset>
                <legend class="title">CONSULTAR FINANCIACION</legend>
                <table width="100%" border="0" cellpadding="1" cellspacing="1" align="center">
                    <tr>
                        <td colspan="3">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table border="0" width="300px" cellpadding="1" cellspacing="1" align="center">
                                <tr>
                                    <td class="label">NUMERO</td>
                                    <td>
                                        <input name="numeroF" type="text" class="text">
                                    </td>
                                    <td>
                                        <input type="submit" value="Consultar" class="check">
                                    </td>
                                </tr>
                            </table>
                        </td>
                        
                    </tr>
                    <tr>
                        <td colspan="3">
                            <iframe frameborder="0" width="100%" height="450px" name="financiacion"></iframe>
                        </td>
                    </tr>
                </table>
            </fieldset>
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