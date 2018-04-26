<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.DatosVehiculo" errorPage="" %>
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
.Estilo13 {color: #FFFFFF; font-weight: bold; }
.Estilo20 {font-size: 12px; font-weight: bold; }
.style1 {
	color: #333333;
	font-size: 12px;
	font-family: Tahoma;
}
.style2 {color: #333333; font-weight: bold; }
.style3 {
	color: #FFFFFF;
	font-weight: bold;
	font-size: 12px;
	font-family: Tahoma;
}
.style4 {
	font-size: 12px;
	font-family: Tahoma;
}
.style10 {font-size: 11px; font-weight: bold; color: #333333; font-family: Tahoma; }
-->
</style>
<script language="javascript" type="text/javascript">
	function edit(opcion){
		document.location.href = "editarEspecificacion.jsp?idv="+opcion.id;
	}
	function sombrear(tr){
		tr.style.backgroundColor="#CCCCCC";
	}
	function renovar(tr){
		tr.style.backgroundColor="#FFFFFF";
	}
	
</script>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>

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


%>
<body>
<table width="100%" border="1" cellpadding="1" cellspacing="0">
   <tr style="border:none; background:url(../html/images/inicio_3.png)">
    <td width="7%"  style="border:none"><div align="center" class="style3">CODIGO</div></td>
    <td width="35%" style="border:none"><div align="center" class="style3">ESPECIFICACIONES</div></td>
    <td width="22%" style="border:none"><div align="center" class="style3">VALOR</div></td>
    <td width="18%" style="border:none"><div align="center" class="style3">F.&nbsp;INICIO</div></td>
    <td width="18%" style="border:none"><div align="center" class="style3">FECHA&nbsp;FIN</div></td>
  </tr>
  <%
  
   java.util.List lista   =  modelo.listarDatosVehiculo(vehiculo.getId_vehiculo());
   java.util.HashMap mapa =  modelo.crearHashParametros(40);
   for(int i=0;i<lista.size();i++){
       DatosVehiculo dv = (DatosVehiculo)lista.get(i);
       if(dv.getGrupo_codigo()!=1){

		   %>

              <tr bgcolor="#FFFFFF"  id="<%=dv.getId_datoVehiculo()%>" onMouseOver="sombrear(this)" ondblclick="edit(this)"  onMouseOut="renovar(this)" style="cursor:pointer">
                <td align="center" style=" border-color:#CCCCCC"><span class="style10"><%=dv.getParam_codigo()%></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style10"><%=mapa.get(dv.getParam_codigo()+"")%></span></td>
                <td align="center" style="  border-color:#CCCCCC"><span class="style10"><%=dv.getValor()%></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style10"><%=dv.getFecha_ini()%></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style10"><%=dv.getFecha_fin()!=null?dv.getFecha_fin():""%></span></td>
	           </tr>
			  
     <%  
	 	 }
   }
   %>
</table>
<% }
 }        
%>
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