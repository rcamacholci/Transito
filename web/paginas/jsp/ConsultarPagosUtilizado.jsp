<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>

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
			
			function buscarPago(){
				if(document.form.pago.value.length!=0){
					window.frames[0].location.href = "verPagosUtilizado.jsp?pago="+document.form.pago.value;
				}else{
                                    alert("Digite el Numero del pago a Buscar");
                                }
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

                        function mostrar(){
                            window.frames[0].location.href = "verPrestamos.jsp?num=1";
			}


			function ver(){
				if(document.form.busqueda[0].checked){
					document.getElementById('tabla1').style.display = "none";
					document.getElementById('tabla2').style.display = "block";
                                }else{
					  document.getElementById('tabla1').style.display = "block";
					  document.getElementById('tabla2').style.display = "none";
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
	 if(request.getParameter("fechaI")!=null&&request.getParameter("fechaF")!=null&&!request.getParameter("fechaI").isEmpty()&&!request.getParameter("fechaF").isEmpty()){
        HashMap parameters = new java.util.HashMap();
        parameters.put("USUARIO", usuario.getNombre());
        parameters.put("FECHA_INI",request.getParameter("fechaI"));
        parameters.put("FECHA_FIN",request.getParameter("fechaF"));
        session.setAttribute("preasignaciones", parameters);
%>
        <script language="javascript" type="text/javascript">
               verReporte();
        </script>

<%  }
	
	
	
	    %>
    <body> 
        <form name="form" id="form" method="post" action="verPagosUtilizado.jsp" target="respuesta">
	        <fieldset>
			<table width="100%" border="0" align="center">
			<tr style="border:none; background:url(../html/images/inicio_3.png)">
				<td colspan="6" align="center" valign="middle"><span class="style7">CONSULTAR PAGOS</span></td>
			</tr>
				<tr align="center">
					<td height="50" colspan="5" align="center" >
						<table border="0" width="100%" id="tabla">
								<tr valign="middle">
								   <td width="40%" height="26" align="right"><label style="color:#333333"><span class="style5">Nº&nbsp;PAGO</span></label>
								  </td>
								  <td width="20%" scope="col" align="right"><input  id="pago" name="pago"  maxlength="7" style="text-align:center;text-transform:uppercase;color:#333333;font:bold; width:125px"  />
							      </td>
								  
								  <td width="21%" scope="col"></td>
				<td width="19%" scope="col" colspan="2"><input id="consultar"  name="consultar2" type="button" value="Consultar" style="color:#333333" onClick="buscarPago()"/></td>
				
								</tr>
						</table>
										
				  </td>
				</tr>	
           </table>
		  </fieldset>
            <iframe src="#" width="100%" name="respuesta" id="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe>
        </form>               
    </body>
</html>