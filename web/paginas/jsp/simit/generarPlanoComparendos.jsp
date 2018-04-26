<%-- 
    Document   : generarArchivoPlanoComparendos
    Created on : 16/07/2012, 10:10:30 AM
    Author     : digitalizacion
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
            try {
                if (session.getAttribute("model") != null) {
                    if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                        Model model = (Model) session.getAttribute("model");
                        if (model != null) {
%>
<html>
    <head>
        <title>Planos Comparendos</title>
      <style type="text/css">
<!--
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style3 {color: #FFFFFF}
.style31 {color: #333333; font-size: 12px; font-weight: bold; font-family: Tahoma; }
.Estilo2 {
	color: #FFFFFF;
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
}
-->
</style>
        <meta http-equiv=Content-Type content="text/html; charset=windows-1252"/>
        <script type="text/javascript" src="../html/scripts/adicionarComparendo.js"></script>
        <script type="text/javascript">

        </script>
    </head>

    <body>
        <div align="center">
            <div align="center" >
                <form name="form" method="post" action="../procesarPlanoSimit.jsp">
                    <fieldset style="width:40%;">
                        <legend></legend>
                        <table width="75%" border="0"  bordercolor="#FFFFFF" align="center">
                            <tr style="border:none; background:url(../../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="Estilo2">GENERACIÓN PLANO COMPARENDOS SIMIT</span></td>
				
                            <tr>
                                <td colspan="5" >&nbsp;</td>
                            </tr>

                            <tr>
                                <td colspan="5" align="center">
                            </tr>
                            <tr>
                                <td colspan="5" align="center">
<button type="submit" name="asignar" id="Generar"  value="Generar"><span class="style2">Generar </span><img src="../../html/images/plano.png" width="19" height="18"/></button>
                                 
                                </td>
                            </tr>
                    </table>
                    </fieldset>
                </form>
            </div>
        </div>
    </body>
</html>
<%
                        }
                    } else {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<% }
                } else {%>
<script type="text/javascript">
    window.parent.document.location.href = "../../index.jsp";
</script>  <%            }
            } catch (Exception mexe) {
                mexe.printStackTrace();%>
<jsp:forward page="../no_access.jsp">
    <jsp:param name="tipo" value="2"></jsp:param>
    <jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param>
</jsp:forward>
<%  }%>