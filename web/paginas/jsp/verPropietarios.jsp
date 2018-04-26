<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarPropietariosVehiculo.jsp")){
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Propietario</title>
<style type="text/css">
<!--
.Estilo1 {
	color: #FFFFFF;
	font-weight: bold;
}
.Estilo4 {font-size: 12px; font-weight: bold; color: #333333; }
.Estilo5 {
	color: #0066CC;
	font-weight: bold;
}
.style4 {color: #FFFFFF; font-weight: bold; font-family: Tahoma; font-size: 12px; }
.style6 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
-->
</style>
<script language="javascript" type="text/javascript">
	function edit(opcion){
		document.location.href = "editarPropietario.jsp?id_propietario="+opcion.id;
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
if(request.getParameter("id").equals("0")){
	placa =  request.getParameter("placa");
}else{
	placa =  session.getAttribute("placa")+"";
}
if(placa!=null){
Vehiculo vehiculo  =modelo.consultarVehiculo(placa.toUpperCase());
if (vehiculo!=null){

%>
<body>
<table width="70%" border="1" cellpadding="1" cellspacing="0" align="center">
  <tr  style="border:none; background:url(../html/images/inicio_3.png)">
    <td style="border:none"><div align="center" class="style4" >IDENTIFICACION</div></td>
    <td style="border:none"><div align="center" class="style4">NOMBRE</div></td>
    <td style="border:none"><div align="center" class="style4">% </div></td>
    <td style="border:none"><div align="center" class="style4">FECHA_TRAMITE</div></td>
  </tr>
  <%
     String nombre_propietario="";
     Propietario propietario= new Propietario();
     java.util.List  listapropietario = modelo.crear_Lista_Propietarios(vehiculo.getId_vehiculo());
     Iterator itt = listapropietario.iterator();
     java.util.HashMap listaTipos = modelo.crearHashParametrosAbreviatura(5);
	 boolean color = true;
	 while (itt.hasNext()) {
		        propietario = (Propietario)itt.next();
                        Persona persona=modelo.consultarPersona(propietario.getFk_persona());
                        nombre_propietario=persona.getApellido_1() + " " + (persona.getApellido_2()!=null?persona.getApellido_2():"")+ " " +persona.getNombre_1();
             %>
             <tr bgcolor="#FFFFFF" onMouseOver="sombrear(this)"  style="cursor:pointer"  ondblclick="edit(this)" onMouseOut="renovar(this)" id="<%= propietario.getId_propietario() %>" >
    <td align="center"><span class="style6"><%=listaTipos.get(persona.getTipo_documento() + "")+" "+persona.getDocumento()%></span></td>
    <td align="center"><span class="style6"><%=nombre_propietario != null ? nombre_propietario :"" %></span></td>


    <td align="center"><span class="style6"><%= propietario.getPorcentaje()%></span></td>
    <td align="center"><span class="style6"><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(propietario.getFecha_inicio())!=null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(propietario.getFecha_inicio()) : "" %></span></td>
  </tr>
  <%
  	color = !color;
  }

  } %>
</table>
<% }else{ %>
 	<script>
		alert("Digite numero de placa");
		window.href="consultar_Vehiculo.jsp";
	</script>
<% }
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