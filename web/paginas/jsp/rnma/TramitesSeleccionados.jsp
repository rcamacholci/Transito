<%-- 
    Document   : TramitesSeleccionados
    Created on : 18/11/2015, 04:00:35 PM
    Author     : Desarrollo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="modelo.*" %>
<!DOCTYPE html>
    <link rel=stylesheet href="../../html/css/Style.css" type="text/css" media=screen></link>
<html>
    <script type="text/javascript" language="text">
        function Enviar(){
            var documento = window.parent.form.txtdocumento.value;
            var tipo = window.parent.form.cmdtipodocumento.value;
            document.form.action="FormularioRNMA.jsp?tipo=1&documento="+documento;
            document.form.submit();
        }
    </script>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>

    <body>
        <form name="form" id="form" method="post" >
        <table align="left">
            <tr align="justify" class="label">
                <td>&nbsp;&nbsp;X&nbsp;&nbsp;</td><td>    Codigo  </td><td>Nombre Tramite</td>
            </tr>
            <%
                try {
                    Model model = (Model) session.getAttribute("model");
                    java.util.List<Tramite> tramites = (java.util.List<Tramite>) session.getAttribute("ListTramites");

                    if (tramites != null) {
            for (Tramite Tram : tramites) {%>
            <tr align="justify" id="T<%=Tram.getId_tramite()%>">
                <td onClick="Enviar(this)" style="cursor:pointer" id="<%=Tram.getId_tramite()%>"> <input class="check" type="checkbox" name="Ftoken" value="<%=Tram.getId_tramite()%>" disabled="true" checked="true" /></td>
                <td class="text"><%=Tram.getId_tramite()%></td>
                <td class="text"><%=Tram.getNombre()%></td>
            </tr>
            <%
                    }
                }//if  
            %>
            <tr align="center" style="display:none">
                <td><input type="button" value="Limpiar"/></td>
                <td>&nbsp;</td>
                <td><input type="button" value="Guardar" onClick="Enviar()"/></td>
            </tr>
            <%
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            %>
        </table>
   </form>
    </body>
</html>
