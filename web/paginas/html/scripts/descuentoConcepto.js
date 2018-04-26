/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function CalcularP(Vconcepto,porcentaje,tabla,id_configuracion,id_tramite){
    
    var VporConcepto = Vconcepto * porcentaje.value / 100;
    var Tconcepto = Vconcepto - VporConcepto;
    document.getElementById(tabla).value = Tconcepto;
   if(confirm("Desea aplicar el descuento? Valor:$"+Tconcepto)){
        if(document.form.noresolucion.value.length>0){
            if(document.form.fecha_resolucion.value.length>0){
                if(document.form.fecha_inicial.value.length>0){
                    if(document.form.fecha_final.value.length>0){
                            AplicarDescuentoConcepto(id_configuracion,porcentaje.value,id_tramite,Tconcepto);
                    }else{
                        alert("Seleccione Fecha Final");
                    }
                }else{
                    alert("Seleccione Fecha Inicial");
                }
            }else{
                alert("Seleccione Fecha de Resolucion");
            }
        }else{
            alert("No se ha digitado No de Resolución");
        }

}else{
        
   }
}

function AplicarDescuentoConcepto(id_configuracion,porcentaje,id_tramite,valor){
    alert(valor);
   var fecha_inicial = document.form.fecha_inicial.value;
   var fecha_final = document.form.fecha_final.value;
   var noresolucion = document.form.noresolucion.value;
   var fecha_resolucion = document.form.fecha_resolucion.value;
   var ajax= new nuevoAjax();
        ajax.open("POST", "aplicarDescuentoConcepto.jsp",true);
        ajax.onreadystatechange=function() {
            if (ajax.readyState==4 && ajax.status == 200) {
                var docxml = ajax.responseXML
                var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue
                if(result == 'si'){
                    alert("Descuento Aplicado correctamente");
                }else{
                    alert("Error al aplicar Descuento");
                }
            }
        }
        ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
        ajax.send("id_configuracion="+id_configuracion+"&porcentaje="+porcentaje+"&fecha_inicial="+fecha_inicial+"&fecha_final="+fecha_final+"&noresolucion="+noresolucion+"&fecha_resolucion="+fecha_resolucion+"&id_tramite="+id_tramite+"&valor="+valor);
    
}