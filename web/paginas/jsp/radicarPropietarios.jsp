
<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Documento sin t&iacute;tulo</title>
<script src="../html/scripts/personas.js" type="text/javascript"></script>
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
	function verT(tipo,i){
		tipo.style.display = 'none';
		document.getElementById('tipo'+i).style.display = 'block';
	}
	function aplicarT(tipo,i){
		document.getElementById('ttipo'+i).value = document.getElementById('tipoN'+tipo.value).value;
		tipo.style.display = 'none';
		document.getElementById('ttipo'+i).style.display = 'block';
		consultaPersona(document.getElementById('tdocumento'+i),i);
	}
	function verP(tipo,i){
		tipo.style.display = 'none';
		document.getElementById('tipopropiedad'+i).style.display = 'block';
	}
	function aplicarP(tipo,i){
		document.getElementById('ttipopropiedad'+i).value = document.getElementById('tipoP'+tipo.value).value;
		tipo.style.display = 'none';
		document.getElementById('ttipopropiedad'+i).style.display = 'block';
		document.location.href = "radicarPropietarios.jsp?tipo=5&tipopropiedad="+document.getElementById('tipopropiedad'+i).value+"&id="+i;
	}
	function verI(tipo,i){
		tipo.style.display = 'none';
		document.getElementById('indivisos'+i).style.display = 'block';
	}
	function aplicarI(tipo,i){
		document.getElementById('tindivisos'+i).value = document.getElementById('tipoI'+tipo.value).value;
		tipo.style.display = 'none';
		document.getElementById('tindivisos'+i).style.display = 'block';
		document.location.href = "radicarPropietarios.jsp?tipo=6&proindiviso="+document.getElementById('indivisos'+i).value+"&id="+i;
	}
	function eliminar(i){
		document.location.href = "radicarPropietarios.jsp?tipo=4&id="+i;
	}
	function consultaPersona(campoP,id){
		//if(!isNaN(campoP.value)&&campoP.value.length>0){
		if(campoP.value.length>0){
			tipo = document.getElementById("tipo"+id) ;
			tipoDoc = tipo.options[tipo.options.selectedIndex].value;
			ajax=nuevoAjax();
			ajax.open("POST", "getPersona.jsp",true);
			ajax.onreadystatechange=function() {
				if (ajax.readyState==4) {
					var respuesta = "" ;
					for(var i = 0; i < ajax.responseText.length ; i++){
						if(isNaN(ajax.responseText.charAt(i)))
							respuesta += ajax.responseText.charAt(i);
					}
					if(respuesta == "nueva"){
						document.getElementById("tnombre"+id).value = "";
						document.getElementById("tporcentaje"+id).disabled = true;
						document.getElementById("add"+id).disabled = true;
						viewPersona(tipoDoc,campoP.value);
					}else{
						consultaCartera(id,ajax.responseText,tipoDoc,campoP.value);
					}        
				}
			}
			ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
        	ajax.send("documento="+campoP.value+"&tipo="+tipoDoc); 
		}
	}
	
	function consultaCartera(id,nombre,dato3,dato4){
		ajax2=nuevoAjax();
		ajax2.open("POST", "verificarPersona.jsp",true);
		ajax2.onreadystatechange=function() {
			if (ajax2.readyState==4) {
				var respuesta = "";
				for(var i = 0; i < ajax2.responseText.length ; i++){
					if(!isNaN(ajax2.responseText.charAt(i))||ajax2.responseText.charAt(i)=='.')
						respuesta += ajax2.responseText.charAt(i);
				}
				if(parseInt(respuesta) == 0){
					document.getElementById("tnombre"+id).value = nombre;
					document.getElementById("tporcentaje"+id).disabled = false;
					document.location.href = "radicarPropietarios.jsp?tipo=2&tipod="+dato3+"&documento="+dato4+"&id="+id;
				}else{
					alert("La persona "+nombre+" posee multas por valor de "+parseInt(respuesta));
					document.getElementById("tnombre"+id).value = "";
					document.getElementById("tporcentaje"+id).disabled = false;
					document.getElementById("add"+id).disabled = false;
				}        
			}
		}
		ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		ajax2.send("documento="+dato4+"&tipo="+dato3); 
	}
	
	function validarP(campoP,id){
		if(isNaN(campoP.value)){
			campoP.value = "100";
		}
		document.location.href = "radicarPropietarios.jsp?tipo=3&porcentaje="+campoP.value+"&id="+id;
	}
	
	function addApoderado(prop){
		if(prop>0)
		document.location.href = "radicarApoderados.jsp?tipo=1&propietario="+prop;
	}
	
