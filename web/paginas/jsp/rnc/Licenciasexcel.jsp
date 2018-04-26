<%-- 
    Document   : HaciendaExcel
    Created on : 31/07/2017, 11:43:30 AM
    Author     : Jcarreno
--%>

<%@page import="java.sql.Date"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table bgcolor="">
            <%
                try {
                    String fi = request.getParameter("fi");
                    String ff = request.getParameter("ff");
                    response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
                    response.setHeader("Content-Disposition", "attachment;filename=\"Licencias " + fi + " a " + ff + " .xls\"");
                    modelo.Model modelo = (modelo.Model) session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
                    fi = request.getParameter("fi");
                    ff = request.getParameter("ff");
            %>
            <tr>
                <th>
                    Instituto de Trasito y Transporte del Atlantico
                </th>
            </tr>
            <tr>
                <td style="background: #004a73;color: #ffffff">TIPO DOCUMENTO</td>
                <td style="background: #004a73;color: #ffffff">DOCUMENTO</td>
                <td style="background: #004a73;color: #ffffff">NOMBRES</td>
                <td style="background: #004a73;color: #ffffff">FECHA NACIMIENTO</td>
                <td style="background: #004a73;color: #ffffff">NUMERO LICENCIA</td>
                <td style="background: #004a73;color: #ffffff">CATEGORIA</td>
                <td style="background: #004a73;color: #ffffff">FECHA</td>
                <td style="background: #004a73;color: #ffffff">DIRECCION</td>
                <td style="background: #004a73;color: #ffffff">TELEFONO</td>
                <td style="background: #004a73;color: #ffffff">CELULAR</td>
            </tr>

            <%
                List<java.util.HashMap> licencias = modelo.getLicencias(fi, ff);
                for (java.util.HashMap hash : licencias) {
            %>
            <tr>
                <td style="color: #003366"><%=hash.get("Documento") != null ? hash.get("Documento") : ""%></td>
                <td style="color: #003366"><%=hash.get("DOCUMENTO") != null ? hash.get("DOCUMENTO") : ""%></td>
                <td style="color: #003366"><%=hash.get("NOMBRES") != null ? hash.get("NOMBRES") : ""%></td>
                <td style="color: #003366"><%=hash.get("FECHA NACIMIENTO") != null ? hash.get("FECHA NACIMIENTO") : ""%></td>
                <td style="color: #003366"><%=hash.get("LICENCIA NUMERO") != null ? hash.get("LICENCIA NUMERO") : ""%></td>
                <td style="color: #003366"><%=hash.get("CATEGORIA") != null ? hash.get("CATEGORIA") : ""%></td>
                <td style="color: #003366"><%=hash.get("FECHA") != null ? hash.get("FECHA") : ""%></td>
                <td style="color: #003366"><%=hash.get("DESCRIPCION") != null ? hash.get("DESCRIPCION") : ""%></td>
                <td style="color: #003366"><%=hash.get("TELEFONO") != null ? hash.get("TELEFONO") : ""%></td>
                <td style="color: #003366"><%=hash.get("CELULAR") != null ? hash.get("CELULAR") : ""%></td>
            </tr>
            <%}//enxt
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </table>
    </body>
</html>
