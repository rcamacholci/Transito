<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*,java.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Vehiculo</title>
<style type="text/css">
<!--
.Estilo4 {color: #333333; font-weight: bold; }
.Estilo5 {
	font-size: 12px;
	font-weight: bold;
	color: #333333;
}
.style1 {
	font-family: Tahoma;
	color: #FFFFFF;
}
.style3 {font-size: 12px; font-weight: bold; color: #FFFFFF; font-family: Tahoma; }
-->
</style>
</head>
<%
Model modelo= (Model)session.getAttribute("model");
if(session.getAttribute("id_persona")!=null){
	Persona persona= modelo.consultarPersona(Long.parseLong(session.getAttribute("id_persona").toString()));
	if(persona!=null){
%>
<body>
<p align="center"><label class="Estilo5">LISTA DE VEHICULOS EN PROPIEDAD</label>
</p>

<table width="100%" border="1" cellpadding="1" cellspacing="0">
 
  <tr bgcolor="#CCCCCC" style="border:none; background:url(../html/images/inicio_3.png)">
    <td width="7%"  style="border:none" ><div align="center" class="Estilo5 style1" >PLACA</div></td>
    <td width="10%"style="border:none" ><div align="center" class="style3" >FECHA&nbsp;INICIO </div></td>
    <td width="10%" style="border:none" ><div align="center" class="style3" >FECHA&nbsp;FIN </div></td>
    <td width="15%" style="border:none"> <div align="center" class="style3" >CLASE</div></td>
    <td width="20%" style="border:none"><div align="center" class="style3" >MARCA/LINEA</div></td>
    <td width="10%" style="border:none"><div align="center" class="style3" >ESTADO</div></td>
    <td width="15%" style="border:none"><div align="center" class="style3" >ESTADO&nbsp;LEGAL </div></td>
    <td width="18%" style="border:none"><div align="center" class="style3" >CARTERA</div></td>

  </tr>
 <% 
    List  pers_vehiculo=modelo.Listar_Propietarios(persona.getId_persona());
    Iterator itt = pers_vehiculo.iterator(); 
     Linea linea=new Linea();
     Marca marca = new Marca();
     Parametro param= new Parametro();
     Parametro param2= new Parametro();
     Parametro param3= new Parametro();
     while (itt.hasNext()) {
        Propietario propietario= (Propietario)itt.next();
        Vehiculo vehiculo=modelo.consultarVehiculoById(propietario.getFk_vehiculo());
        if(vehiculo!=null){
             linea = modelo.consultaLinea(vehiculo.getPlaca().toUpperCase());
             marca= modelo.consultaMarca(vehiculo.getPlaca().toUpperCase());
             param  = modelo.consultarParametro(Integer.parseInt(vehiculo.getClase_vehiculo()+""),1);
             param2 = modelo.consultarParametro(Integer.parseInt(vehiculo.getEstado()+""),66);
             Usuario usuario = (Usuario)session.getAttribute("usuario");
             boolean swActualizoInteres = modelo.actualizarInteresesCostasVehiculos(vehiculo.getId_vehiculo(), usuario.getId_usuario());
             if(!swActualizoInteres){
                // Colocar alerta cuando no se genero intereses
                %><script>alert('Há ocurrido un error al actualizar intereses, intente nuevamente')</script><%
            }
             String carteraSum=modelo.consultarCarteraTotal(vehiculo.getId_vehiculo());
             boolean alerta = modelo.tieneAlertas(vehiculo.getId_vehiculo());
             boolean embargo = modelo.tieneEmbargos(vehiculo.getId_vehiculo());
             String estadoLegal = embargo?"EMBARGADO"+(alerta?"/PIGN":""):(alerta?"PIGNORADO":"NORMAL"); %>
              <tr class="Estilo4">
                <td align="center" style="font-size:12px;"><%=vehiculo.getPlaca()!=null ? vehiculo.getPlaca():"" %></td>
                <td align="center" style="font-size:12px;"><%=propietario.getFecha_inicio()%></td>
                <td align="center" style="font-size:12px;"><%=propietario.getFecha_final()!=null?propietario.getFecha_final():""%></td>
                <td align="center" style="font-size:12px;"><%=param.getNombre()!=null ?   param.getNombre():"" %></td>
                <td align="center" style="font-size:12px;"><%=marca.getNombre()!=null?marca.getNombre()+" "+((linea.getNombre()!=null?linea.getNombre():"")):""%>				</td>
                <td align="center" style="font-size:12px;"><%=param2.getNombre() !=null ? param2.getNombre():""%></td>
                <td align="center" style="font-size:12px;"><%=estadoLegal%></td>
                <td align="center" style="font-size:12px;"><%=carteraSum%></td>
              </tr>
      <%  }
     } %>
</table>
</body>
<%  }
 }else{ %>
    <script>
            alert("Digite numero de documento");
    </script>
<% }
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