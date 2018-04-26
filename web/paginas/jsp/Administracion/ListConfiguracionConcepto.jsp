<%@page import="modelo.Model"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <!-- Viewport Metatag -->
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
            <!-- Viewport Metatag -->
            <meta name="viewport" content="width=device-width,initial-scale=1.0">
                <!-- Plugin Stylesheets first to ease overrides -->
                <link rel="stylesheet" type="text/css" href="../../plugins/colorpicker/colorpicker.css" media="screen">
                    <script src="../../html/scripts/Administracion.js" type="text/javascript"></script>
                    <script src="../../html/scripts/motorAjax.js" type="text/javascript"></script>
                    <script>
                        function edit(tr){
                            document.location.href="ProcesoConfigurarConceptos.jsp?id="+tr.id+"&fecha="+document.form.fecha.value+"&resolucion="+document.form.resolucion.value;
                        }
                    </script>
                    <!-- Required Stylesheets -->
                    <link rel="stylesheet" type="text/css" href="../../bootstrap/css/bootstrap.min.css" media="screen">
                        <link rel="stylesheet" type="text/css" href="../../css/fonts/ptsans/stylesheet.css" media="screen">
                            <link rel="stylesheet" type="text/css" href="../../css/fonts/icomoon/style.css" media="screen">

                                <link rel="stylesheet" type="text/css" href="../../css/mws-style.css" media="screen">
                                    <link rel="stylesheet" type="text/css" href="../../css/icons/icol16.css" media="screen">
                                        <link rel="stylesheet" type="text/css" href="../../css/icons/icol32.css" media="screen">
                                            <!-- Demo Stylesheet -->
                                            <link rel="stylesheet" type="text/css" href="../../css/demo.css" media="screen">
                                                <!-- jQuery-UI Stylesheet -->
                                                <link rel="stylesheet" type="text/css" href="../../jui/css/jquery.ui.all.css" media="screen">
                                                    <link rel="stylesheet" type="text/css" href="../../jui/jquery-ui.custom.css" media="screen">
                                                        <!-- Theme Stylesheet -->
                                                        <link rel="stylesheet" type="text/css" href="../../css/mws-theme.css" media="screen">
                                                            <link rel="stylesheet" type="text/css" href="../../css/themer.css" media="screen">
                                                                <title>Documento sin t&iacute;tulo</title>
                                                                </head>
    <form id="form" name="form" class="mws-form">
                                                                    <input type="hidden" id="resolucion" name="resolucion" value="<%=request.getParameter("reso")%>"/>
                                                                    <input type="hidden" id="fecha" name="fecha" value="<%=request.getParameter("fecha")%>"/>
                                                                    <div style="width: 99%" align="center" class="mws-panel grid_8">
                                                                        <table class="mws-table">
                                                                            <%
                                                                                try {
                                                                                    modelo.Sede sede = (modelo.Sede) session.getAttribute("sede");
                                                                                    modelo.Model model = new modelo.Model();
                                                                                    model.conectar();
                                                                                    model.getCon().setAutoCommit(false);
                                                                                    java.util.LinkedList<modelo.Concepto> temlist = model.listadoConceptosSedeTramite(sede.getId_sede());
                                                                                    for (int i = 0; i < temlist.size(); i++) {
                                                                                        modelo.Concepto con = temlist.get(i);
                                                                            %>
                                                                            <tr id ="<%=con.getId_concepto()%>" name="<%=con.getId_concepto()%>" ondblclick="edit(this)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                                                                                <td align="center" style="cursor:pointer"><%=con.getId_concepto()%></td>
                                                                                <td align="center" style="cursor:pointer"><%=con.getNombre()%></td>
                                                                            </tr>
                                                                            <%
                                                                                }
                                                                            %>
                                                                        </table>
                                                                    </div>
                                                                </form>
                                                                <body>
                                                                </body>
                                                                </html>
                                                                <%} catch (Exception ex) {
                                                                        ex.printStackTrace();
                                                                    }
                                                                %>