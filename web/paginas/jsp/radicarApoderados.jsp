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
	function verT(tipo){
		tipo.style.display = 'none';
		document.getElementById('tipo').style.display = 'block';
	}
	function aplicarT(tipo){
		document.getElementById('ttipo').value = document.getElementById('tipoN').value;
		tipo.style.display = 'none';
		document.getElementById('ttipo').style.display = 'block';
		consultaPersona(document.getElementById('tdocumento'));
	}
	function eliminar(){
		prop = document.getElementById("prop").value;
		document.location.href = "radicarApoderados.jsp?tipo=3&propietario="+prop;
	}
	function consultaPersona(campoP){
		if(!isNaN(campoP.value)&&campoP.value.length>0){
			var tipo = document.getElementById("tipo") ;
			var tipoDoc = tipo.options[tipo.options.selectedIndex].value
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
						document.getElementById("tnombre").value = "";
						viewPersona(tipoDoc,campoP.value);
					}else{
						consultaCartera(ajax.responseText,tipoDoc,campoP.value);
					}        
				}
			}
			ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
        	ajax.send("documento="+campoP.value+"&tipo="+tipoDoc); 
		}else{
			var prop = document.getElementById("prop").value;
			document.location.href = "radicarApoderados.jsp?tipo=3&propietario="+prop;
		}
	}
	
	function consultaCartera(nombre,dato3,dato4){
	    var prop = document.getElementById("prop").value;
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
					document.getElementById("tnombre").value = nombre;
					document.location.href = "radicarApoderados.jsp?tipo=2&tipod="+dato3+"&documento="+dato4+"&propietario="+prop;
				}else{
					alert("La persona "+nombre+" posee multas por valor de "+parseInt(respuesta));
					document.getElementById("tnombre").value = "";
					document.location.href = "radicarApoderados.jsp?tipo=3&propietario="+prop;
				}        
			}
		}
		ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		ajax2.send("documento="+dato4+"&tipo="+dato3); 
	}
	
	function salir(){
		document.location.href = "radicarPropietarios.jsp";
	}
</script>
</head>
<body>
<fieldset>
<table width="70%" border="0" align="center">
	<tr>
    <th scope="col" colspan="4">&nbsp;</th>
  </tr>
   <tr >
   	<input type="hidden" id="prop" value="<%=request.getParameter("propietario")%>" />

 <% Model model =(Model)session.getAttribute("model");
 	Persona propietario = model.consultarPersona(Long.parseLong(request.getParameter("propietario"))); 
	String name = propietario.getTipo_documento()==2?propietario.getNombre_1():propietario.getNombre_1()+" "+propietario.getApellido_1(); %>
    <th scope="col" colspan="4"><font color="#0066CC" style="font-size:11px">APODERADO DE&nbsp;<%=name%></font></th>
  </tr>
  <tr style="background:url(../html/images/inicio_3.png)">
    <th width="30%" scope="col"><span style="color: #FFFFFF"><font style="font-size:11px">TIPO&nbsp;DE&nbsp;DOCUMENTO</font></span></th>
    <th width="15%" scope="col"><span style="color: #FFFFFF"><font style="font-size:11px">DOCUMENTO</font></span></th>
	<th width="55%" scope="col"><span style="color: #FFFFFF"><font style="font-size:11px">NOMBRE DEL PROPIETARIO</font></span></th>
  </tr>
 <%  Radicacion_Apoderado apoderado =(Radicacion_Apoderado)session.getAttribute("apoderados"+propietario.getId_persona());
  	 if(apoderado==null){
	 	apoderado = new Radicacion_Apoderado();
	 }
	 if(request.getParameter("tipo")!=null){
		 if(request.getParameter("tipo").equals("1")){
			session.setAttribute("apoderados"+propietario.getId_persona(),apoderado);
		 }else{	
			 if(request.getParameter("tipo").equals("2")){
				Persona persona = model.consultarPersona(Integer.parseInt(request.getParameter("tipod")),request.getParameter("documento"));
				if(apoderado.getFk_apoderado()!=persona.getId_persona()){
					apoderado.setFk_apoderado(persona.getId_persona());
					apoderado.setFk_propietario(propietario.getId_persona());
					session.setAttribute("apoderados"+propietario.getId_persona(),apoderado);
				}	
			 }else{
				 if(request.getParameter("tipo").equals("3")){
					apoderado = null;
					session.setAttribute("apoderados"+propietario.getId_persona(),apoderado);
				 }	
			 }
		 }
	}	 
	Persona persona = null;
	if(apoderado!=null)
		persona = model.consultarPersona(apoderado.getFk_apoderado());
	java.util.List tipos = model.listadoParametros(5);
	for(int i=0;i<tipos.size();i++){ 
		Parametro param = (Parametro)tipos.get(i); %>
		<input type="hidden" id="tipoN<%=param.getCodigo()%>" value="<%=param.getNombre()%>" />
<%	}
	java.util.HashMap tipos2 = model.crearHashParametros(5);
	
	boolean enable = model.isEnable((List) session.getAttribute("seleccionados"),1);
	String state = enable?"":"disabled"; %>
	<input type="hidden" id="nprop" value="1" />
	  <tr>
		<td align="center"><input name="ttipo" type="text" id="ttipo" ondblclick="verT(this)" value="<%=tipos2.get((persona!=null?persona.getTipo_documento():1)+"")%>" readonly="true" style="text-align:center; color:#333333; font-family:Arial, Helvetica, sans-serif; width:130px; font-size:11px" <%=state%>/>
		  <select name="tipo" id="tipo" style="display:none; font-size:11px; width:130px" onchange="aplicarT(this)"  <%=state%>>
		<%   for(int j=0;j<tipos.size();j++){ 
				 Parametro param = (Parametro)tipos.get(j);
				 if(param.getCodigo()==(persona!=null?persona.getTipo_documento():1)){ %>
					<option value="<%=param.getCodigo()%>" selected="selected"><%=param.getNombre()%></option>
		  <%     }else{ %>
					<option value="<%=param.getCodigo()%>"><%=param.getNombre()%></option>
		  <%	 } 
			} %>
	    </select>		</td>
		<td align="center"><input name="tdocumento" type="text" id="tdocumento" value="<%=(persona!=null?persona.getDocumento():"")%>" onblur="consultaPersona(this)" style="text-align:center; color:#333333; font-family:Arial, Helvetica, sans-serif; width:100px; font-size:11px" <%=state%>/></td>
		<td align="center">
		<%  if(persona!=null){
				if (persona.getTipo_documento() != 2) {%>
				<input name="tnombre" type="text" id="tnombre" value="<%=persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "") + " " + persona.getNombre_1()%>" readonly="true" style="color:#333333; font-family:Arial, Helvetica, sans-serif; width:250px; font-size:11px"  <%=state%>/>
                    <%} else {%>
                <input name="tnombre" type="text" id="tnombre" value="<%=persona.getNombre_1()%>" readonly="true" style="color:#333333; font-family:Arial, Helvetica, sans-serif; width:250px; font-size:11px"  <%=state%>/>
                   <% } 
		    }else{ %>
				<input name="tnombre" type="text" id="tnombre" value="" readonly="true" style="color:#333333;font-family:Arial, Helvetica, sans-serif; width:250px; font-size:11px"  <%=state%> />
	<%		}
	
	%>		</td>
        </tr>
	    <tr>
			<th scope="col" colspan="4">&nbsp;</th>
		 </tr>
		 <tr>
			<th scope="col" colspan="4"><input type="button" name="salir" id="salir" value="OK" onclick="salir()" /></th>
		 </tr>
</table>
</fieldset>
</body>
</html>