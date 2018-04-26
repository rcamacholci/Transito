<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
try{
if(session.getAttribute("usuario")!=null){
    modelo.Model model = (modelo.Model)session.getAttribute("model");
    if(model!=null){
        modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
        if(model.tienePermiso(usuario.getId_usuario(), 47)){
        String comparendo = "";
	Model modelo= (Model)session.getAttribute("model"); 
	if(request.getParameter("id").equals("0")){
		comparendo =  request.getParameter("comparendo");
	}else{
		comparendo =  session.getAttribute("comparendo")+"";
	}
	if(comparendo!=null){
		Comparendo cparendo= modelo.consultar_Comparendo(comparendo); 
		if (cparendo!=null){
			Detalle_Cartera detalle_cartera =new  Detalle_Cartera();
			Concepto concepto= new Concepto();
			Cartera  cartera= new Cartera();%>
			<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
				<title>Cartera</title>
				<style type="text/css">
					<!--
.style2 {
	color: #FFFFFF;
	font-weight: bold;
	font-size: 12px;
	font-family: Tahoma;
}
.Estilo9 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
.Estilo10 {color: #333333}
					-->
				</style>
			</head>	
			<body>
			<center>
		       <%
				   Parametro parametro = modelo.consultarParametro(cparendo.getEstado(), 67);
		       %>
			   <fieldset>

 
             <table width="100%" border="0" align="center">
			 <tr style="border:none; background:url(../html/images/inicio_3.png)">
        <td colspan="11" align="center"><span class="style2 style14 style7">DATOS DE CARTERA  DEL COMPARENDO </span></td>
     </tr>
			 	
				<tr>
        	      <td width="15%" class="style2"><span class="Estilo9">N&ordm;&nbsp;COMPARENDO</span></td>
			      <td  width="15%" align="left"> 
				  <input name="textfield1" type="text" style="text-align:center; width:110px" value="<%= cparendo.getNumero()%>" readonly/></td>
				  <td  width="5%"align="right"><span class="Estilo10"></span></td>
				  <td width="15%"><span class="Estilo9">FECHA</span></td>
				  <td  width="15%">
				  <input name="textfield2" type="text" style="text-align:center; width:110px" value="<%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(cparendo.getFecha())%>" readonly/>				  </td>
			      <td  width="5%"align="right"><span class="Estilo10"></span></td>
				  <td width="15%"><span class="Estilo9">ESTADO&nbsp;COMPARENDO</span></td>
				  <td  width="15%"><input name="textfield3" type="text" style="text-align:center; width:110px" value="<%= parametro.getNombre()%>" readonly/></td>
			   </tr>
			   <%
			   	   cartera=modelo.consultarCartera(cparendo.getFk_cartera());
				   double valor = 0;
				   double saldo = 0;
				   String estado = "NO EXISTE";
				   if(cartera!=null){
				   		Parametro parametro2 = modelo.consultarParametro(cartera.getEstado_cartera(), 21);
						valor = cartera.getValor();
						saldo = cartera.getSaldo();
						estado = parametro2.getNombre();
					}
				%>   
			   <tr>
        	      <td width="15%" class="style2"><span class="Estilo9">VALOR</span></td>
			      <td  width="15%" align="left">
			     <input name="textfield4" type="text" style="text-align:center; width:110px" value="<%= valor %>" readonly/></td>
				  <td  width="5%"align="right"><span class="Estilo10"></span></td>
				  <td width="15%"><span class="Estilo9">SALDO</span></td>
				  <td  width="15%"><input name="textfield5" type="text" style="text-align:center; width:110px" value="<%= saldo %>" readonly/></td>
			      <td  width="5%"align="right"><span class="Estilo10"></span></td>
				  <td width="15%"><span class="Estilo9">ESTADO&nbsp;CARTERA</span></td>
				  <td  width="15%"><input name="textfield6" type="text" style="text-align:center;width:110px" value="<%= estado%>" readonly/></td>
			   </tr>
			  
			  </table>
			  </fieldset>
			   <fieldset>
 <div align="center">
   <legend class="style2 Estilo10" align="center"><strong>DETALLE DE CARTERA DEL COMPARENDO</strong></legend>
 </div>
 <strong></strong>
				<table width="100%" border="1" cellpadding="1" cellspacing="0">
					  <tr style="border:none;background:url(../html/images/inicio_3.png)">
						<th width="60%" style="border:none"><div align="center" class="style2">CONCEPTO</div></th>
						<th width="20%" style="border:none"><div align="center" class="style2">FECHA</div></th>
						<th width="20%" style="border:none"><div align="center" class="style2">VALOR</div></th>
						
					  </tr>
					  
		  <% if(cartera!=null){
			     List listDetalleCartera = modelo.listarDetalleCartera(cartera.getId_cartera());
				 Iterator itr = listDetalleCartera.iterator(); 
				   while (itr.hasNext()) {
					detalle_cartera = (Detalle_Cartera)itr.next();%>
					 <tr class="style2">
					   <td align="left"><span class="Estilo10"><%=modelo.consultarConcepto(detalle_cartera.getFk_concepto()).getNombre()%></span></td>
						<td align="center"><span class="Estilo10"><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(detalle_cartera.getFecha())%></span></td>
						<td  align="right"><span class="Estilo10">$&nbsp;<%=detalle_cartera.getValor()%></span></td>
						
				  </tr>
				<% } 
			}		%> 
			   </table>
			  </fieldset>
			</center>
			</body>
			 </html>
	<% }
	} 
  }else{  %>
           <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="1"></jsp:param></jsp:forward>
<%        }
     }else{ %>
        <script>window.parent.document.location.href = "../../index.jsp";</script>
<%  }
 }else{ %>
     <script>window.parent.document.location.href = "../../index.jsp";</script>
<% }
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% } %>
	 
