<%@ page contentType ="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="modelo.*"  %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

    <%
        try {
            Model model = (Model) session.getAttribute("model");
            Sede sede = (Sede) session.getAttribute("sede");
    %>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>RNMA</title>
    </head>
    <body>
        <form name="form" id="form" method="post">
            <input type="hidden" id="documento" name="docuemnto" value="1043843736">
            <table style="width: 100%;height: 70%">
                <tr>
                    <td width="35%" valign="top">
                        <fieldset>
                            <legend>Tramites permitidos</legend>
                            <iframe name="trg" id="trg" src="TramitesPermitidos.jsp" width="100%" height="400" scrolling="auto" frameborder="0"></iframe>
                        </fieldset>
                    </td>
                    <td width="65%" valign="top" style="display: ">
                            <fieldset>
                                <legend>Tramites Seleccionados</legend>
                                <iframe name="trget" id="trget" src="TramitesSeleccionados.jsp" width="100%" height="400" scrolling="auto" frameborder="0" ></iframe>
                            </fieldset>
                    </td>
                </tr>
            </table>
        </form>
    </body>
    <%} catch (Exception ex) {
            ex.printStackTrace();
        }
    %>
</html>
