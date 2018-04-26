/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function insertSubservicio(){
    var placa = document.form.numplaca.value;
    var idveh = document.form.idvehicu.value;
    var caracteristica = document.form.caracteristica.value;
    var parametro = document.form.parametro.value;
    var fecha_ini = document.form.fecha_inicial.value;
    var ajax = new nuevoAjax();
    ajax.open("POST", "procesarSubservicio.jsp",true);
    ajax.onreadystatechange=function() {
        if (ajax.readyState==4) {
            var docxml = ajax.responseXML;
            var sws = docxml.getElementsByTagName('sw')[0].childNodes[0].nodeValue;
            if(sws=="1"){
                //alert("Guardado Correctamente !!!");
                window.parent.opener.window.location.href = "verLiquidacion.jsp?id=204&tipo=3&placa="+placa;
                window.parent.close();
            }else{
                if(sws=="2"){
                    alert("La caracteristica no fue ingresada !!!");
                    window.parent.opener.window.location.href = "verLiquidacion.jsp?id=204&tipo=3&placa="+placa;
                    window.parent.close();
                }
            }
        }
    }
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("idvehi="+idveh+"&caracteristica="+caracteristica+"&parametro="+parametro+"&fecha_inicial="+fecha_ini+"&id=1");
}