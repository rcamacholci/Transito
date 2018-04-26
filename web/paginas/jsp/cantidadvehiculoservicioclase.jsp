<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarAcuerdosdePago.jsp")){
          modelo.Model model = (modelo.Model)session.getAttribute("model");
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
function paso(){
    var servicio = window.document.form.servicio.value;
    var clase = window.document.form.clase.value;
    window.frames[0].location.href  = "vercantidadvehiculoserviicioclase.jsp?&servicio="+servicio+"&clase="+clase;
  }
function verReporte(){
    ancho = 789;
    alto = 250;
    barra = 0;
    izquierda = (document.width) ? (document.width-ancho)/2 : 100;
    arriba = (document.height) ? (document.height-alto)/2 : 100;
    opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
    var dir = "informes/cantidad.jasper";
    var nombre = "cantidad";
    url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
    window.open(url, 'popUp', opciones);
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
   // Model model = null;
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
				<td colspan="11" align="center"><span class="Estilo2">CANTIDAD DE VEHICULOS POR SERVICIO Y CLASE</span></td>
			</tr>
		</table>
<table border="0" width="100%" id="tabla1">
  <tr valign="middle" align="center">
    <td width="20%" class="style2">SERVICIO</td>
    <td width="20%"><select name="servicio"  id="servicio"   style=" width:180px; color:#333333; font-size:12px">
     <option value="0">---- Seleccione una Servicio ----</option>
        <%
        Model modelo= (Model)session.getAttribute("model");
        Parametro parametro=new Parametro();
        List list=modelo.listadoParametros(3);
        Iterator it = list.iterator();
        while (it.hasNext()) {
        parametro = (Parametro)it.next();%>
    <option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
    <%}%>
</select></td>
   
    <td width="20%" class="style2">CLASE</td>
    <td width="20%"><select name="clase"  id="clase"   style=" width:180px; color:#333333; font-size:12px">
     <option value="0">---- Seleccione una Clase ----</option>
        <%
        Model modelo2= (Model)session.getAttribute("model");
        Parametro parametro2=new Parametro();
        List list2=modelo2.listadoParametros(1);
        Iterator it2 = list2.iterator();
        while (it2.hasNext()) {
        parametro2 = (Parametro)it2.next();%>
    <option value="<%=parametro2.getCodigo()+""%>"><%=parametro2.getNombre()%></option>
    <%}%>
</select></td>
    <td width="20%">
<button id="consultar"  name="consultar" type="button" onClick="paso()"><span class="style2">Consultar </span><img src="../html/images/lupa.png" width="19" height="18"/></button>	
	<!--<input id="consultar"  name="consultar" type="button" value="    Consultar    " style="color:#333333" onClick="paso()" />--></td>
	<td width="20%">
<button id="reporte"  name="reporte" type="button" onClick="verReporte()"><span class="style2">Reporte </span><img src="../html/images/PDF.png"  width="19" height="18"/></button>	
<!--	<input id="reporte"  name="reporte" type="button" value="Reporte" onClick="verReporte()" style="color:#333333"/>--></td>
</td>
  </tr>
</table>
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
