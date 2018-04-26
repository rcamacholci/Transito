/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function insertTipoPersona(){
    var idper = document.form.idpersona.value;
    var tipop = document.form.tipo.value;
    var placa = document.form.placa.value;
    var ajax = new nuevoAjax();
    ajax.open("POST", "procesarTipoPersona.jsp",true);
    ajax.onreadystatechange=function() {
        if (ajax.readyState==4) {
            var docxml = ajax.responseXML;
            var sws = docxml.getElementsByTagName('sw')[0].childNodes[0].nodeValue;
            if(sws=="1"){
                //window.parent.opener.window.location.href = "verLiquidacion.jsp?id=204&tipo=3&placa="+placa;
                window.parent.opener.window.location.href = "verLiquidacion.jsp?id=204&tipo=3&placa="+placa;
                window.parent.close();
            }else{
                   window.parent.close();
            }
        }
    }
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("idpersona="+idper+"&tipo="+tipop);
}