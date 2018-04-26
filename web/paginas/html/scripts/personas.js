/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function viewPersona(tipo,numero){
    if(numero!=''){
        var ancho = 689;
        var alto = 250;
        var izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
        var arriba = (screen.height) ? (screen.height-alto)/2 : 100;
        var opciones = 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
        var url = "adicionarPersona.jsp?tipo="+tipo+"&documento="+numero;
        var ventana = window.open(url, 'popUp', opciones);
    }
}

