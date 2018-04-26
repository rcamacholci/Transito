<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*"  errorPage="" %>
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
                            function ConsultarC(){
				if(document.form.comparendo.value.length>0){								
					window.frames[0].location.href = "VerReportesComparendos.jsp?comparendo="+document.form.comparendo.value;
				}else{
					alert("Ingrese numero de comparendo");
				}
				return false;
			}
                       
			
			function buscarR(){
                            
                             if(document.form.fechaI.value.length==10&&document.form.fechaF.value.length==10){
                            window.frames[0].location.href="VerReportesComparendos2.jsp?fi="+document.form.fechaI.value+"&ff="+document.form.fechaF.value;

                            }else{
                                    alert("Digite fechas de comparendo");
                                }
			}
			
			function buscarIn(){
                            
          if(document.form.fechaIn.value.length==10 && document.form.fechaFn.value.length==10){
             
              window.frames[0].location.href="EstadisticaInfracciones.jsp?fi="+document.form.fechaIn.value+"&ff="+document.form.fechaFn.value+"&infrac="+document.form.infraccion2.value;
           }else{
            alert("Digite fechas");
            }
		}			
            function buscarP(){
	
						
					window.frames[0].location.href = "VerReportesComparendos.jsp?infraccion="+document.form.infraccion.value;
			}


			function ver(){
			
				if(document.form.busqueda[0].checked){
					document.getElementById('tabla1').style.display = "block";
					document.getElementById('tabla2').style.display = "none";
                                        document.getElementById('tabla3').style.display = "none";
					document.getElementById('tabla4').style.display = "none";
                                       window.frames[0].location.href="pantallazo.jsp";
				}else{
                                    if(document.form.busqueda[1].checked){
                                   	document.getElementById('tabla1').style.display = "none";
					document.getElementById('tabla2').style.display = "none";
                                        document.getElementById('tabla3').style.display = "block";
					document.getElementById('tabla4').style.display = "none";
                                         window.frames[0].location.href="pantallazo.jsp";
									}else{
										if(document.form.busqueda[3].checked){
											document.getElementById('tabla1').style.display = "none";
											document.getElementById('tabla2').style.display = "none";
											document.getElementById('tabla3').style.display = "none";
											document.getElementById('tabla4').style.display = "block";
                                                                                        window.frames[0].location.href="pantallazo.jsp";
                                                                                }else{
											document.getElementById('tabla1').style.display = "none";
											document.getElementById('tabla2').style.display = "block";
											document.getElementById('tabla3').style.display = "none";
											document.getElementById('tabla4').style.display = "none";
                                                                                        window.frames[0].location.href="pantallazo.jsp";
                                                                            }
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
				var dir = "comparendos/Comparendos_por_Dias.jasper";
                                 var nombre = "Comparendos_por_Dias";
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
	color: #0066CC;
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
		<form name="form" id="form" method="post" action="" onSubmit="return validarCampos()">
	        <fieldset><div align="center">
		    <legend class="style5"  align="center">CONSULTAR&nbsp;COMPARENDO</legend>
		  	</div> 
			<table width="100%" border="0" align="center">
				<tr>
				  <td colspan="2" valign="middle" align="center"><span class="Estilo11">
				  <input type="radio" name="busqueda" value="1" checked="checked" onClick="ver()">
				  N&ordm;&nbsp;DE&nbsp;COMPARENDO</span></td>
					<td colspan="1" valign="middle" align="center" width="19%"><span class="Estilo11">
				  <input type="radio" name="busqueda" value="1" onClick="ver()">
				  N&ordm;&nbsp;DE&nbsp;INFRACCION </span></td>
					<td colspan="2" valign="middle" align="center"><span class="Estilo11">
				  <input type="radio" name="busqueda" value="2" onClick="ver()">				  
				  FECHAS</span></td>				  			
				    
					<td colspan="2" valign="middle" align="center" width="31%"><span class="Estilo11">
				  <input type="radio" name="busqueda" value="3" onClick="ver()">
				  GRAFICA
					</span></td>	
				  
			  </tr>
				<tr>
					<td colspan="7">
						<table border="0" width="100%" id="tabla1" style="display:">
							  <tr valign="middle">
								 <td width="32%" scope="col" align="right"><label style="color:#333333"><span class="style5">COMPARENDO</span></label>
							  </td>
							  <td width="15%" scope="col" align="right"><input id="comparendo" name="comparendo" type="text" style="text-align:center;color:#333333;font:bold; width:150px"/></td>
							  
							  <td width="13%"  align="center"><label style="color:#333333"></label></td>
										
							              <td width="19%" scope="col">&nbsp;</td>
							   <td width="21%" scope="col">
							   <input id="consultar"  name="consultar" type="button" value="Consultar" style="color:#333333" onClick="ConsultarC()"/>
							   </td>
							
							</tr>
							<tr>
								<td colspan="5" align="center" bgcolor="#FFFFFF">
							  </td>
							</tr>
						</table>
						
						<table border="0" width="100%" id="tabla2" style="display:none" >
								<tr valign="middle">
								   <td width="32%" align="right"><label style="color:#333333"><span class="style5">FECHA&nbsp;INICIAL</span></label>
								  </td>
                                                                    <% String fecha_hoy22 = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
								  <td width="16%" scope="col" align="right"><input  id="fechaI" name="fechaI" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy22%>"/>
                                                                      &nbsp;<input name="bfechaI" type="button" id="bfechaI" value="..." style="width:30px">
								  <SCRIPT type="text/javascript">
														Calendar.setup({
																inputField     :    "fechaI",
																ifFormat       :    "%d/%m/%Y",
																button         :    "bfechaI"
														});
												  </SCRIPT></td>
								  <td width="13%"  align="center"><label style="color:#333333"><span class="style5">FECHA&nbsp;FINAL</span></label>
								  </td>
                                                                  <% String fecha_hoy23 = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
								  <td width="23%" scope="col"><input  id="fechaF" name="fechaF" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy23%>"/>
												&nbsp;<input name="bfechaF" type="button" id="bfechaF" value="..." style="width:30px">
								  <SCRIPT type="text/javascript">
														Calendar.setup({
																inputField     :    "fechaF",
																ifFormat       :    "%d/%m/%Y",
																button         :    "bfechaF"
														});
												  </SCRIPT></td>
				<td width="8%" scope="col"><input id="consultar2"  name="consultar2" type="button" value="Consultar" style="color:#333333" onClick="buscarR()"/></td>
				<td width="8%" scope="col" align="center">
						<input id="reporte"  name="reporte" type="button" value="Reporte" style="color:#333333" onClick="verReporte()"/></td>
								</tr>
						</table>
						<!--/////////////////////////////////////////////-->
						<table border="0" width="100%" id="tabla4" style="display:none" >
								<tr valign="middle">
								   <td width="15%" align="right"><label style="color:#333333"><span class="style5">FECHA&nbsp;INICIAL</span></label>
								  </td>
                                                                  <% String fecha_hoy24 = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
								  <td width="16%" scope="col" align="right"><input  id="fechaIn" name="fechaIn" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy24%>"/>
												 &nbsp;<input name="bfechaIn" type="button" id="bfechaIn" value="..." style="width:30px">
								  <SCRIPT type="text/javascript">
														Calendar.setup({
																inputField     :    "fechaIn",
																ifFormat       :    "%d/%m/%Y",
																button         :    "bfechaIn"
														});
												  </SCRIPT></td>
								  <td width="10%"  align="center"><label style="color:#333333"><span class="style5">FECHA&nbsp;FINAL</span></label>
								  </td>
                                                                  <% String fecha_hoy25 = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
								  <td width="15%" scope="col"><input  id="fechaFn" name="fechaFn" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy25%>"/>
												&nbsp;<input name="bfechaFn" type="button" id="bfechaFn" value="..." style="width:30px">
								  <SCRIPT type="text/javascript">
														Calendar.setup({
																inputField     :    "fechaFn",
																ifFormat       :    "%d/%m/%Y",
																button         :    "bfechaFn"
														});
												  </SCRIPT></td>
												  <td width="17%" scope="col">
												  <select id="infraccion2" name="infraccion2" style="width:200px; font-size:12px">
                                                                            <option value="1000"  selected="selected" >selecionar infraccion</option>
                                                                                <%
                                                                                   java.util.List<Infraccion> lista = model.listaDeInfracciones();
                                                                                   for(int i = 0;i<lista.size();i++){
                                                                                   Infraccion infra = lista.get(i);
                                                                                   %>
                                                                                     <option value="<%=infra.getNumero()+""%>"><%=infra.getNumero()%></option>
                                                                                     <%    
                                                                                      }//while
                                                                                     %>
									</select>								  
												  
								  </td>
				<td width="6%" scope="col">&nbsp;</td>
				<td width="21%" scope="col" align="center">
						<input id="reporte2"  name="reporte2" type="button" value="Reporte" style="color:#333333" onClick="buscarIn()"/></td>
								</tr>
						</table>

						
						<!--/////////////////////////////////////////////-->
						
						<table border="0" width="100%" id="tabla3" style="display:none"  >
								<tr valign="middle">
								   <td width="32%" height="26" align="right"><label style="color:#333333"><span class="style5">INFRACCION</span></label>								  </td>
								  <td width="28%" scope="col" align="center">
								  	<select id="infraccion" name="infraccion" style="width:200px; font-size:12px">
                                                                            <option value="1000" selected="selected">selecionar infraccion</option>
                                                                                <%
                                                                                  //java.util.List<Infraccion> lista = model.listaDeInfracciones();
                                                                                   for(int i = 0;i<lista.size();i++){
                                                                                   Infraccion infra = lista.get(i);
                                                                                   %>
                                                                                     <option value="<%=infra.getId_infraccion()+""%>"><%=infra.getNumero()%></option>
                                                                                     <%    
                                                                                      }//while
                                                                                     %>
									</select>								  </td>
								  
								  <td width="24%" scope="col"><input id="consultar22"  name="consultar22" type="button" value="Consultar" style="color:#333333" onClick="buscarP()"/></td>
				                  <td width="16%" scope="col" colspan="2"><input id="reporte2"  name="reporte2" type="button" value="Reporte" style="color:#333333" onClick="verReporte()"/></td>
								</tr>
						</table>
										
					</td>
				</tr>	
           </table>
		  </fieldset>
		  <iframe src="pantallazo.jsp" width="100%" id="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe>
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
