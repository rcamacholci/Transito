<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                       modelo.Model model = (modelo.Model)session.getAttribute("model");
                       
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
			
			 function mostrar(){
                            window.frames[0].location.href = "verCarpetasPrestadas.jsp?num=1";
			}

                        function buscarPlaca(){
				if(document.form.placa.value.length!=0){
					window.frames[0].location.href = "verCarpetasPrestadas.jsp?num=2&placa="+document.form.placa.value;
				}else{
                                    alert("Digite la placa a Buscar");
                                }
			}
                      
                       


			function ver(){
				if(document.form.busqueda[0].checked){
					document.getElementById('tabla1').style.display = "block";
					document.getElementById('tabla2').style.display = "none";

                                      
				}else{
                                        document.getElementById('tabla1').style.display = "none";
                                        document.getElementById('tabla2').style.display = "block";

                                    }
                       }

			function verReporte(){
				ancho = 789;
				alto = 250;
				barra = 0;
				izquierda = (document.width) ? (document.width-ancho)/2 : 100;
				arriba = (document.height) ? (document.height-alto)/2 : 100;
				opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
				var dir = "/radicaciones/tramites/tramitesUsuarioReport.jasper";
			    var nombre = "reporteTramite";
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
    
    try {
        model = (Model) session.getAttribute("model");
    } catch (Exception exc) {
        exc.printStackTrace();
    }
    %>
    <body> 
		<form name="form" id="form" method="post" action="verPrestamos.jsp" >
	        <fieldset>
			<table width="100%" border="0" align="center">
<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="6" align="center" valign="middle"><span class="style7">DEVOLUCIONES DE CARPETAS</span></td>
			</tr>
				<tr>
				  <td colspan="2" valign="middle" align="center" width="50%"><span class="Estilo11">
				  <input type="radio" name="busqueda" value="1" checked="checked" onClick="ver()">
				  GENERAL
				  </span></td>
					<td colspan="1" valign="middle" align="center" width="50%"><span class="Estilo11">
				  <input type="radio" name="busqueda" value="1" onClick="ver()">
				  N&ordm;&nbsp;DE&nbsp;PLACA </span></td>
							
				</tr>
				<tr align="center">
					<td height="75" colspan="5" align="center" >
						<table border="0" width="100%" id="tabla1">
							  <tr valign="middle">
							   <td width="20%"  colspan="">&nbsp;</td>
   							   <td width="20%"  colspan="">&nbsp;</td>
							   <td width="20%"  align="center" colspan="2"><input id="consultar"  name="consultar" onClick="mostrar()"  type="button" value="Consultar Solicitud" style="color:#333333; width:150px"/></td>

						   <td width="20%"  colspan="">&nbsp;</td>
						   
						   <td width="20%"  colspan="">&nbsp;</td>
							   
							</tr>
							
							<tr>
								
							</tr>
						</table>
						
						
						<table border="0" width="100%" id="tabla2" style=" display:none"  >
								<tr valign="middle">
								   <td width="40%" height="26" align="right"><label style="color:#333333"><span class="style5">PLACA</span></label>
								  </td>
								  <td width="20%" scope="col" align="right"><input  id="placa" name="placa" style="text-align:center;color:#333333;font:bold; width:125px" maxlength="6" />
							      </td>
								  
								  <td width="21%" ></td>
				<td width="19%" colspan="2"><input id="consultar"  name="consultar2" type="button" value="Consultar" style="color:#333333; width:120px" onClick="buscarPlaca()"/></td>
				
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