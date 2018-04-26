<%-- 
    Document   : registrarDatosPersona
    Created on : 07-jul-2010, 14:34:12
    Author     : Civitrans
--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
try{
	if(session.getAttribute("model")!=null){
            Model model= (Model)session.getAttribute("model");
            modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
            UsuarioRunt userRunt = model.consultarUsuarioRunt2(usuario.getId_usuario());
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Registrar Persona</title>
	<script src="../../html/scripts/validarFecha.js" type="text/javascript"></script>
        	<script src="../../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../../html/scripts/calendar-setup.js" type="text/javascript"></script>


 <script language="javascript" type="text/javascript">
 	function validarDocumento(documento){
    	if(documento.value==""){
       		alert("El campo Documento no puede estar vacio");
	       return false;
     	}else return true;
    }

    function validardoc(documento){
    	if(isNaN(documento.value)){
            alert(" El Documento Es Invalido Favor Verifique !");
            return false;
        }
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
   /* function Validar_noLiquidacion(noLiquidacion){
       if(isNaN(noLiquidacion.value)){
           alert("El Numero de Liquidacion es Obligatorio");
           return false;
       }else return true;
   }*/

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
	function validarFormulario(form){
	with(form){
		  if(validarDocumento(documento)==false){
			   documento.focus();
			 return false;
			}
		 if(validardoc(documento)== false){
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
                   
                   if(Validar_noLiquidacion(noLiquidacion)==false){
                       noLiquidacion.focus();
                       return  false;
                   }
                   document.getElementById("primero").style.display = "none";
                   document.getElementById("segundo").style.display = "block";
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
///
function revisarL(lq){
            lq.style.color = "#006699";
            lq.value = '800000000000000000'.substr(0, 18-lq.value.length)+lq.value;
            if(lq.value.length==18){
		if(isNaN(lq.value)){
                    	alert("Digite solo valores numericos.");
		}else{
                    ajax2=new nuevoAjax();
                    ajax2.open("POST", "verificarLiquidacion.jsp",true);
                    ajax2.onreadystatechange=function() {
                            if (ajax2.readyState==4) {
                                var respuesta = ajax2.responseText;
                                if(respuesta.indexOf("PAGADO")!=-1||respuesta.indexOf("NO_ACCESO")!=-1)
                                    lq.style.color = "#006699";
                                else
                                    lq.style.color = "#FF0000";
                        }
                    }
                    ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                    ajax2.send("runt="+lq.value);
		}
            }else{
                lq.style.color = "#FF0000";
            }
	}
///
	function buscarMunicipios(){
		tabla = document.getElementById('municipios');
		document.getElementById('municipio').style.display = 'none';
		valor=document.form.departamentos.options[document.form.departamentos.selectedIndex].value;
		ajax=nuevoAjax();
		ajax.open("POST", "../cargarMunicipios.jsp",true);
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
		ajax.open("POST", "../cargarMunic_dir.jsp",true);
		ajax.onreadystatechange=function() {
			if (ajax.readyState==4) {
				tabla.innerHTML = ajax.responseText;
				document.form.direccion.readOnly = false;
				document.form.telefono.readOnly = false;
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
		ajax.open("POST", "../cargarMunic_nacim.jsp",true);
		ajax.onreadystatechange=function() {
			if (ajax.readyState==4) {
				tabla.innerHTML = ajax.responseText;
			}
		}
		ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		ajax.send("fk_dpto="+valor)

	}





       function cargarTokenSesion(){
         //  alert("yuju");
            var ID = document.form.documento.value;
            var TIPO = "C";
                if(document.form.tipo.value==3)
			TIPO = "E";
		if(document.form.tipo.value==4)
			TIPO = "T";
		if(document.form.tipo.value==5)
			TIPO = "P";                    
            var bc = document.getElementById("bcedula").checked?1:0;
            var bh = document.getElementById("bhuella").checked?1:0;
            var br = document.getElementById("bfirma").checked?1:0;
            var bf = document.getElementById("bfoto").checked?1:0;

          //  alert("tipod doc : "+TIPO+" Docu : "+ID+" bidi : "+bc+" huella : "+bh+" firma : "+br+" foto : "+bf);

            var ajax = new nuevoAjax();
                ajax.open("POST", "../generarTokenInscripcion.jsp",true);
                ajax.onreadystatechange=function() {
                    if (ajax.readyState==4) {
                        var docxml = ajax.responseXML;
                        var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue;
                        if(result=='1'){
                            var trama = docxml.getElementsByTagName('trama')[0].childNodes[0].nodeValue;
                            document.form.token.value = trama;
                           // alert("Token  generado Exisotamente ...");
                            document.getElementById('generarToken').style.display = "none";
                            document.getElementById('biometricos').style.display = "block";
                        }else{
                            alert("Token No generado, Intente Nuevamente");
                        }
                    }
                }

            ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
            ajax.send("tipoD="+TIPO+"&documento="+ID+"&bidimen="+bc+"&huellas="+bh+"&firma="+br+"&foto="+bf+"&tipo=1");
        }



	function Biometria(){
                var temp_R = document.form.token.value;
               // alert(temp_R);
		var obj;
		var rta = "";
		obj = new ActiveXObject("IEActiveRUNT.IEActiveRUNT")
		rta = obj.Enrolar(temp_R);
             //   alert("rta : "+rta);
                document.form.token2.value = rta;
		alert("OK. Datos biometricos capturados ");
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
		ajax.open("POST", "../getPersona.jsp",true);
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
        <link title=win2k-cold-1 media=all href="../../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
	<script src=".../../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src=".../../html/scripts/calendar-setup.js" type="text/javascript"></script>
		<style type="text/css">
            <!--
            .Estilo1 {
                font-family: "Vendana";
                font-weight: bold;
                color: #0066CC;
				font-size: 13px;
            }
            .Estilo2 {
                    font-family: "Vendana";
                    font-weight: bold;
                    color: #006666;
                    font-size: 14px;
            }
            .Estilo3 {
                font-family: "Vendana";
                font-weight: bold;
                color: #0066CC;
		font-size: 12px;
            }
.style1 {color: #003366}
.style3 {font-weight: bold}
.Estilo4 {font-weight: bold}
.Estilo6 {font-size: 12px}
.Estilo7 {
	font-size: 14px;
	color: #000000;
	font-family: Vendana;
	font-weight: bold;
	font-style: italic;

}
.Estilo9 {color: #FF6600}
.Estilo11 {color: #0066CC}
.Estilo12 {color: #FF0000}
.Estilo13 {color: #333333}
.Estilo14 {font-family: "Vendana"; font-weight: bold; color: #333333; font-size: 12px; }
.style7 {
	font-family: Tahoma;
	font-weight: bold;
	font-size: 12px;
	color: #FFFFFF;
}
.style15 {font-family: Tahoma}
.style19 {font-family: Tahoma; font-weight: bold; color: #333333; font-size: 11px; }
.style20 {font-size: 11px}
.style21 {color: #333333; font-family: Tahoma; font-size: 11px; }
.style22 {
	color: #333333;
	font-size: 11px;
	font-weight: bold;
}
.style23 {
	color: #FFFFFF;
	font-family: Tahoma;
	font-size: 11px;
}
.style26 {font-family: Tahoma; font-weight: bold; color: #FFFFFF; font-size: 11px; }
						-->
        </style>
</head>

<% try{
       int respuesta = 0;
       if(model!=null) {
            int tipoDocumento = Integer.parseInt(request.getParameter("tipo"));
            String tipo = "";
            switch(tipoDocumento){
                case 1: tipo = "C";break;
                case 3: tipo = "E";break;
                case 4: tipo = "T";break;
                case 5: tipo = "P";break;
            }
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
            
            Persona persona = model.consultarPersona(tipoDocumento, numeroDocumento);
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
            }

            webservices.consultas.ServicioConsultaRUNTClient consultasService = new webservices.consultas.ServicioConsultaRUNTClient();
            consultasService.setTokenHuellaDigital("");
            consultasService.setUser(userRunt.getCodigo());
             if(session.getAttribute("token2")!=null){
             consultasService.setTokenHuellaDigital(session.getAttribute("token2").toString());
         }

              Model.userHandler = userRunt.getCodigo();
              Model.passUserHandler = userRunt.getPassword();
            com.heinsohn.runt.general.consultas.PersonaNaturalOutDTO personaNaturalOut = consultasService.consultarDatosPersonaNatural(tipo, numeroDocumento);

            if(personaNaturalOut!=null){
                if(personaNaturalOut.getStatus()!=null){
                      if(personaNaturalOut.getStatus().getStatusCode().equals("1")){
                          javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.PersonaNaturalDTO> jaxbPersonaNatural = personaNaturalOut.getPersonaNatural();
                           com.heinsohn.runt.general.personas.PersonaNaturalDTO personaNatural = jaxbPersonaNatural.getValue();
                           if(personaNatural!=null){
                               if(personaNatural.getEstadoPersona().equals("ACTIVA")){
                                    respuesta = 1;
                                    if(persona==null){
                                        javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jaxb_Identificacion = personaNatural.getIdentificacion();
                                        com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacion = jaxb_Identificacion.getValue();
                                        String tipoD = identificacion.getTipoDocumento();
                                        tipoDocumento = tipoD.equals("C")?1:(tipoD.equals("T")?4:3);
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
            }else{
                respuesta = -1;
            }
%>
<body>
    <form  name="form"  method="post" action="procesarRegistrarPersona.jsp" onsubmit="return evaluar(this)" target="envio">
        <%  byte[] Qtemplate = null;
            if(persona!=null){
                Qtemplate = model.consultarBiometricoTipoByte(persona.getId_persona(), "TEMPLATE");
            }
        %>

	   <input type="hidden" id="resultado" name="resultado" value="<%=respuesta%>"/>
	   <input type="hidden" id="biometric" name="biometric" value="<%=(Qtemplate!=null?"1":"0")%>"/>
	   <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	    <tr><td width="100%" align="center">
		    <table width="100%" border="0" align="center" id="segundo" style="display:none">
			   <tr>
                		 <td width="100%">
        				<iframe name="envio" id="envio" width="700px" height="400px"  allowtransparency="true" frameborder="0" marginheight="0" marginwidth="0" scrolling="auto" src=""></iframe>
				</td>
			  </tr>
			</table>		
			<table width="100%" border="0" align="center" id="primero">
			               <tr>
    <td colspan="6" background="../../html/images/inicio_3.png"> <div align="center" class="Estilo15 Estilo26 style7">REGISTRAR DATOS PERSONA </div></td>
  </tr>
							<tr>
								<td colspan="4">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="4">
								<% if(respuesta==0){ %>
									<div align="center" class="Estilo7 Estilo9" style="background-color:#EFEFEF">
									  El tipo de documento y numero asociado no se encuentran registrados en el Runt, debe efectuar la inscripcion!!</div>			
								    <% }else
								   if(respuesta==-1){ %>								   	 								
									<div align="center" class="Estilo7 Estilo12" style="background-color:#EFEFEF">
									  No se pudo acceder al servicio Web o Token esta vencido, favor Vuelva Autenticarse... </div>
								    <% }else
								   if(respuesta==1){ %>								   	 								
									<div align="center" class="Estilo7 Estilo11" style="background-color:#EFEFEF">
									  La persona ya se encuentra inscrita correctamente en el Runt!!</div>			
								    <% } %>							    </td>
						  </tr>
                            <tr>
                              <td width="25%" align="left"><span class="style19">TIPO&nbsp;DOCUMENTO</span></td>
                              <td width="25%"  align="left"><span class="style21">
                                <select name="tipo" id="tipo" style="width:130px; font-size:11px">
                                    <% List list= model.listadoParametros(5);
                                     Iterator it = list.iterator();
                                     while (it.hasNext()) {
                                         Parametro parametro = (Parametro)it.next();
                                         if(tipoDocumento==parametro.getCodigo()){ %>
                                  <option value="<%=parametro.getCodigo()+""%>" selected="selected"><%=parametro.getNombre()%></option>
                                      <% }
                                                                             } %>
                                </select>
                              </span> </td>
                              <td width="25%" align="left"><span class="style19">NUMERO&nbsp;DOCUMENTO</span></td>
                             <td width="25%" align="left">
                                  <input name="documento" type="text" style="width:130px; text-align:center" value="<%=numeroDocumento%>" readonly="true"/>				 </td>
                            </tr>
			    <tr>
				<td align="left" class="Estilo2"><span class="style19">EXPEDIDO EN  </span></td>
				<td align="left"><span class="Estilo4 Estilo27 Estilo13 style15 style20">
				<select name="nacionalidad" style="width:130px; font-size:11px">
					<option>COLOMBIA</option>
				</select>
				</span></td>
				<td align="left"> <span class="style19">FECHA  EXPEDICION </span></td>
				<td align="left"><span class="style21">
				  <label>
			      <input  id="fecha_expedicion" name="fecha_expedicion" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat" font-size:11px; width:95px" value="<%=fechaExpedicion%>" onkeyup="mascara(this,'/',true)" maxlength="10"/>
			      <input name="lanzador0" type="button" id="lanzador0" style="font-size:8px" value="..." />
			      <script type="text/javascript">
					Calendar.setup({
						inputField     :    "fecha_expedicion",      // id del campo de texto
						ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
						button         :    "lanzador0"   // el id del bot&oacute;n que lanzar&aacute; el calendario
					});
				</script>
			      </label>
				  </span></td>
			    </tr>
		  <tr>
				<td align="left"><div align="left" class="Estilo27 Estilo13 style15 style20"><strong>DEPARTAMENTO</strong></div></td>
				<td align="left"><span class="Estilo4 Estilo27 Estilo13 style15 style20">
				  <select name="departamentos"  style="width:130px; font-size:11px"  onchange="buscarMunicipios(); return false" >
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
				<td align="left" class="Estilo4"><span class="style19"><strong>MUNICIPIO&nbsp;EXPEDICION</strong></span></td>
				<td align="left">
                                <div class="style19" id="municipios">
                                    <select name="municipio" id="municipio" style="width:130px">
                                    <%
                                     if(departamentoExpedicion.length()>0){
                                        java.util.List lista = model.crearListaMunicipios(Integer.parseInt(departamentoExpedicion));
                                        for (int i = 0; i < lista.size(); i++) {
                                            Municipio municipio = (Municipio) lista.get(i);
                                            if(municipioExpedicion.equals(municipio.getCodigo()+"")){ %>
                                                <option value="<%=municipio.getCodigo() + ""%>" selected><%=municipio.getNombre()%></option>
                                         <% }else{ %>
                                                <option value="<%=municipio.getCodigo() + ""%>"><%=municipio.getNombre()%></option>
                        <%                   }
                                        }
                                            } %>
                                    </select>
            </div></td>
		  </tr>
		  <tr>
				<td align="left" class="Estilo2"><span class="Estilo13 Estilo1 style15"><span class="style22">PRIMER NOMBRE </span></span></td>
				<td align="left">
			<input name="primer_nombre" type="text" style="width:130px" value="<%=primerNombre%>"/></td>
				<td align="left" class="Estilo2"><span class="Estilo13 Estilo1 style15"><span class="style22">SEGUNDO NOMBRE </span></span></td>
				<td align="left">
				<input name="segundo_nombre" type="text"  style="width:130px" value="<%=segundoNombre%>"/>      </td>
		  </tr>
		  <tr>
				<td align="left" class="Estilo2"><span class="Estilo13 Estilo1 style15"><span class="style22">PRIMER APELLIDO </span></span></td>
				<td align="left"><input name="primer_apellido" type="text"  style="width:130px" value="<%=primerApellido%>"/></td>
				<td align="left" class="Estilo2"><span class="Estilo13 Estilo1 style15"><span class="style22">SEGUNDO APELLIDO </span></span></td>
				<td align="left"><span class="style19"><label><input type="text" name="segundo_apellido"  style="width:130px; font-size:11px" value="<%=segundoApellido%>"/></label></span></td>
		  </tr>
		  <tr>
			  <td align="left" class="Estilo2"><span class="Estilo13 Estilo1 style15"><span class="style22">FECHA NACIMIENTO </span></span></td>
			  <td align="left"><span class="Estilo4 Estilo27 Estilo13 style15 style20"><label>
			  <input  id="fecha_nacimiento" name="date" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat" font-size:11px; width:95px" value="<%=fechaNacimiento%>" onkeyup="mascara(this,'/',true)" maxlength="10"/>
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
		  <td align="left" class="Estilo2"><span class="style19"><strong>LUGAR NACIMIENTO </strong></span></td>
		  <td align="left"><span class="Estilo4 Estilo27 Estilo13 style15 style20">
		  <select name="depar_nacim" style="width:130px; font-size:11px"  onchange="buscarMunicNacim(); return false">
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
		  <td align="left" class="style1 Estilo27"><strong class="style19">CIUDAD&nbsp;NACIMIENTO </strong></td>
		  <td align="left"><div class="style19" id="munici_nacim">
					  <select name="municipio_nacim" id="municipio_nacim" style="width:130px">
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
		  <td align="left" class="Estilo2"><span class="style19"><strong>SEXO</strong></span></td>
		  <td align="left"><span class="Estilo4 Estilo27 Estilo13 style15 style20">
			<label>
			  <select name="sexo" style="width:130px; font-size:11px; ">
				<option value="M" <%=sexo.equals("M")?"selected":""%>>MASCULINO</option>
				<option value="F" <%=sexo.equals("F")?"selected":""%>>FEMENINO</option>
			  </select>
			  </label>
		  </span></td>
		  <td align="left" class="Estilo2"><span class="style19"><strong>GRUPO SANGUINEO  </strong></span></td>
		  <td align="left" class="style19"><span class="Estilo4">
		  <label>
			  <select name="grupo_sanguineo" style="width:60px">
			    <option value="0">--/--</option>
				<option value="O" <%=grupoSanguineo.equals("O")?"selected":""%>>O</option>
				<option value="A" <%=grupoSanguineo.equals("A")?"selected":""%>>A</option>
				<option value="B" <%=grupoSanguineo.equals("B")?"selected":""%>>B</option>
				<option value="AB" <%=grupoSanguineo.equals("AB")?"selected":""%>>AB</option>
			  </select>
			  </label>
		  </span>
		    <label><span class="Estilo27" ><strong>Rh</strong></span></label>
		    <span class="Estilo4">
		    <label>
            <select name="rh" style="width:40px">
				<option value="+" <%=rh.equals("+")?"selected":""%>>+</option>
				<option value="-" <%=rh.equals("-")?"selected":""%>>-</option>
			  </select>
			  </label>
		    </span></td>
		</tr>
		<tr>
		  <td align="left" class="Estilo2"><span class="style19"><strong>CELULAR </strong></span></td>
		  <td align="left"><span class="Estilo4 Estilo27 Estilo13 style15 style20">
			<label>
			  <input name="celular" type="text" id="celular" style="width:130px; font-size:11px" value="<%=celular%>"/>
			  </label>
		  </span></td>
		  <td align="left" class="Estilo2"><span class="style19"><strong>E-MAIL</strong></span></td>
		  <td align="left"><span class="style19">
			<label>
			<input name="email" type="text" id="email" style="width:130px; font-size:11px" value="<%=email%>"/>
			</label>
		  </span></td>
		</tr>
                        
                <tr>
		  <td align="left" class="Estilo2"><span class="style19"><strong>NO LIQUIDACION </strong></span></td>
		  <td align="left"><span class="Estilo4 Estilo27 Estilo13 style15 style20">
			<label>
                            <input name="noLiquidacion" <%=respuesta==0?"":"disabled" %> type="text" id="noLiquidacion" style="width:130px; font-size:11px" maxlength="18"  value=""/>
			  </label>
		  </span></td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
		</tr>
                        
<% if(respuesta == 0){ %>
		<tr>
		  <td height="51" colspan="4">
			  <fieldset>
				  <div align="center">
				    <legend class="Estilo14 style15">DATOS BIOMETRICOS</legend>
		      </div>
				  <table width="100%" border="0" cellpadding="0" cellspacing="0">
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

                                             <td width="23%" valign="middle"><span class="Estilo1">
                                                      <input type="checkbox" name="bcedula" id="bcedula" value="1" />
                                                      <span class="Estilo3"><%=mt1%></span></span></td>
                                                    <td width="23%" valign="middle"><span class="Estilo1">
                                                            <input type="checkbox" name="bhuella" id="bhuella"  checked value="1" disabled/>
                                                      <span class="Estilo3"><%=mt2%></span></span></td>
                                                    <td width="23%" valign="middle"><span class="Estilo1">
                                                            <input type="checkbox" name="bfirma" id="bfirma"  checked value="1" disabled/>
                                                      <span class="Estilo3"><%=mt3%></span></span></td>
                                                    <td width="23%" valign="middle"><span class="Estilo1">
                                                            <input type="checkbox" name="bfoto" id="bfoto"  checked value="1" disabled/>
                                                      <span class="Estilo3"><%=mt4%></span></span></td>
                                           <td width="8%" valign="middle">
                                               <input name="generarToken" type="button" class="style3" id="generarToken"  style="font-size:12px" onclick="cargarTokenSesion()" value="Generar Token" />
                                                <input name="biometricos" type="button" class="style3" id="biometricos" style="display:none" style="font-size:12px" onclick="Biometria()" value="Capturar Biometricos" />                                            </td> </td>
                                   </tr>
                                   <% } %>
			  </table>
			  </fieldset>		  </td>
		</tr>
		
		<tr>
		  <td height="51" colspan="4">
		  	<fieldset>
		  	<div align="center">
		  	  <legend class="Estilo14"><strong>DATOS&nbsp;DIRECCION</strong></legend>
		  	  </div>
		  	<table width="100%" border="0" >
				<tr class="style3" background="../../html/images/inicio_3.png">
				  <td width="20%"   class="Estilo6"><div align="center" class="Estilo1 style23"><strong>DEPARTAMENTO</strong></div></td>
				  <td width="20%" class="Estilo6 Estilo27"><div align="center" class="style26">MUNICIPIO </div></td>
				  <td width="40%" class="Estilo6 Estilo27"><div align="center" class="style26">DIRECCION RESIDENCIA </div></td>
				  <td width="20%" class="Estilo6"><div align="center" class="style26">TELEFONO</div></td>
				</tr>
				<tr>
					<td class="Estilo4">
					  <span style="font-size: 11px">
					  <select name="dir_departamento" style="width:130px; font-size:11px" onchange="buscarDirMunicipios(); return false" onblur=	"buscarDirMunicipios(); return false">
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
				        </select>
				    </span></td>
					<td class="Estilo4"><div align="center" class="style20" id="dir_municipios">
								 <select name="dir_municipio" id="dir_municipio" style="width:130px">
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
                                                                <td class="Estilo4" align="left"><input type="text" name="direccion" style="width:250px" readonly value="<%=direccion%>"/></td>
                                                                <td class="Estilo4"><input type="text" name="telefono" readonly value="<%=telefonoDireccion%>"/></td>
				</tr>
			</table>
			</fieldset>		    </td>
		</tr>
			<tr>
				 <td colspan="4" align="center">&nbsp;</td>
			</tr>
                          <input type="hidden" name="token" value="" >
                          <input type="hidden" name="token2" value="" >
			<tr>
			  <td colspan="4" align="center">
				<% if(respuesta==0){ %>
						<input name="guardar" type="submit"  value="Inscribir Persona"/>
				<% }else{%>
						<input name="guardar" type="submit" value="Guardar Datos"/>
				<% } %></td>
           	  </tr>
	  </table>
			</td>
		</tr>
	 </table>
</form>
</body>
</html>
<%
    }
}catch(Exception exc){
	exc.printStackTrace();
}
	}else{ %>
		<script>
			window.parent.document.location.href = "../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){ %>
    <jsp:forward page="../no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>