
<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Documento sin t&iacute;tulo</title>
<style type="text/css">
<!--
.Estilo1 {color: #FFFFFF}
-->
</style>
<script language="javascript" type="text/javascript">
	function verC(color,i){
		color.style.display = 'none';
		document.getElementById('color'+i).style.display = 'block';
	}
	function aplicarC(color,i){
		document.getElementById('tcodigo'+i).value = color.value;
		document.getElementById('tcolor'+i).style.display = 'block';
        color.style.display = 'none';
		document.location.href = "radicarColores.jsp?tipo=2&color="+color.value+"&id="+i;
	}
	function aplicarG(gama,i){
        document.location.href = "radicarColores.jsp?tipo=3&gama="+gama.value+"&id="+i;
	}
	function eliminar(i){
		document.location.href = "radicarColores.jsp?tipo=4&id="+i;
	}
	function verInput(codigo,name,id){
		if(isNaN(codigo.value)&&codigo.value.length>0){
			var salida = "";
			for(i=0;i<codigo.value.length;i++){
				if(!isNaN(codigo.value.charAt(i))){
					salida += codigo.value.charAt(i);
				}
			}
			codigo.value = salida;
		}
		if(codigo.value.length>0){
			combo = document.getElementById(name);
			for(i=0;i<combo.options.length;i++){
				if(combo.options[i].value == parseInt(codigo.value)){
					combo.options.selectedIndex = i;
					break;
				}
			}
			if(i==combo.options.length){
				codigo.value = combo.options[combo.options.selectedIndex].value
			}	
		}else{
			codigo.value = combo.options[combo.options.selectedIndex].value
		}	
		document.location.href = "radicarColores.jsp?tipo=2&color="+codigo.value+"&id="+id;
	}
</script>
</head>
<body>
<table width="312" border="0" align="center">
  <tr style="background:url(../html/images/inicio_3.png)">
  	<th width="17" scope="col"><span class="Estilo1"><font size="2">COD</font></span></th>
    <th width="169" scope="col"><span class="Estilo1"><font size="2">COLOR</font></span></th>
    <th width="104" scope="col"><span class="Estilo1"><font size="2">GAMA</font></span></th>
	<th width="104" scope="col"><span class="Estilo1"><font size="2">SEC</font></span></th>
	<th width="17" scope="col"><span class="Estilo1"><font size="2">X</font></span></th>
  </tr>
  <% java.util.List lista =(java.util.List)session.getAttribute("colores");
     Model model =(Model)session.getAttribute("model");
	if(lista==null){
	 	lista = new java.util.LinkedList();
	 }
	 if(request.getParameter("tipo")!=null){
		 if(request.getParameter("tipo").equals("1")){
			Radicacion_Color new_rc = new Radicacion_Color();
			lista.add(new_rc);
			session.setAttribute("colores",lista);
		 }else{	
			 if(request.getParameter("tipo").equals("2")){
				Radicacion_Color new_rc = (Radicacion_Color)lista.get(Integer.parseInt(request.getParameter("id")));
				new_rc.setFk_color(Integer.parseInt(request.getParameter("color")));
				new_rc.setSequencia(Integer.parseInt(request.getParameter("id"))+1);
				lista.set(Integer.parseInt(request.getParameter("id")),new_rc);
				session.setAttribute("colores",lista);
			 }else{
				 if(request.getParameter("tipo").equals("3")){
					Radicacion_Color new_rc = (Radicacion_Color)lista.get(Integer.parseInt(request.getParameter("id")));
					new_rc.setGama(request.getParameter("gama"));			
					new_rc.setSequencia(Integer.parseInt(request.getParameter("id"))+1);
					lista.set(Integer.parseInt(request.getParameter("id")),new_rc);
					session.setAttribute("colores",lista);
				 }else{
					if(request.getParameter("tipo").equals("4")){
						lista.remove(Integer.parseInt(request.getParameter("id")));
						session.setAttribute("colores",lista);
					}
				 }	
			 }
		 }
	}	 
	boolean enable = model.isEnable((List) session.getAttribute("seleccionados"),19);
	String state = enable?"":"disabled";
	java.util.List colores = model.listadoColores(); %>
	<input type="hidden" id="ncolor" value="<%=lista.size()%>" /> <%
	for (int i = 0; i < lista.size(); i++) {
		Radicacion_Color rc = (Radicacion_Color) lista.get(i);%>
	  <tr>
	    <td>
			<input name="tcodigo<%=i%>" type="text" id="tcodigo<%=i%>" onblur="verInput(this,'color<%=i%>',<%=i%>)" value="<%=rc.getFk_color()!=0?rc.getFk_color():""%>" style="width:40px; color:#333333; font-family:Arial, Helvetica, sans-serif; text-align:center; font-size:12px" <%=state%>/>		</td>
		<td><input name="tcolor<%=i%>" type="text" id="tcolor<%=i%>" onclick="verC(this,<%=i%>)" readonly="true" style="width:250px;color:#333333; font-size:12px; font-family:Arial, Helvetica, sans-serif; text-transform:uppercase" value="<%=rc.getFk_color()!=0?((Color)model.getColor(rc.getFk_color())).getNombre():""%>" <%=state%>/>
			<select name="color<%=i%>" id="color<%=i%>" style="display:none; width:250px" onchange="aplicarC(this,<%=i%>)" <%=state%>>
			<% for (int j = 0; j < colores.size(); j++) { 
				  Color color = (Color)colores.get(j);
				 if(color.getId_color()==rc.getFk_color()){%>
					<option value="<%=color.getId_color()%>" selected="selected"><%=color.getNombre()%></option>
		  <%     }else{ %>
					<option value="<%=color.getId_color()%>"><%=color.getNombre()%></option>
		  <%	 } 
			  } %>
			</select>		</td>
		<td>
		 <input name="tgama<%=i%>" type="text" id="tgama<%=i%>" value="<%=(rc.getGama()!=null?rc.getGama():"")%>" style="width:200px;color:#333333; font-size:12px; font-family:Arial, Helvetica, sans-serif" onblur="aplicarG(this,<%=i%>)" <%=state%>/>		</td>
		<td>
			<input name="tsecuencia<%=i%>" type="text" id="tsecuencia<%=i%>" value="<%=i+1%>" style="width:30px;color:#333333; font-size:12px; font-family:Arial, Helvetica, sans-serif; text-align:center" readonly="true" <%=state%>/>		</td>
		<td align="center">
		<% if(enable){ %>
            	<label id="delete" onclick="eliminar(<%=i%>)"><img src="../html/images/cortar.gif" width="21" height="21"/></label>
			<% }else{ %>
				<label id="delete"><img src="../html/images/cortar.gif" width="21" height="21"/></label>
	  <% } %>	  </tr>
      <% } %>
</table>
</body>
</html>
