/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function nuevoAjax() {
    var xmlhttp = false;
    try {
        xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
        try {
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (E) {
            xmlhttp = false;
        }
    }

    if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
        xmlhttp = new XMLHttpRequest();
    }

    return xmlhttp;
}

function verificarTokenGenerado() {
    document.form.autenticar.value = "Cargando...";
    document.form.autenticar.disabled = true;
    var rta = "";
    var ajax = new nuevoAjax();
    ajax.open("POST", "verificarToken.jsp", true);
    ajax.onreadystatechange = function () {
        if (ajax.readyState == 4) {
            var docxml = ajax.responseXML;
            var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue;
            var mensaje = docxml.getElementsByTagName('mensaje')[0].childNodes[0].nodeValue;
            if (result == '1') {
                var trama = docxml.getElementsByTagName('trama')[0].childNodes[0].nodeValue;
                var obj = new ActiveXObject("IEActiveRUNT.IEActiveRUNT");
                rta = obj.Autenticar_Ciudadano(trama);
                if(rta.length>30){
                    document.getElementById("estado").value = "AUTENTICADO";
                    document.getElementById("prevalidar").style.display = "block";
                    document.getElementById("autenticar").style.display = "none";
                    document.getElementById("token").value = rta;
                }else{
                    document.getElementById("autenticar").style.display = "block";
                    document.form.autenticar.disabled = false;
                    alert("Error en el proceso, por favor intente nuevamente");
                }
            } 
            document.getElementById("autenticar").value = "Autenticar";
            document.form.autenticar.disabled = false;
            alert(mensaje);
        }
    }
    ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("Validacion=1");
}

function prevalidarHuella() {
    window.location.href = "validacionFuncionario.jsp?token=" + document.form.token.value;

    //     alert("Autenticacion  Correcta");
    //      eval("document.form.estado.value='AUTENTICADO'");
    //      eval("document.form.autenticar.disabled = true");
    //      document.form.continuar.disabled = false;
    //      eval("document.form.estado.value='AUTENTICADO'");
    //      eval("document.form.autenticar.disabled = true");
    //     document.form.autenticacion.value = "1";
}


function AUTENTICAR(tmp) {
    var rta = "";
    var template_R = tmp;
    var obj = new ActiveXObject("IEActiveRUNT.IEActiveRUNT");
    rta = obj.Autenticar_Ciudadano(template_R);
    document.form.token.value = rta;
    // alert("rta : "+rta);
    verificarTokenGenerado(rta);
}

function verificarEstadoTok() {
    var ajax = new nuevoAjax();
    ajax.open("POST", "verificarEstadoToken.jsp", true);
    ajax.onreadystatechange = function () {
        if (ajax.readyState == 4) {
            var docxml = ajax.responseXML;
            var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue;
            if (result == '1') {
                alert("Autenticacion Correcta");
                eval("document.form.estado.value='AUTENTICADO'");
                eval("document.form.autenticar.disabled = true");
                document.form.continuar.disabled = false;
                eval("document.form.estado.value='AUTENTICADO'");
                eval("document.form.autenticar.disabled = true");
                document.form.autenticacion.value = "1";
            } else {
                if (result == '2') {
                    alert("Autenticacion Falló, Favor vuelva Autenticarse");
                    document.location = "autenticarUsuario.jsp";

                }
            }
        }
    }
    ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("token3=" + document.form.token.value);
}



function editarPassRunt() {
    var ancho = 650;
    var alto = 200;
    var izquierda = (screen.width) ? (screen.width - ancho) / 2 : 100;
    var arriba = (screen.height) ? (screen.height - alto) / 2 : 100;
    var opciones = 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba;
    var url = "editarpasswordRunt.jsp";
    var ventana = window.open(url, 'popUp', opciones);
}
