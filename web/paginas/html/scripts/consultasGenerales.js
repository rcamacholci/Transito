/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


/*
 *@name consultarPersona
 *@param id_tipoDoc ID campo tipo documento debe ser tipo select
 *@param id_Documento ID campo documento
 *@param id_input_set ID campo donde quedara el resultado
 *@description consulta una persona por el tipoy numero de  indentificacion
 *@return Nombres de la Persona (Natural/Juridica)
 *@example consultarPersona('tipo_doc','documento','nombres')
 **/
function consultaPersona(id_tipoDoc,id_Documento,id_input_set){
    var tipo = document.getElementById(id_tipoDoc);
    var documento = document.getElementById(id_Documento) ;
    if(documento.value.length>0){
        var ajax= new nuevoAjax();
        ajax.open("POST", "getPersona2.jsp",true);
        ajax.onreadystatechange=function() {
            if (ajax.readyState==4 && ajax.status == 200) {
                var docxml = ajax.responseXML
                var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue
                if(result == 'si'){
                    var nombres = docxml.getElementsByTagName('nombre1')[0].childNodes[0].nodeValue +' '+(docxml.getElementsByTagName('nombre2')[0].childNodes[0].nodeValue!='null'?docxml.getElementsByTagName('nombre2')[0].childNodes[0].nodeValue:'')
                    var apellidos = docxml.getElementsByTagName('apellido1')[0].childNodes[0].nodeValue + ' '+(docxml.getElementsByTagName('apellido2')[0].childNodes[0].nodeValue!='null'?docxml.getElementsByTagName('apellido2')[0].childNodes[0].nodeValue:'')
                    document.getElementById(id_input_set).value=nombres+' '+apellidos
                }else{
                    viewPersona(tipo.value,documento.value);
                    document.getElementById(id_input_set).value=''
                }
            }
        }
        ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
        ajax.send("documento="+documento.value+"&tipo="+tipo.value);
    }
}

function consultaPersonaINF(id_tipoDoc,id_Documento,id_input_set){
    var tipo = document.getElementById(id_tipoDoc);
    var documento = document.getElementById(id_Documento) ;
    if(documento.value.length>0){
        var ajax= new nuevoAjax();
        ajax.open("POST", "getPersonaComp.jsp",true);
        ajax.onreadystatechange=function() {
            if (ajax.readyState==4 && ajax.status == 200) {
                var docxml = ajax.responseXML
                var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue
                if(result == 'si'){
                    var nombres = docxml.getElementsByTagName('nombre1')[0].childNodes[0].nodeValue +' '+(docxml.getElementsByTagName('nombre2')[0].childNodes[0].nodeValue!='null'?docxml.getElementsByTagName('nombre2')[0].childNodes[0].nodeValue:'')
                    var apellidos = docxml.getElementsByTagName('apellido1')[0].childNodes[0].nodeValue + ' '+(docxml.getElementsByTagName('apellido2')[0].childNodes[0].nodeValue!='null'?docxml.getElementsByTagName('apellido2')[0].childNodes[0].nodeValue:'')
                    var direccion = docxml.getElementsByTagName('direccion')[0].childNodes[0].nodeValue + ' '+(docxml.getElementsByTagName('direccion')[0].childNodes[0].nodeValue!='null'?docxml.getElementsByTagName('direccion')[0].childNodes[0].nodeValue:'')
                    var email = docxml.getElementsByTagName('email')[0].childNodes[0].nodeValue + ' '+(docxml.getElementsByTagName('email')[0].childNodes[0].nodeValue!='null'?docxml.getElementsByTagName('email')[0].childNodes[0].nodeValue:'')
                    var telefono = docxml.getElementsByTagName('telefono')[0].childNodes[0].nodeValue
                    document.getElementById(id_input_set).value=nombres+' '+apellidos
                    document.form.dir_infractor.value = direccion;
                    document.form.email.value = email;
                    document.form.telefono.value = telefono;
                }else{
                    viewPersona(tipo.value,documento.value);
                    document.getElementById(id_input_set).value=''
                }
            }
        }
        ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
        ajax.send("documento="+documento.value+"&tipo="+tipo.value);
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