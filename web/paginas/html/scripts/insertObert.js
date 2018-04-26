/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function insertObserr(){
    var placacomp = document.form.placa.value;
    var obser = document.form.observaciones.value;
    var tipodocumento = document.form.tipodocu.value;
    var ajax = new nuevoAjax();
    ajax.open("POST", "getInsertObser.jsp",true);
    ajax.onreadystatechange=function() {
        if (ajax.readyState==4) {
            var docxml = ajax.responseXML;
            var sws = docxml.getElementsByTagName('sw')[0].childNodes[0].nodeValue;
            if(sws=="1"){
                 alert("Observacion Agregada");
                 document.location.href = "consultarDocumento.jsp?placa="+placacomp+"&documento="+tipodocumento;
             }else{
                alert("Observacion no Agregada");
            }
        }
    }
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("placaveh="+placacomp+"&observacion="+obser);
}
