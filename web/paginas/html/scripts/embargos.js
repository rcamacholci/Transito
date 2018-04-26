/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var ActualInx
function EditarEmb(inx,id_embargo){
    var divEdit = document.getElementById('editarEmbargo'+inx)

    if(document.getElementById('edEmb'+inx).style.display=='none'){
        
        document.getElementById('edEmb'+inx).style.display='block'
        cerrarAnterior()
        ActualInx = inx
        var ajax = new nuevoAjax()        
        ajax.open('POST', 'editarEmbargo.jsp',true);
        ajax.onreadystatechange=function() {
            if (ajax.readyState == 4 && ajax.status == 200) {
                divEdit.innerHTML = ajax.responseText
                document.getElementById('edEmb'+inx).style.display='block'
                Calendar.setup({
				inputField     :    "fecha_oficio",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "fecha"   // el id del bot?n que lanzar? el calendario
			});
            }else if(ajax.readyState == 1){
                divEdit.appendChild(Cargando('Detalles Embargo'))
                document.getElementById('edEmb'+inx).style.display='block'
                
            }
        }
        ajax.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
        ajax.send('id_embargo='+id_embargo);



        
    }else{
        document.getElementById('edEmb'+inx).style.display='none'
        divEdit.innerHTML=''
    }
}
function cerrarAnterior(){
    try{
    document.getElementById('edEmb'+ActualInx).style.display='none'
    document.getElementById('editarEmbargo'+ActualInx).innerHTML=''
    }catch(e){}
}


