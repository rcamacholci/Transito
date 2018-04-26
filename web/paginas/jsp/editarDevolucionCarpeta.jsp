<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Caracteristicas</title>
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
<script language="javascript" type="text/javascript">

    function salir(){
        window.parent.document.location.href = "devolucionesCarpetas.jsp";
    }

</script>
<style type="text/css">
<!--
.style2 {
	font-size: 12px;
	font-family: Tahoma;
	color: #333333;
}
.style3 {
	color: #333333;
	font-family: Tahoma;
}
.style4 {font-size: 12px}
.style7 {
	font-size: 12px;
	color: #FFFFFF;
	font-family: Tahoma;
	font-weight: bold;
}
.style8 {
	color: #333333;
	font-weight: bold;
	font-size: 12px;
	font-family: Tahoma;
}
-->
</style>
</head>
<%@ page import="modelo.*"%>
<%@ page import="java.util.*"%>

<%
Model modelo= (Model)session.getAttribute("model");
long id_prestamo;
 if(request.getParameter("idpc")!=null){
	  id_prestamo = Long.parseLong(request.getParameter("idpc"));

          Prestamos_Carpeta pc = modelo.consultarPrestamoById(id_prestamo);
          Carpetas carpeta = modelo.consultarCarpetaById(pc.getFk_carpeta());
          Vehiculo vehiculo = modelo.consultarVehiculoById(carpeta.getFk_vehiculo()); 
          Parametro parametro = modelo.consultarParametro(pc.getEstado(), 337);
          Usuario usuario = modelo.consultarUsuario(pc.getFk_usuario());
	
%>
<body bgcolor="#FFFFFF">
<form name="form" method="post" action="procesar_prestamo_carpeta.jsp">
<input type="hidden" name="id_prestamo" id="id_prestamo" value="<%=request.getParameter("idpc")%>"/>
<input type="hidden" name="num" id="num" value="2"/>
<fieldset>
 <div align="center">
<table width="90%" align="center" border="0">
 
  <tr style="border:none; background:url(../html/images/inicio_3.png)">
  	<td colspan="4" align="center"><span class="style7">EDITAR DEVOLUCION DE CARPETA </span></td>
  </tr>
    <tr>
    <td width="20%"><span class="Estilo1 style2">PLACA</span></td>
    <td width="30%"><input type="text" name="placa" id="placa" style="width:110px; text-align:center; font:bold" value="<%=vehiculo.getPlaca()%>"  maxlength="6" disabled="disabled"/></td>
	
    <td width="20%"><span class="Estilo1 style3"><span class="style4">ESTADO</span></span></td>
    <td width="29%"><input type="text" name="estado" id="estado" style="width:110px; text-align:center; font:bold" value="<%= parametro.getNombre()%>"  disabled="disabled"/></td>
     </tr>
  <tr>
    <td><span class="Estilo1 style2">FECHA&nbsp;SOLICITUD </span></td>
    <td><input type="text" name="fecha_Solicitud" id="fecha_Solicitud" style="width:110px; text-align:center; font:bold" value=" <%= pc.getFecha_solicitud()!=null?new java.text.SimpleDateFormat("dd/MM/yyyy").format(pc.getFecha_solicitud()):""%>" onkeyup="mascara(this,'/',true)" maxlength="10" disabled="disabled"/></td>
    <td><span class="style8">FECHA&nbsp;PRESTAMO </span></td>
    <td><input type="text" name="fecha_prestamo" id="fecha_prestamo" style="width:110px; text-align:center; font:bold" value=" <%= pc.getFecha_prestamo()!=null?new java.text.SimpleDateFormat("dd/MM/yyyy").format(pc.getFecha_prestamo()):""%>" onkeyup="mascara(this,'/',true)" maxlength="10" disabled="disabled"/></td>
  </tr>
	        <td><span class="style8">FOLIOS&nbsp;ACTUALES </span></td>
              <td colspan=""><input type="text" name="foliosV" id="foliosV" style="width:110px; text-align:center; font:bold" value="<%=carpeta.getFolios()%>"   disabled="disabled"/></td>
          <td><span class="style8">FOLIOS&nbsp;NUEVOS </span></td>
          <td><input type="text" name="foliosN" id="foliosN" style="width:110px; text-align:center; font:bold" value=""/></td>
     </tr>
	 <tr>
	    <td><span class="style8">SOLICITANTE </span></td>
          <td colspan=""><input type="text" name="usuario" id="usuario" style="width:110px; font:bold; text-align:center" value="<%= usuario.getNombre()%>"   disabled="disabled"/></td>
		  <td>&nbsp;</td>
          <td>&nbsp;</td>
	 </tr>
	 <tr><td colspan="4">&nbsp;</td></tr>
	 
	 
  
  <tr>
    <td colspan="5" align="center">
		<table width="90%" border="0">
          <tr>
              <th width="45%" scope="col"><input name="adicionar"  type="submit" id="adicionar" value="Devolver Carpeta" style="width:130px; text-align:center" /></th>
            <th width="45%" scope="col"><input name="cancelar" onclick="salir()" type="button" id="cancelar" value="Cancelar" style="width:130px; text-align:center" /></th>
           
          </tr>
      </table></td>
    </tr>
</table>
</fieldset>
</form>
</body>
<%
}


        
%>
</html>
