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
			function validarCampos(){
				if(document.form.radicacion.value.length>0){
					if(!isNaN(document.form.radicacion.value)){
						if(document.form.fecha.value.length>0){
							return true;
						}else{
							alert("Seleccione fecha de radicacion");
						}
					}else{
						alert("Numero de radicacion invalido");
					}
				}else{
					alert("Ingrese numero de radicacion");
				}
				return false;
			}

			function buscarR(){
				if(document.form.fechaI.value.length==10&&document.form.fechaF.value.length==10){
					window.frames[0].location.href = "verRadicacionesLicencias.jsp?fi="+document.form.fechaI.value+"&ff="+document.form.fechaF.value+"&opcion=1";
				}else{
                                    alert("Digite fechas de radicacion");
                                }
			}

                        function buscarDoc(){
				if(document.form.tipoDocumento.value>0){
                                    if(document.form.documento.value>0){
					window.frames[0].location.href = "verRadicacionesLicencias.jsp?tipoDoc="+document.form.tipoDocumento.value+"&documento="+document.form.documento.value+"&opcion=2";
                                    }else{
                                        alert("Digite el documento");
                                    }
                                }else{
                                    alert("Seleccione el tipo de documento");
                                }
			}

			function ver(){
				if(document.form.busqueda[0].checked){
					document.getElementById('tabla1').style.display = "block";
					document.getElementById('tabla2').style.display = "none";
					document.getElementById('tabla3').style.display = "none";
				}else{
                                    if(document.form.busqueda[1].checked){
                                   	document.getElementById('tabla1').style.display = "none";
					document.getElementById('tabla2').style.display = "block";
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
				alto = 600;
				barra = 0;
				izquierda = (document.width) ? (document.width-ancho)/2 : 100;
				arriba = (document.height) ? (document.height-alto)/2 : 100;
				opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
				var dir = "/radicaciones/tramites/tramitesLicenciasUsuarioReport.jasper";
                                var nombre = "reporteTramiteLicencias";
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
.Estilo12 {color: #FFFFFF}
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
		<form name="form" id="form" method="post" action="radicarLicencia.jsp" onSubmit="return validarCampos()">
	        <fieldset><div align="center">
		    
		  	</div>
			<table width="100%" border="0" align="center">
			<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="style3 style14 style2 Estilo28 style1 Estilo12"><strong>CONSULTAR RADICACIONES DE LICENCIAS DE CONDUCCION </strong></span></td>
    </tr>
				<tr>
				  <td colspan="2" valign="middle" align="center" width="33%"><span class="Estilo11">
				  <input type="radio" name="busqueda" value="1" checked="checked" onClick="ver()">
				  N&ordm;&nbsp;DE&nbsp;RADICACION</span></td>
					
				    <td colspan="2" valign="middle" align="center" width="33%"><span class="Estilo11">
				  <input type="radio" name="busqueda" value="2" onClick="ver()">
				  FECHAS&nbsp;DE&nbsp;RADICACION</span></td>
				  <td colspan="2" valign="middle" align="center" width="33%"><span class="Estilo11">
				  <input type="radio" name="busqueda" value="3" onClick="ver()">
				  NUMERO DE DOCUMENTO </span></td>
				</tr>
				<tr>
					<td colspan="5">
						<table border="0" width="100%" id="tabla1">
							  <tr valign="middle">
								 <td width="27%" scope="col" align="right"><label style="color:#333333"><span class="style5">NUMERO</span></label>
							  </td>
							  <td width="21%" scope="col" align="right"><input id="radicacion" name="radicacion" type="text" style="text-align:center;color:#333333;font:bold; width:100px"/></td>

							  <td width="18%"  align="center"><label style="color:#333333"><span class="style5">FECHA</span></label>
							  </td>
										  <% String fecha_hoy = new java.text.SimpleDateFormat("yyyy/MM/dd").format(new java.util.Date());%>
							  <td width="22%" scope="col"><input  id="fecha" name="fecha" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy%>"/>&nbsp;<input name="bfecha" type="button" id="bfecha" value="..." style="width:20px">
							  <SCRIPT type="text/javascript">
													Calendar.setup({
															inputField     :    "fecha",
															ifFormat       :    "%Y/%m/%d",
															button         :    "bfecha"
													});
											  </SCRIPT></td>
							<td width="12%" scope="col"><input id="consultar"  name="consultar" type="submit" value="Consultar" style="color:#333333"/></td>
							</tr>

							<tr>
								<td colspan="5" align="center" bgcolor="#FFFFFF">

									<font color="#FF0000" face="Arial" style="font-size:12px; font-weight:bold">
										<label id="mensaje">
											<%=request.getParameter("respuesta")!=null?request.getParameter("respuesta"):""%>
									</label>
								  </font>
							  </td>
							</tr>
						</table>

						<table border="0" width="100%" id="tabla2"  style="display:none" >
								<tr valign="middle">
								   <td width="23%" align="right"><label style="color:#333333"><span class="style5">FECHA&nbsp;INICIAL</span></label>
								  </td>
								  <td width="21%" scope="col" align="right"><input  id="fechaI" name="fechaI" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy%>"/>
												 <input name="bfechaI" type="button" id="bfechaI" value="..." style="width:20px">
								  <SCRIPT type="text/javascript">
														Calendar.setup({
																inputField     :    "fechaI",
																ifFormat       :    "%Y/%m/%d",
																button         :    "bfechaI"
														});
												  </SCRIPT></td>
								  <td width="17%"  align="center"><label style="color:#333333"><span class="style5">FECHA&nbsp;FINAL</span></label>
								  </td>
								  <td width="22%" scope="col"><input  id="fechaF" name="fechaF" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy%>"/>
												 <input name="bfechaF" type="button" id="bfechaF" value="..." style="width:20px">
								  <SCRIPT type="text/javascript">
														Calendar.setup({
																inputField     :    "fechaF",
																ifFormat       :    "%Y/%m/%d",
																button         :    "bfechaF"
														});
												  </SCRIPT></td>
				<td width="9%" scope="col"><input id="consultar"  name="consultar2" type="button" value="Consultar" style="color:#333333" onClick="buscarR()"/></td>
				<td width="8%" scope="col" align="center">
						<input id="reporte"  name="reporte" type="button" value="Reporte" style="color:#333333" onClick="verReporte()"/></td>
								</tr>
						</table>
						
						<table border="0" width="100%" id="tabla3" style="display:none">
								<tr valign="middle">
								<td width="17%" align="center"><span class="style5">TIPO DOCUMENTO</span></td>
																<td width="22%" align="center"><span class="Estilo13">
																  <select  name="tipoDocumento" id="tipoDocumento" style="width:152px; font-size:10px; color:#333333">
                                                                    <% java.util.List tipoDocumentos = model.listadoParametros(5);
		   for (int i = 0; i < tipoDocumentos.size(); i++) {
			   Parametro parametro = (Parametro) tipoDocumentos.get(i); 
                           
                                %>
                                                                    <option value="<%=parametro.getCodigo()%>" selected="selected"><%= parametro.getNombre()%> </option>
                                                                    <%   
                           
                  } %>
                                                                  </select>
																</span></td>
								                                <td width="23%" align="center"><span style="font-family: Tahoma">
								                                  <label class="style5" style="color:#333333"><span class="Estilo14">DOCUMENTO</span></label>
								                                  </span></td>
								                                <td width="21%" scope="col" align="center">
								  <input name="documento"  id="documento" style="text-align:center;color:#333333;font:bold; width:200px" value=""/>							      </td>
								 
				<td width="9%" scope="col" align="center"><input  name="consultar2" type="button" id="consultar" style="color:#333333" onClick="buscarDoc()" value="Consultar"/></td>
				
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