function buscarMunicipios(){
	tabla = document.getElementById('municipios');
	valor=document.form.departamento.options[document.form.departamento.selectedIndex].value;
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
function consultaPersona(){
	var tipo = document.getElementById("tipodocumento").value ;
	var documento = document.getElementById("documento").value ;
	if(documento.length>0&&!isNaN(documento)){
		
		var ajax= new nuevoAjax();
		ajax.open("POST", "getPersona.jsp",true);
		ajax.onreadystatechange=function() {
			if (ajax.readyState == 4 && ajax.status == 200) {
				var respuesta = "" ;
				for(var i = 0; i < ajax.responseText.length ; i++){
					if(isNaN(ajax.responseText.charAt(i)))
						respuesta += ajax.responseText.charAt(i);
				}
				if(respuesta == "nueva"){
					viewPersona(tipo,documento);
                                        document.getElementById("nombres").value=''
				}else{
					document.getElementById("nombres").value = ajax.responseText;
				}
			}
                        
		}
		ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		ajax.send("documento="+documento+"&tipo="+tipo);
	}else{
            document.getElementById("nombres").value=''
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

	function Editar(sw){
		document.getElementById("nombres").disabled=sw
		document.getElementById("proceso").disabled=sw
		document.getElementById("numero_oficio").disabled=sw
		document.getElementById("fecha_oficio").disabled=sw
		document.getElementById("departamento").disabled=sw
		document.getElementById("municipio").disabled=sw
		document.getElementById("tipodocumento").disabled=sw
		document.getElementById("documento").disabled=sw
		document.getElementById("demandante").disabled=sw
		document.getElementById("oficina").disabled=sw
		document.getElementById("tipoembargo").disabled=sw
		document.getElementById("fecha").disabled=sw
		document.getElementById("observacion").disabled=sw
		document.getElementById("fecha_levantamiento").disabled=sw
		document.getElementById("numero_levantamiento").disabled=sw
		document.getElementById("fechaL").disabled=sw
                document.getElementById("fecha_radicacion").disabled=sw
		document.getElementById("numero_radicacion").disabled=sw
		document.getElementById("fechaR").disabled=sw

                var beditar = document.getElementsByName('beditar')[0]
		if(!sw){
			beditar.value="Guardar"
			beditar.onclick = function(){
				actualizar()
			}
		}
	}

function actualizar(){
    var beditar = document.getElementsByName('beditar')[0]
    var bcancelar = document.getElementsByName('cancelar')[0]
    beditar.value = "ESPERE ..."
    beditar.disabled=true;
    bcancelar.disabled=true;
    


    var nombre = document.getElementById("nombres").value
    var proceso = document.getElementById("proceso").value
    var numero_oficio = document.getElementById("numero_oficio").value
    var fecha_oficio = document.getElementById("fecha_oficio").value
    var departamento = document.getElementById("departamento").value
    var municipio = document.getElementById("municipio").value
    var tipodocumento = document.getElementById("tipodocumento").value
    var documento = document.getElementById("documento").value
    var demandante = document.getElementById("demandante").value
    var oficina = document.getElementById("oficina").value
    var tipoembargo = document.getElementById("tipoembargo").value    
    var observacion = document.getElementById("observacion").value
    var fecha_levantamiento = document.getElementById("fecha_levantamiento").value
    var numero_levantamiento = document.getElementById("numero_levantamiento").value
    var fecha_radicacion = document.getElementById("fecha_radicacion").value
    var numero_radicacion = document.getElementById("numero_radicacion").value

    Editar(true)

    if(revisar()){
        var parametros = 'nombre='+nombre+'&proceso='+proceso+
            '&numero_oficio='+numero_oficio+'&fecha_oficio='+fecha_oficio+
            '&departamento='+departamento+'&municipio='+municipio+'&tipodocumento='+tipodocumento+
            '&documento='+documento+'&demandante='+demandante+'&oficina='+oficina+
            '&tipoembargo='+tipoembargo+'&observacion='+observacion+'&fecha_levantamiento='+fecha_levantamiento+
            '&numero_levantamiento='+numero_levantamiento+'&numero_radicacion='+numero_radicacion+'&fecha_radicacion='+fecha_radicacion

//
        var ajax = new nuevoAjax()
            ajax.open('POST', 'actualizarEmbargo.jsp',true);
            ajax.onreadystatechange=function() {
                if (ajax.readyState == 4 && ajax.status == 200) {
                    var xmldoc = ajax.responseXML
                    var result = xmldoc.getElementsByTagName('result')[0].childNodes[0].nodeValue
                    if(result=='si'){
                        alert('Embargo Actualizado!!')
                        

                        parent.document.location.href="consultarEmbargosVehiculo.jsp?id=1"
                    }else if(result=='no' ){
                        var error = xmldoc.getElementsByTagName('error')[0].childNodes[0].nodeValue
                        alert('No se puedo actualizar el embargo Error : '+error)

                        Editar(false)
                        beditar.disabled=false;
                        bcancelar.disabled=false;
                    }
                    
                }
            }
            ajax.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
            ajax.send(parametros);

    }else{
        Editar(false)
        beditar.disabled=false;
        
        bcancelar.disabled=false;

    }



    


}
function salir(){
	document.form.action = "verEmbargos.jsp?id=1";
	document.form.submit();
}

function revisar(){
        String.prototype.trim = function() { return this.replace(/^\s+|\s+$/g, ""); };
	var nombres = document.getElementById("nombres")
        var demandante = document.getElementById("demandante")
        var proceso = document.getElementById("proceso")
        var numero_oficio = document.getElementById("numero_oficio")
        var fecha_oficio = document.getElementById("fecha_oficio")
        var observacion = document.getElementById("observacion")
        var fecha_radicacion = document.getElementById("fecha_radicacion")
        var numero_radicacion = document.getElementById("numero_radicacion")


        if(demandante.value.trim() == '' &&  nombres.value.trim()==''){
            alert("Digite una cedula valida o el nombre del Demandante");
            return false
        }
        
        if(proceso.value.trim()==''){
            alert("Digite Numero de proceso")
            return false            
        }
        if(numero_oficio.value.trim()==''){
            alert("Digite Numero Oficio")
            return false
        }
        if(fecha_oficio.value.trim()==''){
            alert("Digite la Fecha de Oficio")
            return false
        }

        if(numero_radicacion.value.trim()==''){
            alert("Digite Numero Radicacion")
            return false
        }
        if(fecha_radicacion.value.trim()==''){
            alert("Digite la Fecha de Radicacion")
            return false
        }

        if(observacion.value.trim()==''){
            alert("Digite alguna observación")
            return false
        }

        return true;	
	
}

function registrarEmbargo(){
    if(confirm("Confirme el registro de este embargo?")){
    if(revisar()){
        document.form.action='procesar_embargo.jsp'
        document.form.submit();
    }
    }

}