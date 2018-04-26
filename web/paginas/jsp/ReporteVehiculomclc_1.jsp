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
             buscarLineas();
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

           setTimeout("buscarLineas()",100);

           function nuevoAjax(){
		var xmlhttp= false;
		try{
			xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		}catch(e){
			try {
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}catch(E){
				xmlhttp = false;
			}
		}

		if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
			xmlhttp = new XMLHttpRequest();
		}

		return xmlhttp;
	}
        function buscarLineas(){
		var tabla = document.getElementById('lineasdiv');
		var mr = document.getElementById('marcas').value;
		ajax2=nuevoAjax();
		ajax2.open("POST", "cargarLineas2.jsp",true);
		ajax2.onreadystatechange=function() {
			if (ajax2.readyState==4) {
				tabla.innerHTML = ajax2.responseText;
			}
		}
		ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		ajax2.send("marca="+mr+"&linea=0");
	}

 function validar(){
var clase = document.form.clases.value;
var marca = document.form.marcas.value;
var linea = document.form.lineas.value;
var carrocerria = document.form.carrocerias.value;
window.frames[0].location.href="mclc.jsp?clase="+clase+"&marcas="+marca+"&lineas="+linea+"&carrocerias="+carrocerria;

     }
	 function verReporte(){
				ancho = 789;
				alto = 250;
				barra = 0;
				izquierda = (document.width) ? (document.width-ancho)/2 : 100;
				arriba = (document.height) ? (document.height-alto)/2 : 100;
				opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra+',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
				var dir = "reportes/ReporteMclc.jasper";
                                var nombre = "ReporteMclc";
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
			<td colspan="6" align="center"><span class="style2">DATOS DEL VEHICULO</span></td>
		  </tr>
            <tr>
		  	<td colspan="6">&nbsp;</td>
		  </tr>

               <tr align="left" class="style1">
                 <td width="18%" class="Estilo6">
                   CLASE</td>
                 <td width="5%" scope="col">&nbsp;</td>
                 <td width="27%" scope="col"><span style="font-size: 10px">
                   <select name="clases" id="clases"  style="width:202px; font-size:10px; color:#333333">
                       <option value="100" selected="selected"><<--Seleccione Clase-->></option>
                     <%  java.util.List clases = modelo.listadoParametros(1);
                            for (int i = 0; i < clases.size(); i++) {
                                Parametro parametro = (Parametro) clases.get(i);%>
                     <option  value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%></option>
                      <%} %>
                   </select>
                 </span> </td>
                 <td width="17%" scope="col"><span class="Estilo6">
                   CARROCERIA</font></span></td>
                 <td width="5%" scope="col">&nbsp;</td>
                 <td width="28%" scope="col"><select name="carrocerias" id="carrocerias" style="width:202px; font-size:10px; color:#333333" >
                         <option value="2000" selected="selected "><<--Seleccione Carroceria-->></option>
                   <%
		java.util.List carrocerias = modelo.listadoParametros(2);
		for (int i = 0; i < carrocerias.size(); i++) {
			Parametro parametro = (Parametro) carrocerias.get(i); %>
                   <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                   <% }%>
                 </select></td>
           </tr>
               <tr align="left" class="style1">
                   <td><span class="Estilo6">
                   MARCA
                  </span></td>
                   <td>&nbsp;</td>
                   <td><span style="font-size: 10px">
                     <select name="marcas" id="marcas" onChange="buscarLineas()" style="width:202px; font-size:10px; color:#333333" >
                         <option value="1000000" selected="selected"><<--Seleccione Marca-->></option>
                       <%
					java.util.List marcas = modelo.listadoMarcas();
					for (int i = 0; i < marcas.size(); i++) {
						 Marca marca = (Marca) marcas.get(i);
                                  %>
                       <option value="<%=marca.getCodigo()%>"><%= marca.getNombre()%> </option>
                       <% }%>
                   </select>
                   </span></td>
                   <td><span class="Estilo6">
                 LINEA</span></td>
				 <td>&nbsp;</td>
                 <td><div id="lineasdiv"></div></td>
           </tr>
<tr align="left" class="style1">
		   </tr>
			<tr>
		  	<td colspan="6"></td>
		  </tr>
         </table>

		 <table width="90%" border="0" align="center">
          <tr>

            <td width="100%" height="31"  scope="col" align="center"><input name="adicionar" type="button" id="adicionar" value="Registrar" style="width:100px; text-align:center" onClick="validar()"/></td>
            <td><img src="../html/images/reporte.png" alt="reporte" height="25" width="25" onclick="verReporte()"/></td>
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
