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
            <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
                <!-- Plugin Stylesheets first to ease overrides -->
                <link rel="stylesheet" type="text/css" href="../../plugins/colorpicker/colorpicker.css" media="screen">
                    <script src="../../html/scripts/Administracion.js" type="text/javascript"></script>
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
                                                                <body>
                                                                    <div align="center" style="width:90%" class="mws-panel">
                                                                        <%if(request.getParameter("op").equals("1")){%>
                                                                        <fieldset><legend>Parametrizacion</legend>
                                                                        <ul id="icons-colors" class="clearfix">
                                                                            <li title="Colores"  style="cursor:pointer" onclick="LlamarProceso('ParametrizacionColores.jsp')"><img src="../../html/images/Colores.png"/></li>
                                                                            <li title="Conceptos"  style="cursor:pointer" onclick="LlamarProceso('AdministrarConceptos.jsp')"><img src="../../html/images/Tramites.png"/></li>
                                                                            <li title="Entidad distribucion"  style="cursor:pointer" onclick="LlamarProceso('ParametrizacionEntidades.jsp')"><img src="../../html/images/Grupos.png"/></li>
                                                                            <li title="Conceptos"  style="cursor:pointer" onclick="LlamarProceso('ParametrizacionTramite.jsp')"><img src="../../html/images/Parametros.jpg"/></li>
                                                                            <li title="Conceptos"  style="cursor:pointer" onclick="LlamarProceso('AdministrarConceptos.jsp')"><img src="../../html/images/Calendar.png"/></li>
                                                                            <li title="Conceptos"  style="cursor:pointer" onclick="LlamarProceso('AdministrarConceptos.jsp')"><img src="../../html/images/Colores.png"/></li>
                                                                            <li title="Conceptos"  style="cursor:pointer" onclick="LlamarProceso('AdministrarConceptos.jsp')"><img src="../../html/images/Colores.png"/></li>
                                                                            <li title="Conceptos"  style="cursor:pointer" onclick="LlamarProceso('AdministrarConceptos.jsp')"><img src="../../html/images/Colores.png"/></li>
                                                                            <li title="Conceptos"  style="cursor:pointer" onclick="LlamarProceso('AdministrarConceptos.jsp')"><img src="../../html/images/Colores.png"/></li>
                                                                            <li title="Conceptos"  style="cursor:pointer" onclick="LlamarProceso('AdministrarConceptos.jsp')"><img src="../../html/images/Colores.png"/></li>
                                                                            <li title="Conceptos"  style="cursor:pointer" onclick="LlamarProceso('AdministrarConceptos.jsp')"><img src="../../html/images/Colores.png"/></li>
                                                                        </ul>
                                                                        </fieldset>
                                                                        <%}else if(request.getParameter("op").equals("2")){%>
                                                                        <fieldset><legend>Edicion</legend>
                                                                        <ul id="icons-colors" class="clearfix">
                                                                            <li title="Colores"  style="cursor:pointer" onclick="LlamarProceso('ListadoColores.jsp')"><img src="../../html/images/Colores.png"/></li>
                                                                            <li title="Conceptos"  style="cursor:pointer" onclick="LlamarProceso('ListadoConcepto.jsp')"><img src="../../html/images/editar.png"/></li>
                                                                            <li title="Entidad distribucion"  style="cursor:pointer" onclick="LlamarProceso('ParametrizacionEntidades.jsp')"><img src="../../html/images/Grupos.png"/></li>
                                                                            <li title="Conceptos"  style="cursor:pointer" onclick="LlamarProceso('ParametrizacionTramite.jsp')"><img src="../../html/images/Parametros.jpg"/></li>
                                                                            <li title="Conceptos"  style="cursor:pointer" onclick="LlamarProceso('AdministrarConceptos.jsp')"><img src="../../html/images/Calendar.png"/></li>
                                                                            <li title="Conceptos"  style="cursor:pointer" onclick="LlamarProceso('AdministrarConceptos.jsp')"><img src="../../html/images/Colores.png"/></li>
                                                                            <li title="Conceptos"  style="cursor:pointer" onclick="LlamarProceso('AdministrarConceptos.jsp')"><img src="../../html/images/Colores.png"/></li>
                                                                            <li title="Conceptos"  style="cursor:pointer" onclick="LlamarProceso('AdministrarConceptos.jsp')"><img src="../../html/images/Colores.png"/></li>
                                                                            <li title="Conceptos"  style="cursor:pointer" onclick="LlamarProceso('AdministrarConceptos.jsp')"><img src="../../html/images/Colores.png"/></li>
                                                                            <li title="Conceptos"  style="cursor:pointer" onclick="LlamarProceso('AdministrarConceptos.jsp')"><img src="../../html/images/Colores.png"/></li>
                                                                            <li title="Conceptos"  style="cursor:pointer" onclick="LlamarProceso('ConfiguracionConceptos.jsp')"><img src="../../html/images/Colores.png"/></li>
                                                                        </ul>
                                                                        </fieldset>
                                                                        <%}%>
                                                                    </div>
                                                                </body>
                                                                </html>
