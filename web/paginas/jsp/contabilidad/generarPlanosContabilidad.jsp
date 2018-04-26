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
<!--
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style3 {color: #FFFFFF}
.style31 {color: #333333; font-size: 12px; font-weight: bold; font-family: Tahoma; }
.Estilo2 {
	color: #FFFFFF;
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
}
-->
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
                <form name="form" method="post" onSubmit="return validarFormulario(this)" action="procesarPlanosContabilidad.jsp">
                    <fieldset>
                        <legend></legend>
                        <table width="75%" border="0"  bordercolor="#FFFFFF" align="center">
                            <tr style="border:none; background:url(../../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="Estilo2">GENERACIÓN PLANO DE CONTABILIDAD </span></td>
				<tr>
                            <tr>
                                <td colspan="5" >&nbsp;</td>
                            </tr>

                            <tr>
                                   <td width="150" height="59"  align="center"><label style="color:#333333">
							      <div align="right"><span class="style2">Fecha Inicial</span></div>
						      </label>							  </td>
                                <% String fecha = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
                                <td width="220"> <div align="left">
								<input type="text" name="date" class="cdate" id="fecha_desde"  value="<%=fecha%>" onKeyUp="mascara(this,'/',true)" maxlength="10"/>
                                  <!--  <input name="button" type="button" class="bdate" id="lanzador" value="<<"/> -->
                                     <button name="button" type="button" id="lanzador"><img src="../../html/images/calendario.png"  width="18" height="18"/></button>
                                    <script type="text/javascript">
                                        Calendar.setup({
                                            inputField     :    "fecha_desde",      // id del campo de texto
                                            ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                            button         :    "lanzador"   // el id del bot&iuml;&iquest;&frac12;n que lanzar&iuml;&iquest;&frac12; el calendario
                                        });
                                    </script>
									   </div>
                              </td>
                                
                                 <td width="150" height="59"  align="center"><label style="color:#333333">
							      <div align="right"><span class="style2">Fecha Final</span></div>
						      </label>							  </td>
                                <td width="220"><div align="left">
								<input type="text" name="date2" class="cdate" id="fecha_hasta" value="<%=fecha%>" onKeyUp="mascara(this,'/',true)" maxlength="10"/>
                                   <!-- <input name="button" type="button" class="bdate" id="lanzador2" value="<<"/> -->
                                   <button name="button" type="button" id="lanzador2"><img src="../../html/images/calendario.png"  width="18" height="18"/></button>
                                    <script type="text/javascript">
                                        Calendar.setup({
                                            inputField     :    "fecha_hasta",      // id del campo de texto
                                            ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                            button         :    "lanzador2"   // el id del bot&iuml;&iquest;&frac12;n que lanzar&iuml;&iquest;&frac12; el calendario
                                        });
                                    </script>
									 </div>
                              </td>
                            </tr>
                            <tr>
                                <td colspan="5" align="center">
                            </tr>
                            <tr>
                                <td colspan="5" align="center">
<button type="submit" name="asignar" id="asignar"  value="Generar"><span class="style2">Generar </span><img src="../../html/images/plano.png" width="19" height="18"/></button>
                                  <!--  <input type="submit" name="asignar" id="asignar" class="check" value="Generar"/> -->
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
