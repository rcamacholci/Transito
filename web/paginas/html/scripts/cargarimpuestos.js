/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function existenVehiculos(input){
    var valor = input.value;
    var ajax = new nuevoAjax();
    ajax.open("POST", "getEstado_Vehiculo.jsp",true);
    ajax.onreadystatechange=function() {
        if (ajax.readyState==4) {
            var docxml = ajax.responseXML;
            var vehi = docxml.getElementsByTagName('vehi')[0].childNodes[0].nodeValue;
            var estado = docxml.getElementsByTagName('estado')[0].childNodes[0].nodeValue;
            var fecha = docxml.getElementsByTagName('fecha')[0].childNodes[0].nodeValue;
            if(vehi=="0"){
                if(estado=="0"){
                    if(fecha=="1"){
                          alert("Este vehiculo no tiene fecha de matricula");
                          document.form.placa.value="";
                      }
                  }else{
                         alert("El vehiculo no se encuentra en estado Activo o Radicado");
                         document.form.placa.value="";
                      }
            }else{
                alert("Este Vehiculo no se encuentra registrado");
                document.form.placa.value="";
            }
        }
    }
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("numero="+valor);
}