</script>
</head>
<body>
<table width="100%" border="0" align="center">
  <tr style="background:url(../html/images/inicio_3.png)">
    <th width="18%" scope="col"><span style="color: #FFFFFF"><font style="font-size:11px">TIPO&nbsp;DE&nbsp;DOCUMENTO</font></span></th>
    <th width="13%" scope="col"><span style="color: #FFFFFF"><font style="font-size:11px">DOCUMENTO</font></span></th>
	<th width="33%" scope="col"><span style="color: #FFFFFF"><font style="font-size:11px">NOMBRE DEL PROPIETARIO</font></span></th>
	<th width="17%" scope="col"><span style="color: #FFFFFF"><font style="font-size:11px">TIPO PROP.</font></span></th>
	<th width="4%" scope="col"><span style="color: #FFFFFF"><font style="font-size:11px">PI</font></span></th>
	<th width="4%" scope="col"><span style="color: #FFFFFF"><font style="font-size:11px">%</font></span></th>
	<th width="6%" scope="col"><span style="color: #FFFFFF"><font style="font-size:11px">A</font></span></th>
	<th width="5%" scope="col"><span style="color: #FFFFFF"><font style="font-size:11px">X</font></span></th>
  </tr>
  <% java.util.List lista =(java.util.List)session.getAttribute("propietarios");
  	  Model model =(Model)session.getAttribute("model");
	if(lista==null){
	 	lista = new java.util.LinkedList();
	 }
	 if(request.getParameter("tipo")!=null){
		 if(request.getParameter("tipo").equals("1")){
			Radicacion_Propietario new_propietario = new Radicacion_Propietario();
			new_propietario.setPorcentaje(100);
                        new_propietario.setTipoPropiedad(request.getParameter("tipopropiedad"));
                        new_propietario.setProIndiviso(request.getParameter("proindiviso"));
			lista.add(new_propietario);
			session.setAttribute("propietarios",lista);
		 }else{	
			 if(request.getParameter("tipo").equals("2")){
				Radicacion_Propietario new_propietario = (Radicacion_Propietario)lista.get(Integer.parseInt(request.getParameter("id")));
				Persona persona = model.consultarPersona(Integer.parseInt(request.getParameter("tipod")),request.getParameter("documento"));
				boolean exits = false;
				for(int v=0;v<lista.size();v++){
					Radicacion_Propietario rp = (Radicacion_Propietario)lista.get(v);
					if(rp.getFk_persona()==persona.getId_persona()){
						exits = true;
						break;
					}
				}
				if(!exits){
					new_propietario.setFk_persona(persona.getId_persona());
					lista.set(Integer.parseInt(request.getParameter("id")),new_propietario);
					session.setAttribute("propietarios",lista);
				}	
			 }else{
				 if(request.getParameter("tipo").equals("3")){
					Radicacion_Propietario new_propietario = (Radicacion_Propietario)lista.get(Integer.parseInt(request.getParameter("id")));
					try{
						new_propietario.setPorcentaje(Integer.parseInt(request.getParameter("porcentaje").replaceAll("[.]",",")));
					}catch(Exception nm){
						nm.printStackTrace();
						new_propietario.setPorcentaje(0);
					}
					lista.set(Integer.parseInt(request.getParameter("id")),new_propietario);
					int sumap = 0;
					for(int v=0;v<lista.size();v++){
						Radicacion_Propietario rp = (Radicacion_Propietario)lista.get(v);
						sumap += rp.getPorcentaje();
					}
					if(sumap>100){
						new_propietario.setPorcentaje(new_propietario.getPorcentaje()-(sumap-100));
						lista.set(Integer.parseInt(request.getParameter("id")),new_propietario);
					}
					session.setAttribute("propietarios",lista);
				 }else{
					if(request.getParameter("tipo").equals("4")){
						lista.remove(Integer.parseInt(request.getParameter("id")));
						session.setAttribute("propietarios",lista);
					}else{
						if(request.getParameter("tipo").equals("5")){
							Radicacion_Propietario new_propietario = (Radicacion_Propietario)lista.get(Integer.parseInt(request.getParameter("id")));
							new_propietario.setTipoPropiedad(request.getParameter("tipopropiedad"));
							lista.set(Integer.parseInt(request.getParameter("id")),new_propietario);
							session.setAttribute("propietarios",lista);
						}else{
							if(request.getParameter("tipo").equals("6")){
								Radicacion_Propietario new_propietario = (Radicacion_Propietario)lista.get(Integer.parseInt(request.getParameter("id")));
								new_propietario.setProIndiviso(request.getParameter("proindiviso"));
								lista.set(Integer.parseInt(request.getParameter("id")),new_propietario);
								session.setAttribute("propietarios",lista);
							}
						}
					}
				 }	
			 }
		 }
	}	 
	java.util.List tipos = model.listadoParametros(5);
	for(int i=0;i<tipos.size();i++){ 
		Parametro param = (Parametro)tipos.get(i); %>
		<input type="hidden" id="tipoN<%=param.getCodigo()%>" value="<%=param.getNombre()%>" />
<%	}
	java.util.HashMap tipos2 = model.crearHashParametros(5);
	
	java.util.List tipospropiedades = model.listadoParametros(327);
	for(int i=0;i<tipospropiedades.size();i++){ 
		Parametro param = (Parametro)tipospropiedades.get(i); %>
		<input type="hidden" id="tipoP<%=param.getCodigo()%>" value="<%=param.getNombre()%>" />
<%	}
	java.util.HashMap tipospropiedades2 = model.crearHashParametros(327); %>
		<input type="hidden" id="tipoI1" value="S" />
		<input type="hidden" id="tipoI2" value="N" />
