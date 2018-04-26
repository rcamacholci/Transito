<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarColoresVehiculo.jsp")){
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
.style1 {
	color: #333333;
	font-size: 12px;
	font-family: Tahoma;
}
.style4 {color: #FFFFFF; font-weight: bold; font-family: Tahoma; font-size: 12px; }
.style6 {font-size: 12px; font-weight: bold; color: #333333; }
-->
</style>

<script language="javascript" type="text/javascript">
	function edit(opcion){
		document.location.href = "editarColores.jsp?idv="+opcion.id;
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
    java.util.List listaColores = modelo.consultarColoresPlaca(placa.toUpperCase());
    if (listaColores!=null){

        %>
        <body>
        <table width="70%" border="1" cellpadding="1" cellspacing="0" align="center">
          <tr style="border:none; background:url(../html/images/inicio_3.png)">
            <td width="12%" style="border:none"><div align="center" class="style4" >CODIGO</div></td>
            <td width="22%" style="border:none"><div align="center" class="style4">COLOR</div></td>
            <td width="23%" style="border:none"><div align="center" class="style4">GAMA</div></td>
            <td width="8%" style="border:none"><div align="center" class="style4">SEC</div></td>
            <td width="17%" style="border:none"><div align="center" class="style4">FECHA</div></td>
          </tr>
          <%
           
            Iterator itt = listaColores.iterator();
            while (itt.hasNext()) {
	        Historico_Color historico_color = (Historico_Color)itt.next();
                Color color = modelo.getColor(historico_color.getFk_color());
             %>  
          
             <tr id="<%=historico_color.getId_historico()%>" bgcolor="#FFFFFF"  style="cursor:pointer;" ondblclick="edit(this)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
            <td align="center"><span class="style6"><%=color.getId_color()%></span></td>
            <td align="center"><span class="style6"><%=color.getNombre()%></span></td>
            <td align="center"><span class="style6"><%= historico_color.getGama()==null?"":historico_color.getGama()%></span></td>
            <td align="center"><span class="style6"><%= historico_color.getSecuencia()%></span></td>
            <td align="center"><span class="style6"><%= historico_color.getFecha_ini()!=null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(historico_color.getFecha_ini()) : "" %></span></td>
          </tr>
  <%
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