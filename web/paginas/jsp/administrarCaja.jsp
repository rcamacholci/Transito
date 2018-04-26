<%-- 
    Document   : gestion_caja
    Created on : 25-ene-2009, 12:47:17
    Author     : Javier
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                    Model modelo= (Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Caja</title>
        <style type="text/css">
<!--
.Estilo1 {
	color: #CC0000;
	font-weight: bold;
}
.Estilo4 {
	color: #333333;
	font-size: 12px;
}
.Estilo5 {
	color: #333333;
	font-weight: bold;
	font-size: 12px;
}
.Estilo7 {
	font-size: 14px;
	font-weight: bold;
	color: #333333;
}
.style1 {font-family: Tahoma}
.style2 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
.style4 {color: #333333; font-weight: bold; font-size: 10px; font-family: Tahoma; }
-->
        </style>
		<script language="javascript" type="text/javascript">
			function ver_Taquilla(id,name){
				window.location.href = "consultar_taquilla.jsp?id_caja="+id+"&nombre_caja="+name+"&id=0&n=0";
	        }
			function sombrear(tr){
				tr.style.backgroundColor="#CCCCCC";
			}
			function renovar(tr){
				tr.style.backgroundColor="#FFFFFF";
			}
			function newC(){
				window.location.href = "adicionarCaja.jsp?id=1";
			}
			
		</script>
</head>
    <body>
	<center>
	<p>&nbsp;</p>
	
	  <fieldset>
 <div align="center">
   <legend class="style2" align="center">ADMINISTRAR CAJAS CIVITRANS</legend>
 </div>
 
  <table width="100%" border="0" align="center" >
	  <tr>
	  <td colspan="4">&nbsp;</td>
        
                <td width="4%" align="right" valign="middle"><div align="center"><img src="../html/images/adicionar.gif" alt="Nueva" name="" width="22" height="22" id="" style="cursor:pointer" onclick="newC()"/><span class="style4">&nbsp;NUEVO</span></div></td>
        
	  </tr>
</table>
    <table width="100%" border="1" align="center" cellpadding="1" cellspacing="0" >
	  
      <tr bgcolor="#CCCCCC" style="border:none;  background:url(../html/images/inicio_3.png)"  >
        <td width="5%"  style="border:none"><div align="center" class="Estilo1 Estilo4 style1">CODIGO</div></td>
        <td width="60%" style="border:none"><div align="center" class="style2">NOMBRE</div></td>
        <td width="20%" style="border:none"><div align="center" class="style2">FECHA&nbsp;INICIO </div></td>
        <td width="15%" style="border:none"><div align="center" class="style2">ESTADO</div></td>
      </tr>
	  	 <%
                   String fecha_fin="";
                   UsuarioCaja usuarioCaja = null;
                   Taquilla taquilla = new Taquilla();
                   Parametro parametro = new Parametro();
                   List list =modelo.consultarCajasUsuario(usuario.getId_usuario());
	           Iterator itt = list.iterator(); 
                   boolean permiso = modelo.tienePermiso(usuario.getId_usuario(), 136);
                   if(permiso){
                       list = modelo.consultarCajasUsuario(1);
                       itt = list.iterator(); 
                   }
                   while (itt.hasNext()) {	
                         usuarioCaja = (UsuarioCaja)itt.next();
                         Caja caja = modelo.consultarCaja(usuarioCaja.getFk_caja());
                         taquilla=modelo.consultar_Taquilla(usuarioCaja.getFk_caja(),usuarioCaja.getFk_sede(),usuarioCaja.getFk_usuario());
                         String estado = "CERRADA";
                         if(taquilla!=null){
                             if(taquilla.getEstado()==1){
                                estado = "ABIERTA";
                             }
                         }
      %>	
     <tr onMouseOver="sombrear(this)" onMouseOut="renovar(this)" style="cursor:pointer" ondblclick="<%=(permiso?"ver_Taquilla("+caja.getId_caja()+",'"+caja.getNombre().toUpperCase()+"')":"")%>">
        <td align="center" ><span class="Estilo5 style1"><%=caja.getId_caja()  %> </span></td>
        <td align="left"><span class="Estilo5 style1"><%=caja.getNombre().toUpperCase() %> </span></td>
        <td align="center"><span class="Estilo5 style1"><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(caja.getFecha_inicio())%> </span></td>
        <td align="center"><span class="Estilo5 style1"><%= estado %></span></td>
      </tr>
      <%}%>
    </table>
	  </fieldset>
	  </center>
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