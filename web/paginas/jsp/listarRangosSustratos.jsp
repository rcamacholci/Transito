
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                        Model modelo= (Model)session.getAttribute("model");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>::  RANGOS  ::</title>
<link rel="SHORTCUT ICON" href="icono.ico" type="image/x-icon"    />
<style type="text/css">
<!--
	A:hover { color: white; background:blue }
.Estilo2 {
	font-size: 12px;
	font-weight: bold;
}
body {
	background-image: url(fondo.png);

}
.style1 {color: #333333}
.style4 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style5 {color: #333333; font-family: Tahoma; }
.style6 {font-family: Tahoma}
.style8 {font-size: 10px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style9 {color: #FFFFFF}
-->
</style>
<script type="text/javascript" language="javascript">
	function ver_venales(id){
		document.location.href = "listar_sustratos.jsp?rangoS="+id+"&id=0&n=1";
	}
	function newC(){
		document.location.href = "agregarRango.jsp";
	}
        function sombrear(tr){
		tr.style.backgroundColor="#CCCCCC";
	}
	function renovar(tr){
		tr.style.backgroundColor="#FFFFFF";
	}
</script>
</head>

<body>

<fieldset><div align="center">
<legend class="style4" align="center">LISTADO DE RANGOS DE SUSTRATOS </legend>
</div>


<table width="100%" border="0">
  <%if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("agregarRango.jsp")){ %>
    <td width="5%" align="right" valign="middle" bgcolor="#FFFFFF"><div align="right"><img src="../html/images/adicionar.gif" alt="Nueva" name="adicionarVenal" width="22" height="22" id="adicionarVenal" style="cursor:pointer" onclick="newC()"/>&nbsp;<span class="style8">NUEVO</span></div></td>
  <%}else{%>
  <td width="5%" align="right" valign="middle" bgcolor="#FFFFFF">&nbsp;</td>
  <%}%>

</table>
<table width="100%" border="1" align="center" cellpadding="1" cellspacing="0" >
  <tr bgcolor="#CCCCCC" class="Estilo2" style="border:none ; background:url(../html/images/inicio_3.png)" >
    <td width="6%" style="color: #000000; border:none; "><div align="center" class="Estilo4 style6 style9">CODIGO</div></td>
    <td width="28%" style="color: #000000; border:none"><div align="center" class="style4 style6 style9">TIPO</div></td>
    <td width="10%" style="color: #000000; border:none"><div align="center" class="style5 style6 style9"><span class="Estilo2">N&ordm; INICIO </span></div></td>
    <td width="10%" style="color: #000000; border:none"><div align="center" class="style5 style6 style9"><span class="Estilo2">N&ordm; FIN </span></div></td>
    <td width="7%" style="color: #000000; border:none"><div align="center" class="style5 style6 style9"><span class="Estilo2">TOTAL</span></div></td>
    <td width="12%" style="color: #000000; border:none"><div align="center" class="style5 style6 style9"><span class="Estilo2">ACTIVOS</span></div></td>
    <td width="17%" style="color: #000000; border:none"><div align="center" class="style5 style6 style9"><span class="Estilo2">UTILIZADOS</span></div></td>
   
    <td width="10%" style="color: #000000; border:none"><div align="center" class="style5 style6 style9"><span class="Estilo2">%REP</span></div></td>
  </tr>
  
  <%     
         Parametro parametro = new Parametro();
         List listRangos;	
         listRangos =modelo.listConsultarRangosSustratos();
         Rango_Sustratos rangoS= new Rango_Sustratos();
         Iterator itt = listRangos.iterator(); 
         while (itt.hasNext()) {
                   rangoS = (Rango_Sustratos)itt.next();
                   parametro=modelo.consultarParametro( rangoS.getTipo(), 338);
                   int total = modelo.consultar_Total_Sustratos(rangoS.getId_rango_sustrato());
                   int activos = modelo.consultar_Estado_Sustratos(rangoS.getId_rango_sustrato(),1);
                   int utilizados = modelo.consultar_Estado_Sustratos(rangoS.getId_rango_sustrato(),2);
  %>
          
    <tr id="<%=rangoS.getId_rango_sustrato()%>" ondblclick="ver_venales(<%=rangoS.getId_rango_sustrato()%>)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)" style="cursor:pointer">
    <td width="6%"  style="color:#000000"><div  align="center" class="style4"  style="font-size:12px"><strong> <%= rangoS.getId_rango_sustrato()%></strong> </div></td>
    <td width="28%" style="color:#000000"><div class="style1" style="font-size:12px"><strong><%= parametro.getNombre()==null?"":parametro.getNombre() %></strong></div></td>
    <td width="10%" style="color:#000000" align="center"><div class="style4"  style="font-size:12px"><strong><%= rangoS.getNum_inicio()  %></strong></div> </td>
    <td width="10%" style="color:#000000" align="center"><div class="style4"  style="font-size:12px"><strong><%=rangoS.getNum_fin() %></strong></div> </td>
    <td width="7%" style="color:#000000" align="center"><div class="style1"  style="font-size:12px"><strong><%=total%> </strong> </div></td>
    <td width="12%" style="color:#000000" align="center"> <div class="style1"  style="font-size:12px"><strong><%=activos%></strong></div></td>
    <td width="17%" style="color:#000000" align="center"><div class="style1" style="font-size:12px"><strong><%=utilizados%></strong></div></td>
    <td width="10%" style="color: #000000" align="center"><div class="style1"  style="font-size:12px"><strong><%= (utilizados*100)/total +"%"%>  </strong></div></td>
    </tr>
  <%}%>
</table>
</fieldset>
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
