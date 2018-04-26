/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

var ActualInx
function DetalleAlerta(inx,id_alerta){
    var divEdit = document.getElementById('editarAlerta'+inx)

    if(document.getElementById('edAlerta'+inx).style.display=='none'){
        divEdit.appendChild(Cargando('DETALLES ALERTA'))
        document.getElementById('edAlerta'+inx).style.display='block'
        cerrarAnterior()
        ActualInx = inx
        var ajax = new nuevoAjax()
        ajax.open('POST', 'editarAlerta.jsp',true);
        ajax.onreadystatechange=function() {
            if (ajax.readyState == 4 && ajax.status == 200) {
                divEdit.innerHTML = ajax.responseText
                document.getElementById('edAlerta'+inx).style.display='block'
                Calendar.setup({
				inputField     :    "fecha_inicio",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "fechai"   // el id del bot?n que lanzar? el calendario
			});
                Calendar.setup({
				inputField     :    "fecha_fin",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "fechaf"   // el id del bot?n que lanzar? el calendario
			});
            }else if(ajax.readyState == 1){
                divEdit.appendChild(Cargando('DETALLES ALERTA'))
                document.getElementById('edAlerta'+inx).style.display='block'

            }
        }
        ajax.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
        ajax.send('id_alerta='+id_alerta);




    }else{
        document.getElementById('edAlerta'+inx).style.display='none'
        divEdit.innerHTML=''
    }
    
}
function cerrarAnterior(){
    try{
    document.getElementById('edAlerta'+ActualInx).style.display='none'
    document.getElementById('editarAlerta'+ActualInx).innerHTML=''
    }catch(e){}
}

function consultaPersona(){
	var tipo = document.getElementById("tipodocumento") ;
	var documento = document.getElementById("documento").value ;
	if(documento.length>0&&!isNaN(documento)){
		var tipoDoc = tipo.options[tipo.options.selectedIndex].value
		var ajax= new nuevoAjax();
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
                                        document.getElementById("nombres").value=''
				}else{
					document.getElementById("nombres").value = ajax.responseText;
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

function revisar(){
	if(document.getElementById("nombres").value.length>5){
		if(document.getElementById("fecha_inicio").value.length>0){
			if(document.getElementById("observacion").value.length>0){
                                if(document.getElementById("grado").value.length>0){
                                    //document.form.submit();
                                    return true
                                }else{
                                    alert("Seleccione el grado de Alerta");
                                    return false
                                }

			}else{
				alert("Digite alguna observacion");
                                return false
			}
		}else{
			alert("Seleccione fecha de inicio");
                        return false
		}
	}else{
		alert("Digite un numero de identificacion valido");
                return false
	}
        return false
}
function salir(){
	document.form.action = "verAlertas.jsp?id=1";
	document.form.submit();
}

function Editar(sw){
document.getElementById("nombres").disabled=sw
document.getElementById("tipoalerta").disabled=sw
document.getElementById("grado").disabled=sw
document.getElementById("fecha_inicio").disabled=sw
document.getElementById("fecha_fin").disabled=sw
document.getElementById("tipodocumento").disabled=sw
document.getElementById("documento").disabled = sw
document.getElementById("observacion").disabled = sw
document.getElementById('fechai').disabled = sw
document.getElementById('fechaf').disabled = sw

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
    var tipoalerta = document.getElementById("tipoalerta").value
    var grado = document.getElementById("grado").value
    var fecha_inicio = document.getElementById("fecha_inicio").value
    var fecha_fin = document.getElementById("fecha_fin").value
    var tipodocumento = document.getElementById("tipodocumento").value
    var documento = document.getElementById("documento").value    
    var observacion = document.getElementById("observacion").value

    Editar(true)

    if(revisar()){
        var parametros = 'nombre='+nombre+'&tipoalerta='+tipoalerta+
            '&grado='+grado+'&fecha_inicio='+fecha_inicio+
            '&fecha_fin='+fecha_fin+'&tipodocumento='+tipodocumento+
            '&documento='+documento+'&observacion='+observacion

        var ajax = new nuevoAjax()
            ajax.open('POST', 'actualizarAlerta.jsp',true);
            ajax.onreadystatechange=function() {
                if (ajax.readyState == 4 && ajax.status == 200) {
                    var xmldoc = ajax.responseXML
                    var result = xmldoc.getElementsByTagName('result')[0].childNodes[0].nodeValue
                    if(result=='si'){
                        alert('Alerta Actualizada!!')


                        parent.document.location.href="consultarAlertasVehiculo.jsp?id=1"
                    }else if(result=='no' ){
                        var error = xmldoc.getElementsByTagName('error')[0].childNodes[0].nodeValue
                        alert('No se puedo actualizar la alerta Error : '+error)
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