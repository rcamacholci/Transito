/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function insertValTimbre(){
    var placa = document.form.numplaca.value;
    var idveh = document.form.idvehicu.value;
    var numfac = document.form.numfactura.value;
    var valtimbre = document.form.valortimbre.value;
    var vig = document.form.vigencia.value;
    var ajax = new nuevoAjax();
    ajax.open("POST", "procesarValorTimbre.jsp",true);
    ajax.onreadystatechange=function() {
        if (ajax.readyState==4) {
            var docxml = ajax.responseXML;
            var sws = docxml.getElementsByTagName('sw')[0].childNodes[0].nodeValue;
            var valort = docxml.getElementsByTagName('valorti')[0].childNodes[0].nodeValue;
            if(sws=="1"){
                window.parent.opener.window.location.href = "verLiquidacion.jsp?id=204&tipo=3&varete="+valort+"&placa="+placa;
                window.parent.close();
            }else{
                if(sws=="2"){
                    alert("Este numero de factura ya fue ingresado !!!");
                }else{
                    if(sws=="3"){
                        alert("La vigencia de esta factura no es la actual !!!");
                    }
                }
            }
        }
    }
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("idvehi="+idveh+"&nfact="+numfac+"&vtim="+valtimbre+"&vigen="+vig);
}