<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>

<%
    modelo.Model model = (modelo.Model)session.getAttribute("model");
    if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>

<html>
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<title>Vehiculo</title>
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
		<script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
		<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript">
           function buscarFecha(){
				if(document.form.fechaI.value.length==10){
                    if(document.form.fechaF.value.length==10){
						window.frames[0].location.href = "verNotasGenerales.jsp?fechaI="+document.form.fechaI.value+"&fechaF="+document.form.fechaF.value;
                    }else{
                        alert("Digite la fecha Final de la Busqueda");
                    }
                }else{
                     alert("Digite la fecha Inicial de la Busqueda");
                }
			}

            function verReporte(){
				ancho = 789;
				alto = 600;
				barra = 0;
				izquierda = (document.width) ? (document.width-ancho)/2 : 100;
				arriba = (document.height) ? (document.height-alto)/2 : 100;
				opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
				var dir = "/notascredito/reporteNotasGenerales.jasper";
                                var nombre = "notascredito";
				url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
				window.open(url, 'popUp', opciones);
			}
		</script>
        <style type="text/css">
<!--
.style1 {
	color: #003366;
	font-family: Arial;
	font-size: 14px;
	font-weight: bold;
}
.style2 {
	font-family: Arial;
	font-size: 11px;
	color: #006633;
	font-weight: bold;
}
.style3 {
	font-family: Arial;
	font-size: 11px;
	color: #003366;
	font-weight: bold;
	text-align:center;
	width:100px;
}
.style4 {
	font-family: Arial;
	font-size: 9px;
	color:#006633;
	font-weight: bold;
	text-align:center;
	width:20px;
}
.style5 {
	font-family: Arial;
	font-size: 10px;
	color:#006633;
	font-weight: bold;
	text-align:center;
	width:80px;
}

-->
        </style>
</head>
    <body>
		<form name="form" id="form" method="post" action="verPrestamos.jsp">
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="8" align="center" valign="middle"><span class="style1">REPORTE DISTRIBUCION DE PAGOS POR USUARIOS </span></td>
				</tr>
				<tr>
					<td align="center" colspan="8" valign="middle">&nbsp;</td>
			    </tr>
				<tr>
					<td align="center" colspan="8" valign="middle">
				        <fieldset>
                                            <legend></legend>
							<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
								<tr align="center" class="style2">
									<td colspan="1">&nbsp;</td>
									<td colspan="1"><span class="style2" >Fecha Inicial</span> </td>
									<% String fecha_hoy = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
									<td colspan="1">
									<input  id="fechaI" name="fechaI" class="style3" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy%>"/>
									<input name="bfechaI" type="button" id="bfechaI" class="style4" value="<">
									<script type="text/javascript">
											Calendar.setup({
													inputField     :    "fechaI",
													ifFormat       :    "%d/%m/%Y",
													button         :    "bfechaI"
											});
									</script>
									</td>
									<td colspan="1" style="border-right:none"><span class="style2">Fecha Final </span></td>
									<td colspan="1">
									<input  id="fechaF" name="fechaF" class="style3" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy%>"/>
									<input name="bfechaF" type="button" id="bfechaF" value="<" class="style4">
									<script type="text/javascript">
											Calendar.setup({
													inputField     :    "fechaF",
													ifFormat       :    "%d/%m/%Y",
													button         :    "bfechaF"
											});
									</script>
									</td>
									<td colspan="1" style="border-right:none"><span class="style2">Usuario </span></td>
									<td colspan="1">
									<% Model model = (Model)session.getAttribute("model");
									   Usuario usuario = (Usuario)session.getAttribute("usuario");
									   boolean permiso = model.tienePermiso(usuario.getId_usuario(), 136);%>
										<select name="usuario" id="usuario" style="color:#333333; width:150px">
											 <option value="0"><<--General-->></option>
										<%	 java.util.List usuarios = model.listarUsuarios(usuario.getFk_sede());
											 for (int i = 0; i < usuarios.size(); i++) {
												 Usuario user = (Usuario) usuarios.get(i);
												 if(model.consultarCajaUsuario(user.getId_usuario())!=null){
														if(user.getId_usuario()==usuario.getId_usuario()||permiso) %>
														<option value="<%=user.getId_usuario()%>"><%=user.getNombre()%></option>
										  <%	 }
											} %>
								   </select>
									</td>
									<td colspan="1">&nbsp;</td>
									<td colspan="1"><input id="consultar" name="consultar" type="button" value="Consultar" class="style5" onClick="buscarFecha()"/></td>
									<td colspan="1"><input id="reporte"  name="reporte" type="button" value="Reporte" class="style5" onClick="verReporte()"/></td>
								</tr>
							</table>
		 			   </fieldset>
					</td>
				</tr>
				<tr>
					<td align="center" colspan="8" valign="middle">&nbsp;</td>
			    </tr>	   
				<tr>
					<td colspan="8" align="center" valign="top">
					      <iframe src="#" width="100%" id="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe>
					</td>	  
				</tr>  
			</table>	
        </form>
    </body>
</html>
<%  }else{ %>
       <jsp:forward page="no_access.jsp">
             <jsp:param name="tipo" value="1"></jsp:param>
       </jsp:forward>
<%  } %>