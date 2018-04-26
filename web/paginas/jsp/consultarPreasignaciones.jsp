<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  import="modelo.Usuario" errorPage="" %>

<%
                    modelo.Model modelo = (modelo.Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
%>


<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%@ page import="modelo.*"%>
        <%@page import="java.util.*"%>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Vehiculo</title>
        <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript">

            function buscarPlaca(){
                if(document.form.placa.value.length!=0){
                    window.frames[0].location.href = "verPreasignaciones.jsp?num=2&placa="+document.form.placa.value;
                }else{
                    alert("Digite la placa a Buscar");
                }
            }

            function ReporteExcel(){

                window.frames[0].location.href = "verPreasignaciones.jsp?num=3&exc=1";

            }

            function buscarVencidas(){
                window.frames[0].location.href = "verPreasignaciones.jsp?num=3&exc=0";
            }

            function paso(){
                if(document.form.fechaI.value.length>0){
                    if(document.form.fechaF.value.length>0){
                        document.form.action='consultarPreasignaciones.jsp'
                        document.form.submit();
                    }else{
                        alert("Digite la fecha final del reporte Genearal");
                    }
                }else{
                    alert("Digite la fecha inicial del reporte General");
                }
            }





            function buscarFecha(){
                if(document.form.fechaI.value.length==10){
                    if(document.form.fechaF.value.length==10){
                        window.frames[0].location.href = "verPreasignaciones.jsp?num=1&fechaI="+document.form.fechaI.value+"&fechaF="+document.form.fechaF.value+"&fk_usuario="+document.form.usuario.options[document.form.usuario.selectedIndex].value;
                    }else{
                        alert("Digite la fecha Final de la Busqueda");
                    }
                }else{
                    alert("Digite la fecha Inicial de la Busqueda");
                }
            }

            function mostrar(){
                window.frames[0].location.href = "verPrestamos.jsp?num=1";
            }


            function ver(){
                if(document.form.busqueda[0].checked){
                    document.getElementById('tabla1').style.display = "none";
                    document.getElementById('tabla2').style.display = "block";
                    document.getElementById('tabla3').style.display = "none";
                }else{
                    if(document.form.busqueda[1].checked){
                        document.getElementById('tabla1').style.display = "block";
                        document.getElementById('tabla2').style.display = "none";
                        document.getElementById('tabla3').style.display = "none";
                    }else{
                        document.getElementById('tabla1').style.display = "none";
                        document.getElementById('tabla2').style.display = "none";
                        document.getElementById('tabla3').style.display = "block";
                    }
                }
            }
            function verReporte(){
                ancho = 789;
                alto = 250;
                barra = 0;
                izquierda = (document.width) ? (document.width-ancho)/2 : 100;
                arriba = (document.height) ? (document.height-alto)/2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "/preasignacion/ReportePreasignaciones.jasper";
                var nombre = "preasignaciones";
                url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
                window.open(url, 'popUp', opciones);
            }
        </script>
        <STYLE>
            <!--
            A.ssmItems:link		{color:black;text-decoration:none;}
            A.ssmItems:hover	{color:black;text-decoration:none;}
            A.ssmItems:active	{color:black;text-decoration:none;}
            A.ssmItems:visited	{color:black;text-decoration:none;}
            .style5 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
            .Estilo11 {
                color: #0066CC;
                font-weight: bold;
                font-size: 10px;
            }
            .style7 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
            -->
        </STYLE>


    </head>
    <%
            if (request.getParameter("fechaI") != null && request.getParameter("fechaF") != null && !request.getParameter("fechaI").isEmpty() && !request.getParameter("fechaF").isEmpty()) {
                HashMap parameters = new java.util.HashMap();
                parameters.put("USUARIO", usuario.getNombre());
                parameters.put("FECHA_INI", request.getParameter("fechaI"));
                parameters.put("FECHA_FIN", request.getParameter("fechaF"));
                parameters.put("fk_usuario", request.getParameter("usuario"));
                session.setAttribute("preasignaciones", parameters);
    %>
    <script language="javascript" type="text/javascript">
        verReporte();
    </script>

    <%  }



    %>
    <body>
        <form name="form" id="form" method="post" action="verPrestamos.jsp" >
            <fieldset>
                <table width="100%" border="0" align="center">
                    <tr style="border:none; background:url(../html/images/inicio_3.png)">
                        <td colspan="6" align="center" valign="middle"><span class="style7">CONSULTAR PREASIGNACIONES</span></td>
                    </tr>
                    <tr>

                        <td colspan="1" valign="middle" align="center" width="33%"><span class="Estilo11">
                                <input type="radio" name="busqueda" value="1" onClick="ver()">
				  N&ordm;&nbsp;DE&nbsp;PLACA </span></td>
                        <td colspan="2" valign="middle" align="center" width="33%"><span class="Estilo11">
                                <input type="radio" name="busqueda" value="2"  checked="checked" onClick="ver() ">
				  FECHA&nbsp;DE&nbsp;SOLICITUD</span></td>
                        <td colspan="2" valign="middle" align="center" width="33%"><span class="Estilo11">
                                <input type="radio" name="busqueda" value="3"  onClick="ver() ">
				  VENCIDAS A LAS FECHA </span></td>
                    </tr>
                    <tr align="center">
                        <td height="50" colspan="5" align="center" >

                            <table border="0" width="100%" id="tabla1"  >
                                <tr valign="middle">
                                     <td width="10%" align="right"><label style="color:#333333"><span class="style5">USUARIO</span></label>
                                     <td width="17%" scope="col">
                                        <select name="usuario" id="usuario" size="1" style="width:100%;size:4;color:#333333; ">
                                            <option value="0">Seleccione Usuario</option>
                                            <%
                try {

                    java.util.List listaUsuarios = modelo.listarUsuarios(234);
                    for (int i = 0; i < listaUsuarios.size(); i++) {
                        Usuario usua = (Usuario) listaUsuarios.get(i);
                                            %>
                                            <option value="<%=usua.getId_usuario()%>"><%=usua.getNombre()%></option>
                                            <%	}
                } catch (Exception exc) {
                    out.println(exc.getMessage());
                }%>
                                        </select>
                                    </td>
                                    <td width="10%" align="right"><label style="color:#333333"><span class="style5">FECHA&nbsp;INICIAL</span></label>
                                    </td>
                                    <% String fecha_hoy = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
                                    <td width="18%" scope="col" align="center"><input  id="fechaI" name="fechaI" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy%>"/>
                                        <input name="bfechaI" type="button" id="bfechaI" value="<" style="width:20px">
                                        <SCRIPT type="text/javascript">
                                            Calendar.setup({
                                                inputField     :    "fechaI",
                                                ifFormat       :    "%d/%m/%Y",
                                                button         :    "bfechaI"
                                            });
                                        </SCRIPT></td>
                                    <td width="14%"  align="center"><label style="color:#333333"><span class="style5">FECHA&nbsp;FINAL</span></label>
                                    </td>
                                    <td width="20%" scope="col"><input  id="fechaF" name="fechaF" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy%>"/>
                                        <input name="bfechaF" type="button" id="bfechaF" value="<" style="width:20px">
                                        <SCRIPT type="text/javascript">
                                            Calendar.setup({
                                                inputField     :    "fechaF",
                                                ifFormat       :    "%d/%m/%Y",
                                                button         :    "bfechaF"
                                            });
                                        </SCRIPT></td>

                                    <td width="8%" scope="col"><input id="consultar"  name="consultar2" type="button" value="Consultar" style="color:#333333" onClick="buscarFecha()"/></td>
                                    <td width="8%" scope="col" align="center">
                                        <input id="reporte"  name="reporte" type="button" value="Reporte" style="color:#333333" onClick="paso()"/></td>
                                </tr>
                            </table>

                            <table border="0" width="100%" id="tabla2" style="display:none" >
                                <tr valign="middle">
                                    <td width="40%" height="26" align="right"><label style="color:#333333"><span class="style5">PLACA</span></label>
                                    </td>
                                    <td width="20%" scope="col" align="right"><input  id="placa" name="placa" style="text-align:center;color:#333333;font:bold; width:125px" maxlength="6" />
                                    </td>

                                    <td width="21%" scope="col"></td>
                                    <td width="19%" scope="col" colspan="2"><input id="consultar"  name="consultar2" type="button" value="Consultar" style="color:#333333" onClick="buscarPlaca()"/></td>

                                </tr>
                            </table>
                            <table border="0" width="100%" id="tabla3" style="display:none" >
                                <tr valign="middle">


                                    <td width="19%" scope="col" colspan="2" align="center"><input id="consultar"  name="consultar2" type="button" value="Consultar Preasignaciones Vencidas" style="color:#333333" onClick="buscarVencidas()"/></td>
                                    <td width="19%" scope="col" colspan="2" align="center"><input id="consultar"  name="consultar2" type="button" value="Reporte Excel" style="color:#333333" onClick="ReporteExcel()"/></td>

                                </tr>
                            </table>

                        </td>
                    </tr>
                </table>
            </fieldset>
            <iframe src="#" width="100%" id="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe>
        </form>
    </body>
</html>