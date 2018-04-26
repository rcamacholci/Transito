<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <!-- Viewport Metatag -->
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
            <!-- Viewport Metatag -->
            <meta name="viewport" content="width=device-width,initial-scale=1.0">

                <!-- Plugin Stylesheets first to ease overrides -->
                    <link rel="stylesheet" type="text/css" href="../../plugins/colorpicker/colorpicker.css" media="screen">
                    <script src="../../html/scripts/Administracion.js"ol type="text/javascript"></script>
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
                                                                <form class="mws-panel-toolbar">
                                                                    <body>
                                                                            <div align="center" style="width:100%">
                                                                                <fieldset  style="width:90%">
                                                                                    <table width="100%" style="height:470px" border="0">
                                                                                        <tr>
                                                                                            <td colspan="2" align="left">
                                                                                                <table border="0">
                                                                                                    <tr >
                                                                                                        <td align="left">
                                                                                                            <ul>
                                                                                                            <li title="Tablas Parametricas" style="cursor:pointer" onclick="LlamarOpcion('MenuAdministracion.jsp?op=1')"><i class="icol32-bricks"></i>Parametrizacion</li>
                                                                                                            <li title="Ediciones" style="cursor:pointer" onclick="LlamarOpcion('MenuAdministracion.jsp?op=2')"><i class="icol32-brick-edit" ></i></li>
                                                                                                            <li title="Configuraciones" style="cursor:pointer"><i class="icol32-cog" ></i></li>
                                                                                                            <li title="Roles" style="cursor:pointer"><i class="icol32-group-gear"></i></li>
                                                                                                        </ul>
                                                                                                       </td>
                                                                                                    </tr>
                                                                                                </table>                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td width="32%" style="vertical-align:top">
                                                                                                <fieldset >
                                                                                                <iframe id="menu_opciones" name="menu_opciones" height="450px" width="100%" frameborder="0"></iframe>
                                                                                                </fieldset>                                                                                            </td>
                                                                                            <td width="82%">
                                                                                                <fieldset>
                                                                                                    <iframe id="contenedor" name="contenedor" height="480px" width="100%" frameborder="0"></iframe>
                                                                                                </fieldset>                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </fieldset>
                                                                            </div>

                                                                    </body>
                                                                </form>
                                                                </html>