<%	boolean enable = model.isEnable((List) session.getAttribute("seleccionados"),1);
	String state = enable?"":"disabled"; %>
	<input type="hidden" id="nprop" value="<%=lista.size()%>" />
	 <%
	 int sumap = 0;
	for(int i=0;i<lista.size();i++){
		Radicacion_Propietario propietario = (Radicacion_Propietario)lista.get(i);
		Persona persona = model.consultarPersona(propietario.getFk_persona()); 
		sumap += (int)propietario.getPorcentaje(); %>
	  <tr>
		<td align="center"><input name="ttipo<%=i%>" type="text" id="ttipo<%=i%>" ondblclick="verT(this,<%=i%>)" value="<%=tipos2.get((persona!=null?persona.getTipo_documento():1)+"")%>" readonly="true" style="text-align:center; color:#333333; font-family:Arial, Helvetica, sans-serif; width:130px; font-size:11px" <%=state%>/>
		  <select name="tipo<%=i%>" id="tipo<%=i%>" style="display:none; font-size:11px; width:130px" onchange="aplicarT(this,<%=i%>)"  <%=state%>>
			<%   for(int j=0;j<tipos.size();j++){ 
					 Parametro param = (Parametro)tipos.get(j);
					 if(param.getCodigo()==(persona!=null?persona.getTipo_documento():1)){ %>
						<option value="<%=param.getCodigo()%>" selected="selected"><%=param.getNombre()%></option>
			  <%     }else{ %>
						<option value="<%=param.getCodigo()%>"><%=param.getNombre()%></option>
			  <%	 } 
				} %>
	    </select>		</td>
		<td align="center"><input name="tdocumento<%=i%>" type="text" id="tdocumento<%=i%>" value="<%=(persona!=null?persona.getDocumento():"")%>" onblur="consultaPersona(this,<%=i%>)" style="text-align:center; color:#333333; font-family:Arial, Helvetica, sans-serif; width:100px; font-size:11px" <%=state%>/></td>
		<td align="center">
			<%  if(persona!=null){%>
				<input name="tnombre<%=i%>" type="text" id="tnombre<%=i%>" value="<%=persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "") + " " + persona.getNombre_1()%>" readonly="true" style="color:#333333; font-family:Arial, Helvetica, sans-serif; width:250px; font-size:11px"  <%=state%>/>
                            <%}else{ %>
				<input name="tnombre<%=i%>" type="text" id="tnombre<%=i%>" value="" readonly="true" style="color:#333333;font-family:Arial, Helvetica, sans-serif; width:250px; font-size:11px"  <%=state%>/>
            <%		}
	
	%>		</td>
	
	<td align="center">    
		
         <input name="ttipopropiedad<%=i%>" type="text" id="ttipopropiedad<%=i%>" ondblclick="verP(this,<%=i%>)" value="<%=tipospropiedades2.get((propietario.getTipoPropiedad()!=null?propietario.getTipoPropiedad():"1")+"")%>" readonly="true" style="text-align:center; color:#333333; font-family:Arial, Helvetica, sans-serif; width:130px; font-size:11px" <%=state%>/>
			<select name="tipopropiedad<%=i%>" id="tipopropiedad<%=i%>" style="display:none; font-size:11px; width:130px" onchange="aplicarP(this,<%=i%>)"  <%=state%>>
			<%   for(int j=0;j<tipospropiedades.size();j++){ 
					 Parametro param = (Parametro)tipospropiedades.get(j);
					 if((param.getCodigo()+"").equals(propietario.getTipoPropiedad()!=null?propietario.getTipoPropiedad():"1")){ %>
						<option value="<%=param.getCodigo()%>" selected="selected"><%=param.getNombre()%></option>
			  <%     }else{ %>
						<option value="<%=param.getCodigo()%>"><%=param.getNombre()%></option>
			  <%	 } 
				} %>
			</select>			</td>
			
			<td align="center">    
		
                            <input name="tindivisos<%=i%>" type="text" id="tindivisos<%=i%>" ondblclick="verI(this,<%=i%>)" value="<%=propietario.getProIndiviso()!=null?propietario.getProIndiviso():"N"%>" readonly="true" style="text-align:center; color:#333333; font-family:Arial;width:30px; font-size:11px" <%=state%>/>
			<select name="indivisos<%=i%>" id="indivisos<%=i%>" style="display:none; width:30px; font-size:11px" onchange="aplicarI(this,<%=i%>)" <%=state%>>
			<% if(propietario.getProIndiviso()!=null){
					if(propietario.getProIndiviso().equals("S")){ %>
						<option value="S" selected="selected">S</option>
						<option value="N">N</option>
				<%  }else{		%>
						<option value="S">S</option>
						<option value="N" selected="selected">N</option>
				<%  }		
				}else{ %>
						<option value="S">S</option>
						<option value="N" selected="selected">N</option>
			<%  }  %>	
			</select>			</td>
		<td align="center"><input name="tporcentaje<%=i%>" type="text" id="tporcentaje<%=i%>" value="<%=(int)propietario.getPorcentaje()%>" onblur="validarP(this,<%=i%>)" style="text-align:center; color:#333333; font-family:Arial, Helvetica, sans-serif; width:30px; font-size:11px"  <%=state%>/></td>
		<td align="center">
		<input type="button" name="add<%=i%>" id="add<%=i%>" value="+" style="font-size:18px; height:20px; text-align:center; cursor:pointer; width:15px; vertical-align:middle" onclick="addApoderado(<%=propietario.getFk_persona()%>)"/>
</td>
		<td align="center">
			<% if(enable){ %>
            	<label id="delete" onclick="eliminar(<%=i%>)"><img src="../html/images/cortar.gif" width="17" height="17"/></label>
			<% }else{ %>
				<label id="delete"><img src="../html/images/cortar.gif" width="17" height="17"/></label>
			<% } %>		</td>
	  </tr>
      <% } 
	  %>
	  <input type="hidden" id="sumap" value="<%=sumap%>" />
</table>
</body>
</html>
<label id="add">