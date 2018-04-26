<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultar_taquilla.jsp")){
                    Model modelo= (Model)session.getAttribute("model");    
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
        
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Lista De Taquillas</title>
<script language="javascript" type="text/javascript">
	
	function regresar(){
		window.location.href="consultar_taquilla.jsp?id_caja="+document.getElementById('codigo').value+"&nombre_caja="+document.getElementById('nombre').value;
	}	
	function verT(id){
		var nombre = document.getElementById("nombre").value;
		var cod=document.getElementById('codigo').value;
		var fechaI  = document.getElementById("date").value;
		var fechaF  = document.getElementById("date2").value;
	    window.location.href = "Transacciones_Taquilla.jsp?id_taquilla="+id+"&nombre="+nombre+"&codigo="+cod+"&id=0&n=0&date="+fechaI+"&date2="+fechaF;
	}
	function sombrear(tr){
		tr.style.backgroundColor="#CCCCCC";
	}
	function renovar(tr){
		tr.style.backgroundColor="#FFFFFF";
	}
</script>
<style type="text/css">
<!--
.Estilo4 {
	color: #333333;
	font-size: 14px;
	font-weight: bold;
}
.Estilo9 {color: #333333; font-weight: bold; font-size: 12px; }
.Estilo12 {font-size: 12px; color: #333333; }
.style2 {color: #333333; font-size: 12px; font-weight: bold; font-family: Tahoma; }
.style3 {color: #FFFFFF}
.style4 {font-size: 12px; font-weight: bold;}
-->
</style>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<body>
<% 
 try{
      long id_caja= Long.parseLong(request.getParameter("codigo"));
      int año = Integer.parseInt(request.getParameter("date").substring(6, 10))-1900;
      int mes = Integer.parseInt(request.getParameter("date").substring(3, 5))-1;
      int dia = Integer.parseInt(request.getParameter("date").substring(0, 2));
      
      int año_hasta = Integer.parseInt(request.getParameter("date2").substring(6, 10))-1900;
      int mes_hasta = Integer.parseInt(request.getParameter("date2").substring(3, 5))-1;
      int dia_hasta = Integer.parseInt(request.getParameter("date2").substring(0, 2));
      
      java.sql.Timestamp  fecha_inicio=  new java.sql.Timestamp(año,mes,dia,0,0,0,0);
      java.sql.Timestamp  fecha_fin=     new java.sql.Timestamp(año_hasta,mes_hasta,dia_hasta,23,59,59,0);
   
      Taquilla taquilla = new Taquilla();
      Parametro parametro = new Parametro();
      boolean permiso = modelo.tienePermiso(usuario.getId_usuario(), 136);
      List list = modelo.listarTaquilla(fecha_inicio,fecha_fin,id_caja,usuario.getId_usuario());
      if(permiso){
           list = modelo.listarTaquilla(fecha_inicio,fecha_fin,id_caja,1);
       }
%>
	  <fieldset>
	  </br>
	  </br>
	  <div align="center"><span class="style2">TAQUILLAS <%=request.getParameter("nombre")%></span></div>
	  <input type="hidden" name="codigo" id="codigo" value="<%=request.getParameter("codigo")%>"/>
	  <input type="hidden" name="nombre" id="nombre" value="<%=request.getParameter("nombre")%>"/>
	  <input type="hidden" name="date" id="date" value="<%=request.getParameter("date")%>"/>
	  <input type="hidden" name="date2" id="date2" value="<%=(request.getParameter("date2")!=null?request.getParameter("date2"):"")%>"/>
	  
	  
		<p>&nbsp;</p>
		
		<table width="90%" border="1" align="center" cellpadding="1" cellspacing="0">
		 
	  <% if(list.size()>0){  %>
		  <tr bgcolor="#CCCCCC" class="style2" style="background:url(../html/images/inicio_3.png)">
			<td width="5%" style="border:none"><div align="center" class="style3"><span class="style4">N</span></div></td>
			<td width="10%" style="border:none"><div align="center" class="style3"><span class="style4">CODIGO</span></div></td>
			<td width="17%" style="border:none"><div align="center" class="style3"><span class="style4">FECHA</span></div></td>
			<td width="17%" style="border:none"><div align="center" class="style3"><span class="style4">HORA INICIAL </span></div></td>
			<td width="17%" style="border:none"><div align="center" class="style3"><span class="style4">HORA FINAL </span></div></td>
			<td width="17%" style="border:none"><div align="center" class="style3"><span class="style4">USUARIO</span></div></td>
			<td width="17%" style="border:none"><div align="center" class="style3"><span class="style4">ESTADO</span></div></td>
		  </tr>
   <%     for(int i=0;i<list.size();i++){
			taquilla = (Taquilla)list.get(i);
			usuario= modelo.consultarUsuario(taquilla.getFk_usuario());
			parametro=  modelo.consultarParametro(taquilla.getEstado(),18);
			String f_fin="";
			if(taquilla.getEstado()!=1){
                            if(taquilla.getFecha_fin()!=null)
				f_fin =new java.text.SimpleDateFormat("HH:mm:ss").format(taquilla.getFecha_fin());
			}  %>
			<tr class="style2" id="<%=taquilla.getId_taquilla()%> " style="cursor:pointer" ondblclick="verT(<%=taquilla.getId_taquilla()%>)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
				<td><div align="center"><span class="Estilo12"><%=(i+1)%></span></div></td>
				<td><div align="center"><span class="style2"><%= taquilla.getId_taquilla() %></span></div></td>
				<td><div align="center"><span class="Estilo12"><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(taquilla.getFecha_ini())%></span></div></td>
				<td><div align="center"><span class="Estilo12"><%= new java.text.SimpleDateFormat("HH:mm:ss").format(taquilla.getFecha_ini())%></span></div></td>
				<td><div align="center"><span class="Estilo12"><%= f_fin%></span></div></td>
				<td><div align="center"><span class="Estilo12"><%=usuario.getNombre() !=null ? usuario.getNombre()  :""  %></span></div></td>
				<td><div align="center"><span class="style2"><%= parametro.getNombre() %></span></div></td>
		  </tr>
		  
		  
		  
	    <%}
		}else{  %>
			<tr class="style2"><td colspan="7"><div align="center" class="Estilo9">NO EXISTEN TAQUILLAS ENTRE LAS FECHAS SOLICITDAS </div></td>
<%  	}%>
</table>

<table align="center" border="0">
<tr style="border:none">
		  <td style="border:none">&nbsp;</td>
  </tr>
		  <tr style="border:none">
		    <td  align="center" style="border:none"><input name="cancelar" type="button" id="cancelar" value="Atras" style="width:100px; text-align:center" onclick="regresar()"/></td>
		  </tr>
		   <tr style="border:none">
		  <td  style="border:none">&nbsp;</td>
		  </tr></table>
</fieldset>

        <div align="center" class="style2">
          <% 
 }catch(Exception ex){
 ex.printStackTrace(); %>
            <span class="Estilo9"> NO SE PUDO EFECTUAR LA CONSULTA CORRECTAMENTE </span>
			
			
          <% } %>
</div>
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