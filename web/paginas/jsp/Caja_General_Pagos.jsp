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
<script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
<script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
function verReporte(){
    ancho = 789;
    alto = 250;
    barra = 0;
    izquierda = (document.width) ? (document.width-ancho)/2 : 100;
    arriba = (document.height) ? (document.height-alto)/2 : 100;
    opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
    var dir = "recaudoycartera/taquillas/Caja_General_Pago.jasper";
    var nombre = "reportecajageneralpagos";
    url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
    window.open(url, 'popUp', opciones);
}
                      
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

 function reportFechas(){
     var fechaI = document.form.fecha1.value;
     var fechaF = document.form.fecha2.value;
        if(document.form.fecha1.value.length==10&&document.form.fecha2.value.length==10){
                window.frames[0].location.href = "verCaja_General_Pagos.jsp?fi="+fechaI+"&ff="+fechaF+"&opcion=1";
        }else{
                alert("Digite fechas de pagos");
        }
 }
		
function buscarR(){
        if(document.form.fecha1.value.length==10&&document.form.fecha2.value.length==10){
                window.frames[0].location.href = "verAcuerdosdePagos.jsp?fi="+document.form.fecha1.value+"&ff="+document.form.fecha2.value+"&opcion=1";
        }else{
                alert("Digite fechas de radicacion");
        }
}                     
					</script>
<style type="text/css">
<!--
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style3 {color: #FFFFFF}
.style31 {color: #333333; font-size: 12px; font-weight: bold; font-family: Tahoma; }
.Estilo2 {
	color: #FFFFFF;
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
}
-->
</style>


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
	        <table width="100%" border="0"  bordercolor="#FFFFFF" align="center" >
				<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="Estilo2">REPORTE DE LA CAJA GENERAL DE PAGOS </span></td>
				
				<tr>
				  <td colspan="5">
						<table border="0" width="100%" id="tabla1">
							  <tr valign="middle">
							    <td width="24%" height="54"  align="center"><label style="color:#333333">
							    <div align="right"><span class="style2">FECHA INICIAL</span></div>
							    </label>							  </td>
										  <% String fecha_hoy = new java.text.SimpleDateFormat("yyyy/MM/dd").format(new java.util.Date());%>
							              <td width="17%" scope="col">
							                          <div align="left">
							                            <input  id="fecha1" name="fecha1" style="text-align:center;color:#333333;font:bold; width:125px" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy%>"/>
<button name="bfecha1" type="button" id="bfecha1"><img src="../html/images/calendario.png"  width="18" height="18"/></button>							                            
							                           <!-- <input name="bfecha1" type="button" id="bfecha1" value="..." style="width:30px"> -->
							                            <SCRIPT type="text/javascript">
													Calendar.setup({
															inputField     :    "fecha1",
															ifFormat       :    "%Y/%m/%d",
															button         :    "bfecha1"
													});
											  </SCRIPT>
				                                        </div></td><td width="10%"  align="center"><label style="color:#333333">
							  <div align="right"><span class="style2">FECHA FINAL</span></div>
							  </label>							  </td>
										  <% String fecha_hoy2 = new java.text.SimpleDateFormat("yyyy/MM/dd").format(new java.util.Date());%>
							  <td width="16%" scope="col"><input  id="fecha2" name="fecha2" style="text-align:center;color:#333333;font:bold; width:125px" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy2%>"/>
<button name="bfecha2" type="button" id="bfecha2"><img src="../html/images/calendario.png"  width="18" height="18"/></button>						  
							 <!-- <input name="bfecha2" type="button" id="bfecha2" value="..." style="width:30px"> -->
							  <SCRIPT type="text/javascript">
													Calendar.setup({
															inputField     :    "fecha2",
															ifFormat       :    "%Y/%m/%d",
															button         :    "bfecha2"
													});
											  </SCRIPT></td>
		<td width="18%" align="center" >
<button id="consultar"  name="consultar" type="button" onClick="reportFechas()" ><span class="style2">Consultar </span><img src="../html/images/lupa.png" width="19" height="18"/></button>		
<!-- <input id="consultar"  name="consultar" type="button" onClick="reportFechas()" value="Consultar" style="color:#333333"/> --> </td>
		<td width="15%" align="center">
<button id="reporte"  name="reporte" type="button" onClick="verReporte()"><span class="style2">Reporte </span><img src="../html/images/PDF.png"  width="19" height="18"/></button>		
<!--<input id="reporte"  name="reporte" type="button" value="Reporte" onClick="verReporte()" style="color:#333333"/>--></td>
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
