<%-- 
    Document   : procesarPlanosHacienda
    Created on : 8/08/2011, 11:27:32 AM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="procesos.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
            try {
                if (session.getAttribute("usuario") != null) {
                    modelo.Model model = (modelo.Model) session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
                    String fechaI = request.getParameter("date");
                    String fechaF = request.getParameter("date2");
                    if (model != null && fechaI != null && fechaF != null) {
                        new procesos.planosHacienda(model, usuario, fechaI, fechaF);
                    }
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Archivos Planos</title>
        <style type="text/css">
            <!--
            .style1 {
                color: #FFFFFF;
                font-weight: bold;
            }
            .style2 {color: #FFFFFF}
            .style3 {
                color: #006699;
                font-weight: bold;
            }
            -->
        </style>
    </head>
    <body>
        <table border="0" width="50%" align="center">
            <tr>
                <td height="40" align="center" bgcolor="#CCCCCC"><span class="style3">ARCHIVOS PLANOS HACIENDA</span></td>
            </tr>
            <tr>
                <td height="40" align="center" bgcolor="#006699"><a href="../../data/externs/ATLANTICO_<%=fechaI.replaceAll("/", "")+"-"+fechaF.replaceAll("/", "")%>.txt" name="ttahtrve" class="style1" target="_blank"><%="ATLANTICO_"+fechaI.replaceAll("/", "")+"-"+fechaF.replaceAll("/", "")%></a></td>
            </tr>
        </table>
    </body>
    <%  }
            } catch (Exception mexe) {
                mexe.printStackTrace();
            }%>
</html>