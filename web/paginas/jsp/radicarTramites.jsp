<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" errorPage="" %>
<%@ page import = "modelo.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
        <title>Radicar Tramites</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link title="win2k-cold-1" media="all" href="../html/css/calendar-blue.css" type="text/css " rel="stylesheet" />
<script type="text/javascript" src="../html/scripts/calendar.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
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

    function consultaPersona(){
		tipo = document.getElementById("tipoDocumentos") ;
		documento = document.getElementById("numeroDocumento").value ;
		if(documento.length>0&&!isNaN(documento)){
			tipoDoc = tipo.options[tipo.options.selectedIndex].value
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
						window.open("adicionarPersona.jsp") ;
					}else{
						document.getElementById("nombreRadicador").value = ajax.responseText;
					}        
				}
			}
			ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			ajax.send("documento="+documento+"&tipo="+tipoDoc); 
		}	
	}
	
	function consultaPersonaAlerta(){
		tipo = document.getElementById("tipoDocumentoAlerta") ;
		documento = document.getElementById("numeroDocumentoAlerta").value ;
		if(documento.length>0&&!isNaN(documento)){
			tipoDoc = tipo.options[tipo.options.selectedIndex].value
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
						window.open("adicionarPersona.jsp") ;
					}else{
						document.getElementById("nombreAlerta").value = ajax.responseText;
					}        
				}
			}
			ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			alert("documento="+documento+"&tipo="+tipoDoc);
			ajax.send("documento="+documento+"&tipo="+tipoDoc); 
		}	
	}
	
	function Despues(){
		document.getElementById('datosRadicacion').style.display = 'none';
		document.getElementById('formularioFUN').style.display = 'block';
	}
	
	function newP(){
   		window.frames[0].location.href = "radicarPropietarios.jsp?tipo=1";
    }
	
	function verCodigo(alerta){
		document.getElementById('tipoAlerta').value = alerta.options[alerta.options.selectedIndex].value;
	}
	
	function verAlerta(codigo){
		combo = document.getElementById('alertas');
		for(i=0;i<combo.options.length;i++){
			if(combo.options[i].value == parseInt(codigo.value)){
				combo.options.selectedIndex = i;
				break;
			}
		}
	}
	function verOrganismo(obj,id){
		combo = document.getElementById('organismos2');
		if(id==1){
			document.getElementById('tipoOrganismo').value = combo.options[obj.options.selectedIndex].value;
		}else{
			if(obj.value.length>0&&!isNaN(obj.value)){
				for(i=0;i<combo.options.length;i++){
					if(parseInt(combo.options[i].value) == parseInt(obj.value)){
						document.getElementById('organismos').options.selectedIndex = i;
						break;
					}
				}
			}else{
				document.getElementById('tipoOrganismo').value = combo.options[obj.options.selectedIndex].value;
			}	
		}
	}
