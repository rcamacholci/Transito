<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%@page import = "modelo.*" %>
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

                         function paso(){
                                    document.form.action='estadisticasLicencias.jsp'
                                    document.form.submit();
                        }

              
			
			function verReporte(){
				ancho = 789;
				alto = 600;
				barra = 0;
				izquierda = (document.width) ? (document.width-ancho)/2 : 100;
				arriba = (document.height) ? (document.height-alto)/2 : 100;
				opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
				var dir = "/licenciasC/estadisticoLicencias.jasper";
                                var nombre = "estadisticaLicencias";
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
.Estilo13 {font-family: Tahoma}
.Estilo14 {font-weight: bold; font-size: 12px; color: #333333;}
.Estilo5 {color: #333333;
	font-size: 10px;
}
.Estilo51 {	font-family: "Segoe Script";
	color: #68A805;
	font-size: 12px;
}
-->
        </STYLE>
</head>
    <%
    Model model = null;
    try {
        model = (Model) session.getAttribute("model");
        Usuario usuario = (Usuario) session.getAttribute("usuario");
    
    if(request.getParameter("tramite")!=null&&request.getParameter("categoria")!=null&&!request.getParameter("tramite").isEmpty()&&!request.getParameter("categoria").isEmpty()){
        java.util.HashMap parameters = new java.util.HashMap();
        parameters.put("USUARIO", usuario.getNombre());
        parameters.put("FK_TRAMITE",Integer.parseInt(request.getParameter("tramite")));
        parameters.put("CATEGORIA",request.getParameter("categoria"));
        session.setAttribute("estadisticaLicencias", parameters);
%>
        <script language="javascript" type="text/javascript">
               verReporte();
               document.location = "estadisticasLicencias.jsp";
	</script>

<%  }
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
			<td colspan="11" align="center"><span class="style3 style14 style2 Estilo28 style1 Estilo12"><strong>REPORTE ESTADISTICO  LICENCIAS DE CONDUCCION </strong></span></td>
    </tr>
				
				<tr>
					<td colspan="5">
						
						<table border="0" width="100%" id="tabla1">
								<tr valign="middle">
								   <td width="23%" align="right"><label style="color:#333333"><span class="style5">NOMBRE DEL TRAMITE </span></label></td>
								  <td width="21%" scope="col" align="center"><span class="Estilo51">
								    <select  name="tramite" id="tramite" style="width:300px; font-size:11px; color:#000033" onChange="selTramite(this)">
                                      <option value="0">---Seleccione Tramite---</option>
                                      <% Sede sede = (Sede)session.getAttribute("sede");
                                            java.util.List tramites = model.consultarTramites(2,sede.getId_sede());
						 for (int i = 0; i < tramites.size(); i++) {
							   Tramite tramite = (Tramite) tramites.get(i); %>
                                      <option value="<%=tramite.getId_tramite()%>"><%= tramite.getNombre()%> </option>
                                      <% } %>
                                    </select>
								  </span></td>
								 
								 <td width="17%" align="center"><span class="style5">CATEGORIAS</span></td>
								 <td width="22%"><select  name="categoria" id="categoria" style="width:100px; text-align:center;color:#000033;font-size:13px; font-weight:bold">
                                 <option value="0">---- / ----</option>
                                 <% java.util.List categorias = model.listadoParametros(221);
						for (int i = 0; i < categorias.size(); i++) {
						   Parametro parametro = (Parametro) categorias.get(i); %>
                                 <option value="<%=parametro.getNombre()%>"><%= parametro.getNombre()%> </option>
                                 <%  } %>
                                </select></td>
				                  
				                 
						<!--		</tr>
								
							  <td width="23%" align="right"><label style="color:#333333"><span class="style5">FECHA&nbsp;INICIAL</span></label>							    </td>
                                                                   
								  <td width="21%" scope="col"  align="center"><input  id="fechaI" name="fechaI" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this,'/',true)" maxlength="10" value=""/>
												 <input name="bfechaI" type="button" id="bfechaI" value="..." style="width:20px">
								  <SCRIPT type="text/javascript">
														Calendar.setup({
																inputField     :    "fechaI",
																ifFormat       :    "%d/%m/%Y",
																button         :    "bfechaI"
														});
												  </SCRIPT></td>
								  <td width="17%"  align="center"><label style="color:#333333"><span class="style5">FECHA&nbsp;FINAL</span></label>								  </td>
								  <td width="22%" scope="col" align="center"><input  id="fechaF" name="fechaF" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this,'/',true)" maxlength="10" value=""/>
												 <input name="bfechaF" type="button" id="bfechaF" value="..." style="width:20px">
								  <SCRIPT type="text/javascript">
														Calendar.setup({
																inputField     :    "fechaF",
																ifFormat       :    "%d/%m/%Y",
																button         :    "bfechaF"
														});
												  </SCRIPT></td>
				                  
				                 
							  </tr> --->
							<tr>
							<td colspan="4" align="center" ><input  name="reporte2" type="button" id="reporte2" style="color:#333333" onClick="paso()" value="--- Reporte ---"/></td>
							</tr>
						</table>

						
						
					</td>
				</tr>
           </table>
		  </fieldset>

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
