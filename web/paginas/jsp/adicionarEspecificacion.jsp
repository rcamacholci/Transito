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
	color: #333333;
	font-weight: bold;
	font-size: 12px;
}
.Estilo2 {
	color: #333333;
	font-size: 12px;
	font-weight: bold;}
-->
</style>
<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="../html/scripts/calendar.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
function revisar(){
	if(document.getElementById("parametro").value.length>0){
            if(document.getElementById("fecha_inicial").value.length>0){
                    if(document.getElementById("fecha_final").value.length>0){
                            fecha1 = document.getElementById("fecha_inicial").value;
                            fecha2 = document.getElementById("fecha_final").value;
                            f1 = new Date(fecha1.substr(6,4),fecha1.substr(3,2)-1,fecha1.substr(0,2));
                            f2 = new Date(fecha2.substr(6,4),fecha2.substr(3,2)-1,fecha2.substr(0,2));
                            if(f2>=f1){
                                    document.form.submit();
                            }else{
                                    alert("Fecha final debe ser mayor o igual a la inicial");
                            }
                    }else{
                            document.form.submit();
                    }
            }else{
                    alert("Seleccione al menos una fecha inicial");
            }
	}else{
		alert("Ingrese algun valor de especificacion");
	}
}

function salir(){
	document.form.action = "verEspecificaciones.jsp?id=1";
	document.form.submit();
}

</script>
<style type="text/css">
<!--
.style1 {font-family: Tahoma}
.style2 {
	font-size: 12px;
	font-family: Tahoma;
	color: #333333;
}
-->
</style>
</head>
<%@ page import="modelo.*"%>
<%@ page import="java.util.*"%>

<%
Model modelo= (Model)session.getAttribute("model"); 
String placa = "";
String fecha = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
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
<body>
<form name="form" method="post" action="procesar_especificacion.jsp?id=1">
<input type="hidden" name="vehiculo" id="vehiculo" value="<%=vehiculo.getId_vehiculo()%>"/>
<fieldset>
 <div align="center">
  <legend class="style7 style6 style5 style2"><strong>ADICIONAR</strong></legend>
 </div>

<table width="90%" align="center" border="0">

  <tr>
    <td width="18%"><span class="Estilo1 style1">ESPECIFICACION</span></td>
    <td width="32%">
		<select name="especificacion" id="especificacion" style="width:120px">
		 <% 
			java.util.List list=modelo.listadoParametros(40);
			java.util.Iterator it = list.iterator(); 
			while (it.hasNext()) {
				parametro = (Parametro)it.next(); %> 
				<option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
		  <%}%>
		</select>
	</td>
	<td width="3%">&nbsp;</td>
    <td width="14%"><span class="Estilo1 style1">VALOR</span></td>
    <td width="33%"><input name="parametro" id="parametro" style="width:120px; text-align:center"/></td>
  </tr>
  <tr>
    <td><span class="Estilo1 style1">FECHA.&nbsp;INICIAL </span></td>
    <td><input type="text"  name="fecha_inicial" id="fecha_inicial" style="width:97px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10" />
<button name="fecha1" type="button" id="fecha1"><img src="../html/images/calendario.png"/ width="19" height="18"></button>	
     <!-- <input name="fecha1" type="button" id="fecha1" value="<"  style="width:20px; text-align:center"/>-->
	  <script type="text/javascript">
			Calendar.setup({
				inputField     :    "fecha_inicial",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "fecha1"   // el id del bot?n que lanzar? el calendario
			});
		 </script></td>
	<td>&nbsp;</td>	 
    <td><span class="Estilo1 style1">FECHA.&nbsp;FINAL </span></td>
    <td><input type="text" name="fecha_final" id="fecha_final" style="width:97px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10"/>
<button name="fecha2" type="button" id="fecha2"><img src="../html/images/calendario.png"/ width="19" height="18"></button>	
      <!--<input name="fecha2" type="button" id="fecha2" value="<" style="width:20px; text-align:center"/>-->
	  <script type="text/javascript">
			Calendar.setup({
				inputField     :    "fecha_final",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "fecha2"   // el id del bot?n que lanzar? el calendario
			});
		 </script></td>
    </tr>
	
  <tr>
    <td colspan="5" align="center">
		<table width="100%" border="0">
          <tr>
            <th width="50%" scope="col">
<button name="adicionar" type="button" id="adicionar" onclick="revisar()">Adicionar <img src="../html/images/adicionar.png" width="19" height="18"/></button>			
			<!-- <input name="adicionar" type="button" id="adicionar" value="Adicionar" style="width:80px; text-align:center" onclick="revisar()"/>--></th>
            <th width="50%" scope="col">
<button name="cancelar" type="button" id="cancelar" onclick="salir()">Cancelar <img src="../html/images/cancelar.png" width="19" height="18"/></button>						
			<!--<input name="cancelar" type="button" id="cancelar" value="Cancelar" style="width:80px; text-align:center" onclick="salir()"/>--></th>
          </tr>
        </table>
	  </td>
    </tr>
</table>
</fieldset>
</form>
</body>
<%
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