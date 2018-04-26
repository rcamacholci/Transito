<%-- 
    Document   : listarConceptos
    Created on : 13/02/2013, 02:58:03 PM
    Author     : Jefrey
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*, java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%
Model model = (Model) session.getAttribute("model");
Sede sede = (Sede)session.getAttribute("sede");
%>

<html>
    <head>
         <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="../html/scripts/tablecloth.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Refresh" content="15">
        <title>LISTADO DE CONCEPTOS</title>
    </head>
    <body>
       <table width="200" border="1">
                <tr>
                    <th colspan="2" scope="col">LISTADO DE CONCEPTOS</ th>
                </tr>

            <% LinkedList conceptos = model.listadoConceptosSedeTramite(sede.getId_sede());
                for(int i=0;i<conceptos.size();i++){
                Concepto concepto = (Concepto)conceptos.get(i);
            %>
                <tr>
                    <td width="74%" colspan="2" scope="col"><%=concepto.getNombre() %></td>
                </tr>
            <%}%>

        </table>
    </body>
</html>