</script>
</head>
<%
try {
	Model model = (Model) session.getAttribute("model");
	String placa = request.getParameter("placa").toUpperCase();
	Vehiculo vehiculo = model.consultarVehiculo(placa);
	java.util.List listaPropietarios = new java.util.LinkedList();
    if(vehiculo!=null){
		java.util.List lista = model.crear_Lista_Propietarios(vehiculo.getId_vehiculo());
		for(int i=0;i<lista.size();i++){
			Propietario p = (Propietario)lista.get(i);
			Radicacion_Propietario rp = new Radicacion_Propietario();
			rp.setFk_persona(p.getFk_persona());
			rp.setPorcentaje(p.getPorcentaje());
                        rp.setProIndiviso(p.getProIndiviso());
                        rp.setTipoPropiedad(p.getTipoPropiedad());
			listaPropietarios.add(rp);
		}
	}
	java.util.HashMap hash_especificaciones =  model.listarEspecificacionesVehiculo(vehiculo.getPlaca());
	session.setAttribute("propietarios",listaPropietarios);
	session.setAttribute("especificaciones",hash_especificaciones);
%>
<body background="../html/images/fondo2.png">
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<form name="form" id="form" method="post" action="">
<table width="70%" border="0" align="center" id="datosRadicacion">
  <tr>
    <th colspan="6" scope="col" bgcolor="#0066CC"><label><font size="2" face="Arial, Helvetica, sans-serif" color="#FFFFFF">DATOS RADICACION</font></label></th>
  </tr>
  <tr>
    <th colspan="6" scope="col"><label><font size="3" face="Arial, Helvetica, sans-serif" ><%=placa%></font></label></th>
  </tr>
  <tr>
    <td width="8%">&nbsp;</td>
    <td width="22%">&nbsp;</td>
    <td width="9%">&nbsp;</td>
    <td colspan="3">&nbsp;</td>
  </tr>
  <tr>
    <td><label><font size="2" face="Arial, Helvetica, sans-serif" color="#0066CC"><b>Radicado&nbsp;Por</b></font></label></td>
    <td><select  name="tipoDocumento" id="tipoDocumento">
        <% java.util.List tipoDocumentos = model.listadoParametros(5);
			for (int i = 0; i < tipoDocumentos.size(); i++) {
               Parametro parametro = (Parametro) tipoDocumentos.get(i); %>
			   <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
        <% } %>
         </select>	</td>
    <td><label><font size="2" face="Arial, Helvetica, sans-serif" color="#0066CC"><b>Documento</b></font></label></td>
    <td width="13%"><input name="numeroDocumento" type="text" id="numeroDocumento" onblur="consultaPersona()" size="20"/></td>
    <td width="10%"><label><font size="2" face="Arial, Helvetica, sans-serif" color="#0066CC"><b>Nombre</b></font></label></td>
    <td width="38%"><input name="nombreRadicador" type="text" id="nombreRadicador" size="60" readonly="true"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="3">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="6"><table width="100%" border="0">
      <tr>
        <th width="5%" bgcolor="#0066CC" scope="col"><font color="#FFFFFF">
          <label><font size="2" face="Arial, Helvetica, sans-serif"><b>ID</b></font></label>
        </font></th>
        <th width="50%" bgcolor="#0066CC" scope="col"><font color="#FFFFFF">
          <label><font size="2" face="Arial, Helvetica, sans-serif"><b>Tramite</b></font></label>
        </font></th>
        <th width="15%" bgcolor="#0066CC" scope="col"><font color="#FFFFFF">
          <label><font size="2" face="Arial, Helvetica, sans-serif"><b>FUN</b></font></label>
        </font></th>
        <th width="15%" bgcolor="#0066CC" scope="col"><font color="#FFFFFF">
          <label><font size="2" face="Arial, Helvetica, sans-serif"><b>RUNT</b></font></label>
        </font></th>
        <th width="15%" bgcolor="#0066CC" scope="col"><font color="#FFFFFF">
          <label><font size="2" face="Arial, Helvetica, sans-serif"><b>SIMIT</b></font></label>
        </font></th>
      </tr>
  <% java.util.List listaTramites = (LinkedList) session.getAttribute("seleccionados"); 
  	 for(int i=0;i<listaTramites.size();i++){
            long id_tramite = Integer.parseInt(listaTramites.get(i).toString());
            modelo.Tramite tramite  = model.consultarTramite(id_tramite) ; %>
	  <tr style="color:#333333">
        <td align="center"><label><font size="2" face="Arial, Helvetica, sans-serif"><b><%=tramite.getId_tramite()%></b></font></label></td>
        <td><label><font size="2" face="Arial, Helvetica, sans-serif"><b><%=tramite.getNombre()%></b></font></label></td>
        <td align="center"><input type="text" id="fun<%=tramite.getId_tramite()%>" onblur="" value=""/></td>
        <td align="center"><input type="text" id="runt<%=tramite.getId_tramite()%>" value=""/></td>
        <td align="center"><input type="text" id="simit<%=tramite.getId_tramite()%>" value=""/></td>
      </tr>
	<%  } %>
    </table>	
	</td>
    </tr>
	<tr>
    <th colspan="6" scope="col">&nbsp;</th>
  </tr>
 
</table>



<table width="100%" border="0" id="formularioFUN">
  <tr>
    <td width="100%">
		<table width="100%" border="0">
		  <tr>
			<td width="781" valign="top">
				<table width="775" border="0">
					  <tr>
						<td width="95%" align="center" bgcolor="#0066CC"><label><font size="2" face="Arial, Helvetica, sans-serif" color="#FFFFFF"><b>PROPIETARIOS</b></font></label></td>
						<td width="5%" align="center" bgcolor="#0066CC"><img src="../html/images/adicionar.gif" alt="Nuevo Propietario" width="16" height="16" style="cursor:pointer" onclick="newP()"/></td>
					  </tr>
					  <tr>
						<td colspan="2" valign="top"><iframe src = "radicarPropietarios.jsp" id="prop" marginwidth="0" height="120" width="775" marginheight="0" scrolling="auto" style="border:none"></iframe></td>
					  </tr>
					   <tr>
						 <td colspan="2" align="center">&nbsp;</td>
					   </tr>
					   <tr>
						 <td colspan="2" align="center">
							 <table width="100%" border="0">
							   <tr bgcolor="#0066CC">
								 <th colspan="5" scope="col"><label><font size="2" face="Arial" color="#FFFFFF"><b>DATOS ALERTAS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font></label></th>
							   </tr>
							   <tr>
								 <td width="11%"><label><font size="2" face="Arial, Helvetica, sans-serif" color="#0066CC"><b>Tipoo&nbsp;Alerta</b></font></label></td>
								 <td width="5%"><input name="tipoAlerta" type="text" id="tipoAlerta" size="6" style="color:#333333; text-align:center" onblur="verAlerta(this)"/></td>
								 <td width="21%">
								 <select name="alertas" id="alertas" onchange="verCodigo(this)">
								 <% Alerta alerta = model.consultarAlerta(vehiculo.getId_vehiculo());
									java.util.List alertas = model.listadoParametros(4);	
									for (int i = 0; i < alertas.size(); i++) {
										Parametro parametro = (Parametro) alertas.get(i);
										if (alerta != null) {
											if (parametro.getCodigo() == alerta.getTipo()) {%>
												<option value="<%=parametro.getCodigo()%>" selected><%=parametro.getNombre()%></option>	
												<script language="javascript" type="text/javascript">document.getElementById('tipoAlerta').value = <%=parametro.getCodigo()%>; </script>
										<%	} else {%>
												<option value="<%=parametro.getCodigo()%>"><%=parametro.getNombre()%></option>	
										<%	}
										} else {%>
											<option value="<%=parametro.getCodigo()%>" ><%=parametro.getNombre()%> </option>	
									<%	}
									}%>
								 </select></td>
								 <td width="15%"><label><font size="2" face="Arial, Helvetica, sans-serif" color="#0066CC"><b>Observacion</b></font></label></td>
								 <td width="48%"><input name="observacionAlerta" type="text" id="observacionAlerta" size="60"/></td>
							   </tr>
							   <tr>
								<td colspan="5">
									<table width="100%" border="0">
									  <tr>
										<td width="11%"><label><font size="2" face="Arial, Helvetica, sans-serif" color="#0066CC"><b>A&nbsp;Favor&nbsp;de</b></font></label></td>
											<td width="28%">
											<select  name="tipoDocumentoAlerta" id="tipoDocumentoAlerta">
												<% tipoDocumentos = model.listadoParametros(5);
													for (int i = 0; i < tipoDocumentos.size(); i++) {
													   Parametro parametro = (Parametro) tipoDocumentos.get(i); %>
													   <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
												<% } %>
										</select>	</td>
										<td width="14%"><input name="numeroDocumentoAlerta" type="text" id="numeroDocumentoAlerta" onblur="consultaPersonaAlerta()" size="17" style="text-align:center; color:#333333"/></td>
										<td width="7%"><label><font size="2" face="Arial, Helvetica, sans-serif" color="#0066CC"><b>Nombre</b></font></label></td>
										<td width="40%"><input name="nombreAlerta" type="text" id="nombreAlerta" size="50" readonly="true"/></td>
									  </tr>
									</table>								 </td>
					   		   </tr>
						 	</table>						 </td>
					   </tr>
					   
					   
					    <tr>
						 <td colspan="2" align="center">
							 <table width="100%" border="0">
							   <tr>
							    	<td colspan="5">&nbsp;</td>
							   </tr>
							   <tr bgcolor="#0066CC">
								 <th colspan="5" scope="col"><label><font size="2" face="Arial" color="#FFFFFF"><b>DATOS ORGANISMO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font></label></th>
							   </tr>
							   <tr>
								 <td width="13%"><label><font size="2" face="Arial, Helvetica, sans-serif" color="#0066CC"><b>Organismo</b></font></label></td>
								 <td width="13%"><input name="tipoOrganismo" type="text" id="tipoOrganismo" size="15" style="color:#333333; text-align:center" onblur="verOrganismo(this,2)"/></td>
								 <td width="31%">
								  <select name="organismos2" id="organismos2" style="display:none">
								 <%	java.util.List organismos = model.consultarSedes();
									 for (int i = 0; i < organismos.size(); i++) {
										Sede sede = (Sede) organismos.get(i);%>
										<option value="<%=sede.getCodigo()%>"></option>
								 <%	 } %>
								 </select>
								 <select name="organismos" id="organismos" onchange="verOrganismo(this,1)">
									 <%  
									 for (int i = 0; i < organismos.size(); i++) {
											Sede sede = (Sede) organismos.get(i);
											if(vehiculo!=null){
												if(vehiculo.getFk_sede()==sede.getId_sede()){ %>
														<option value="<%=sede.getId_sede()%>" selected> <%=sede.getNombre_corto()%> </option>
														<script language="javascript" type="text/javascript">document.getElementById('tipoOrganismo').value = <%=sede.getCodigo()%>; </script>
											 <%   }else{ %>
														<option value="<%=sede.getId_sede()%>"> <%=sede.getNombre_corto()%> </option>
											  <%  }
											}else{ %>
													<option value="<%=sede.getId_sede()%>"> <%=sede.getNombre_corto()%> </option>
										  <%  }
									}  %>
                                 </select>								</td>
								 <td width="20%"><label><font size="2" face="Arial, Helvetica, sans-serif" color="#0066CC"><b>Numero&nbsp;Licencia</b></font></label></td>
								 <td width="23%"><input name="numeroLicencia" type="text" id="numeroLicencia" size="20"/></td>
							   </tr>
						 	</table>						 </td>
					   </tr>
					   
					   <tr>
						 <td colspan="2" align="center">
							 <table width="100%" border="0">
							 	<tr>
							    	<td colspan="7">&nbsp;</td>
							   </tr>
							   <tr bgcolor="#0066CC">
								 <th colspan="7" scope="col"><label><font size="2" face="Arial" color="#FFFFFF"><b>DATOS ASEGURADORA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font></label></th>
							   </tr>
							   <tr>
								 <td width="11%"><label><font size="2" face="Arial, Helvetica, sans-serif" color="#0066CC"><b>Aseguradora</b></font></label></td>
								 <td width="37%">
								 <select name="comboAseguradora" id="comboAseguradora">
                                  <%	java.util.List aseguradoras = model.listaAseguradoras();
										for (int i = 0; i < aseguradoras.size(); i++) {
											Aseguradora aseguradora = (Aseguradora) aseguradoras.get(i);
											Persona persona = model.consultarPersona(aseguradora.getFk_persona());%>
                                            <option value="<%=aseguradora.getId_aseguradora()%>"> <%=persona.getNombre_1() + " " + persona.getApellido_1()%> </option>
                                     <%	} %>
                                 </select>								</td>
								<td width="8%"><label><font size="2" face="Arial" color="#0066CC"><b>Poliza</b></font></label></td>
								<td width="18%"><input name="poliza" type="text" id="poliza" size="20" style="text-align:center; font-family:Arial, Helvetica, sans-serif; color:#333333"/></td>
								<td width="8%"><label><font size="2" face="Arial" color="#0066CC"><b>Vence</b></font></label></td>
								<td width="13%"><input name="vence" type="text" id="vence" size="15" readonly="true"/></td>
								<td width="5%"><input name="fechavence" type="button" id="fechavence" value="<<" style="text-align:center; font-family:Arial, Helvetica, sans-serif; color:#333333"/></td>
											  <script type="text/javascript">
													Calendar.setup({
														inputField     :    "vence",      // id del campo de texto
														ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
														button         :    "fechavence"   // el id del bot?n que lanzar? el calendario
													});
												</script>
							   </tr>
						 	</table>						 </td>
					   </tr>
				</table>			</td>
			<td width="275" valign="top"><iframe src = "radicarEspecificaciones.jsp" id="espc" marginwidth="0" height="400" width="275" marginheight="0" scrolling="auto" style="border:none"></iframe></td>
			<td width="68">&nbsp;</td>
			<td width="68">&nbsp;</td>
		  </tr>
		</table>
	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</form>
</body>
<%  }catch(Exception exc){
        exc.printStackTrace();
    }    %>
</html>
