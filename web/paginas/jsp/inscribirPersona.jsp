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
    <title>Inscripcion Persona</title>
	<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
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

        function consultaSimit(){
          //  alert("tipo documento : "+document.getElementById('tDoc').value+" documento : "+document.getElementById('doc').value);
        var documen = document.getElementById('doc');
        var tip = document.getElementById('tDoc');
        if(documen.value.length>0&&tip.value.length>0){
                var ajax2=nuevoAjax();
                ajax2.open("POST", "wsSimit.jsp",true);
                ajax2.onreadystatechange=function() {
                       if (ajax2.readyState==4) {
                        var docxml = ajax2.responseXML;
                        var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue;
                        alert(result);
                    }
                }
                ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                ajax2.send("documento="+documen.value+"&tipo="+tip.value);
        }
    }
        
        
        
        
        
        
        
        
        
        
        
        function validarDocumento(documento){
        
    	if(documento.value==""){
       		alert("El campo Documento no puede estar vacio");
	       return false;
     	}else return true;
    }

	function validarDireccion(direccion){
    	if(direccion.value==""){
       		alert("El campo  Direccion es Obligatorio, Por Favor  Digitelo  !");
	        return false;
     	}else return true;
    }

    function validardoc(documento){
    	if(isNaN(document.form.documento.value)){
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
       if((!isNaN(document.form.segundo_nombre.value))&& (segundo_nombre.value!="")){
           alert("El Segundo Nombre No es Correcto !");
           return false;
       }else return true;
   }

   function validarFechanac(fecha_nacimiento){
   		if(fecha_nacimiento.value==""){
       		alert("El campo Fecha de Nacimiento no puede estar vacio");
       		return false;
		}else return true;
   }

   function validarFechaExp(fecha_expedicion){
     	if(fecha_expedicion.value==""){
       		alert("El campo Fecha de Expedicion no puede estar vacio");
       		return false;
    	}else return true;
   }

   function validar_telefono(telefono){
       if(isNaN(telefono.value)){
            alert("El Numero De Telefono No es Correcto");
             return false;
        }else return true;
   }

   function validarCelular(celular){
   		if(celular.value==""){
       		alert("El campo Celular no puede estar vacio");
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

   function validarDocumento2(documento2){
		 if(documento2.value==""){
		   alert("El campo  Documento del representante no puede estar vacio");
		   return false;
		 }else return true;
   }
   function validarTipoContrato(tipo_contrato){
     if(tipo_contrato.value==""){
       alert("El campo  Tipo de contrato no puede estar vacio");
       return false;
     }else return true;
   }
   function validarFechaInicio(fecha_representacion){
     if(fecha_representacion.value==""){
       alert("El campo Fecha de representacion no puede estar vacio");
       return false;
    }else return true;
   }
   function validarFechaVigencia(fecha_vigencia){
     if(fecha_vigencia.value==""){
       alert("El campo Fecha de vigencia no puede estar vacio");
       return false;
    }else return true;
   }
   function validarFechaExp2(fecha_expedicion2){
     if(fecha_expedicion2.value==""){
       alert("El campo Fecha de Expedicion no puede estar vacio");
       return false;
    }else return true;
   }
   function validarRazonSocial(razon_sicial){
     if(razon_sicial.value==""){
       alert("El campo Razon social no puede estar vacio");
       return false;
    }else return true;
   }
   function validarSigla(sigla){
       if(sigla.value==""){
            alert(" El campo Sigla no puede estar vacio");
               return false;
       }
   }
   function validarPrestador(prestador_servicio){
     if(prestador_servicio.value==""){
       alert("El campo Prestador de servicio no puede estar vacio");
       return false;
     }else return true;
   }
   function validarEmail2(email2){
     if(email2.value==""){
       alert("El campo E-mail no puede estar vacio");
       return false;
    }else return true;
   }
   function validarCapital(capital_pagado){
     if(capital_pagado.value==""){
       alert("El campo Capital pagado no puede estar vacio");
       return false;
    }else return true;
   }
   function validar_celular2(celular2){
       if(isNaN(celular2.value)){
          alert("El Numero Celular No es Correcto");
          return false;
       }else return true;
   }
   function validarTelefono(telefono){
       if(isNaN(telefono.value)){
          alert("El Numero de Telefono No es Correcto");
          return false;
       }
   }
   function validarTelefono2(telefono2){
       if(isNaN(telefono2.value)){
          alert("El Numero de Telefono No es Correcto");
          return false;
       }return true;
   }

   function validarPatrimonio(patrimonio_liquido){
     if(patrimonio_liquido.value==""){
       alert("El campo Patrimonio liquido no puede estar vacio");
       return false;
    }else return true;
   }
   function validarNro_Certificado(nro_certificado){
     if(nro_certificado.value==""){
       alert("El campo Nro Certificado de Existencia no puede estar vacio");
       return false;
    }else return true;
   }


function validarFormulario1(form)
   {
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
        if(validarFechanac(fecha_nacimiento)==false){
         fecha_nacimiento.focus();
         return false;
       }
	   if(validarFechaExp(fecha_expedicion)==false){
         fecha_expedicion.focus();
         return false;
       }
       if(biometric.value=="0"){
	   	if(document.getElementById("bcedula").checked==1||document.getElementById("bhuella").checked==1||document.getElementById("bfirma").checked==1||document.getElementById("bfoto").checked==1){
         alert("Los datos biometricos no han sido capturados...");
		 return false;
		 }
       }
        if(validarTelefono(telefono)==false){
         telefono.focus();
         return false;
       }
       if(validar_celular(celular)== false){
          celular.focus();
         return false;
       }
       if(validarDireccion(direccion)==false){
         direccion.focus();
         return false;
       }
	   if(municipio_nacim.length==0){
	   	   alert("Seleccione lugar de nacimiento");
		   return false;
	   }
	    if(municipio.length==0){
	   	   alert("Seleccione lugar de expedicion");
		   return false;
	   }
	   if(dir_municipio.length==0){
	   	   alert("Seleccione lugar de direccion");
		   return false;
	   }
	   return true;
   }

}
function validarFormulario2(form)
   {
     with(form){

      if(validarDocumento(documento)==false){
           documento.focus();
         return false;
        }
     if(validardoc(documento)== false){
          documento.focus();
         return false;
         }
	if(validarRazonSocial(razon_social)==false){
         razon_social.focus();
         return false;
       }

       if(validarSigla(sigla)==false){
         sigla.focus();
         return false;
       }
	/*  if(validarPrestador(prestador_servicio)==false){
         prestador_servicio.focus();
         return false;
       }
       if(validarEmail2(email2)== false){
          email2.focus();
         return false;
         }
        if(validarCapital(capital_pagado)==false){
         capital_pagado.focus();
         return false;
       }
	   if(validar_celular2(celular2)==false){
         celular2.focus();
         return false;
       }
        if(validarTelefono2(telefono2)==false){
         telefono2.focus();
         return false;
       }

       if(validarNro_Certificado(nro_certificado)== false){
          nro_certificado.focus();
         return false;
         }*/
		if(validarDocumento2(documento2)==false){
         documento2.focus();
         return false;
       }
       /*
	   if(validarTipoContrato(tipo_contrato)== false){
          tipo_contrato.focus();
         return false;
       }
	   if(validarFechaInicio(fecha_representacion)== false){
          fecha_representacion.focus();
         return false;
       }
	   if(validarFechaVigencia(fecha_vigencia)== false){
         fecha_vigencia.focus();
         return false;
       }
	   if(validarFechaExp2(fecha_expedicion2)== false){
         fecha_expedicion2.focus();
         return false;
       }*/
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

	function buscarMunicipios2(){
		tabla = document.getElementById('municipios2');
		document.getElementById('municipio2').style.display = 'none';
		valor=document.form.departamento2.options[document.form.departamento2.selectedIndex].value;
		ajax=nuevoAjax();
		ajax.open("POST", "cargarMunicipio2.jsp",true);
		ajax.onreadystatechange=function() {
			if (ajax.readyState==4) {
				tabla.innerHTML = ajax.responseText;
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

	function buscarDirMunicipios2(){
		tabla = document.getElementById('dir_municipios2');

		valor=document.form.dir_departamento2.options[document.form.dir_departamento2.selectedIndex].value;
		ajax=nuevoAjax();
		ajax.open("POST", "cargarMunic_dir2.jsp",true);
		ajax.onreadystatechange=function() {
			if (ajax.readyState==4) {
				tabla.innerHTML = ajax.responseText;
				document.form.direccion2.disabled = false;
				document.form.telefono2.disabled = false;
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
		   alert("OK. Datos biometricos recibidos");
		}else{
			document.form.biometric.value = "0";
			document.form.excepcion.value = obj.R_Excepcion;
			alert(obj.R_Excepcion);
		}
	}

	function procesar(evt,page,val){
		var access = false;
		if(val=="1"){
			if(evaluar(document.form)){
				access = true;
			}else{
				access = false;
			}
		}else{
			access = true;
		}
		if(access){
			document.getElementById("paso").value = evt;
			document.form.action = page;
			document.form.submit();
		}
	}

	function evaluar(form){
		if(form.tipo.value!="2"){
			return validarFormulario1(form);
		}else{
			return validarFormulario2(form);
		}
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

	function verMotivos(chk){
		if(!chk.checked){
			document.getElementById("mtv").style.display = "block";
		}else{
			document.getElementById("mtv").style.display = "none";
		}
	}
</script>
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
		<script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
		<style type="text/css">
		<!--
		.Estilo2 {font-size: 14px; color:#CC0000}
		.Estilo4 {color: #333333;font-size: 14px;}
		.Estilo5 {font-size: 17px; color: #0066CC; }
		.Estilo6 {font-size: 14px; color: #0066CC; }
		.Estilo7 {
	color: #FFFFFF;
	font-weight: bold;
	font-size: 12px;
		}
		.Estilo13 {
			font-size: 14px;
			color: #333333;
		}
		.Estilo15 {
	color: #333333;
	font-size: 12px;
}
		.Estilo18 {font-size: 12px}
.Estilo20 {
	color: #009933;
	font-weight: bold;
	font-style: italic;
	font-size: 14px;
}
.Estilo24 {font-size: 14px; color: #FF0000; font-weight: bold; font-style: italic; }
.style1 {
	font-family: Tahoma;
	color: #333333;
}
.style2 {font-family: Tahoma}
.style3 {color: #333333; font-size: 12px; font-weight: bold; font-family: Tahoma; }
.Estilo25 {color: #333333; font-weight: bold; font-size: 12px; }
.Estilo26 {color: #333333; font-size: 11px; font-weight: bold; font-family: Tahoma; }
.Estilo27 {font-size: 11px}
.Estilo28 {font-weight: bold; font-family: Tahoma; color: #333333;}
.Estilo29 {color: #0066CC}
		-->
		</style>
</head>

<% try{
       if(model!=null) {
            int paso = Integer.parseInt(request.getParameter("paso"));
            long idp = 0;
            String tipoDocumento = request.getParameter("tipo");
            String numeroDocumento = request.getParameter("numero");
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
            String razonSocial = "";
            String sigla = "";
            String tipoEntidad = "";
            String tipoSociedad = "";
            String prestadorServicio = "";
            String telefonoEmpresa = "";
            String emailEmpresa = "";
            String celularEmpresa = "";
            String fax = "";
            String capitalPagado = "";
            String patrimonioLiquido = "";
            String certificadoRepresentante = "";
            String departamentoDireccion2 = "";
            String municipioDireccion2 = "";
            String direccion2 = "";
            String telefonoDireccion2 = "";
            String tipoDocumentoRepresentante = "";
            String numeroDocumentoRepresentante = "";
            String tipoContrato = "";
            String fechaInicioRepresentante = "";
            String estadoRepresentacion = "";
            String fechaVigenciaRepresentante = "";
            if(paso==1||paso==4){
                Persona bbdd = (Persona)session.getAttribute("bbdd");
                if(bbdd!=null){
                    idp = bbdd.getId_persona();
                    tipoDocumento = bbdd.getTipo_documento()+"";
                    numeroDocumento = bbdd.getDocumento();
                    paisExpedido = "1";
                    if(bbdd.getFecha_exp()!=null)
                        fechaExpedicion = new java.text.SimpleDateFormat("dd/MM/yyyy").format(bbdd.getFecha_exp());
                    if(bbdd.getFk_divipo()!=0){
                        Divipo divipo = model.getDivipo(bbdd.getFk_divipo());
                        if(divipo!=null){
                            departamentoExpedicion = divipo.getFk_departamento()+"";
                            municipioExpedicion = divipo.getFk_municipio()+"";
                        }
                    }
                    if(bbdd.getTipo_documento()!=2){
                        if(bbdd.getNombre_1()!=null)
                            primerNombre = bbdd.getNombre_1();
                        if(bbdd.getNombre_2()!=null)
                            segundoNombre = bbdd.getNombre_2();
                        if(bbdd.getApellido_1()!=null)
                            primerApellido = bbdd.getApellido_1();
                        if(bbdd.getApellido_2()!=null)
                            segundoApellido = bbdd.getApellido_2();
                        if(bbdd.getFecha_nac()!=null)
                            fechaNacimiento = new java.text.SimpleDateFormat("dd/MM/yyyy").format(bbdd.getFecha_nac());
                        if(bbdd.getFk_lugar_nacimiento()!=0){
                            Divipo divipo = model.getDivipo(bbdd.getFk_lugar_nacimiento());
                            if(divipo!=null){
                                departamentoNacimiento = divipo.getFk_departamento()+"";
                                municipioNacimiento = divipo.getFk_municipio()+"";
                            }
                        }
                        if(bbdd.getSexo()!=null)
                            sexo = bbdd.getSexo();
                        if(bbdd.getGrupo_sanguineo()!=null)
                            grupoSanguineo = bbdd.getGrupo_sanguineo();
                        if(bbdd.getRh()!=null)
                            rh = bbdd.getRh();
                        if(bbdd.getCelular()!=null)
                            celular = bbdd.getCelular();
                        if(bbdd.getEmail()!=null)
                            email = bbdd.getEmail();
                        java.util.List direcciones = model.listado_direcciones_persona(bbdd.getId_persona());
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
                                Empresa empresa = model.consultarEmpresa(bbdd.getTipo_documento(), bbdd.getDocumento());
                                if(empresa!=null){
                                        if(empresa.getFecha_exp()!=null)
                                                fechaExpedicion = new java.text.SimpleDateFormat("dd/MM/yyyy").format(empresa.getFecha_exp());
                                        if(empresa.getRazon_social()!=null)
                                                razonSocial = empresa.getRazon_social();
                                        if(empresa.getSigla()!=null)
                                                sigla = empresa.getSigla();
                                        if(empresa.getTipo_entidad()!=null)
                                                tipoEntidad = empresa.getTipo_entidad();
                                        if(empresa.getTipo_sociedad()!=null)
                                                tipoSociedad = empresa.getTipo_sociedad();
                                        if(empresa.getPrestador_servicio()!=null)
                                                prestadorServicio = empresa.getPrestador_servicio();
                                        if(empresa.getTelefono()!=null)
                                                telefonoEmpresa = empresa.getTelefono();
                                        if(empresa.getCelular()!=null)
                                                celularEmpresa = empresa.getCelular();
                                        if(empresa.getEmail()!=null)
                                                emailEmpresa = empresa.getEmail();
                                        if(empresa.getCapital_pagado()!=null)
                                                capitalPagado = empresa.getCapital_pagado();
                                        if(empresa.getPatrimonio_liquido()!=null)
                                                patrimonioLiquido = empresa.getPatrimonio_liquido();
                                        if(empresa.getNro_certificado()!=null)
                                                certificadoRepresentante = empresa.getNro_certificado();
                                        if(empresa.getFk_representante()!=0){
                                                Representante representante = model.consultarRepresentante(empresa.getFk_representante());
                                                if(representante!=null){
                                                        if(representante.getFk_persona()!=0){
                                                                Persona personaRepresentante = model.consultarPersona(representante.getFk_persona());
                                                                tipoDocumentoRepresentante = personaRepresentante.getTipo_documento()+"";
                                                                numeroDocumentoRepresentante = personaRepresentante.getDocumento();
                                                                if(representante.getFecha_inicio_representacion()!=null)
                                                                        fechaInicioRepresentante = new java.text.SimpleDateFormat("dd/MM/yyyy").format(representante.getFecha_inicio_representacion());
                                                                if(representante.getEstado_representacion()!=null)
                                                                        estadoRepresentacion = representante.getEstado_representacion();
                                                                if(representante.getFecha_vigencia()!=null)
                                                                        fechaVigenciaRepresentante = new java.text.SimpleDateFormat("dd/MM/yyyy").format(representante.getFecha_vigencia());
                                                                if(representante.getTipo_contrato()!=null)
                                                                        tipoContrato = representante.getTipo_contrato();
                                                        }
                                                }
                                        }
                                        java.util.List direcciones = model.listado_direcciones_persona(bbdd.getId_persona());
                                        if(direcciones.size()>0){
                                            Direccion direccionP = (Direccion)direcciones.get(0);
                                            if(direccionP.getFk_divipo()!=0){
                                                Divipo divipo = model.getDivipo(direccionP.getFk_divipo());
                                                if(divipo!=null){
                                                    departamentoDireccion2 = divipo.getFk_departamento()+"";
                                                    municipioDireccion2 = divipo.getFk_municipio()+"";
                                                }
                                            }
                                            if(direccionP.getDescripcion()!=null)
                                                direccion2 = direccionP.getDescripcion();
                                            if(direccionP.getTelefono()!=null)
                                                telefonoDireccion2 = direccionP.getTelefono();
                                            if(direccionP.getFax()!=null)
                                                fax = direccionP.getFax();
                                        }
                                    }
                                }
                        }
                 }//fin paso 1
                 if(paso==3){
                    if(Integer.parseInt(request.getParameter("tipo"))!=2){
                        com.heinsohn.runt.general.personas.PersonaNaturalDTO runt = (com.heinsohn.runt.general.personas.PersonaNaturalDTO)session.getAttribute("runt");
                        if(runt!=null){
                            javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jaxb_Identificacion = runt.getIdentificacion();
                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacion = jaxb_Identificacion.getValue();
                            String tipoD = identificacion.getTipoDocumento();
                            tipoDocumento = tipoD.equals("C")?"1":(tipoD.equals("T")?"4":"3");
                            numeroDocumento = identificacion.getNumeroDocumento();
                            paisExpedido = "1";
                            if(runt.getFechaExpedicionDocumento()!=null)
                                fechaExpedicion = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.sql.Date(runt.getFechaExpedicionDocumento().getYear()-1900,runt.getFechaExpedicionDocumento().getMonth()-1,runt.getFechaExpedicionDocumento().getDay()));
                            if(runt.getPrimerNombrePersona()!=null)
                                primerNombre = runt.getPrimerNombrePersona();
                            if(runt.getSegundoNombrePersona()!=null)
                                segundoNombre = runt.getSegundoNombrePersona();
                            if(runt.getPrimerApellidoPersona()!=null)
                                primerApellido = runt.getPrimerApellidoPersona();
                            if(runt.getSegundoApellidoPersona()!=null)
                                segundoApellido = runt.getSegundoApellidoPersona();
                            if(runt.getFechaNacimientoPersona()!=null)
                                fechaNacimiento = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.sql.Date(runt.getFechaNacimientoPersona().getYear()-1900,runt.getFechaNacimientoPersona().getMonth()-1,runt.getFechaNacimientoPersona().getDay()));
                            if(runt.getSexoPersona()!=null)
                                sexo = runt.getSexoPersona();
                            if(runt.getGrupoSanguineoPersona()!=null){
                                grupoSanguineo = runt.getGrupoSanguineoPersona().substring(0, runt.getGrupoSanguineoPersona().length()-1);
                                rh = runt.getGrupoSanguineoPersona().substring(runt.getGrupoSanguineoPersona().length()-1,runt.getGrupoSanguineoPersona().length());
                            }
                            if(runt.getCelularPersona()!=null)
                                celular = runt.getCelularPersona();
                            if(runt.getEmailPersona()!=null)
                                email = runt.getEmailPersona();
                            java.util.List<com.heinsohn.runt.general.personas.DireccionDTO> direcciones = runt.getDirecciones();
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
                                        if(direccionP.getDireccion()!=null)
                                            direccion2 = direccionP.getDireccion();
                                        if(direccionP.getTelefono()!=null)
                                            telefonoDireccion2 = direccionP.getTelefono();
                                        if(direccionP.getFax()!=null)
                                            fax = direccionP.getFax();
                                    }
                                }
                            }
                        }
                    }else{
                        com.heinsohn.runt.general.personas.PersonaJuridicaDTO runt = (com.heinsohn.runt.general.personas.PersonaJuridicaDTO)session.getAttribute("runt");
                        if(runt!=null){
                            javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.EmpresaDTO> jaxbEmpresa = runt.getEmpresa();
                            com.heinsohn.runt.general.personas.EmpresaDTO empresa = jaxbEmpresa.getValue();
                            if(empresa!=null){
                                if(empresa.getRazonSocial()!=null)
                                    razonSocial = empresa.getRazonSocial();
                                if(empresa.getSigla()!=null)
                                    sigla = empresa.getSigla();
                                if(empresa.getTipoEntidad()!=null)
                                    tipoEntidad = empresa.getTipoEntidad();
                                if(empresa.getTipoSociedad()!=null)
                                    tipoSociedad = empresa.getTipoSociedad();
                                if(empresa.getDireccionTelefono()!=null)
                                    telefonoDireccion2 = empresa.getDireccionTelefono();
                                if(empresa.getCelular()!=null)
                                    celularEmpresa = empresa.getCelular();
                                if(empresa.getDireccionEmail()!=null)
                                    emailEmpresa = empresa.getDireccionEmail();
                                if(empresa.getPatrimonioLiq()!=null)
                                    patrimonioLiquido = empresa.getPatrimonioLiq()+"";
                                if(empresa.getCertExistenciaRepre()!=null)
                                    certificadoRepresentante = empresa.getCertExistenciaRepre();
                                java.util.List<com.heinsohn.runt.general.personas.RepresentanteLegalDTO> listaR = runt.getRepresenLegal();
                                if(listaR!=null){
                                    if(listaR.size()>0){
                                        com.heinsohn.runt.general.personas.RepresentanteLegalDTO representante = listaR.get(0);
                                        if(representante!=null){
                                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacion = representante.getIdentificacion();
                                            if(identificacion!=null){
                                                String tipoD = identificacion.getTipoDocumento();
                                                tipoDocumentoRepresentante = tipoD.equals("C")?"1":(tipoD.equals("T")?"4":"3");
                                                numeroDocumentoRepresentante = identificacion.getNumeroDocumento();
                                                if(representante.getFechaInicioRepresentacion()!=null)
                                                    fechaInicioRepresentante = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.sql.Date(representante.getFechaInicioRepresentacion().getYear()-1900,representante.getFechaInicioRepresentacion().getMonth()-1,representante.getFechaInicioRepresentacion().getDay()));
                                                if(representante.getEstadoRepresentacionLegal()!=null)
                                                    estadoRepresentacion = representante.getEstadoRepresentacionLegal();
                                                if(representante.getFechaVigenciaRepresentacion()!=null)
                                                    fechaVigenciaRepresentante = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.sql.Date(representante.getFechaVigenciaRepresentacion().getYear()-1900,representante.getFechaVigenciaRepresentacion().getMonth()-1,representante.getFechaVigenciaRepresentacion().getDay()));
                                                if(representante.getTipoContrato()!=null)
                                                    tipoContrato = representante.getTipoContrato();
                                             }
                                        }
                                    }
                                }
                             }
                        }
                    }
                }//fin paso 3
%>
<body>
    <form  name="form"  method="post" action="">

        <input type="hidden" name="tDoc" id="tDoc" value="<%= tipoDocumento %>"/>
        <input type="hidden" name="doc" id="doc" value="<%= numeroDocumento %>"/>

        <%  byte[] Qtemplate = null;
            if(idp!=0){
                Biometrico biometricoAnt = model.consultarBiometrico(idp);
                Qtemplate = model.consultarBiometricoTipoByte(idp, "TEMPLATE");
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
		<tr><td align="center">
			<table width="798" border="0" bordercolor = "#FFFFFF" align="center" cellpadding="0" cellspacing="0">

                            <%  if(primerNombre.length()==0&&razonSocial.length()==0){ %>
                                    <tr>
                                            <td colspan="4" align="center" class="Estilo24">La persona no se encuentra registrada</td>
                                    </tr>
                            <%  }
                                if(request.getParameter("runt")!=null){
				    if(Integer.parseInt(request.getParameter("runt"))==1){ %>
						<tr>
							<td colspan="4" align="center" class="Estilo5 Estilo20 Estilo29">La persona se encuentra registrada correctamente en el RUNT</td>
						</tr>
				 <% }
				    if(Integer.parseInt(request.getParameter("runt"))==0){ %>
						<tr>
							<td colspan="4" align="center" class="Estilo24">La persona no se encuentra registrada en el RUNT</td>
						</tr>
				 <% }
				    if(Integer.parseInt(request.getParameter("runt"))==-1){ %>
						<tr>
							<td colspan="4" align="center" class="Estilo24">No se pudo acceder al servicio de consulta RUNT</td>
						</tr>
				 <% }
				}else{
                                   if(request.getParameter("bbdd")!=null){
					if(Integer.parseInt(request.getParameter("bbdd"))==1){ %>
                                            <tr>
                                                <td colspan="4" align="center" class="Estilo5 Estilo20 Estilo29">La persona fue ingresada satisfactoriamente</td>
                                            </tr>
                                     <% }
                                        if(Integer.parseInt(request.getParameter("bbdd"))==2){ %>
                                            <tr>
                                                <td colspan="4" align="center" class="Estilo5 Estilo20 Estilo29">Los datos de la persona fueron actualizados</td>
                                            </tr>
                                     <% }
                                        if(Integer.parseInt(request.getParameter("bbdd"))==3){ %>
                                            <tr>
                                                <td colspan="4" align="center" class="Estilo5 Estilo20 Estilo29"><%=request.getParameter("msg")%></td>
                                            </tr>
                                     <% }
                                   }else{ %>

                            <%     }
                                } %>
				<tr>
				  <td width="188" align="left" class="Estilo2"><span class="style3">TIPO DOCUMENTO </span></td>
				  <td width="226"  align="left">
                                    <select name="tipo" id="tipo" style="width:180px; font-size:11px">
                                      <% List list= model.listadoParametros(5);
                                         Iterator it = list.iterator();
                                         while (it.hasNext()) {
                                             Parametro parametro = (Parametro)it.next();
                                             if(tipoDocumento.equals(parametro.getCodigo()+"")){ %>
                                                <option value="<%=parametro.getCodigo()+""%>" selected="selected"><%=parametro.getNombre()%></option>
                                          <% }
										 } %>
                                    </select>				 </td>
				 <td width="170" align="left" class="Estilo2"><span class="style3">NUMERO DOCUMENTO </span></td>
				 <td width="224" align="left">
         			      <input name="documento" type="text" value="<%=numeroDocumento%>" readonly="true" style="width:180px; text-align:center"/>				 </td>
			  </tr>
                                      <% if(!tipoDocumento.equals("2")){ %>
			    <tr>
				<td width="188" height="30" align="left" class="Estilo2"><span class="style3">EXPEDIDO EN </span></td>
				<td width="226" align="left"><span class="Estilo4">
				<select name="nacionalidad" style="width:180px">
					<option>COLOMBIA</option>
				</select>
				</span></td>
				<td width="170" align="left"> <span class="style3">FECHA DE EXPEDICION </span></td>
				<td width="224" align="left"><label>
				<input  id="fecha_expedicion" name="fecha_expedicion" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat" value="<%=fechaExpedicion%>" onkeyup="mascara(this,'/',true)" maxlength="10"/>
				<input name="lanzador0" type="button" id="lanzador0" value="..." />
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
				<td width="188" height="30" align="left"><div align="left"><span class="style3">DEPARTAMENTO</span></div></td>
				<td width="226" align="left"><span class="Estilo4">
			   <select name="departamentos"  style="width:180px"  onchange="buscarMunicipios(); return false" >
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
				<td align="left" class="Estilo4"><span class="style3">MUNICIPIO EXPEDICION </span></td>
				<td align="left">
								<div class="Estilo4" id="municipios">
									<select name="municipio" id="municipio" style="width:180px">
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
				<td align="left" height="30" class="Estilo2"><span class="style3">PRIMER NOMBRE </span></td>
				<td align="left">
				<input name="primer_nombre" type="text" style="width:180px" value="<%=primerNombre%>"/></td>
				<td align="left" class="Estilo2"><span class="style3">SEGUNDO NOMBRE </span></td>
				<td  align="left">
				<input name="segundo_nombre" type="text"  style="width:180px" value="<%=segundoNombre%>"/>      </td>
		  </tr>
		  <tr>
				<td align="left" height="30" class="Estilo2"><span class="style3">PRIMERO APELLIDO </span></td>
				<td align="left"><input name="primer_apellido" type="text"  style="width:180px" value="<%=primerApellido%>"/></td>
				<td align="left" class="Estilo2"><span class="style3">SEGUNDO APELLIDO </span></td>
				<td align="left"><span class="Estilo4"><label><input type="text" name="segundo_apellido"  style="width:180px" value="<%=segundoApellido%>"/></label></span></td>
		  </tr>
		  <tr>
			  <td align="left" height="30" class="Estilo2"><span class="style3">FECHA DE NACIMIENTO </span></td>
			  <td align="left"><span class="Estilo4"><label>
			  <input  id="fecha_nacimiento" name="date" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat" value="<%=fechaNacimiento%>" onkeyup="mascara(this,'/',true)" maxlength="10"/>
			  <input name="button" type="button" id="lanzador1" value="..." />
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
		  <td align="left" height="30" class="Estilo2"><span class="style3">LUGAR DE NACIMIENTO </span></td>
		  <td width="226" align="left"><span class="Estilo4">
		  <select name="depar_nacim" style="width:180px"  onchange="buscarMunicNacim(); return false">
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
		  <td align="left" class="style3">CIUDAD DE NACIMIENTO </td>
		  <td align="left"><div class="Estilo4" id="munici_nacim">
					  <select name="municipio_nacim" id="municipio_nacim" style="width:180px">
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
		  <td align="left" height="30" class="Estilo2"><span class="style3">SEXO PERSONA </span></td>
		  <td align="left"><span class="Estilo4">
			<label>
			  <select name="sexo" style="width:180px">
				<option value="M" <%=sexo.equals("M")?"selected":""%>>MASCULINO</option>
				<option value="F" <%=sexo.equals("F")?"selected":""%>>FEMENINO</option>
			  </select>
			  </label>
		  </span></td>
		  <td align="left" class="Estilo2"><span class="style3">GRUPO SANGUINEO  </span></td>
		  <td align="left" class="Estilo2"><span class="Estilo4">
		  <label>
			  <select name="grupo_sanguineo" style="width:80px">
				<option value="O" <%=grupoSanguineo.equals("O")?"selected":""%>>O</option>
				<option value="A" <%=grupoSanguineo.equals("A")?"selected":""%>>A</option>
				<option value="B" <%=grupoSanguineo.equals("B")?"selected":""%>>B</option>
				<option value="AB" <%=grupoSanguineo.equals("AB")?"selected":""%>>AB</option>
			  </select>
			  &nbsp;&nbsp;&nbsp;RH
			  <select name="rh" style="width:60px">
				<option value="+" <%=rh.equals("+")?"selected":""%>>+</option>
				<option value="-" <%=rh.equals("-")?"selected":""%>>-</option>
			  </select>
			  </label>
		  </span></td>
		</tr>
		<tr>
		  <td align="left" height="30" class="Estilo2"><span class="style3">NUMERO CELULAR </span></td>
		  <td align="left"><span class="Estilo4">
			<label>
			  <input name="celular" type="text" id="celular" style="width:180px" value="<%=celular%>"/>
			  </label>
		  </span></td>
		  <td align="left" class="Estilo2"><span class="style3">DIRECCION EMAIL </span></td>
		  <td align="left"><span class="Estilo4">
			<label><span class="Estilo13">
			<input name="email" type="text" id="email" style="width:180px" value="<%=email%>"/>
			</span></label>
		  </span></td>
		</tr>

		<tr>
		  <td height="51" colspan="4">
			  <fieldset>
				  <legend class="Estilo26">DATOS BIOMETRICOS</legend>
			      <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                   <tr style="border:none">
                                        <% if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("desabilitarBiometricos")){ %>
                                                 <td width="28%" valign="middle"><span class="Estilo27">
                                                      <input type="checkbox" name="bcedula" id="bcedula" value="1" />
                                                      <span class="Estilo28">CEDULA&nbsp;BIDIMENSIONAL </span></span></td>
                                                    <td width="23%" valign="middle"><span class="Estilo27">
                                                    <input type="checkbox" name="bhuella" id="bhuella" value="1" onclick="verMotivos(this)"/>
                                                      <span class="Estilo28">HUELLA&nbsp;DACTILAR </span></span></td>
                                                    <td width="22%" valign="middle"><span class="Estilo27">
                                                      <input type="checkbox" name="bfirma" id="bfirma" value="1" />
                                                      <span class="Estilo28">FIRMA&nbsp;DIGITAL </span></span></td>
                                                    <td width="15%" valign="middle"><span class="Estilo27">
                                                      <input type="checkbox" name="bfoto" id="bfoto" value="1" />
                                                      <span class="Estilo28">FOTO&nbsp;DIGITAL </span></span></td>

                                          <%}else{%>
                                                  <td width="28%" valign="middle"><span class="Estilo27">
                                                          <input type="checkbox" name="bcedula" id="bcedula" value="1"   disabled/>
                                                  <span class="Estilo28">CEDULA&nbsp;BIDIMENSIONAL </span></span></td>
                                                <td width="23%" valign="middle"><span class="Estilo27">
                                                        <input type="checkbox" name="bhuella" id="bhuella" value="1"  onclick="verMotivos(this)"  disabled/>
                                                  <span class="Estilo28">HUELLA&nbsp;DACTILAR </span></span></td>
                                                <td width="22%" valign="middle"><span class="Estilo27">
                                                  <input type="checkbox" name="bfirma" id="bfirma" value="1"  disabled/>
                                                  <span class="Estilo28">FIRMA&nbsp;DIGITAL </span></span></td>
                                                <td width="15%" valign="middle"><span class="Estilo27">
                                                  <input type="checkbox" name="bfoto" id="bfoto" value="1"  disabled/>
                                                  <span class="Estilo28">FOTO&nbsp;DIGITAL </span></span></td>
                                        <%}%>

                                           <td width="10%" valign="middle">
                                                    <% if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("capturarBiometrico")){ %>
                                                          <input name="biometricos" type="button" id="biometricos" onclick="Biometria()" value="Biometricos" />
                                                    <% }else{ %>
                                                          <input name="biometricos" type="button" id="biometricos" onclick="Biometria()" value="Biometricos" disabled />
                                                    <% } %>
                                            </td>
                                   </tr>
							<tr style="border:none">
								<td colspan="5" align="center">
									<table align="center" width="100%" border="0">
										<tr id="mtv" style="display:none">
											<td colspan="2" align="right"><span class="style3">MOTIVO RECHAZO HUELLA DIGITAL </span></td>
											<td colspan="3" align="left">
											   <select name="motivos" id="motivos" style="width:180px; font-size:11px">
											<% list= model.listadoParametros(331);
											   it = list.iterator();
									   			while (it.hasNext()) {
													Parametro parametro = (Parametro)it.next();
													if(tipoDocumento.equals(parametro.getCodigo()+"")){ %>
														<option value="<%=parametro.getCodigo()+""%>" selected="selected"><%=parametro.getNombre()%></option>
												 <% }else{ %>
														<option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
												  <%}
												} %>
        			                          </select>
										    </td>
										</tr>
									</table>
								</td>
							</tr>
			  </table>
			  </fieldset>		  </td>
		</tr>
		<tr>
		  <td height="51" colspan="4">
			<table width="791" border="0">
				<tr bgcolor="#CCCCCC" class="style3">
				  <td width="186"   class="Estilo6"><div align="center" class="style3">DEPARTAMENTO</div></td>
					<td width="160" class="Estilo15"><label></label>
				  <div align="center">MUNICIPIO</div></td>
				  <td width="283" class="Estilo6"><div align="center" class="Estilo25">DIRECCION RESIDENCIA </div></td>
				  <td width="144" class="Estilo6"><div align="center" class="Estilo25">TELEFONO</div></td>
				</tr>
				<tr>
					<td class="Estilo4">
					<select name="dir_departamento" style="width:180px" onchange="buscarDirMunicipios(); return false" onblur=	"buscarDirMunicipios(); return false">
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
								 <select name="dir_municipio" id="dir_municipio" style="width:180px">
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
                                                                <td class="Estilo4" align="left"><input type="text" name="direccion" style="width:280px" disabled="disabled" value="<%=direccion%>"/></td>
					<td class="Estilo4"><input type="text" name="telefono" disabled="disabled" value="<%=telefonoDireccion%>"/></td>
				</tr>
			</table>		  </td>
		</tr>
		<% }else{ %>
			<tr id="datosEmpresa">
			  <td colspan="4">
				<table width="797" border="0" bordercolor = "#FFFFFF" align="center"  cellpadding="0" cellspacing="0">

				   <tr class="style3">
					  <td width="185" height="30" align="left" class="Estilo2"><span class="Estilo15">EXPEDIDO EN </span></td>
					  <td width="224" align="left"><span class="Estilo15">
					  <select name="nacionalidad2" style="width:180px">
						<option>COLOMBIA</option>
					  </select>
					 </span> </td>
					  <td width="170" align="left"> <span class="Estilo15">FECHA DE EXPEDICION </span></td>
					  <td width="218" align="left"><span class="Estilo18">
					    <label>
						<input  id="fecha_expedicion2" name="fecha_expedicion2"  style="text-align:center" value="<%=fechaExpedicion%>" onkeyup="mascara(this,'/',true)" maxlength="10" alt="DD/MM/AAAA"/>
						<input name="lanzador2" type="button" id="lanzador2" value="..." />
						<script type="text/javascript">
						Calendar.setup({
							inputField     :    "fecha_expedicion2",      // id del campo de texto
							ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
							button         :    "lanzador2"   // el id del bot&oacute;n que lanzar&aacute; el calendario
						});
						</script>
					    </label>
				     </span></td>
				  </tr>
					  <tr class="style3">
						  <td width="185" height="30" align="left"><span class="Estilo15">DEPARTAMENTO</span></td>
						  <td width="224" align="left"><span class="Estilo15">
						  <select name="departamento2"  style="width:180px"  onchange="buscarMunicipios2(); return false" >
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
							<td align="left" class="Estilo4"><span class="Estilo18">MUNICIPIO EXPEDICION </span></td>
							<td align="left"><div class="Estilo15" id="municipios2">
							<select name="municipio2" id="municipio2" style="width:180px">
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
							</select></div></td>
				  </tr>
					  <tr class="style3">
						<td width="185" height="30" align="left" class="Estilo2"><span class="Estilo15">NOMBRE/RAZON SOCIAL </span></td>
						<td width="224" align="left">
						<input name="razon_social" type="text" style="width:180px"  value="<%=razonSocial%>"/></td>
						<td width="170" align="left" class="Estilo2"><span class="Estilo15">SIGLA&nbsp; </span></td>
						<td width="218"  align="left">
						<input name="sigla" type="text"  style="width:180px"  value="<%=sigla%>"/>      </td>
				  </tr>
					  <tr class="style3">
						<td align="left" height="30" class="Estilo2"><span class="Estilo15">TIPO ENTIDAD </span></td>
						<td align="left">
						  <span style="font-size: 12px">
						  <select name="tipo_entidad" style="width:180px">
						    <% list= model.listadoParametros(328);
												 it = list.iterator();
												 while (it.hasNext()) {
													 Parametro parametro = (Parametro)it.next();
													 if(tipoEntidad.equals(parametro.getNombre()+"")){ %>
						    <option value="<%=parametro.getNombre()%>" selected="selected"><%=parametro.getNombre()%></option>
						          <% }else{ %>
						    <option value="<%=parametro.getNombre()%>"><%=parametro.getNombre()%></option>
						         <%}
												 } %>
				          </select>
					    </span></td>
						<td align="left" class="Estilo2"><span class="Estilo15">TIPO SOCIEDAD </span></td>
						<td align="left">
						  <span style="font-size: 12px">
						  <select name="tipo_sociedad" style="width:180px">
						    <% list= model.listadoParametros(329);
												 it = list.iterator();
												 while (it.hasNext()) {
													 Parametro parametro = (Parametro)it.next();
													 if(tipoSociedad.equals(parametro.getNombre()+"")){ %>
						    <option value="<%=parametro.getNombre()%>" selected="selected"><%=parametro.getNombre()%></option>
						          <% }else{ %>
						    <option value="<%=parametro.getNombre()%>"><%=parametro.getNombre()%></option>
						         <%}
												 } %>
				          </select>
					    </span></td>
				  </tr>
					<tr class="style3">
					  <td align="left" height="30" class="Estilo2"><span class="Estilo15">PRESTADOR SERVICIOS </span></td>
					  <td align="left">
						  <span style="font-size: 12px">
						  <select name="prestador_servicio" id="prestador_servicio" style="width:180px">
						    <option value="N" <%=prestadorServicio=="N"?"selected":""%>>NO</option>
						    <option value="S" <%=prestadorServicio=="S"?"selected":""%>>SI</option>
				          </select>
					    </span>
					 </td>
					 <td align="left" class="Estilo2"><span class="Estilo15">DIRECCION E-MAIL </span></td>
					 <td align="left"><span class="Estilo15">
						<label>
						  <input name="email2" type="text" id="email2"  style="width:180px" value="<%=emailEmpresa%>"/>
						</label>
					  </span></td>
				  </tr>
					<tr class="style3">
					  <td align="left" height="30" class="Estilo2"><span class="Estilo15"> NUMERO DE FAX </span></td>
					  <td align="left"><span class="Estilo15">
						<label>
						  <input name="fax" type="text" id="fax"  style="width:180px" value="<%=fax%>"/>
					  </label>
					  </span></td>
					  <td align="left"><span class="Estilo15">NUMERO CELULAR </span></td>
					  <td align="left"><span class="Estilo15">
						<label>
						  <input name="celular2" type="text" id="celular2"  style="width:180px" value="<%=celularEmpresa%>"/>
					  </label>
					  </span></td>
				  </tr>
					<tr class="style3">
					  <td align="left" height="30" class="Estilo2"><span class="Estilo15">CAPITAL PAGADO </span></td>
					  <td align="left"><span class="Estilo15">
						<label>
						  <input name="capital_pagado" type="text" id="capital_pagado"  style="width:180px" value="<%=capitalPagado%>"/>
					  </label>
					  </span></td>
					  <td align="left" class="Estilo2"><span class="Estilo15">PATRIMONIO LIQUIDO </span></td>
					  <td align="left"><span class="Estilo15">
						<label>
						  <input name="patrimonio_liquido" type="text" id="patrimonio_liquido"  style="width:180px" value="<%=patrimonioLiquido%>"/>
						</label>
					  </span></td>
				  </tr>
					<tr class="style3">
						<td align="left" height="30" class="Estilo2"><span class="Estilo15">CERTF. REPRESENTANTE </span></td>
						<td align="left"><span class="Estilo15">
						<label>
						  <input name="nro_certificado" type="text" id="nro_certificado"  style="width:180px" value="<%=certificadoRepresentante%>"/>
					    </label>
					  </span></td>
				  </tr>
                    <tr>
					  <td height="51" colspan="4">
						<table width="791" border="0">
							<tr bgcolor="#CCCCCC" class="style3">
							  <td width="186"   class="Estilo6"><div align="center" class="Estilo7 Estilo15">DEPARTAMENTO</div></td>
								<td width="160" class="Estilo15"><label></label>
							  <div align="center">MUNICIPIO</div></td>
							  <td width="283" class="Estilo6"><div align="center" class="Estilo25">DIRECCION RESIDENCIA </div></td>
							  <td width="144" class="Estilo6"><div align="center" class="Estilo25">TELEFONO</div></td>
						  </tr>
							<tr>
								<td class="Estilo4">
								<select name="dir_departamento2" style="width:180px" onchange="buscarDirMunicipios2(); return false" onblur=	"buscarDirMunicipios2(); return false">
										   <% listaDepar_per = model.crearListaDpto();
											   it_dep_per = listaDepar_per.iterator();
											   while (it_dep_per.hasNext()) {
													Departamento dpto = (Departamento)it_dep_per.next();
													if(departamentoDireccion2.equals(dpto.getId_departamento()+"")){ %>
														<option value="<%=dpto.getId_departamento()+""%>" selected><%=dpto.getNombre()%></option>
												 <% }else{ %>
														<option value="<%=dpto.getId_departamento()+""%>"><%=dpto.getNombre()%></option>
												 <% }
											   }%>
								</select></td>
								<td class="Estilo4"><div align="center" id="dir_municipios2">
											 <select name="dir_municipio2" id="dir_municipio2" style="width:180px">
											 <% if(departamentoDireccion2.length()>0){
													java.util.List lista = model.crearListaMunicipios(Integer.parseInt(departamentoDireccion2));
													for (int i = 0; i < lista.size(); i++) {
														Municipio municipio = (Municipio) lista.get(i);
														if(municipioDireccion2.equals(municipio.getCodigo()+"")){ %>
															<option value="<%=municipio.getCodigo() + ""%>" selected><%=municipio.getNombre()%></option>
													 <% }else{ %>
															<option value="<%=municipio.getCodigo() + ""%>"><%=municipio.getNombre()%></option>
											<%	        }
													}
												}%>
											</select>
											</div></td>
								<td class="Estilo4" align="left">
									<input type="text" name="direccion2" style="width:280px" disabled="disabled" value="<%=direccion2%>"/></td>
								<td class="Estilo4"><input type="text" name="telefono2" disabled="disabled" value="<%=telefonoDireccion2%>"/></td>
							</tr>
						</table>		  </td>
					</tr>



					<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					</tr>
				</table>
					<fieldset>
                         <div align="center">
                          <legend align="center" class="style1 Estilo18 style5 style6 style7 style2"><strong>REPRESENTANTE LEGAL </strong></legend>
                         </div>
					<table width="791" border="0" bordercolor="">

					<tr>
						<td width="185" height="30" align="left" class="Estilo2"><span class="style3">TIPO DOCUMENTO </span></td>
					    <td width="224"  align="left"><span class="Estilo4">
						<label>
						   <select name="tipo_documento" id="tipo_documento" style="width:180px; font-size:11px">
							  <% list= model.listadoParametros(5);
												 it = list.iterator();
												 while (it.hasNext()) {
													 Parametro parametro = (Parametro)it.next();
													 if(tipoDocumentoRepresentante.equals(parametro.getCodigo()+"")){ %>
														<option value="<%=parametro.getCodigo()+""%>" selected="selected"><%=parametro.getNombre()%></option>
												  <% }else{ %>
														<option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
												   <%}
												 } %>
						  </select>
					  </label>
					  </span></td>
					  <td width="170" align="left" class="Estilo2"><span class="style3">NUMERO DOCUMENTO </span></td>
					  <td width="218" align="left">
					  <input name="documento2" id="documento2" type="text" onBlur="queryPerson()"  style="width:180px" value="<%=numeroDocumentoRepresentante%>"/>	</td>
				  </tr>
					  <tr>
						<td height="30" align="left" class="Estilo2"><span class="style3">NOMBRE REPRESENTANTE </span></td>
						<td colspan="2" align="left"><div align="left" id="divPersona"></div></td>
					  </tr>
					<tr>
						<td height="30" class="Estilo2" align="left"><span class="style3">TIPO DE CONTRATO </span></td>
						<td align="left"><input name="tipo_contrato" type="text" style="width:180px" value="<%=tipoContrato%>"/></td>
						<td class="Estilo2" align="left"><span class="style3">FECHA REPRESENTACION </span></td>
						<td align="left"><span class="Estilo4">
						  <label>
						  <input  id="fecha_representacion" name="fecha_representacion" style="text-align:center" value="<%=fechaInicioRepresentante%>" onkeyup="mascara(this,'/',true)" maxlength="10"/>
						  <input name="lanzador3" type="button" id="lanzador3" value="..." />
						  <script type="text/javascript">
						Calendar.setup({
							inputField     :    "fecha_representacion",      // id del campo de texto
							ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
							button         :    "lanzador3"   // el id del bot&oacute;n que lanzar&aacute; el calendario
						});
						  </script>
						  </label>
						</span></td>
					</tr>
					<tr>
					  <td height="30" class="Estilo2" align="left"><span class="style3">ESTADO REPRESENTANCION</span></td>
					  <td align="left">
					  <select name="estado_repre" style="width:180px">
					  <% list= model.listadoParametros(330);
									 it = list.iterator();
									 while (it.hasNext()) {
										 Parametro parametro = (Parametro)it.next();
										 if(estadoRepresentacion.equals(parametro.getNombre()+"")){ %>
											<option value="<%=parametro.getNombre()%>" selected="selected"><%=parametro.getNombre()%></option>
									  <% }else{ %>
											<option value="<%=parametro.getNombre()%>"><%=parametro.getNombre()%></option>
									   <%}
									 } %>
					  </select>			  </td>
					  <td class="Estilo2" align="left"><span class="style3">FECHA DE VIGENCIA </span></td>
					  <td align="left"><span class="Estilo4">
						<label>
						<input  id="fecha_vigencia" name="fecha_vigencia" style="text-align:center" value="<%=fechaVigenciaRepresentante%>" onkeyup="mascara(this,'/',true)" maxlength="10"/>
						<input name="lanzador4" type="button" id="lanzador4" value="..." />
						<script type="text/javascript">
						Calendar.setup({
							inputField     :    "fecha_vigencia",      // id del campo de texto
							ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
							button         :    "lanzador4"   // el id del bot&oacute;n que lanzar&aacute; el calendario
						});
						  </script>
						</label>
					  </span></td>
				  </tr>
			   </table>		</fieldset>	  </td>
			</tr>
			<tr>
				 <td colspan="4" align="center">&nbsp;</td>
			</tr>
			<% }
			if(paso==1){ %>
			<tr>
                             <% if(model.tienePermiso(usuario.getId_usuario(), 33)){ %>
                                    <td colspan="2" align="center"><input type="button" name="actualizar" value="Actualizar Datos Transito" onclick="procesar(1,'inscribirPersonaRUNT.jsp',1)"/></td>
                             <% }else{ %>
                                    <td colspan="2" align="center">&nbsp;</td>
                             <% }
                                if(model.tienePermiso(usuario.getId_usuario(), 34)){ %>
                                    <td colspan="2" align="center"><input type="button" name="verificar" value="Verificacion RUNT" onclick="procesar(2,'consultarPersonaRUNT.jsp',0)"/>
                                    <input type="button" name="verificarS" value="Verificacion SIMIT" onclick="consultaSimit()"/></td>
                              <% }else{ %>
                                    <td colspan="2" align="center">&nbsp;</td>
                              <% } %>
			</tr>
	  <%   }
		   if(paso==2){ %>
			<tr>
                            <% if(model.tienePermiso(usuario.getId_usuario(), 32)){ %>
                                <td colspan="2" align="right"><input type="button" name="adicionar" value="Adicionar Datos Transito" onclick="procesar(3,'inscribirPersonaRUNT.jsp',1)"/></td>
                            <% }else{ %>
                                <td colspan="2" align="right">&nbsp;</td>
                            <% }
                               if(model.tienePermiso(usuario.getId_usuario(), 34)){ %>
				<td colspan="2" align="center"><input type="button" name="verificar" value="Verificacion RUNT" onclick="procesar(2,'consultarPersonaRUNT.jsp',0)"/>
                                <input type="button" name="verificarS" value="Verificacion SIMIT" onclick="consultaSimit()"/></td>
                            <% }else{ %>
                                <td colspan="2" align="center">&nbsp;</td>
                            <% } %>
			</tr>
	  <%   }
		   if(paso==3){ %>
			<tr>
                              <% if(model.tienePermiso(usuario.getId_usuario(), 33)&&model.tienePermiso(usuario.getId_usuario(), 36)){ %>
                                    <td colspan="4" align="center">
                                    <input type="button" name="actualizar" value="Actualizar Datos RUNT/Transito" onclick="procesar(4,'inscribirPersonaRUNT.jsp',1)"/>
                                    </td>
                              <% }else{ %>
                                    <td colspan="4" align="center">&nbsp;</td>
                             <% } %>
			</tr>
         <%   }
               if(paso==4){ %>
			<tr>
                            <% if(model.tienePermiso(usuario.getId_usuario(), 36)){ %>
				<td colspan="4" align="center">
                                    <input type="button" name="inscribir" value="Inscripcion RUNT" onclick="procesar(4,'inscribirPersonaRUNT.jsp',1)"/>
              </td>
                           <% }else{ %>
                                <td colspan="4" align="center">&nbsp;</td>
                             <% } %>
			</tr>
       <%   } %>
          </table>
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