/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * Author     : Jorge Lopez
 */
var Placa_Consultada
var Documento_Consultado
var Tipo_Doc_Consultado
var Valor_T_finan
var TipoFinan
var ListaCartera

function consultaPersona(){
    var documento = document.getElementById('documento');
    if(!isNaN(documento.value)&&documento.value.length>0){
        var tipos = document.getElementById('tipos');
        var tipoDoc = tipos.value
        var ajax2= new nuevoAjax2();
        ajax2.open('POST', 'getPersona.jsp',true);
        ajax2.onreadystatechange=function() {
            if (ajax2.readyState==4) {
                var respuesta = "";
                for(var i = 0; i < ajax2.responseText.length ; i++){
					if(isNaN(ajax2.responseText.charAt(i))||ajax2.responseText.charAt(i)==' ')
						respuesta += ajax2.responseText.charAt(i);
				}
				if(respuesta.indexOf("nueva")!=-1){
					viewPersona(tipoDoc,documento.value);
				    Documento_Consultado = ''
                    Tipo_Doc_Consultado = ''
                }else{
                    document.getElementById('nombre_rs').value = respuesta;
                    Documento_Consultado = documento.value
                    Tipo_Doc_Consultado = tipos.value
                }
            }
        }
        ajax2.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
        ajax2.send('documento='+documento.value+'&tipo='+tipos.value);

    }
}


function viewPersona(tipo,numero){
    if(!isNaN(numero)){
	ancho = 689;
	alto = 250;
	barra = 0;
	izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
	arriba = (screen.height) ? (screen.height-alto)/2 : 100;
	opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars='+barra+',resizable=0,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
	url = "adicionarPersona.jsp?tipo="+tipo+"&documento="+numero;
	window.open(url, 'popUp', opciones);
    }
}

function consultarPlacas(){
    var placa = document.getElementById('placa')
    if(placa.value.length>=5 && placa.value.length<=6){
        window.frames.iframeCartera.location.href = 'verCarteraFinanciacion_Imp.jsp?id=1&placa='+placa.value;
        Placa_Consultada=placa.value
    }else{
        alert('Digite un numero de placa valida');
        Placa_Consultada=''
    }
}

function consultarPersonas(){
    //var placa = document.getElementsByName('placa')[0]
    var documento = document.getElementsByName('documento')[0]

    if(documento.value.length>=5 ){//&& placa.value.length<=11){

        var tipo = document.getElementsByName('tipos')[0];
        window.frames.iframeCartera.location.href = 'verCarteraFinanciacion_Imp.jsp?id=2&documento='+documento.value+'&tipo='+tipo.value;
        window.frames.iframeTipo.location.href = 'calcularTipoFinanciacion_Imp.jsp';
        Documento_Consultado = documento.value
        Tipo_Doc_Consultado = tipo.value
    }else{
        alert('Digite un numero de documento valido');
        Documento_Consultado = ''
        Tipo_Doc_Consultado = ''
    }
}


function consultarDatosFinanciacion(){
    var documento = document.getElementsByName('documento')[0]
    var placa =document.getElementsByName('placa')[0]


   // if(documento.value=='' && placa.value=='' ){
       // alert('Es necesario una placa y un documento !')
    //}else{
        if(placa.value!='' ){
            //if(documento.value!=''){
                //realiz la busqueda por placa y documento
                consultarPlacas()
                //consultaPersona()
            //}else{
               // alert('EL documento de la persona es necesario!!')
            //}
        }else if(documento.value!='' ){
            //&& placa.value==''
            //realiza la busqueda de por persona
            consultaPersona()
            consultarPersonas()

        }


    //}

}

function actualizarTipoF(check){
    //alert("valor de check= "+check.id);
    if(check.checked){
        window.parent.frames[1].location.href = "calcularTipoFinanciacion_Imp.jsp?id=1&add="+check.id;
    }else{
        window.parent.frames[1].location.href = "calcularTipoFinanciacion_Imp.jsp?id=0&add="+check.id;
    }
}


