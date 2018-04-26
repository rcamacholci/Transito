<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Vehiculo</title>
    <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
		<script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
		<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript">
			
			function buscarR(){
				if(document.form.fechaI.value.length==10&&document.form.fechaF.value.length==10){
					window.frames[0].location.href = "verComparendos.jsp?fi="+document.form.fechaI.value+"&ff="+document.form.fechaF.value+"&polca="+document.form.polca.value;
				}else{
                                    alert("Digite fechas de radicacion");
                                }
			}
                       


			
			function verReporte(){
				ancho = 789;
				alto = 250;
				barra = 0;
				izquierda = (document.width) ? (document.width-ancho)/2 : 100;
				arriba = (document.height) ? (document.height-alto)/2 : 100;
				opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
				var dir = "/comparendos/recaudoComparendos.jasper";
			    var nombre = "recaudoC";
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
.style1 {
	font-size: 12px;
	font-family: Tahoma;
}
.style5 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
.Estilo11 {
	color:#000000;
	font-weight: bold;
	font-size: 10px;
}
-->
        </STYLE>


</head>
    <%
    Model model = null;
    try {
        model = (Model) session.getAttribute("model");
    } catch (Exception exc) {
        exc.printStackTrace();
    }
    %>
    <body> 
         <% String fecha_hoy = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
		<form name="form" id="form" method="post" action="">
	        <fieldset><div align="center">
		    <legend class="style5"  align="center">CONSULTAR&nbsp;COMPARENDOS</legend>
		  	</div> 
			<table width="100%" border="0" align="center">
				
				<tr>
					<td colspan="5">
						<table border="0" width="100%" id="tabla2">
								<tr valign="middle">
								   <td width="27%" align="right"><label style="color:#333333"><span class="style5">FECHA&nbsp;INICIAL</span></label>
								  </td>
								  <td width="20%" scope="col" align="right"><input  id="fechaI" name="fechaI" style="text-align:center;color:#333333;font:bold; width:125px" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy%>"/>
												 <input name="bfechaI" type="button" id="bfechaI" value="..." style="width:30px">
								  <SCRIPT type="text/javascript">
														Calendar.setup({
																inputField     :    "fechaI",
																ifFormat       :    "%d/%m/%Y",
																button         :    "bfechaI"
														});
												  </SCRIPT></td>
								  <td width="14%"  align="center"><label style="color:#333333"><span class="style5">FECHA&nbsp;FINAL</span></label>
								  </td>
								  <td width="23%" scope="col"><input  id="fechaF" name="fechaF" style="text-align:center;color:#333333;font:bold; width:125px" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy%>"/>
												 <input name="bfechaF" type="button" id="bfechaF" value="..." style="width:30px">
								  <SCRIPT type="text/javascript">
														Calendar.setup({
																inputField     :    "fechaF",
																ifFormat       :    "%d/%m/%Y",
																button         :    "bfechaF"
														});
												  </SCRIPT></td>
                                                                                                  <td width="27%" align="center"><label style="color:#333333"><span class="style5">POLCA</span></label>
                                                                       <td><select name="polca" id="polca" style="font-size:12px; width:100px">
                                                                                    <option value="2"> - Seleccione opcion - </option>
                                                                                    <option value="0"> - No - </option>
                                                                                    <option value="1"> - Si - </option>
                                                                      </select></td>
				<td width="8%" scope="col"><input id="consultar"  name="consultar2" type="button" value="Consultar" style="color:#333333" onClick="buscarR()"/></td>
				<td width="8%" scope="col" align="center">
						<input id="reporte"  name="reporte" type="button" value="Reporte" style="color:#333333" onClick="verReporte()"/></td>
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
<%  }else{ %>
			   <jsp:forward page="no_access.jsp">
				 <jsp:param name="tipo" value="1"></jsp:param>
			   </jsp:forward>
	<%  }
	}else{ %>
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
