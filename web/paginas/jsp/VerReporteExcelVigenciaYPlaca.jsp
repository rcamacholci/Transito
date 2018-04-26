<%--
    Document   : VerReporteExcelVigenciaYPlaca
    Created on : 2/04/2014, 03:55:05 PM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
            try {
                if (session.getAttribute("model") != null) {
                    // if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                    Model model = (Model) session.getAttribute("model");

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <style type="text/css">
        <!--
        .Estilo3 {font-size: 12px; color: #FFFFFF; }
        .Estilo4 {
            color: #333333;
            font-weight: bold;
            font-size: 12px;
        }
        .Estilo5 {font-size: 16px; color: #FFFFFF; }
        -->
    </style>
    <body>
        <table width="100%" border="1" cellpadding="1" cellspacing="0">
            <%
                    response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
                    response.setHeader("Content-Disposition", "attachment;filename=\"ReporteVigenciaPlaca.xls\"");
            %>
            <tr  style="border:none;background:url(../html/images/inicio_3.png)">
                <th scope="col" align="center"><span class="Estilo3">
                        PLACA
                    </span></th>
                <th scope="col" align="center"><span class="Estilo3">
                        2004
                    </span></th>
                <th scope="col" align="center"><span class="Estilo3">
                        2005
                    </span></th>
                <th scope="col" align="center"><span class="Estilo3">
                        2006
                    </span></th>
                <th scope="col" align="center"><span class="Estilo3">
                        2007
                    </span></th>
                <th scope="col" align="center"><span class="Estilo3">
                        2008
                    </span></th>
                <th scope="col" align="center"><span class="Estilo3">
                        2009
                    </span></th>
                <th scope="col" align="center"><span class="Estilo3">
                        2010
                    </span></th>
                <th scope="col" align="center"><span class="Estilo3">
                        2011
                    </span></th>
                <th scope="col" align="center"><span class="Estilo3">
                        2012
                    </span></th>
                <th scope="col" align="center"><span class="Estilo3">
                        2013
                    </span></th>
                    <th scope="col" align="center"><span class="Estilo3">
                        2014
                    </span></th>
                    <th scope="col" align="center"><span class="Estilo3">
                        2015
                    </span></th>
                    <th scope="col" align="center"><span class="Estilo3">
                        2016
                    </span></th>
                    <th scope="col" align="center"><span class="Estilo3">
                        2017
                    </span></th>
            </tr>
            <%
            try{
                    java.util.List<ReporteManuel> temp = model.consultarReporteManuel();
                    if (temp != null) {
                        for (int i = 0; i < temp.size(); i++) {
                            ReporteManuel reporteManuel = temp.get(i);

            %>
            <tr>
                <th scope="col" align="center"><span class="Estilo4">
                        <%=reporteManuel.getPlaca()%>
                    </span></th>
                <th scope="col" align="center"><span class="Estilo4">
                        <%=reporteManuel.getV2004()%>
                    </span></th>
                <th scope="col" align="center"><span class="Estilo4">
                        <%=reporteManuel.getV2005()%>
                    </span></th>
                <th scope="col" align="center"><span class="Estilo4">
                        <%=reporteManuel.getV2006()%>
                    </span></th>
                <th scope="col" align="center"><span class="Estilo4">
                        <%=reporteManuel.getV2007()%>
                    </span></th>
                <th scope="col" align="center"><span class="Estilo4">
                        <%=reporteManuel.getV2008()%>
                    </span></th>
                <th scope="col" align="center"><span class="Estilo4">
                        <%=reporteManuel.getV2009()%>
                    </span></th>
                <th scope="col" align="center"><span class="Estilo4">
                        <%=reporteManuel.getV2010()%>
                    </span></th>
                <th scope="col" align="center"><span class="Estilo4">
                        <%=reporteManuel.getV2011()%>
                    </span></th>
                <th scope="col" align="center"><span class="Estilo4">
                        <%=reporteManuel.getV2012()%>
                    </span></th>
                <th scope="col" align="center"><span class="Estilo4">
                        <%=reporteManuel.getV2013()%>
                    </span></th>
                     <th scope="col" align="center"><span class="Estilo4">
                        <%=reporteManuel.getV2014()%>
                    </span></th>
                     <th scope="col" align="center"><span class="Estilo4">
                        <%=reporteManuel.getV2015()%>
                    </span></th>
                     <th scope="col" align="center"><span class="Estilo4">
                        <%=reporteManuel.getV2016()%>
                    </span></th>
                     <th scope="col" align="center"><span class="Estilo4">
                        <%=reporteManuel.getV2017()%>
                    </span></th>
            </tr>
            <%
                            }
                        }
                    } catch (Exception exc) {
                        exc.printStackTrace();
                    }
            %>
        </table>
    </body>
</html>
<%
    }
    else

    {%>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%    }
}

catch
(Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%            }%>
