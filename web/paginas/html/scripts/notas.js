/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var ActualInx
function DetallePago(inx,id_tiquete){
    var divEdit = document.getElementById('detallePago'+inx)

    if(document.getElementById('detPago'+inx).style.display=='none'){

        document.getElementById('detPago'+inx).style.display='block'
        cerrarAnterior()
        ActualInx = inx
        var ajax = new nuevoAjax()
        ajax.open('POST', 'consultarNotasCartera.jsp',true);
        ajax.onreadystatechange=function() {
            if (ajax.readyState == 4 && ajax.status == 200) {
                divEdit.innerHTML = ajax.responseText
                document.getElementById('detPago'+inx).style.display='block'

            }else if(ajax.readyState == 1){
                divEdit.appendChild(Cargando('NOTAS CARTERA'))
                document.getElementById('detPago'+inx).style.display='block'

            }
        }
        ajax.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
        ajax.send('id_nota_credito='+id_tiquete);




    }else{
        document.getElementById('detPago'+inx).style.display='none'
        divEdit.innerHTML=''
    }

}
function cerrarAnterior(){
    try{
    document.getElementById('detPago'+ActualInx).style.display='none'
    document.getElementById('detallePago'+ActualInx).innerHTML=''
    }catch(e){}
}


