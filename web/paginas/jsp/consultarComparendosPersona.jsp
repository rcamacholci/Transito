<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Comparendos</title>
<script language="javascript" type="text/javascript">
	function ver_Comparendo(id){
            window.location.href = "consultarComparendo.jsp?comparendo="+id+"&id=0&n=0";
        }
</script>
<style type="text/css">
<!--
.Estilo2 {color: #FFFFFF; font-weight: bold; }
.Estilo4 {color: #333333; font-weight: bold; }
.Estilo5 {
	color: #333333;
	font-size: 12px;
}
.Estilo7 {color: #333333; font-weight: bold; font-size: 12px; }
.Estilo8 {color: #333333}
.style1 {font-family: Tahoma}
.style3 {color: #333333; font-family: Tahoma; }
.style4 {color: #FFFFFF}
.style5 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
-->
</style>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>

<%
Model modelo= (Model)session.getAttribute("model");
if(session.getAttribute("id_persona")!=null){
	Persona persona= modelo.consultarPersona(Long.parseLong(session.getAttribute("id_persona").toString()));
	if(persona!=null){
		%>
		<body>
		<table width="100%" border="1" cellpadding="1" cellspacing="0">
		  <tr bgcolor="#CCCCCC" style="border:none; background:url(../html/images/inicio_3.png)">
			<td width="10%"  style="border:none"><div align="center" class="Estilo2 Estilo5 style1 style4">NUMERO</div></td>
			<td width="55%" style="border:none"><div align="center" class="style5">INFRACCION</div></td>
			<td width="15%" style="border:none"><div align="center" class="style5">FECHA</div></td>
			<td width="10%" style="border:none"><div align="center" class="style5">PLACA</div></td>
			<td width="10%" style="border:none"><div align="center" class="style5">ESTADO</div></td>
		  </tr>
		 
		  <%
			
			List  per_comp=modelo.Listar_Comparendos(persona.getId_persona());
			Iterator itt = per_comp.iterator(); 
			
			 Parametro param= new Parametro();
			
			 while (itt.hasNext()) {	
						Comparendo comparendo= (Comparendo)itt.next();
								param  = modelo.consultarParametro(comparendo.getEstado(),67);
								Infraccion infraccion= modelo.consultarInfraccion(comparendo.getFk_infraccion());
								   
									  %>
			<tr id="<%=comparendo.getId_comparendo()%>" ondblclick="ver_Comparendo('<%=comparendo.getNumero()%>')" class="Estilo4" style="cursor:pointer">
			<td align="center" style="font-size:12px;"><span class="style3"><%= comparendo.getNumero()  %></span></td>
			<td align="left" style="font-size:11px;"><span class="style3"><%=infraccion.getDescripcion()%></span></td>
			<td align="center" style="font-size:12px;"><span class="style3"><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(comparendo.getFecha())%></span></td>
			<td align="center" style="font-size:12px;"><span class="style3"><%= comparendo.getPlaca()!=null?comparendo.getPlaca():""  %></span></td>
			<td align="center" style="font-size:12px;"><span class="style3"><%=param.getNombre() %></span></td>
		  </tr>
		  <%}%>
		</table>
		</body>
<%  }
 }else{ %>
    <script>
            alert("Digite numero de documento");
            window.href="consultar_persona.jsp";
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