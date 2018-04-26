<%-- 
    Document   : generarPlanosHacienda
    Created on : 8/08/2011, 10:57:46 AM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
            try {
                if (session.getAttribute("model") != null) {
                    if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                        Model model = (Model) session.getAttribute("model");
                        if (model != null) {
%>
<html>
    <head>
        <title>Hacienda</title>
        <style type="text/css">
            .label {font-size: 11px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold ; width:60px}
            .text {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ;  text-transform:uppercase}
            .cdate {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; width:80px}
            .bdate {font-size: 10px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold; width:20px }
            .name {font-size: 11px; color:#003366; text-align:left ; font-family:Arial; font-weight:bold; width:362px }
            .input { width:130px }
            .check { font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; }
        </style>
        <meta http-equiv=Content-Type content="text/html; charset=windows-1252"/>
        <link title=win2k-cold-1 media=all href="../../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script src="../../html/scripts/validarFecha.js" type="text/javascript"></script>
        <script type="text/javascript">

            function validarFechaInicio(date){
                if(date.value==""){
                    alert("       Digite Fecha de Inicio");
                    return false;
                }else
                    return true;
            }
            function validarFechaFinal(date2){
                if(date2.value==""){
                    alert("       Digite Fecha Final ");
                    return false;
                }else
                    return true;
            }

            function validarFechaMayor(){
                var dia_ini = document.form.date.value.substr(0, 2);
                var mes_ini = document.form.date.value.substr(3, 2);
                var ano_ini = document.form.date.value.substr(6, 4);
                var dia_fin = document.form.date2.value.substr(0, 2);
                var mes_fin = document.form.date2.value.substr(3, 2);
                var ano_fin = document.form.date2.value.substr(6, 4);
                fecha_ini = new Date(ano_ini,mes_ini-1,dia_ini).getTime();
                fecha_fin = new Date(ano_fin,mes_fin-1,dia_fin).getTime();
                if(fecha_ini<=fecha_fin){

                }else{
                    alert("  Error, La Fecha de Inicio es Mayor ");
                    return false;
                }
            }


            function validarFormulario()
            {
                with(form){

                    if(validarFechaInicio(document.form.date)==false){
                        date.focus();
                        return false;
                    }
                    if(validarFechaFinal(document.form.date2)==false){
                        date2.focus();
                        return false;
                    }
                    if(validarFechaMayor()==false){
                        date.focus();
                        return false;
                    }

                }
            }
        </script>
    </head>

    <body>
        <div align="center">
            <div align="center" >
                <form name="form" method="post" onsubmit="return validarFormulario(this)" action="procesarPlanosHacienda.jsp">
                    <fieldset>
                        <legend></legend>
                        <table border="0" align="center" width="480px" cellpadding="1" cellspacing="1">
                            <tr>
                                <td colspan="5" align="center"><div class="text" style="width:250px">GENERACION DE PLANOS HACIENDA</div></td>
                            </tr>
                            <tr>
                                <td colspan="5" >&nbsp;</td>
                            </tr>

                            <tr>
                                <td class="label">Fecha&nbsp;Inicial</td>
                                <% String fecha = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
                                <td><input type="text" name="date" class="cdate" id="fecha_desde"  value="<%=fecha%>" onkeyup="mascara(this,'/',true)" maxlength="10"/>
                                    <input name="button" type="button" class="bdate" id="lanzador" value="<<"/>
                                    <script type="text/javascript">
                                        Calendar.setup({
                                            inputField     :    "fecha_desde",      // id del campo de texto
                                            ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                            button         :    "lanzador"   // el id del bot&iuml;&iquest;&frac12;n que lanzar&iuml;&iquest;&frac12; el calendario
                                        });
                                    </script>
                                </td>
                                <td>&nbsp;</td>
                                <td class="label">Fecha Final</td>
                                <td><input type="text" name="date2" class="cdate" id="fecha_hasta" value="<%=fecha%>" onkeyup="mascara(this,'/',true)" maxlength="10"/>
                                    <input name="button" type="button" class="bdate" id="lanzador2" value="<<"/>
                                    <script type="text/javascript">
                                        Calendar.setup({
                                            inputField     :    "fecha_hasta",      // id del campo de texto
                                            ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                            button         :    "lanzador2"   // el id del bot&iuml;&iquest;&frac12;n que lanzar&iuml;&iquest;&frac12; el calendario
                                        });
                                    </script>
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="5" align="center">
                                    <input type="submit" name="asignar" id="asignar" class="check" value="Generar"/>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </form>
            </div>
        </div>
    </body>
</html>
<%
                        }
                    } else {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<% }
                } else {%>
<script type="text/javascript">
    window.parent.document.location.href = "../../index.jsp";
</script>  <%            }
            } catch (Exception mexe) {
                mexe.printStackTrace();%>
<jsp:forward page="../no_access.jsp">
    <jsp:param name="tipo" value="2"></jsp:param>
    <jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param>
</jsp:forward>
<%  }%>
