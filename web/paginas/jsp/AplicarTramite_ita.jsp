<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*"  errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		//if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                if(1==1){
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
        <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="../html/scripts/tablecloth.js"></script>

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
                           // alert("ok");
                             if(document.form.placa.value.length>0){
                                 if(document.form.radicacion.value.length>0){
                                     if(document.form.fechaF.value.length==10){
                                         window.frames[0].location.href="Procesar_AT.jsp?placa="+document.form.placa.value+"&ff="+document.form.fechaF.value+"&radicacion="+document.form.radicacion.value;
                                     }else{
                                         alert("Digite Fecha");
                                     }
                                }else{
                                    alert("Digite Radicacion");
                                }

                            }else{
                                    alert("Digite Placa");
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
		    <legend class="style5"  align="center">APLICAR TRAMITE ITA</legend>
		  	</div> 
			<table width="100%" border="0" align="center">
				
				<tr>
					<td height="88" colspan="7">
						
						
					  <table border="0" width="100%" id="tabla2" style="display:" >
								<tr valign="middle">
								   <td width="19%" height="64" align="right"><label style="color:#333333"><span class="style5">Placa&nbsp;</span></label>&nbsp;<input type="text" id="placa" name="placa" width="55%"></td>
                                                                    <% String fecha_hoy22 = new java.text.SimpleDateFormat("yyyy/MM/dd").format(new java.util.Date());%>
								  <td width="20%" scope="col" align="right"><span class="style5">Radicacion:</span>&nbsp;<input type="text" id="radicacion" name="radicacion" width="70%"></td>
                                                                  <td width="23%"  align="center"><label style="color:#333333"><span class="style5">Fecha&nbsp;</span></label>&nbsp;<input  id="fechaF" name="fechaF" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy22%>" />
                                                                      &nbsp;<input name="bfechaF" type="button" id="bfechaF" value="..." style="width:30px" >
								  <SCRIPT type="text/javascript">
														Calendar.setup({
																inputField     :    "fechaF",
																ifFormat       :    "%Y/%m/%d",
																button         :    "bfechaF"
														});
												  </SCRIPT>
								  </td>
                                                                  <% String fecha_hoy23 = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
								  <td width="27%" scope="col"><input id="consultar2"  name="consultar2" type="button" value="Aplicar" style="color:#333333" onClick="buscarR()"/></td>
				<td width="11%" scope="col"></td>
						</tr>
					  </table>
						<!--/////////////////////////////////////////////-->


						
						<!--/////////////////////////////////////////////-->
						
									
					</td>
				</tr>	
           </table>
           
			<h2>&nbsp;</h2>
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
