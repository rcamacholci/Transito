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

          function buscar(){
              //alert("funcion");//
              if(document.form.fechaInR.value.length==10 && document.form.fechaFnR.value.length==10){
                
                    window.frames[0].location.href="verVias.jsp?fi="+document.form.fechaInR.value+"&ff="+document.form.fechaFnR.value;
            }else{
            alert("Digite fechas");
            }
        }

        function REIN(){
            alert("ok");
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
.Estilo16{
	color: #0066CC;
	font-weight: bold;
	font-size: 15px;
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
		
		<form name="form" id="form" method="post" action="javascript:buscar()" onSubmit="">
	        <fieldset><div align="center">
                        <legend class="style5"  align="center">CONSULTAR&nbsp;COMPARENDOS&nbsp;VIAS</legend>
		  	</div>
            <table border="0" width="100%" id="tabla5" style="display:" >
								<tr valign="middle">
								   <td width="12%" align="right"><label style="color:#333333"><span class="style5">FECHA&nbsp;INICIAL</span></label>								  </td>
                                                                  <%String fecha_hoy24 = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
								  <td width="13%" scope="col" align="right"><input  id="fechaInR" name="fechaInR" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy24%>"/>
												 &nbsp;<input name="bfechaInR" type="button" id="bfechaInR" value="..." style="width:30px">
								  <SCRIPT type="text/javascript">
														Calendar.setup({
																inputField     :    "fechaInR",
																ifFormat       :    "%d/%m/%Y",
																button         :    "bfechaInR"
														});
												  </SCRIPT></td>
								  <td width="10%"  align="center"><label style="color:#333333"><span class="style5">FECHA&nbsp;FINAL</span></label>								  </td>
                                                                  <%String fecha_hoy25 = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
								  <td width="15%" scope="col"><input  id="fechaFnR" name="fechaFnR" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy25%>"/>
												&nbsp;<input name="bfechaFnR" type="button" id="bfechaFnR" value="..." style="width:30px">
								  <SCRIPT type="text/javascript">
														Calendar.setup({
																inputField     :    "fechaFnR",
																ifFormat       :    "%d/%m/%Y",
																button         :    "bfechaFnR"
														});
												  </SCRIPT></td>
<td width="27%" scope="col" class="Estilo16"><input id="reporte"  name="reporte" type="submit" value="Reporte" style="color:#333333" /></td>
				<td width="4%" scope="col">&nbsp;</td>
				<td width="19%" scope="col" align="center">&nbsp;</td>
                        <TD width="0%">&nbsp;</TD>
								</tr>
						</table>
						
            <iframe src="pantallazo.jsp" width="100%" id="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe>
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
