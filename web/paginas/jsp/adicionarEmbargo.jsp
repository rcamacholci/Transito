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
<script type="text/javascript" src="../html/scripts/embargos.js"></script>
<script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
<script type="text/javascript" src="../html/scripts/calendar.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>

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
.style5 {color: #333333}
.style6 {
	font-family: Tahoma;
	font-size: 12px;
}
.style7 {font-family: Tahoma}
.style8 {font-size: 12px}
.style9 {
	color: #333333;
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
}
.style10 {font-family: Tahoma; font-size: 12px; font-weight: bold; }
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

<script>registrarEmbargo()</script>

<body>
<form name="form" method="post" action="javascript:registrarEmbargo()">
<input type="hidden" name="vehiculo" id="vehiculo" value="<%=vehiculo.getId_vehiculo()%>"/>
<fieldset><div align="center">
  <legend class="style2 style7 style6 style5"><strong>ADICIONAR</strong></legend>
 </div>
<table width="70%" align="center" border="0">
   <tr>
    <td><span class="Estilo1 style5 style6">DEPARTAMENTO</span></td>
    <td><span class="style10" style="color: #333333">
      <select name="departamento" id="departamento" onchange="buscarMunicipios()" style="width:180px;font-size:12px">
        <% List list= modelo.crearListaDpto();
			Iterator it = list.iterator(); 
			while (it.hasNext()) {
				Departamento dpto = (Departamento)it.next();%>
        <option value="<%=dpto.getId_departamento()+""%>"><%=dpto.getNombre()%></option>
          <%}%>
      </select>
    </span> </td>
    <td><span class="style5"></span></td>
    <td><span class="Estilo1 style5 style7"><span class="style8">MUNICIPIO</span></span></td>
    <td><div class="Estilo4" style="width:180px" id="municipios"><span class="style5"></span></div></td>
	<script language="javascript" type="text/javascript">document.getElementById('departamento').selectedIndex = 2;buscarMunicipios()</script>
  </tr>
  <tr>
    <td><span class="style5"></span></td>
    <td><span class="style5"></span></td>
    <td><span class="style5"></span></td>
    <td><span class="style5"></span></td>
    <td><span class="style5"></span></td>
  </tr>
  <tr>
    <td><span class="Estilo1 style5 style7"><span class="style8">TIPO&nbsp;DOCUMENTO </span></span></td>
    <td><span class="style10" style="color: #333333">
      <select name="tipodocumento" id="tipodocumento" style="width:180px;font-size:12px">
        <% 
		list=modelo.listadoParametros(5);
		it = list.iterator(); 
		while (it.hasNext()) {
			parametro = (Parametro)it.next(); %> 
        <option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
          <%}%>
      </select>
    </span></td>
    <td><span class="style5"></span></td>
    <td><span class="Estilo1 style5 style7"><span class="style8">NUMERO&nbsp;DOCUMENTO </span></span></td>
    <td><input name="documento" id="documento" style="width:180px; text-align:center" onblur="consultaPersona()"/></td>
  </tr>
  <tr>
    <td><span class="Estilo1 style5 style7"><span class="style8">NOMBRE&nbsp;PERSONA </span></span></td>
    <td colspan="4"><input name="nombres" id="nombres" style="width:530px;text-transform:uppercase" readonly/></td>
  </tr>
  <tr>
    <td><span class="Estilo1 style5 style7"><span class="style8">DEMANDANTE </span></span></td>
    <td colspan="4"><input name="demandante" id="demandante"  style="width:530px;text-transform:uppercase"  /></td>
  </tr>
  <tr>
    <td><span class="style5"></span></td>
    <td><span class="style5"></span></td>
    <td><span class="style5"></span></td>
    <td><span class="style5"></span></td>
    <td><span class="style5"></span></td>
  </tr>
  <tr>
    <td><span class="Estilo1 style5 style7"><span class="style8">OFICINA&nbsp;JURIDICA </span></span></td>
    <td colspan="4"><span class="style10" style="color: #333333">
      <select name="oficina" id="oficina" style="width:530px;font-size:12px">
        <%
	   list=modelo.consultarOficinasJuridicas();
	   it = list.iterator(); 
		while (it.hasNext()) {
			Oficina_Juridica oficina = (Oficina_Juridica)it.next(); %> 
        <option value="<%=oficina.getId_oficina()+""%>"><%=oficina.getNombre()%></option>
          <%}%>
      </select>
    </span></td>
  </tr>
  <tr>
    <td><span class="Estilo1 style5 style7"><span class="style8">TIPO&nbsp;EMBARGO</span></span></td>
    <td><span class="style10" style="color: #333333">
      <select name="tipoembargo" id="tipoembargo" style="width:180px;font-size:12px">
        <% 
		list=modelo.listadoParametros(341);
		it = list.iterator(); 
		while (it.hasNext()) {
			parametro = (Parametro)it.next(); %> 
        <option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
          <%}%>
      </select>
    </span></td>
    <td><span class="style5"></span></td>
    <td><span class="Estilo1 style5 style7"><span class="style8">PROCESO</span></span></td>
    <td><span class="style10" style="color: #333333">
      <select name="proceso" id="proceso" style="width:180px;font-size:12px">
        <% 
		list=modelo.listadoParametros(23);
		it = list.iterator(); 
		while (it.hasNext()) {
			parametro = (Parametro)it.next(); %>
        <option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
        <%}%>
      </select>
    </span></td>
  </tr>
  <tr>
    <td><span class="Estilo1 style5 style7"><span class="style8">NUMERO&nbsp;OFICIO </span></span></td>
    <td><input name="numero_oficio" id="numero_oficio" style="width:180px; text-align:center"/></td>
    <td><span class="style5"></span></td>
    <td><span class="Estilo1 style5 style7"><span class="style8">FECHA&nbsp;OFICIO </span></span></td>
    <td>
         <span class="style9">
		 <input type="text" name="fecha_oficio" id="fecha_oficio" style="width:140px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10"/>
<button name="fecha" type="button" id="fecha"><img src="../html/images/calendario.png" width="19" height="18"/></button>		 
<!--		 <input name="fecha" type="button" id="fecha" value="<<" style="width:25px; text-align:center"/>     -->
		 <script type="text/javascript">
			Calendar.setup({
				inputField     :    "fecha_oficio",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "fecha"   // el id del bot?n que lanzar? el calendario
			});
		 </script>
         </span></td>
  </tr>
  <tr>
    <td><span class="Estilo1 style5 style7"><span class="style8">NUMERO&nbsp;RAD. </span></span></td>
    <td><input name="numero_radicacion" id="numero_radicacion" style="width:180px; text-align:center"/></td>
    <td><span class="style5"></span></td>
    <td><span class="Estilo1 style5 style7"><span class="style8">FECHA&nbsp;RADICACION </span></span></td>
    <td>
         <span class="style9">
         <input type="text" name="fecha_radicacion" id="fecha_radicacion" style="width:140px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10"/>
         <input name="fecha" type="button" id="fecha" value="<<" style="width:25px; text-align:center"/>     
		 <script type="text/javascript">
			Calendar.setup({
				inputField     :    "fecha_oficio",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "fecha"   // el id del bot?n que lanzar? el calendario
			});
		 </script>
         </span></td>
  </tr>
  <tr>
    <td height="58"><span class="Estilo1 style5 style7"><span class="style8">OBSERVACIONES</span></span></td>
    <td colspan="4"><span class="style10" style="color: #333333">
      <textarea name="observacion" id="observacion" style="width:530px; height:70px"></textarea>
    </span></td>
  </tr>
  
  
  <tr>
    <td colspan="5" align="center">
		<table width="100%" border="0">
          <tr>
            <th width="50%" scope="col">
<button name="adicionar" type="submit" id="adicionar" >Adicionar<img src="../html/images/adicionar.png" width="19" height="18"/></button>			
              <!--  <input name="adicionar" type="submit" id="adicionar" value="Adicionar" style="width:100px; text-align:center" />--></th>
            <th width="50%" scope="col">
<button onclick="salir()" name="cancelar" type="button" id="cancelar">Cancelar<img src="../html/images/cancelar.png" width="19" height="18"/></button>			
		  <!--  	<input name="cancelar" type="button" id="cancelar" value="Cancelar" style="width:100px; text-align:center" onclick="salir()"/> --> </th>
          </tr>
        </table>	</td>
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