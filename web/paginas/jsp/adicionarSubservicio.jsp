<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <%
try{
    Model modelo = (Model)session.getAttribute("model");


%>
<head>
    <title>Adicionar SubServicio </title>

<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<script src="../html/scripts/calendar.js" type="text/javascript"></script>
<script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
<script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<script src="../html/scripts/insertSubservicio.js" type="text/javascript"></script>
<script type="text/javascript" src="../html/scripts/motorAjax.js"></script>

<META http-equiv=Content-Type content="text/html; charset=windows-1252" />
<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>

<!--<META content="MSHTML 6.00.2900.3020" name=GENERATOR>-->

<!--<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />-->
<script type="text/javascript"  src="../html/scripts/jquery.js"></script>



<style type="text/css">
<!--
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style3 {color: #FFFFFF}
.style31 {color: #333333; font-size: 12px; font-weight: bold; font-family: Tahoma; }
.Estilo2 {color: #FFFFFF; 	font-family: Tahoma; 	font-size: 12px; 	font-weight: bold; }
-->
</style>
<script language="javascript" type="text/javascript">

function validarcamposAdic(){
	if(document.getElementById("parametro").options.selectedIndex>=0){
		if(document.getElementById("fecha_inicial").value.length>0){	
                        insertSubservicio();
                }else{
                        alert("Seleccione al menos una fecha inicial");
                }
	}else{
		alert("No hay parametro seleccionado");
	}
}




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

function selC(){
    //var valort = document.form.valortimbre.value;
    //var placa = document.form.numplaca.value;
    //valort = valort*0.01;
    //window.parent.close();

    //window.parent.opener.window.location.href = "verLiquidacion.jsp?id=204&tipo=3&varete="+valort+"&placa="+placa;
}




</script>
<style type="text/css">
<!--
.style5 {color: #333333}
.style6 {font-family: Tahoma}
.style7 {font-size: 12px}
.style8 {
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
	color: #333333;
}
-->
</style>

</head>
<body>
<% 
if(request.getParameter("placa")!=null){
    String placa = request.getParameter("placa");
    Vehiculo veh = modelo.consultarVehiculo(placa.toUpperCase());
    long idvehiculo = veh.getId_vehiculo();
    long carateristica = 8;
    
    if (veh!=null){
     Parametro parametro = null;
 %>
<form  name="form"  method="post" action="procesar_caracteristica.jsp?id=1">
    <input type="hidden" id="idvehicu" value="<%=idvehiculo%>"/>
    <input type="hidden" id="caracteristica" value="<%=carateristica %>"/>
    <input type="hidden" id="numplaca" value="<%=placa%>"/>

	<fieldset>
	   <table width="90%" align="center" border="0">


  <tr>
      <td width="20%" align="center" colspan="4"><span class="style8">ADICIONAR SUBTIPO SERVICIO</span></td>
  </tr>
  <tr>
    <td><span class="Estilo1 style5 style7"><span class="style6">SUBTIPO SERVICIO </span></span></td>
    <td width="32%">
		<select name="parametro" id="parametro" style="width:120px" onchange="consultaCaracteristica()">
		 <%
			java.util.List list=modelo.listadoParametros(362);
			java.util.Iterator it = list.iterator();
			while (it.hasNext()) {
				parametro = (Parametro)it.next(); %>
				<option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
		  <%}%>
		</select>
	</td>
    <td><span class="Estilo1 style5 style7"><span class="style6">FECHA INICIAL </span></span></td>
    <td><input type="text"  name="fecha_inicial" id="fecha_inicial" style="width:97px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10" />
<button name="fecha1" type="button" id="fecha1"><img src="../html/images/calendario.png" width="19" height="18"/></button>
      <!--<input name="fecha1" type="button" id="fecha1" value="<"style="width:20px; text-align:center"/>-->
	  <script type="text/javascript">
			Calendar.setup({
				inputField     :    "fecha_inicial",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "fecha1"   // el id del bot?n que lanzar? el calendario
			});
		 </script></td>
</tr>
<tr>
    <td colspan="4" align="center">
        <input name="adicionar" type="button" id="adicionar" value="Guardar" onclick="validarcamposAdic()" >
    </td>
</tr>
	  </table>
	</fieldset>
</form>
</body>
</html>
<%
 }
 }
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% } %>