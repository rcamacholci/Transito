/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function existeVehiculo(input) {
    var valor = input.value;
    var ajax = new nuevoAjax();
    ajax.open("POST", "getVehiculo_Estado.jsp", true);
    ajax.onreadystatechange = function() {
        if (ajax.readyState == 4) {
            var docxml = ajax.responseXML;
            var vehi = docxml.getElementsByTagName('vehi')[0].childNodes[0].nodeValue;
            var estado = docxml.getElementsByTagName('estado')[0].childNodes[0].nodeValue;
            var fecha = docxml.getElementsByTagName('fecha')[0].childNodes[0].nodeValue;
            var cart = docxml.getElementsByTagName('cart')[0].childNodes[0].nodeValue;
            if (vehi == "0") {
                if (estado == "0") {
                    if (fecha == "0") {
                        if (cart == "1") {
                            alert("Este vehiculo tiene carteras activas");
                            document.form.placa.value = "";
                        }
                        existeRadicacion();
                    } else {
                        alert("Este vehiculo no tiene fecha de matricula");
                        document.form.placa.value = "";
                    }
                } else {
                    alert("El vehiculo no se encuentra en estado Trasladado");
                    document.form.placa.value = "";
                }
            } else {
                alert("Este Vehiculo no se encuentra registrado");
                document.form.placa.value = "";
            }
        }
    }
    ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("numero=" + valor);
}


function existeRadicacion() {
    var placa = document.form.placa.value;
    var radicacion = document.form.numR.value;
    if (placa.length > 0 && radicacion.length > 0) {
        var ajax = new nuevoAjax()
        ajax.open("POST", "getNumeroRadicacion.jsp", true)
        ajax.onreadystatechange = function() {
            if (ajax.readyState == 4) {
                var docxml = ajax.responseXML;
                var mensaje = docxml.getElementsByTagName('mensaje')[0].childNodes[0].nodeValue;
                if (mensaje != "si") {
                    document.form.numR.value = "";
                    alert(mensaje);
                }
            }
        }
        ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        ajax.send('numero='+placa+'&numR='+radicacion);
    }
}