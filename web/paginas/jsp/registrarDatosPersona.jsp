<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarPersona.jsp")){
                    Model model= (Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Registrar Persona</title>
	<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <script src="../html/scripts/personas.js" type="text/javascript"></script>
 <script language="javascript" type="text/javascript">
 	function validarDocumento(documento){
    	if(documento.value==""){
       		alert("El campo Documento no puede estar vacio");
	       return false;
     	}else return true;
    }

   
    function validarPrimerNombre(primer_nombre){
    	if(primer_nombre.value==""){
       		alert("El campo Primer Nombre no puede estar vacio");
       		return false;
    	}else return true;
   	}

    function validarPrimerApellido(primer_apellido){
    	if(primer_apellido.value==""){
       		alert("El campo Primer Apellido no puede estar vacio");
       		return false;
     	}else return true;
    }

    function validar_Sdo_Nombre(segundo_nombre){
       if((!isNaN(segundo_nombre.value))&& (segundo_nombre.value!="")){
           alert("El Segundo Nombre No es Correcto !");
           return false;
       }else return true;
   }

    function validar_celular(celular){
       if(isNaN(celular.value)){
           alert("El Numero Celular No es Correcto");
           return false;
       }else return true;
   }

   function validar_Sdo_Apellido(segundo_apellido){
       if((!isNaN(segundo_apellido.value))&& (segundo_apellido.value!="")){
           alert("El Segundo Apellido No es Correcto");
           return false;
       }else return true;
   }

   function validarTelefono(telefono){
       if(isNaN(telefono.value)){
          alert("El Numero de Telefono No es Correcto");
          return false;
       }else return true;
   }

   function validarDireccion(direccion){
       if(isNaN(direccion.value)){
          alert("El Campo direccion No es Correcto");
          return false;
       }else return true;
   }

   function validarFormulario(form){
	with(form){
		  if(validarDocumento(documento)==false){
			   documento.focus();
			 return false;
			}
		
		   if(validarPrimerNombre(primer_nombre)==false){
			 primer_nombre.focus();
			 return false;
		   }
	
		   if(validarPrimerApellido(primer_apellido)==false){
			 primer_apellido.focus();
			 return false;
		   }
			if(validar_Sdo_Nombre(segundo_nombre)==false){
			 segundo_nombre.focus();
			 return false;
		   }
		   if(validar_Sdo_Apellido(segundo_apellido)== false){
			  segundo_apellido.focus();
			 return false;
			 }
		   if(validarTelefono(telefono)==false){
			 telefono.focus();
			 return false;
		   }
		   if(validar_celular(celular)== false){
			  celular.focus();
			 return false;
		   }
                   if(validarDireccion(direccion)== false){
			  direccion.focus();
			 return false;
		   }
		   return true;
	   }
	
	}

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

	function buscarMunicipios(){
		tabla = document.getElementById('municipios');
		document.getElementById('municipio').style.display = 'none';
		valor=document.form.departamentos.options[document.form.departamentos.selectedIndex].value;
		ajax=nuevoAjax();
		ajax.open("POST", "cargarMunicipios.jsp",true);
		ajax.onreadystatechange=function() {
			if (ajax.readyState==4) {
				tabla.innerHTML = ajax.responseText
			}
		}
		ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		ajax.send("fk_dpto="+valor)

	}

	function buscarDirMunicipios(){
		tabla = document.getElementById('dir_municipios');

		valor=document.form.dir_departamento.options[document.form.dir_departamento.selectedIndex].value;
		ajax=nuevoAjax();
		ajax.open("POST", "cargarMunic_dir.jsp",true);
		ajax.onreadystatechange=function() {
			if (ajax.readyState==4) {
				tabla.innerHTML = ajax.responseText;
				document.form.direccion.disabled = false;
				document.form.telefono.disabled = false;
			}
		}
		ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		ajax.send("fk_dpto="+valor)

	}

	function buscarMunicNacim(){
		tabla = document.getElementById('munici_nacim');
		document.getElementById('municipio_nacim').style.display = 'none';
		valor=document.form.depar_nacim.options[document.form.depar_nacim.selectedIndex].value;
		ajax=nuevoAjax();
		ajax.open("POST", "cargarMunic_nacim.jsp",true);
		ajax.onreadystatechange=function() {
			if (ajax.readyState==4) {
				tabla.innerHTML = ajax.responseText;
			}
		}
		ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		ajax.send("fk_dpto="+valor)

	}

	function Biometria()
	{
		var obj
		var rta = ""
		var ID = document.form.documento.value;

		var TIPO = "CC";
		if(document.form.tipo.value==3)
			TIPO = "CE";
		if(document.form.tipo.value==4)
			TIPO = "TI";
		if(document.form.tipo.value==5)
			TIPO = "PP";

		var N1 = document.form.primer_nombre.value;
		var N2 = document.form.segundo_nombre.value;
		var A1 = document.form.primer_apellido.value;
		var A2 = document.form.segundo_apellido.value;
		var FECHA = document.form.date.value;
		var SEXO = document.form.sexo.value;
		var bc = document.getElementById("bcedula").checked?1:0;
		var bh = document.getElementById("bhuella").checked?1:0;
		var br = document.getElementById("bfirma").checked?1:0;
		var bf = document.getElementById("bfoto").checked?1:0;

		obj = new ActiveXObject("Identica_Runt.Bio_Main")
		rta = obj.Enrolar(ID,TIPO,N1,N2,A1,A2,FECHA,SEXO,bc,br,bf,bh);
		if(rta.indexOf("<>"+ID+"<><>"+TIPO+"<><>1<><>")!=-1){
			//	rta = obj.Autenticar_Ciudadano(obj.RTemplate,ID,TIPO);
		   document.form.biometric.value = "1";
		   document.form.template.value = obj.RTemplate;
		   document.form.huella1.value = obj.Huella1;
		   document.form.huella2.value = obj.Huella2;
		   document.form.bidimensional.value = obj.BC2D;
		   document.form.dedo1.value = obj.N_DEDO1;
		   document.form.dedo2.value = obj.N_DEDO2;
		   document.form.foto.value = obj.FOTO;
		   document.form.firma.value = obj.FIRMA;
		   alert("OK. Datos biometricos capturad");
		}else{
			document.form.biometric.value = "0";
			document.form.excepcion.value = obj.R_Excepcion;
			alert(obj.R_Excepcion);
		}
	}

	function evaluar(form){
		return validarFormulario(form);
	}

	function queryPerson(){
		tabla = document.getElementById('divPersona');
		var doc = document.getElementById("documento2").value;
		var combo = document.getElementById("tipo_documento");
		var type= combo.options[combo.options.selectedIndex].value;
		ajax=nuevoAjax();
		ajax.open("POST", "getPersona.jsp",true);
		ajax.onreadystatechange=function() {
			if (ajax.readyState==4) {
				var respuesta = "" ;
				var response = ajax.responseText;
				for(var i = 0; i < response.length ; i++){
					if(isNaN(response.charAt(i)))
						respuesta += response.charAt(i);
				}
				if(respuesta == "nueva"){
					viewPersona(type,doc);
				}else{
				   tabla.innerHTML = ajax.responseText;
				}
			}
		}
		ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		ajax.send("documento="+doc+"&tipo="+type)
	}

</script>
        <link title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
	<script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
		<style type="text/css">
		<!--
		.Estilo2 {font-size: 14px; color:#CC0000}
		.Estilo4 {color: #333333;font-size: 14px;}
		.Estilo6 {font-size: 14px; color: #0066CC; }
		.Estilo13 {
			font-size: 14px;
			color: #333333;
		}
		.Estilo15 {
	color: #333333;
	font-size: 12px;
}
.style1 {
	font-family: Tahoma;
	color: #333333;
}
.style2 {font-family: Tahoma}
.style3 {color: #333333; font-size: 12px; font-weight: bold; font-family: Tahoma; }
.Estilo26 {color: #333333; font-size: 11px; font-weight: bold; font-family: Tahoma; }
.Estilo27 {font-size: 11px}
.Estilo28 {font-weight: bold; font-family: Tahoma; color: #333333;}
.Estilo31 {color: #333333}
.Estilo33 {color: #FFFFFF}
		-->
		</style>
</head>

<% try{
       if(model!=null) {
            String tipoDocumento = request.getParameter("tipo");
            String numeroDocumento = request.getParameter("documento");
            String paisExpedido = "";
            String fechaExpedicion = "";
            String departamentoExpedicion = "";
            String municipioExpedicion = "";
            String primerNombre = "";
            String segundoNombre = "";
            String primerApellido = "";
            String segundoApellido = "";
            String fechaNacimiento = "";
            String departamentoNacimiento = "";
            String municipioNacimiento = "";
            String sexo = "";
            String grupoSanguineo = "";
            String rh = "";
            String celular = "";
            String email = "";
            String departamentoDireccion = "";
            String municipioDireccion = "";
            String direccion = "";
            String telefonoDireccion = "";
            com.heinsohn.runt.general.personas.PersonaNaturalDTO personaNatural = null;
            Persona persona = model.consultarPersona(Integer.parseInt(tipoDocumento), numeroDocumento);
            if(persona!=null){
                paisExpedido = "1";
                if(persona.getFecha_exp()!=null)
                    fechaExpedicion = new java.text.SimpleDateFormat("dd/MM/yyyy").format(persona.getFecha_exp());
                if(persona.getFk_divipo()!=0){
                    Divipo divipo = model.getDivipo(persona.getFk_divipo());
                    if(divipo!=null){
                        departamentoExpedicion = divipo.getFk_departamento()+"";
                        municipioExpedicion = divipo.getFk_municipio()+"";
                    }
                }
                if(persona.getNombre_1()!=null)
                    primerNombre = persona.getNombre_1();
                if(persona.getNombre_2()!=null)
                    segundoNombre = persona.getNombre_2();
                if(persona.getApellido_1()!=null)
                    primerApellido = persona.getApellido_1();
                if(persona.getApellido_2()!=null)
                    segundoApellido = persona.getApellido_2();
                if(persona.getFecha_nac()!=null)
                    fechaNacimiento = new java.text.SimpleDateFormat("dd/MM/yyyy").format(persona.getFecha_nac());
                if(persona.getFk_lugar_nacimiento()!=0){
                    Divipo divipo = model.getDivipo(persona.getFk_lugar_nacimiento());
                    if(divipo!=null){
                        departamentoNacimiento = divipo.getFk_departamento()+"";
                        municipioNacimiento = divipo.getFk_municipio()+"";
                    }
                }
                if(persona.getSexo()!=null)
                    sexo = persona.getSexo();
                if(persona.getGrupo_sanguineo()!=null)
                    grupoSanguineo = persona.getGrupo_sanguineo();
                if(persona.getRh()!=null)
                    rh = persona.getRh();
                if(persona.getCelular()!=null)
                    celular = persona.getCelular();
                if(persona.getEmail()!=null)
                    email = persona.getEmail();

                java.util.List direcciones = model.listado_direcciones_persona(persona.getId_persona());
                if(direcciones.size()>0){
                    Direccion direccionP = (Direccion)direcciones.get(0);
                    if(direccionP!=null){
                        if(direccionP.getFk_divipo()!=0){
                            Divipo divipo = model.getDivipo(direccionP.getFk_divipo());
                            if(divipo!=null){
                                departamentoDireccion = divipo.getFk_departamento()+"";
                                municipioDireccion = divipo.getFk_municipio()+"";
                            }
                        }
                        if(direccionP.getDescripcion()!=null)
                            direccion = direccionP.getDescripcion();
                        if(direccionP.getTelefono()!=null)
                            telefonoDireccion = direccionP.getTelefono();
                     }
                }
            }else{
                webservices.consultas.ServicioConsultaRUNTClient consultasService = new webservices.consultas.ServicioConsultaRUNTClient();
                consultasService.setTokenHuellaDigital(Model.userToken);
                consultasService.setUser(Model.userHandler);
                com.heinsohn.runt.general.consultas.PersonaNaturalOutDTO personaNaturalOut = consultasService.consultarDatosPersonaNatural(tipoDocumento, numeroDocumento);
                if(personaNaturalOut!=null){
                    if(personaNaturalOut.getStatus()!=null){
                          if(personaNaturalOut.getStatus().getStatusCode().equals("1")){
                              javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.PersonaNaturalDTO> jaxbPersonaNatural = personaNaturalOut.getPersonaNatural();
                               personaNatural = jaxbPersonaNatural.getValue();
                               if(personaNatural!=null){
                                   if(personaNatural.getEstadoPersona().equals("ACTIVA")){
                                        javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jaxb_Identificacion = personaNatural.getIdentificacion();
                                        com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacion = jaxb_Identificacion.getValue();
                                        String tipoD = identificacion.getTipoDocumento();
                                        tipoDocumento = tipoD.equals("C")?"1":(tipoD.equals("T")?"4":"3");
                                        numeroDocumento = identificacion.getNumeroDocumento();
                                        paisExpedido = "1";
                                        if(personaNatural.getFechaExpedicionDocumento()!=null)
                                            fechaExpedicion = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.sql.Date(personaNatural.getFechaExpedicionDocumento().getYear()-1900,personaNatural.getFechaExpedicionDocumento().getMonth()-1,personaNatural.getFechaExpedicionDocumento().getDay()));
                                        if(personaNatural.getPrimerNombrePersona()!=null)
                                            primerNombre = personaNatural.getPrimerNombrePersona();
                                        if(personaNatural.getSegundoNombrePersona()!=null)
                                            segundoNombre = personaNatural.getSegundoNombrePersona();
                                        if(personaNatural.getPrimerApellidoPersona()!=null)
                                            primerApellido = personaNatural.getPrimerApellidoPersona();
                                        if(personaNatural.getSegundoApellidoPersona()!=null)
                                            segundoApellido = personaNatural.getSegundoApellidoPersona();
                                        if(personaNatural.getFechaNacimientoPersona()!=null)
                                            fechaNacimiento = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.sql.Date(personaNatural.getFechaNacimientoPersona().getYear()-1900,personaNatural.getFechaNacimientoPersona().getMonth()-1,personaNatural.getFechaNacimientoPersona().getDay()));
                                        if(personaNatural.getSexoPersona()!=null)
                                            sexo = personaNatural.getSexoPersona();
                                        if(personaNatural.getGrupoSanguineoPersona()!=null){
                                            grupoSanguineo = personaNatural.getGrupoSanguineoPersona().substring(0, personaNatural.getGrupoSanguineoPersona().length()-1);
                                            rh = personaNatural.getGrupoSanguineoPersona().substring(personaNatural.getGrupoSanguineoPersona().length()-1,personaNatural.getGrupoSanguineoPersona().length());
                                        }
                                        if(personaNatural.getCelularPersona()!=null)
                                            celular = personaNatural.getCelularPersona();
                                        if(personaNatural.getEmailPersona()!=null)
                                            email = personaNatural.getEmailPersona();
                                        java.util.List<com.heinsohn.runt.general.personas.DireccionDTO> direcciones = personaNatural.getDirecciones();
                                        if(direcciones!=null){
                                            if(direcciones.size()>0){
                                                com.heinsohn.runt.general.personas.DireccionDTO direccionP = direcciones.get(0);
                                                if(direccionP!=null){
                                                    if(direccionP.getMunicipio()!=null){
                                                        com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO dir_mun = direccionP.getMunicipio();
                                                        Divipo divipo = model.getDivipobyCodigo(dir_mun.getIdMunicipio());
                                                        if(divipo!=null){
                                                            departamentoDireccion = divipo.getFk_departamento()+"";
                                                            municipioDireccion = divipo.getFk_municipio()+"";
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                   }
                               }
                          }
                     }
                }
            }
%>
<body>
    <form  name="form"  method="post" action="procesarRegistrarPersona.jsp" onsubmit="return evaluar(this)">
        <%  byte[] Qtemplate = null;
            if(persona!=null){
                Qtemplate = model.consultarBiometricoTipoByte(persona.getId_persona(), "TEMPLATE");
            } %>

	   <input type="hidden" id="paso" name="paso" value="1"/>
	   <input type="hidden" id="biometric" name="biometric" value="<%=(Qtemplate!=null?"1":"0")%>"/>
	   <input type="hidden" id="template" name="template" value=""/>
	   <input type="hidden" id="huella1" name="huella1" value=""/>
	   <input type="hidden" id="huella2" name="huella2" value=""/>
	   <input type="hidden" id="bidimensional" name="bidimensional" value=""/>
	   <input type="hidden" id="dedo1" name="dedo1" value=""/>
	   <input type="hidden" id="dedo2" name="dedo2" value=""/>
	   <input type="hidden" id="foto" name="foto" value=""/>
	   <input type="hidden" id="firma" name="firma" value=""/>
	   <table border="0" cellpadding="0" cellspacing="0" align="center">
	    <tr><td width="767" align="center">
			<fieldset>
			<table width="760" border="0" align="center" cellpadding="0" cellspacing="0">
			              <tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="style2 style14 style3 Estilo33">REGISTRAR DATOS DE PERSONA </span></td>
		  </tr>
							<tr>
								<td colspan="4">&nbsp;</td>
							</tr>
                            <tr>
                              <td width="185" align="left" class="Estilo2"><span class="style3 Estilo27">TIPO DOCUMENTO </span></td>
                              <td width="223"  align="left"><span style="font-size: 11px">
                                <select name="tipo" id="tipo" style="width:180px; font-size:11px">
                                  <% List list= model.listadoParametros(5);
                                     Iterator it = list.iterator();
                                     while (it.hasNext()) {
                                         Parametro parametro = (Parametro)it.next();
                                         if(tipoDocumento.equals(parametro.getCodigo()+"")){ %>
                                  <option value="<%=parametro.getCodigo()+""%>" selected="selected"><%=parametro.getNombre()%></option>
                                      <% }
                                                                             } %>
                                </select>
                              </span> </td>
                              <td width="167" align="left" class="Estilo2"><span class="style3 Estilo27">NUMERO DOCUMENTO </span></td>
                             <td width="185" align="left">
                                  <input name="documento" type="text" value="<%=numeroDocumento%>" readonly="true" style="width:180px; text-align:center; font-size:11px"/>				 </td>
                            </tr>
			    <tr>
				<td width="185" height="30" align="left" class="Estilo2"><span class="style3 Estilo27">EXPEDIDO EN </span></td>
				<td width="223" align="left"><span class="Estilo4 Estilo27">
				<select name="nacionalidad" style="width:180px; font-size:11px">
					<option>COLOMBIA</option>
				</select>
				</span></td>
				<td width="167" align="left"> <span class="style3 Estilo27">FECHA DE EXPEDICION </span></td>
				<td width="185" align="left"><label>
				<input  id="fecha_expedicion" name="fecha_expedicion" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat" font-size:11px; width:150px" value="<%=fechaExpedicion%>" onkeyup="mascara(this,'/',true)" maxlength="10"/>
				<input name="lanzador0" type="button" id="lanzador0" style="font-size:8px" value="..." />
				<script type="text/javascript">
					Calendar.setup({
						inputField     :    "fecha_expedicion",      // id del campo de texto
						ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
						button         :    "lanzador0"   // el id del bot&oacute;n que lanzar&aacute; el calendario
					});
				</script>
				</label></td>
		  </tr>
		  <tr>
				<td width="185" height="30" align="left"><div align="left" class="Estilo27"><span class="Estilo28">DEPARTAMENTO</span></div></td>
				<td width="223" align="left"><span class="Estilo4 Estilo27">
			   <select name="departamentos"  style="width:180px; font-size:11px"  onchange="buscarMunicipios(); return false" >
				   <option value="0">---Seleccionar---</option>
						<% List listaDepar_per = model.crearListaDpto();
						   Iterator it_dep_per = listaDepar_per.iterator();
						   while (it_dep_per.hasNext()) {
								Departamento dpto = (Departamento)it_dep_per.next();
								if(departamentoExpedicion.equals(dpto.getId_departamento()+"")){ %>
									<option value="<%=dpto.getId_departamento()+""%>" selected><%=dpto.getNombre()%></option>
							 <% }else{ %>
									<option value="<%=dpto.getId_departamento()+""%>"><%=dpto.getNombre()%></option>
							 <% }
						   }%>
				</select>
				</span></td>
				<td align="left" class="Estilo4"><span class="style3 Estilo27">MUNICIPIO EXPEDICION </span></td>
				<td align="left">
								<div class="Estilo4" id="municipios">
									<select name="municipio" id="municipio" style="width:180px; font-size:11px">
									<%
									 if(departamentoExpedicion.length()>0){
											java.util.List lista = model.crearListaMunicipios(Integer.parseInt(departamentoExpedicion));
											for (int i = 0; i < lista.size(); i++) {
												Municipio municipio = (Municipio) lista.get(i);
												if(municipioExpedicion.equals(municipio.getCodigo()+"")){ %>
													<option value="<%=municipio.getCodigo() + ""%>" selected><%=municipio.getNombre()%></option>
											 <% }else{ %>
													<option value="<%=municipio.getCodigo() + ""%>"><%=municipio.getNombre()%></option>
									<%	    }
											}
										} %>
									</select>
								</div></td>
		  </tr>
		  <tr>
				<td align="left" height="30" class="Estilo2"><span class="style3 Estilo27">PRIMER NOMBRE </span></td>
				<td align="left">
			<input name="primer_nombre" type="text" style="width:180px; font-size:11px" value="<%=primerNombre%>"/></td>
				<td align="left" class="Estilo2"><span class="style3 Estilo27">SEGUNDO NOMBRE </span></td>
				<td  align="left">
				<input name="segundo_nombre" type="text"  style="width:180px; font-size:11px" value="<%=segundoNombre%>"/>      </td>
		  </tr>
		  <tr>
				<td align="left" height="30" class="Estilo2"><span class="style3 Estilo27">PRIMERO APELLIDO </span></td>
				<td align="left"><input name="primer_apellido" type="text"  style="width:180px; font-size:11px" value="<%=primerApellido%>"/></td>
				<td align="left" class="Estilo2"><span class="style3 Estilo27">SEGUNDO APELLIDO </span></td>
				<td align="left"><span class="Estilo4"><label><input type="text" name="segundo_apellido"  style="width:180px; font-size:11px" value="<%=segundoApellido%>"/></label></span></td>
		  </tr>
		  <tr>
			  <td align="left" height="30" class="Estilo2"><span class="style3 Estilo27">FECHA DE NACIMIENTO </span></td>
			  <td align="left"><span class="Estilo4 Estilo27"><label>
			  <input  id="fecha_nacimiento" name="date" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat" value="<%=fechaNacimiento%>" onkeyup="mascara(this,'/',true)" maxlength="10"/>
			  <input name="button" type="button" id="lanzador1" style="font-size:8px" value="..." />
			  <SCRIPT type="text/javascript">
				Calendar.setup({
					inputField     :    "fecha_nacimiento",      // id del campo de texto
					ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
					button         :    "lanzador1"   // el id del botón que lanzará el calendario
				});
			  </SCRIPT>
			  </label>
			  </span></td>
			  <td colspan="2">&nbsp;</td>
		</tr>
		  <tr>
		  <td align="left" height="30" class="Estilo2"><span class="style3 Estilo27">LUGAR DE NACIMIENTO </span></td>
		  <td width="223" align="left"><span class="Estilo4 Estilo27">
		  <select name="depar_nacim" style="width:180px; font-size:11px"  onchange="buscarMunicNacim(); return false">
		  	  <option value="0">---Seleccionar---</option>
			<% listaDepar_per = model.crearListaDpto();
			   it_dep_per = listaDepar_per.iterator();
			   while (it_dep_per.hasNext()) {
					Departamento dpto = (Departamento)it_dep_per.next();
					if(departamentoNacimiento.equals(dpto.getId_departamento()+"")){ %>
						<option value="<%=dpto.getId_departamento()+""%>" selected><%=dpto.getNombre()%></option>
				 <% }else{ %>
						<option value="<%=dpto.getId_departamento()+""%>"><%=dpto.getNombre()%></option>
				 <% }
			   }%>
		  </select>
		  </span></td>
		  <td align="left" class="style3 Estilo27">CIUDAD DE NACIMIENTO </td>
		  <td align="left"><div class="Estilo4" id="munici_nacim">
					  <select name="municipio_nacim" id="municipio_nacim" style="width:180px; font-size:11px">
						 <% if(departamentoNacimiento.length()>0){
								java.util.List lista = model.crearListaMunicipios(Integer.parseInt(departamentoNacimiento));
								for (int i = 0; i < lista.size(); i++) {
									Municipio municipio = (Municipio) lista.get(i);
									if(municipioNacimiento.equals(municipio.getCodigo()+"")){ %>
										<option value="<%=municipio.getCodigo() + ""%>" selected><%=municipio.getNombre()%></option>
								 <% }else{ %>
										<option value="<%=municipio.getCodigo() + ""%>"><%=municipio.getNombre()%></option>
						<%	        }
								}
							}%>
				</select>
				  </div></td>
		  </tr>
		  <tr>
		  <td align="left" height="30" class="Estilo2"><span class="style3 Estilo27">SEXO PERSONA </span></td>
		  <td align="left"><span class="Estilo4 Estilo27">
			<label>
			  <select name="sexo" style="width:180px; font-size:11px; text-align:center">
				<option value="M" <%=sexo.equals("M")?"selected":""%>>MASCULINO</option>
				<option value="F" <%=sexo.equals("F")?"selected":""%>>FEMENINO</option>
			  </select>
			  </label>
		  </span></td>
		  <td align="left" class="Estilo2"><span class="style3 Estilo27">GRUPO SANGUINEO  </span></td>
		  <td align="left" class="Estilo2"><span class="Estilo4">
		  <label>
			  <select name="grupo_sanguineo" style="width:80px; font-size:11px; text-align:center">
			    <option value="0">--/--</option>
				<option value="O" <%=grupoSanguineo.equals("O")?"selected":""%>>O</option>
				<option value="A" <%=grupoSanguineo.equals("A")?"selected":""%>>A</option>
				<option value="B" <%=grupoSanguineo.equals("B")?"selected":""%>>B</option>
				<option value="AB" <%=grupoSanguineo.equals("AB")?"selected":""%>>AB</option>
			  </select>
			  &nbsp;&nbsp;&nbsp;</label>
		  </span>
		    <label><span class="style3 Estilo27" >RH</span></label>
		    <span class="Estilo4">
		    <label>
            <select name="rh" style="width:60px; font-size:11px; text-align:center">
				<option value="+" <%=rh.equals("+")?"selected":""%>>+</option>
				<option value="-" <%=rh.equals("-")?"selected":""%>>-</option>
			  </select>
			  </label>
		    </span></td>
		</tr>
		<tr>
		  <td align="left" height="30" class="Estilo2"><span class="style3 Estilo27">NUMERO CELULAR </span></td>
		  <td align="left"><span class="Estilo4 Estilo27">
			<label>
			  <input name="celular" type="text" id="celular" style="width:180px; font-size:11px" value="<%=celular%>"/>
			  </label>
		  </span></td>
		  <td align="left" class="Estilo2"><span class="style3 Estilo27">DIRECCION EMAIL </span></td>
		  <td align="left"><span class="Estilo4">
			<label><span class="Estilo13">
			<input name="email" type="text" id="email" style="width:180px; font-size:11px" value="<%=email%>"/>
			</span></label>
		  </span></td>
		</tr>

		<tr>
		  <td height="51" colspan="4">
			  				  
                              <table width="100%" border="0" cellpadding="0" cellspacing="0" style="display:none">
				  <tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="style2 style14 style3 Estilo33">DATOS BIOMETRICOS </span></td>
		  </tr>
                                   <tr style="border:none">
                                       <%   String mt1 = "Capturar Ced BD";
                                            String mt2 = "Capturar Huella";
                                            String mt3 = "Capturar Firma";
                                            String mt4 = "Capturar Foto";
                                            if(persona!=null){
                                                Biometrico biometricoAnt = model.consultarBiometrico(persona.getId_persona());
                                                if(biometricoAnt.getBidimensional()!=null)
                                                    mt1 = "Cambiar Ced BD";
                                                if(biometricoAnt.getTemplate()!=null)
                                                    mt2 = "Cambiar Huella";
                                                if(biometricoAnt.getFirma()!=null)
                                                    mt3 = "Cambiar Firma";
                                                if(biometricoAnt.getFoto()!=null)
                                                    mt4 = "Cambiar Foto";
                                            }%>

                                             <td width="28%" valign="middle"><span class="Estilo27">
                                                      <input type="checkbox" name="bcedula" id="bcedula" value="1" />

                                                      <span class="Estilo28"><%=mt1%></span></span></td>
                                                    <td width="23%" valign="middle"><span class="Estilo27">
                                                    <input type="checkbox" name="bhuella" id="bhuella" value="1"/>
                                                      <span class="Estilo28"><%=mt2%></span></span></td>
                                                    <td width="22%" valign="middle"><span class="Estilo27">
                                                      <input type="checkbox" name="bfirma" id="bfirma" value="1"/>
                                                      <span class="Estilo28"><%=mt3%></span></span></td>
                                                    <td width="15%" valign="middle"><span class="Estilo27">
                                                      <input type="checkbox" name="bfoto" id="bfoto" value="1" checked="checked" />
                                                      <span class="Estilo28"><%=mt4%></span></span></td>
                                           <td width="10%" valign="middle">
                                                <input name="biometricos" type="button" id="biometricos" style="font-size:11px" onclick="Biometria()" value="Biometricos" />                                            </td>
                                   </tr>
			  </table>
			  		  </td>
		</tr>
		<tr>
			<td colspan="4">&nbsp;</td>
		</tr>
		<tr>
		  <td height="51" colspan="4">
		  	<fieldset>
			<table width="760" border="0" >
			<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="style2 style14 style3 Estilo33">DATOS DE LA RESIDENCIA </span></td>
		  </tr>
				<tr class="style3">
				  <td width="184"   class="Estilo6"><div align="center" class="style3 Estilo27 Estilo31">DEPARTAMENTO</div></td>
				  <td width="180" class="Estilo15 Estilo27"><label></label>
				  <div align="center">MUNICIPIO</div></td>
				  <td width="250" class="Estilo6 Estilo27"><div align="center" class="Estilo27 Estilo31">DIRECCION RESIDENCIA </div></td>
				  <td width="158" class="Estilo6"><div align="center" class="Estilo27 Estilo31">TELEFONO</div></td>
				</tr>
				<tr>
					<td class="Estilo4">
					<select name="dir_departamento" style="width:180px; font-size:11px" onchange="buscarDirMunicipios(); return false" onblur=	"buscarDirMunicipios(); return false">
						<option value="0">---Seleccionar---</option>
							   <% listaDepar_per = model.crearListaDpto();
								   it_dep_per = listaDepar_per.iterator();
								   while (it_dep_per.hasNext()) {
										Departamento dpto = (Departamento)it_dep_per.next();
										if(departamentoDireccion.equals(dpto.getId_departamento()+"")){ %>
											<option value="<%=dpto.getId_departamento()+""%>" selected><%=dpto.getNombre()%></option>
									 <% }else{ %>
											<option value="<%=dpto.getId_departamento()+""%>"><%=dpto.getNombre()%></option>
									 <% }
								   }%>
					</select></td>
					<td class="Estilo4"><div align="center" id="dir_municipios">
								 <select name="dir_municipio" id="dir_municipio" style="width:180px; font-size:11px">
								 <% if(departamentoDireccion.length()>0){
										java.util.List lista = model.crearListaMunicipios(Integer.parseInt(departamentoDireccion));
										for (int i = 0; i < lista.size(); i++) {
											Municipio municipio = (Municipio) lista.get(i);
											if(municipioDireccion.equals(municipio.getCodigo()+"")){ %>
												<option value="<%=municipio.getCodigo() + ""%>" selected><%=municipio.getNombre()%></option>
										 <% }else{ %>
												<option value="<%=municipio.getCodigo() + ""%>"><%=municipio.getNombre()%></option>
								<%	        }
										}
									}%>
								</select>
								</div></td>
                                                                <td class="Estilo4" align="left"><input type="text" name="direccion" style="width:250px; font-size:11px" disabled="disabled" value="<%=direccion%>"/></td>
					<td class="Estilo4"><input type="text" name="telefono" disabled="disabled" style="font-size:11px" value="<%=telefonoDireccion%>"/></td>
				</tr>
			</table>
			</fieldset>
					    </td>
		</tr>
			<tr>
				 <td colspan="4" align="center">&nbsp;</td>
			</tr>
			<tr>
                              <td colspan="4" align="center">
							  <input type="submit" name="guardar" value="Registrar Datos Persona" style="font-size:13px"/></td>
                	</tr>
	  </table>
	  </fieldset>
			</td>
		</tr>
	 </table>
</form>
</body>
</html>
<%
    }else{ %>
<%  }
}catch(Exception exc){
	exc.printStackTrace();
}%>
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