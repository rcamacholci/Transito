<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html;charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                       modelo.Model modelo = (modelo.Model)session.getAttribute("model");
                       String departamentoExpedicion="";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <title>JSP Page</title>
        <script language="javascript" type="text/javascript">
            function ver(){
                if(document.form.clase.value=="30"){
                   alert("Elija una clase");
                }else{
                   window.frames[0].location.href ="VerTramites.jsp?clase="+document.form.clase.value;
                }
            }
        </script>
        <style type="text/css">
<!--
.style1 {
	font-family: Tahoma;
	font-weight: bold;
	font-size: 12px;
	color: #333333;
}
.Estilo5 {	color: #333333;
	font-size: 10px;
}
.style2 {
	color: #FFFFFF;
	font-weight: bold;
	font-size: 12px;
	font-family: Tahoma;
}
.Estilo6 {font-size: 10px}
.Estilo4 {color: #333333;font-size: 14px;}
-->
        </style>
		<script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
		<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
                <script src="../html/scripts/personas.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">

	 function verReporte(){
     				ancho = 789;
				alto = 250;
				barra = 0;
				izquierda = (document.width) ? (document.width-ancho)/2 : 100;
				arriba = (document.height) ? (document.height-alto)/2 : 100;
				opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra+',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
				var dir = "reportes/Reportetramite.jasper";
                                var nombre = "ReporteTramite";
				url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
				window.open(url, 'popUp', opciones);
			}
		</script>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
    <body>

   <form id="form" name="form" method="post">
      <fieldset>

		<table border="0" align="center" width="90%">
		  
	</table>
		 <table width="90%" border="0" align="center" id="panelCaracteristicas">

               <tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td width="100%" align="center"><span class="style2">TRAMITES</span></td>
		  </tr>
			<tr>
		  	<td></td>
		  </tr>
         </table>

		 <table width="90%" border="0" align="center">
          <tr>
              <td><span class="">Clase:</span>&nbsp;</td>
              <td>
                  <select id="clase" name="clase" style="width:200px; font-size:12px" onchange="ver()">
                      <option value="30" selected="selected" onclick="ver()" ><---Selecionar Clase---></option>
                      <option value="1" onclick="ver()">Vehiculos</option>
                      <option value="10" onclick="ver()">Motocicletas</option>
                      <option value="4" onclick="ver()">RNMA</option>
                      <option value="5" onclick="ver()">RNRYS</option>
                  </select>
                 </td>
            <td width="48%" height="31"  scope="col" align="right" class="Estilo2"><b>Generar Reporte:</b></td>
            <td width="52%">&nbsp;&nbsp;&nbsp;&nbsp;<img src="../html/images/reporte.png" alt="reporte" height="25" width="25" onclick="verReporte()"/></td>
          </tr>
        </table>
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
