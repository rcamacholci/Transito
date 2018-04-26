<%@page import="java.util.Calendar"%>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>


<%
    modelo.Model model = (modelo.Model) session.getAttribute("model");
    modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");

    String fechaIni = (request.getParameter("fechaIni") != null) ? request.getParameter("fechaIni") : "";
    String fechaFin = (request.getParameter("fechaFin") != null) ? request.getParameter("fechaFin") : "";
    boolean valid = (request.getParameter("valid") != null) ? Boolean.parseBoolean(request.getParameter("valid")) : true;

    long plano = (request.getParameter("plano") != null) ? Long.parseLong(request.getParameter("plano")) : 0;
    int estado = (request.getParameter("estado") != null) ? Integer.parseInt(request.getParameter("estado")) : 0;

    String msg = "";
    String pageList = "";


    if (valid) {

        if (fechaIni.equals("")) {
            msg = "Por favor indique la fecha inicial";
        }

        if (fechaFin.equals("")) {
            msg = "Por favor indique la fecha final";
        }

        if (msg.equals("")) {

            java.util.Date dateI = new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fechaIni);
            java.util.Date dateF = new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fechaFin);

            if (dateF.getTime() < dateI.getTime()) {
                msg = "La fecha final no puede ser menor a la fecha inicial";
            } else {
                pageList = "listarDatosArchivosPlanos.jsp?plano=1&estado=1" + "&fechaIni=" + fechaIni + "&fechaFin=" + fechaFin;
            }
        }
    }


    String fechaBase = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date(java.util.Calendar.getInstance().getTimeInMillis()));

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Generar Archivos Planos</title>

        <link rel="stylesheet" type="text/css" href='../../html/css/style.css' />
        <link title="win2k-cold-1" media="all" href="../../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../../html/scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
        <script src="../../html/scripts/generalFunctions.js" type="text/javascript"></script>
        <script src="../../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../../html/scripts/calendar-setup.js" type="text/javascript"></script>

        <script type="text/javascript">
            $(document).ready(pageLoaded) ;
            
            function pageLoaded(){
                Calendar.setup({
                    inputField     :    "fechaIni",      // id del campo de texto
                    ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                    button         :    "bfechaIni"   // el id del botón que lanzará el calendario
                });
                
                Calendar.setup({
                    inputField     :    "fechaFin",      // id del campo de texto
                    ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                    button         :    "bfechaFin"   // el id del botón que lanzará el calendario
                });
                
                var scMsg = "<%= msg%>"   ;
                if ( scMsg != "" ){
                    alert(scMsg) ;
                }
                
            }
            
            
            function validIfShowStateFields(sel){
                if ( sel.options[sel.selectedIndex].value == 1 ){
                    showOrHideStateFields(1) ;
                }else{
                    showOrHideStateFields(0) ;
                }
            }
            
            
            function showOrHideStateFields(opt){
                if (opt == 1){ // show
                    $("#divTxtEstado").show() ;
                    $("#divSelEstado").show() ;
                }else{ // hide
                    $("#divTxtEstado").hide() ;
                    $("#divSelEstado").hide() ;
                } 
                
            }
            
        </script>


        <style type="text/css">
            .dataTable{
                border: outset 1px #000 ;
            }
            .bdate {font-size: 10px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold; width:20px }
            .input {width:130px }
        </style>
    </head>

    <body>
        <form name="form" id="form" action="generatePlains.jsp" method="post">
            <table width="90%" border="0" align="center" class="dataTable" style="border:none">
                <tr>
                    <td colspan="4">
                        <div class="title_" align="center">  
                            Generaci&oacute;n de Archivos Planos
                        </div>
                    </td>
                </tr>
                <tr>
                    <td width="9%">
                        <div align="left" style="font-weight:bold">Desde</div>
                    </td>
                    <td width="36%">
                        <div align="left">
                            <input type="text" name="fechaIni" id="fechaIni"  value="<%= ((!fechaIni.equals("")) ? fechaIni : fechaBase)%>" class="date"  style="background-image:url(../../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10" />
                            <span class="input">
                                <input name="bfechaIni" type="button" id="bfechaIni" class="bdate" value="&lt;&lt;"/>
                            </span></div>
                    </td>
                    <td width="13%">
                        <div align="left" style="font-weight:bold">Hasta</div>
                    </td>
                    <td width="42%"><div align="left">
                            <input type="text" name="fechaFin" id="fechaFin" value="<%= ((!fechaFin.equals("")) ? fechaFin : fechaBase)%>" class="date"  style="background-image:url(../../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10" />
                            <span class="input">
                                <input name="bfechaFin" type="button" id="bfechaFin" class="bdate" value="&lt;&lt;"/>
                            </span></div></td>
                </tr>
                <!--<tr>
                    <td>
                        <div align="left" style="font-weight:bold">Buscar</div>
                    </td>
                    <td>
                        <div align="left">  
                            <select name="plano" id="plano" class="combo" onchange="javascript:validIfShowStateFields(this)">
                                <option value="0"> << SELECCIONAR >> </option>
                                <
                                    java.util.List<modelo.Parametro> lista = model.listadoParametros(84);
                                    String selected = null;
                                    boolean found = false;
                                    for (modelo.Parametro p : lista) {
                                        selected = "";
                                        if (plano > 0 && !found) {
                                            if (plano == p.getCodigo()) {
                                                selected = "selected";
                                                found = true;
                                            }
                                        }
                                %>
                                <option value="<= p.getCodigo()%>" <= selected%>><= p.getNombre()%></option>
                                <
                                    }
                                %>
                            </select>
                        </div>
                    </td>!-->

                <tr>
                    <td colspan="4">
                        <div align="right">
                            <input type="submit" name="submit" value="Buscar"/>
                        </div>
                    </td>
                </tr>
            </table>
            <iframe src="<%= pageList%>" id="data" name="data" marginwidth="0" height="900" width="100%" marginheight="0" align="top"  style="border:none" frameborder="0"></iframe>
        </form>
    </body>
</html>