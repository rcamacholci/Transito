<%-- 
    Document   : TramitesPermitidos
    Created on : 18/11/2015, 04:40:23 PM
    Author     : Desarrollo
--%>
    <link rel=stylesheet href="../../html/css/Style.css" type="text/css" media=screen></link>
<%@page import="com.sun.org.apache.xml.internal.resolver.readers.TR9401CatalogReader"%>
<%@page import="java.util.*"%>
<%@page import="modelo.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        try {
            Model model = (Model) session.getAttribute("model");
            Sede sede = (Sede) session.getAttribute("sede");
            List<Tramite> Ttra = model.consultarTramites(4, sede.getId_sede());
    %>
    <script type="text/javascript">
        function Enviar() {
            window.form.accion = "TramitesPermitidos";
            //window.form.target= window.parent.form.target ="trget";
            document.form.submit();
        }
    </script>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    
    <%
        java.util.List chk = new java.util.LinkedList();
        if (request.getParameter("ListTra") != null) {
            java.util.List<Tramite> tempc = new java.util.LinkedList<Tramite>();
            String[] Tramites = request.getParameterValues("ListTra");
            for (int i = 0; i < Tramites.length; i++) {
                Tramite Tram = model.consultarTramite(Long.parseLong(Tramites[i]));
                tempc.add(Tram);
                chk.add(Tram.getId_tramite());
            }
            session.setAttribute("ListTramites", tempc);
    %>
    <script type="text/javascript" >
        window.parent.frames[1].location.href="TramitesSeleccionados.jsp";
    </script>
    <%} else {
        session.removeAttribute("ListTramites");
    %>
    <script type="text/javascript" >
        window.parent.frames[1].location.href="TramitesSeleccionados.jsp";
    </script>
    <%
        }%>
    <body>
        <form name="form" id="form" method="post" >
            <table align="center">
                <tr align="justify" class="label">
                    <td>&nbsp;&nbsp;X&nbsp;&nbsp;</td><td>    Codigo  </td><td>Nombre Tramite</td>
                </tr>
                <% for (Tramite Tram : Ttra) {%>
                <% if(Tram.getId_tramite()==91 || Tram.getId_tramite()==113){ %>
                <tr align="justify" id="T<%=Tram.getId_tramite()%>">
                    <td  style="cursor:pointer" id="<%=Tram.getId_tramite()%>" onClick="Enviar()">
                            <input type="checkbox" name="ListTra" id="ListTra" class="check" value="<%=Tram.getId_tramite()%>" <%=chk.contains(Tram.getId_tramite()) ? "Checked" : ""%> />
                    </td>
                    <td class="text"><%=Tram.getId_tramite()%></td>
                    <td class="text"><%=Tram.getNombre()%></td>
                </tr>
                <% }} %>
                </tr>
            </table>
        </form>
    </body>
    <%} catch (Exception ex) {
            ex.printStackTrace();
        }
    %>
</html>
