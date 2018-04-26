<%-- 
    Document   : adicionarMunicipio
    Created on : 1/05/2010, 11:39:31 AM
    Author     : Administrador
--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <%
try{
    Model modelo = (Model)session.getAttribute("model");
    Parametro parametro=new Parametro();

%>
<head>
    <title>Adicionar Municipio/Departamento</title>
 
<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>

<script language="JavaScript1.2">
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

function buscarDirMunicipios(){
	tabla = document.getElementById('dir_municipios');

	valor=document.form.dir_departamento.options[document.form.dir_departamento.selectedIndex].value;
	ajax1=new nuevoAjax();
	ajax1.open("POST", "cargarCiudades.jsp",true);
	ajax1.onreadystatechange=function() {
		if (ajax1.readyState==4) {
			tabla.innerHTML = ajax1.responseText;
		}
	}
	ajax1.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	ajax1.send("fk_dpto="+valor+"&name=dir_municipio");
}

function aceptar(){
    eval("opener.document.form."+document.form.name.value+".value='"+document.form.dir_municipio.value+"- "+document.form.dir_municipio.options[document.form.dir_municipio.selectedIndex].text+"'");
    window.close();
}
</script>
 <style type="text/css">
<!--
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style3 {color: #FFFFFF}
.style31 {color: #333333; font-size: 12px; font-weight: bold; font-family: Tahoma; }
.Estilo2 {color: #FFFFFF; 	font-family: Tahoma; 	font-size: 12px; 	font-weight: bold; }
-->
</style>
</head>
<body>
<%
 String departamento = "";
 String municipio = "";
 String name = request.getParameter("name");
 String value = request.getParameter("value");
 if(value.trim().length()>0){
     long idM = Long.parseLong(value.trim().substring(0, value.indexOf("-")));
     Municipio mncp = modelo.consultarMunicipioByCodigo(idM);
     if(mncp!=null){
        municipio = mncp.getCodigo()+"";
        departamento = mncp.getDepartamento()+"";
     }
}
%>
<form  name="form"  method="post" onsubmit="return validarFormulario(this)">
    <input type="hidden" name="name" value="<%=name%>"/>
	<fieldset>
	   <table width="40%" border="0"  bordercolor="#FFFFFF" align="center" >
			<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="Estilo2 style1">ADICIONAR MUNICIPIO</span></td>
			</tr>
			<tr>
              <td colspan="2" align="center">&nbsp;</td>
			</tr>
			<tr>
			  <td width="53%"><div align="center" class="style2">DEPARTAMENTO</div></td>
			  <td width="47%">
				<select name="dir_departamento" style="width:150px; font-size:11px" onchange="buscarDirMunicipios(); return false" onfocus="buscarDirMunicipios(); return false">
				 <% List listaDepar_per = modelo.crearListaDpto();
					Iterator it_dep_per = listaDepar_per.iterator();
					while (it_dep_per.hasNext()) {
						modelo.Departamento dpto = (modelo.Departamento)it_dep_per.next();
						if(departamento.equals(dpto.getId_departamento()+"")){ %>
							  <option value="<%=dpto.getId_departamento()+""%>" selected><%=dpto.getNombre()%></option>
					 <% }else{ %>
							  <option value="<%=dpto.getId_departamento()+""%>"><%=dpto.getNombre()%></option>
					 <% }
					}%>
				</select>
		      </td>
			</tr>
			<tr>  
			  <td width="53%"><div align="center" class="style2">MUNICIPIO</div></td>
			  <td width="47%">
					<div  style="width:150px" align="center" id="dir_municipios">
						<select name="dir_municipio" id="dir_municipio" style="width:150px; font-size:11px">
					  <% if(departamento.length()>0&&municipio.length()>0){
							java.util.List lista = modelo.crearListaMunicipios(Integer.parseInt(departamento));
							for (int i = 0; i < lista.size(); i++) {
								modelo.Municipio mncp = (modelo.Municipio) lista.get(i);
								if(municipio.equals(mncp.getCodigo()+"")){ %>
									<option value="<%=mncp.getCodigo() + ""%>" selected><%=mncp.getNombre()%></option>
							 <% }else{ %>
									<option value="<%=mncp.getCodigo() + ""%>"><%=mncp.getNombre()%></option>
			<%                  }
							}
						} %>
						</select>
					</div>
                          </td>
			</tr>
			<tr>
			 <td align="center" colspan="2">&nbsp;</td>
		 </tr>
			 <tr>
           <td align="center" colspan="2">
<button onclick="aceptar()" type="button" name="guardar" class="style2">Aceptar<img src="../html/images/adicionar.png" width="19" height="18"  /></button>		   
		   <!-- <input type="button" name="guardar" value="Aceptar" style="font-size:10px" onclick="aceptar()"/> --></td>
			
			 </tr>
	  </table>
	</fieldset>
</form>
</body>
</html>
<%
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% } %>