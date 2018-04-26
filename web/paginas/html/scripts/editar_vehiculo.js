/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


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
		tipo = document.getElementById("tipoDocumento") ;
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
						viewPersona(tipoDoc,documento);
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
						viewPersona(tipoDoc,documento);
					}else{
						document.getElementById("nombreAlerta").value = ajax.responseText;
					}
				}
			}
			ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			ajax.send("documento="+documento+"&tipo="+tipoDoc);
		}
	}

	function viewPersona(tipo,numero){
            if(!isNaN(numero)){
		ancho = 789;
		alto = 250;
		barra = 0;
		izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
		arriba = (screen.height) ? (screen.height-alto)/2 : 100;
		opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars='+barra+',resizable=0,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
		url = "adicionarPersona.jsp?tipo="+tipo+"&documento="+numero;
		window.open(url, 'popUp', opciones);
            }
	}

	function Despues(){
		document.getElementById('datosRadicacion').style.display = 'none';
		document.getElementById('formularioFUN').style.display = 'block';
	}

	function newP(){
   		window.frames[0].location.href = "radicarPropietarios.jsp?tipo=1&tipopropiedad=1&proindiviso=S";
    }

	function newC(){
   		window.frames[2].location.href = "radicarColores.jsp?tipo=1";
    }

	function verInput(codigo,name){
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
			combo = document.getElementById(name);
			codigo.value = combo.options[combo.options.selectedIndex].value
		}
		if(name=="marcas"){
			buscarLineas();
		}
	}

	

        


	function verModelo(campo){
		if(isNaN(campo.value)){
			campo.value = "";
		}else{
			if(parseInt(campo.value)<1940){
				campo.value = 1940;
			}else{
				if(parseInt(campo.value)>new Date().getFullYear()+1){
					campo.value = new Date().getFullYear();
				}
			}
		}
	}
	function view(name){
	/*
		document.getElementById('radicarPropietarios').style.display = 'none';
		document.getElementById('radicarEspecificaciones').style.display = 'none';
		document.getElementById('radicarCaracteristicas').style.display = 'none';
		document.getElementById('radicarColores').style.display = 'none';
		document.getElementById('radicarImportacion').style.display = 'none';
		document.getElementById('radicarAlertas').style.display = 'none';
		document.getElementById('radicarOrganismos').style.display = 'none';
		document.getElementById('radicarAseguradoras').style.display = 'none';
		document.getElementById('radicarObservaciones').style.display = 'none';

		document.getElementById('radicarPropietarios2').style.display = 'block';
		document.getElementById('radicarEspecificaciones2').style.display = 'block';
		document.getElementById('radicarCaracteristicas2').style.display = 'block';
		document.getElementById('radicarColores2').style.display = 'block';
		document.getElementById('radicarImportacion2').style.display = 'block';
		document.getElementById('radicarAlertas2').style.display = 'block';
		document.getElementById('radicarOrganismos2').style.display = 'block';
		document.getElementById('radicarAseguradoras2').style.display = 'block';
		document.getElementById('radicarObservaciones2').style.display = 'block';*/

		document.getElementById('panelPropietarios').style.display = 'none';
		document.getElementById('panelEspecificaciones').style.display = 'none';
		document.getElementById('panelCaracteristicas').style.display = 'none';
		document.getElementById('panelColores').style.display = 'none';
		document.getElementById('panelImportacion').style.display = 'none';
		document.getElementById('panelAlertas').style.display = 'none';
		document.getElementById('panelOrganismos').style.display = 'none';
		document.getElementById('panelAseguradoras').style.display = 'none';
		document.getElementById('panelObservaciones').style.display = 'none';
		document.getElementById('panelRunt').style.display = 'none';
		/*
		if(name!="Tramites"){
			document.getElementById('radicar'+name).style.display = 'block';
			document.getElementById('radicar'+name+'2').style.display = 'none';
		}*/
		document.getElementById('panel'+name).style.display = 'block';

	}

	function verCombo(combo,campo){
		document.getElementById('tipo'+campo).value = combo.options[combo.options.selectedIndex].value;
		if(campo=='Importacion'){
			if(combo.options[combo.options.selectedIndex].value==1){
				document.getElementById('tipoImpor').style.display = 'block';
				document.getElementById('tipoD').style.display = 'block';
				document.getElementById('tiposimpor').style.display = 'block';
				document.getElementById('tipoEntidad').style.display = 'none';
				document.getElementById('tipoE').style.display = 'none';
				document.getElementById('tiposentidades').style.display = 'none';
			}else{
				document.getElementById('tipoImpor').style.display = 'none';
				document.getElementById('tipoD').style.display = 'none';
				document.getElementById('tiposimpor').style.display = 'none';
				document.getElementById('tipoEntidad').style.display = 'block';
				document.getElementById('tipoE').style.display = 'block';
				document.getElementById('tiposentidades').style.display = 'block';
			}
		}else{
			if(campo=='Departamento'){
				buscarCiudades();
			}else{
				if(campo=='Marca'){
					buscarLineas();
				}
			}
		}
	}

	function buscarCiudades(){
		campo = document.getElementById('tipoDepartamento');
		codigo = document.getElementById('tipoCiudad');
		ajax= nuevoAjax();
		ajax.open("POST", "cargar_ciudades2.jsp",true);
		ajax.onreadystatechange=function() {
			if (ajax.readyState==4) {
				document.getElementById('ciudad').innerHTML = ajax.responseText;
				verCombo(document.getElementById('ciudades'),'Ciudad');
			}
		}
		ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		ajax.send("fk_dpto="+campo.value+"&codigo="+codigo.value);
	}


	function buscarLineas(){
		tabla = document.getElementById('lineasdiv');
		ck_li = document.getElementById('tipoMarca').value;
                t_l = document.getElementById('tipoL').value;
		var mr = ck_li;
		if(ck_li==0){
			mr = document.getElementById('marca_cod').value;
		}
		ln = document.getElementById('linea_cod').value;
		valor=document.getElementsByName('marcas').value;
		ajax2=nuevoAjax();
		ajax2.open("POST", "cargarLineas.jsp",true);
		ajax2.onreadystatechange=function() {
			if (ajax2.readyState==4) {
				tabla.innerHTML = ajax2.responseText;
			}
		}
		ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		ajax2.send("marca="+mr+"&linea="+ln+"&tipoL="+t_l);

	}

	function validar(sector){
		tramite = document.getElementById("ntramites");
		for(i=0;i < tramite.options.length ;i++){
			var dato = document.getElementById("fun"+tramite.options[i].value).value;
			if(dato.length ==0 ){
				alert("Digite Numeros de FUN del Tramite ["+tramite.options[i].value+"]");
				return false;
			}
		}
		if(sector=="panelPropietarios"){
			npropietarios = window.frames['prop'].document.getElementById("nprop").value;
			sumap = window.frames['prop'].document.getElementById("sumap").value;
			for(i=0;i<npropietarios;i++){
				if(window.frames['prop'].document.getElementById("tnombre"+i).value.length==0){
					alert("Ingrese un propietario valido, no deben existir campos en blanco");
					return false;
				}
			}
			if(npropietarios==0){
				alert("Debe ingresar por lo menos un propietario al vehiculo");
				return false;
			}
			if(sumap!=100){
				alert("Los porcentajes de propiedad deben ser igual a 100%");
				return false;
			}
			return true;
		}else{
			if(sector=="panelColores"){
				ncolores = window.frames['colr'].document.getElementById("ncolor").value;
				for(i=0;i<ncolores;i++){
					if(window.frames['colr'].document.getElementById("tcolor"+i).value.length==0){
						alert("Ingrese un color valido, no deben existir campos en blanco");
						return false;
					}
				}
				if(ncolores==0){
					alert("Debe ingresar por lo menos un color al vehiculo");
					return false;
				}
				return true;
			}else{
				if(sector=="panelOrganismos"){
					org = document.getElementById("organismos");
					if(org.options.selectedIndex ==0){
						alert("Seleccione el Organismo de Transito..");
						return false;
					}
					return true;
				}else{
					if(sector=="panelAlertas"){
						alrt = document.getElementById("nombreAlerta").value;
						if(alrt.length ==0){
							alert("Ingrese Numero de documento entidad/persona que pignora");
							return false;
						}
						return true;
					}else{
						if(sector=="panelAseguradoras"){
							n_as = document.getElementById("comboAseguradora").options.selectedIndex;
							if(n_as==0){
								alert("Seleccione una aseguradora de la lista");
								return false;
							}
							npol = document.getElementById("poliza").value;
							if(npol.length ==0){
								alert("Ingrese Numero de poliza de la aseguradora");
								return false;
							}
							nven = document.getElementById("vence").value;
							if(nven.length ==0){
								alert("Ingrese Fecha de vencimiento de la poliza de la aseguradora");
								return false;
							}
							return true;
						}else{
							if(sector=="panelEspecificaciones"){
								nespc = window.frames['espc'].document.getElementById("nespc").value;
								codespc = window.frames['espc'].document.getElementById("codespc");
								for(i=0;i<codespc.options.length;i++){
									if(window.frames['espc'].document.getElementById("obligado"+codespc.options[i].value)!=null){
										if(window.frames['espc'].document.getElementById("obligado"+codespc.options[i].value).value=="1"){
											if(window.frames['espc'].document.getElementById("valor"+codespc.options[i].value).value.length==0){
												alert("Ingrese algun valor en la especificacion ["+codespc.options[i].value+"]");
												return false;
											}
										}
									}
								}
								return true;
							}else{
								if(sector=="panelCaracteristicas"){
									clases = document.getElementById("clases");
									if(clases.options.selectedIndex!=0||clases.disabled){
										servicios = document.getElementById("servicios");
										if(servicios.options.selectedIndex!=0||servicios.disabled){
											marcas = document.getElementById("marcas");
											if(marcas.options.selectedIndex!=0||marcas.disabled){
												carrocerias = document.getElementById("carrocerias");
												if(carrocerias.options.selectedIndex!=0||carrocerias.disabled){
													modalidades = document.getElementById("modalidades");
													if(modalidades.options.selectedIndex!=0||modalidades.disabled){
														combustibles = document.getElementById("combustibles");
														if(combustibles.options.selectedIndex!=0||combustibles.disabled){
															modelo = document.getElementById("modelo");
															if(modelo.value.length>0||modelo.disabled){
																motor = document.getElementById("motor");
																if(motor.value.length>0||motor.disabled){
																	chasis = document.getElementById("chasis");
																	if(chasis.value.length>0||chasis.disabled){
																		serie = document.getElementById("serie");
																		if(serie.value.length>0||serie.disabled){
																			lineas = document.getElementById("lineas");
																			if(lineas!=null){
																				if(lineas.options.selectedIndex!=0||lineas.disabled){
																					return true;
																				}else{
																					alert("Seleccione una linea para el vehiculo");
																				}
																			}else{
																				alert("Seleccione una linea para el vehiculo");
																			}
																		}else{
																			alert("Digite el numero de serie del vehiculo");
																		}
																	}else{
																		alert("Digite el numero de chasis del vehiculo");
																	}
																}else{
																	alert("Digite el numero de motor del vehiculo");
																}
															}else{
																alert("Digite el modelo del vehiculo");
															}
														}else{
															alert("Seleccione un tipo de combustible para el vehiculo");
														}
													}else{
														alert("Seleccione una modalidad para el vehiculo");
													}
												}else{
													alert("Seleccione una carroceria para el vehiculo");
												}
											}else{
												alert("Seleccione una marca para el vehiculo");
											}
										}else{
											alert("Seleccione un servicio para el vehiculo");
										}
									}else{
										alert("Seleccione una clase para el vehiculo");
									}
									return false;
								}else{
									if(sector=="panelImportacion"){
										docimp = document.getElementById("documentoimp").value;
										fecimp = document.getElementById("fechadocumento").value;
										tipimp = document.getElementById("tiposimportaciones");
										tipdoc = document.getElementById("tiposimpor");
										tipent = document.getElementById("tiposentidades");
										depts = document.getElementById("departamentos");
										muncp = document.getElementById("ciudades");
										if(tipimp.options.selectedIndex!=0){
											if(tipimp.options.selectedIndex==1){
												if(tipdoc.options.selectedIndex==0){
													alert("Seleccione tipo de documento de importacion del vehiculo");
													return false;
												}
											}else{
												if(tipent.options.selectedIndex==0){
													alert("Seleccione tipo de entidad de importacion del vehiculo");
													return false;
												}
											}
											if(depts.options.selectedIndex!=0){
												if(muncp.options.selectedIndex!=0){
													if(docimp.length>0){
														if(fecimp.length>0){
															return true;
														}else{
															alert("Digite fecha de documento de importacion del vehiculo");
														}
													}else{
														alert("Digite numero de documento de importacion del vehiculo");
													}
												}else{
													alert("Seleccione ciudad de importacion del vehiculo");
												}
											}else{
												alert("Seleccione departamento de importacion del vehiculo");
											}
										}else{
											alert("Seleccione tipo de importacion del vehiculo");
										}
										return false;
									}
								}
							}
						}
					}
				}
			}
		}
		return true;
	}

	function next(){
		var secuencia = document.getElementById("secuencia");
		indice = parseInt(document.getElementById("idsecuencia").value) + 1;
		if(validar(secuencia.options[indice-1].value)){
			if(secuencia.options.length > indice ){
				document.getElementById("idsecuencia").value = indice;
				panel = secuencia.options[indice].value;
				document.getElementById("actionA").style.display = 'block';
				view(panel.substr(5,panel.length));
				if(indice + 1 == secuencia.options.length){
					document.getElementById("actionS").style.display = 'none';
				}
			}else{
				alert("No hay tramites disponibles..");
			}
		}
	}

	function past(){
		var secuencia = document.getElementById("secuencia");
		indice = parseInt(document.getElementById("idsecuencia").value) - 1;
		if(indice >= 0){
			document.getElementById("idsecuencia").value = indice;
			panel = secuencia.options[indice].value;
			document.getElementById("actionS").style.display = 'block';
			view(panel.substr(5,panel.length));
			if(indice == 0)
				document.getElementById("actionA").style.display = 'none';
		}

	}

	function evaluar(){
		tramite = document.getElementById("ntramites");
		placa = document.getElementById("placa").value;
		motor = document.getElementById("motor").value;
		chasis = document.getElementById("chasis").value;
		serie = document.getElementById("serie").value;
		for(i=0;i < tramite.options.length ;i++){
			var dato = document.getElementById("fun"+tramite.options[i].value).value;
                        var runt = document.getElementById("runt"+tramite.options[i].value).value;
			if(dato.length ==0 ){
				alert("Digite Numero FUN del Tramite ["+tramite.options[i].value+"]");
				return false;
			}
                        if(runt.length ==0 ){
				alert("Digite Numero RUNT del Tramite ["+tramite.options[i].value+"]");
				return false;
			}
			ajax3=nuevoAjax();
			ajax3.open("POST", "verificarDatos.jsp",true);
			ajax3.onreadystatechange=function() {
				if (ajax3.readyState==4) {
					if(ajax3.responseText.indexOf("existe")==-1){
						document.form.submit();
						return true;
					}else{
						alert(ajax3.responseText);
						return false;
					}
				}
			}
			ajax3.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			ajax3.send("placa="+placa+"&fun="+dato+"&motor="+motor+"&chasis="+chasis+"&serie="+serie+"&tramite="+tramite.options[i].value);
		}
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

		obj = new ActiveXObject("Identica_Runt.Bio_Main")
		var bc = document.form.bc.style.color=="rgb(51, 51, 51)"?0:1;
		var br = document.form.br.style.color=="rgb(51, 51, 51)"?0:1;
		var bh = document.form.bh.style.color=="rgb(51, 51, 51)"?0:1;
		var bf = document.form.bf.style.color=="rgb(51, 51, 51)"?0:1;

		rta = obj.Enrolar(ID,TIPO,N1,N2,A1,A2,FECHA,SEXO,1,1,0,1);
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




        function verificarDatos(){
            var sw = true

            var marcas = document.getElementById('marcas')
            var lineas = document.getElementById('lineas')
            var clases = document.getElementById('clases')
            var servicios = document.getElementById('servicios')
            var estado = document.getElementById('estado')
            var tiposimportaciones = document.getElementById('tiposimportaciones')
            var sede = document.getElementById('sede')
            var tiposimpor = document.getElementById('tiposimpor')

            var departamentos = document.getElementById('departamentos')
            var ciudades = document.getElementById('ciudades')
            var documentoimp = document.getElementById('documentoimp')
            var organismos= document.getElementById('organismos')
//            var numeroLicencia = document.getElementById('numeroLicencia')
/*
            if(marcas.selectedIndex==0){
                alert('Debe seleccionar una Maraca!')
                sw = false
            }
            if(lineas.selectedIndex==0){
                alert('Debe seleccionar una Linea!')
                sw = false
            }
            if(servicios.selectedIndex==0){
                alert('Debe seleccionar un Servicio!')
                sw = false
            }
            if(clases.selectedIndex==0){
                alert('Debe seleccionar una Clase!')
                sw = false
            }
            if(estado.selectedIndex==0){
                alert('Debe seleccionar un Estado!')
                sw = false
            }
            if(sede.selectedIndex==0){
                alert('Debe seleccionar una Sede')
                sw = false
            }
            */


            if(sw){
                document.getElementsByName('formEditarV')[0].action='actualizar_vehiculo.jsp'
                document.getElementsByName('formEditarV')[0].submit()
            }



        }


function cambiarSede(id_sede,nomCombSede){
            var comboList = document.getElementsByName(nomCombSede)[0]
            var length = comboList.length
            for(var i=0;i<length;i++){
                if(comboList.options[i].value==parseInt(id_sede)){
                    comboList.selectedIndex=i
                    break;
                }
            }


        }
