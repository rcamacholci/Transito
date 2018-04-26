<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*"  errorPage="" %>
<%
try{//
	if(session.getAttribute("model")!=null){//
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Vehiculo</title>
    <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
	    <link href="../../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="../../html/css/lineaVertical.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="../../html/css/3pestanas.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="../../html/scripts/tablecloth.js"></script>
        <link href="../../html/css/page2Colum.css" rel="stylesheet" type="text/css" media="screen" />
        <LINK title=win2k-cold-1 media=all href="../../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
		<script src="../../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script src="../../html/scripts/validarFecha.js" type="text/javascript"></script>
                <script language="javascript" type="text/javascript">
             function ConsultarC(){
				if(document.form.comparendo.value.length>0){								
					window.frames[0].location.href = "Impresion_Audiencia.jsp?comparendo="+document.form.comparendo.value;
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

          function buscarInr(){
              if(document.form.fechaInR.value.length==10 && document.form.fechaFnR.value.length==10){

              window.frames[0].location.href="EstadisticaInfraccionesR.jsp?fi="+document.form.fechaInR.value+"&ff="+document.form.fechaFnR.value+"&doc="+document.form.documento.value;
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
					document.getElementById('tabla5').style.display = "none";
                    window.frames[0].location.href="pantallazo.jsp";
				}else{
                                    if(document.form.busqueda[1].checked){
                                   	document.getElementById('tabla1').style.display = "none";
					document.getElementById('tabla2').style.display = "none";
                                        document.getElementById('tabla3').style.display = "block";
					document.getElementById('tabla4').style.display = "none";
					document.getElementById('tabla5').style.display = "none";
                                         window.frames[0].location.href="pantallazo.jsp";
									}else{
										if(document.form.busqueda[3].checked){
											document.getElementById('tabla1').style.display = "none";
											document.getElementById('tabla2').style.display = "none";
											document.getElementById('tabla3').style.display = "none";
											document.getElementById('tabla4').style.display = "block";
											document.getElementById('tabla5').style.display = "none";
                                                                                        window.frames[0].location.href="pantallazo.jsp";
                                                                                }else{
													if(document.form.busqueda[4].checked){
											document.getElementById('tabla1').style.display = "none";
											document.getElementById('tabla2').style.display = "none";
											document.getElementById('tabla3').style.display = "none";
											document.getElementById('tabla4').style.display = "none";
											document.getElementById('tabla5').style.display = "block";
														}else{	
											document.getElementById('tabla1').style.display = "none";
											document.getElementById('tabla2').style.display = "block";
											document.getElementById('tabla3').style.display = "none";
											document.getElementById('tabla4').style.display = "none";
											document.getElementById('tabla5').style.display = "none";
                                            window.frames[0].location.href="pantallazo.jsp";
														}
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
						<table>
						<tr><th colspan="5">IMPRESION DE AUDIENCIAS</th></tr>
							  <tr valign="middle">
								 <th >COMPARENDO</th>
							  
							  <td width="17%" scope="col" align="right"><input id="comparendo" name="comparendo" type="text" style="text-align:center;color:#333333;font:bold; width:150px"/></td>
							  
							  <td align="center"><label style="color:#333333"></label>										
				                <input id="consultar"  name="consultar" type="button" value="Consultar" style="color:#333333" onClick="ConsultarC()"/>
							 
						  </tr>
						</table>						

			<iframe src="../Impresion_Audiencia.jsp?comparendo=0" width="100%" id="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe>
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
