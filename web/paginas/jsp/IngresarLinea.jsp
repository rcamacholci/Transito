<%-- 
    Document   : IngresarLinea
    Created on : 5/06/2012, 01:11:22 PM
    Author     : acer
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                     Model modelo= (Model)session.getAttribute("model");
                    
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Adicionar Usuario</title>
<script language="javascript" type="text/javascript">
  function nuevoAjax(){
		var xmlhttp= false;
		try{
			xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		}catch(e){
			try {
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}catch(E){
				xmlhttp = false;
			}
		}

		if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
			xmlhttp = new XMLHttpRequest();
		}

		return xmlhttp;
	}
        function Cargarl(){
                document.getElementById('td').style.display = "none";
                document.getElementById('td2').style.display = "block";

		var tabla = document.getElementById('lineasdiv');
		var mr = document.getElementById('placa').value;
		ajax2=nuevoAjax();
		ajax2.open("POST", "cargarLinea.jsp",true);
		ajax2.onreadystatechange=function() {
			if (ajax2.readyState==4) {
				tabla.innerHTML = ajax2.responseText;
			}
		}
		ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		ajax2.send("placa="+mr);
	}


</script>


<style type="text/css">
<!--
.Estilo4 {color: #0066CC}
.style2 {
	color: #333333;
	font-weight: bold;
	font-size: 11px;
	font-family: Tahoma;
}
.Estilo6 {
	color: #FFFFFF;
	font-weight: bold;
	font-size: 12px;
}
.Estilo7 {
	font-size: 12px;
	font-weight: bold;
	color: #333333;
}
-->
</style>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
Parametro parametro=new Parametro();

%>
<body >

<form id="form" name="form" method="post" action="IngresarLinea_prosesar.jsp">
	<fieldset>

<table border="0" width="58%" align="center">
<tr>
<td>
  
  <table width="100%" border="0" align="center">
  <tr>
	<td colspan="2" background="../html/images/inicio_3.png"><div align="center"><span class="Estilo6">REGISTRAR USUARIO</span></div></td>
  </tr>
  <tr>
      <td width="48%"><span class="style2">PLACA:&nbsp;</span>
        <input type="text" id="placa" name="placa" maxlength="6" onblur="Cargarl()" style="width:70px; text-align:center; font-size:11px; text-transform:uppercase;" /></td>
      <td width="52%" id="td" style="display:"><span class="style2">CODIGO LINEA:&nbsp;</span>
        <input type="text" id="Fline" name="Fline" style="width:70px; text-align:center; font-size:11px; text-transform:uppercase;" readonly/>
      </td>
                        <td id="td2" style="display:none">
                       <div id="lineasdiv"></div></td>
                  </td>
  </tr>
  <tr>
      <td><span class="style2">MARCA:&nbsp;</span><select id="marca" name="marca" style="width:150px;">
                    <option value="1000000" selected="selected">Seleccione Marca</option>
                                  <%
					java.util.List marcas = modelo.listadoMarcas();
					for (int i = 0; i < marcas.size(); i++) {
                                            Marca marca = (Marca) marcas.get(i);                                  %>
                       <option value="<%=marca.getCodigo()%>"><%= marca.getNombre()%> </option>
                       <% }%>
          </select>
		  </td>
                  <td colspan="2" ><span class="style2">NOMBRE DE LINEA:&nbsp;</span><input type="text" id="linea" name="linea" style="width:100px; text-align:center; font-size:11px; text-transform:uppercase;" />
                  </td>
  </tr>
  </td>
  </tr>
  <tr align="center"><td colspan="2"><input type="submit" value="Guardar"></td></tr>
  </table>
 
  </td>
 </table>
 </fieldset>
</form>

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
