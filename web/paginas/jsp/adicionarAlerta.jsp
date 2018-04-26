<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Especificaciones</title>
<style type="text/css">
<!--
.Estilo1 {
	color: #0066CC;
	font-weight: bold;
}
.Estilo2 {color: #0066CC}
-->
</style>
<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="../html/scripts/calendar.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<script src="../html/scripts/personas.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
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
function consultaPersona(){
	tipo = document.getElementById("tipodocumento") ;
	documento = document.getElementById("documento").value ;
	if(documento.length>0&&!isNaN(documento)){
		tipoDoc = tipo.options[tipo.options.selectedIndex].value
		ajax2=nuevoAjax();
		ajax2.open("POST", "getPersona.jsp",true);
		ajax2.onreadystatechange=function() {
			if (ajax2.readyState==4) {
				var respuesta = "" ;
				for(var i = 0; i < ajax2.responseText.length ; i++){
					if(isNaN(ajax2.responseText.charAt(i)))
						respuesta += ajax2.responseText.charAt(i);
				}
				if(respuesta == "nueva"){
					viewPersona(tipoDoc,documento);
				}else{
					document.getElementById("nombres").value = ajax2.responseText;
				}        
			}
		}
		ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		ajax2.send("documento="+documento+"&tipo="+tipoDoc); 
	}	
}

function revisar(){
	if(document.getElementById("nombres").value.length>5){
		if(document.getElementById("fecha_inicio").value.length>0){
			if(document.getElementById("observacion").value.length>0){
                                if(document.getElementById("grado").value.length>0){
                                    document.form.submit();
                                }else{
                                    alert("Seleccione el grado de Alerta");
                                }
				
			}else{
				alert("Digite alguna observacion");
			}
		}else{
			alert("Seleccione fecha de inicio");
		}
	}else{
		alert("Digite un numero de identificacion valido");
	}
}
function salir(){
	document.form.action = "verAlertas.jsp?id=1";
	document.form.submit();
}
</script>
<style type="text/css">
<!--
.style1 {
	color: #333333;
	font-family: Tahoma;
}
.style3 {
	color: #333333;
	font-size: 12px;
}
.style7 {
	color: #333333;
	font-size: 12px;
	font-weight: bold;
	font-family: Tahoma;
}
.style9 {color: #333333; font-size: small; font-weight: bold; font-family: Tahoma; }
.style10 {font-size: small}
.Estilo12 {color: #333333}
-->
</style>
</head>
<%@ page import="modelo.*"%>
<%@ page import="java.util.*"%>

<%
Model modelo= (Model)session.getAttribute("model"); 
String placa = "";
if(request.getParameter("id")=="0"){
	placa =  request.getParameter("placa");
}else{
	placa =  session.getAttribute("placa")+"";
}
if(placa!=null){
Vehiculo vehiculo  = new Vehiculo();
vehiculo=modelo.consultarVehiculo(placa.toUpperCase());
if (vehiculo!=null){
  Parametro parametro = null;

%>
<body bgcolor="#FFFFFF">
<form name="form" method="post" action="procesar_alerta.jsp">
<input type="hidden" name="vehiculo" id="vehiculo" value="<%=vehiculo.getId_vehiculo()%>"/>
<fieldset><div align="center">
  <legend class="style2 style7 style6 style5"><strong>ADICIONAR</strong></legend>
 </div>
<table width="90%" align="center" border="0">
   <tr>
    <td width="18%"><span class="style7">TIPO&nbsp;DOCUMENTO </span></td>
    <td width="26%"><select name="tipodocumento" id="tipodocumento" style="width:160px;font-size:11px">
	 <% 
		java.util.List list=modelo.listadoParametros(5);
		java.util.Iterator it = list.iterator(); 
		while (it.hasNext()) {
			parametro = (Parametro)it.next(); %> 
			<option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
	  <%}%>
    </select></td>
    <td width="2%">&nbsp;</td>
    <td width="17%"><p class="style7">NUMERO&nbsp;DOCUMENTO</p>      </td>
    <td width="37%"><input name="documento" id="documento" style="width:210px; text-align:center" onblur="consultaPersona()"/></td>
  </tr>
  <tr>
    <td><span class="style7">NOMBRE</span></td>
    <td colspan="4"><input name="nombres" id="nombres" style="width:530px;text-transform:uppercase" readonly/></td>
  </tr>
  
  
  <tr>
    <td><span class="style7">TIPO&nbsp;ALERTA </span></td>
    <td><select name="tipoalerta" id="tipoalerta" style="width:145px;font-size:11px">
      <% 
		list=modelo.listadoParametros(4);
		it = list.iterator(); 
		while (it.hasNext()) {
			parametro = (Parametro)it.next(); %>
      <option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
      <%}%>
    </select></td>
    <td>&nbsp;</td>
    <td class="style7">GRADO ALERTA </td>
    <td><span class="Estilo12">
      <select name="grado" id="grado" style="width:145px">
        
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
        <option value="6">6</option>
        <option value="7">7</option>
      </select>
    </span> </td>
  </tr>
  <tr>
    <td><span class="style9">FECHA&nbsp;INICIO </span></td>
    <td><input type="text" name="fecha_inicio" id="fecha_inicio" style="width:120px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10"/>
<button name="fechai" type="button" id="fechai"><span class="styl2"></span><img src="../html/images/calendario.png" width="18" height="18" /></button>
    <!--  <input name="fechai" type="button" id="fechai" value="<<" style="width:22px; text-align:center"/> -->
	  <script type="text/javascript">
			Calendar.setup({
				inputField     :    "fecha_inicio",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "fechai"   // el id del bot?n que lanzar? el calendario
			});
		 </script></td>
    <td>&nbsp;</td>
    <td><span class="style9">FECHA&nbsp;FIN</span></td>
    <td>
         <input type="text" name="fecha_fin" id="fecha_fin"  style="width:120px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10"/>
<button name="fechaf" type="button" id="fechaf"><img src="../html/images/calendario.png" width="19" height="18"/></button>		 
<!--         <input name="fechaf" type="button" id="fechaf" value="<<" style="width:22px; text-align:center"/> -->    
		 <script type="text/javascript">
			Calendar.setup({
				inputField     :    "fecha_fin",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "fechaf"   // el id del bot?n que lanzar? el calendario
			});
		 </script> </td>
  </tr>
  
  <tr>
    <td height="58"><span class="style7">OBSERVACIONES</span></td>
    <td colspan="4"><textarea name="observacion" id="observacion" style="width:530px; height:70px"></textarea></td>
  </tr>
  
  
  <tr>
    <td colspan="5" align="center">
		<table width="70%" border="0">
          <tr>
            <th width="50%" scope="col">
<button name="adicionar" type="button" id="adicionar"  onclick="revisar()">Adicionar<img src="../html/images/adicionar.png" width="18" height="18"/></button>			
		<!--	<input name="adicionar" type="button" id="adicionar" value="Adicionar" style="width:100px; text-align:center" onclick="revisar()"/> --></th>
            <th width="50%" scope="col">
			<button name="cancelar" type="button" id="cancelar" onclick="salir()">Cancelar <img src="../html/images/cancelar.png" width="18" height="18"/></button>
<!--			<input name="cancelar" type="button" id="cancelar" value="Cancelar" style="width:100px; text-align:center" onclick="salir()"/>--></th>
          </tr>
        </table>    </td>
    </tr>
</table>
</fieldset>
</form>
</body>
<%
//NNK75 - SBW25 - RCH855
}
 }        
%>
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