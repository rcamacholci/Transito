/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function anadirBanco(){
    ancho = 600;
    alto = 160;
    barra = 0;
    izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
    arriba = (screen.height) ? (screen.height-alto)/2 : 100;
    opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars='+barra+',resizable=0,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
    url = "adicionarBanco.jsp";
    window.open(url, 'popUp', opciones);
}

function anadirTipoPago(){
    ancho = 600;
    alto = 160;
    barra = 0;
    izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
    arriba = (screen.height) ? (screen.height-alto)/2 : 100;
    opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars='+barra+',resizable=0,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
    url = "adicionarTipoPago.jsp";
    window.open(url, 'popUp', opciones);
}

function anadirConcepto(){
    ancho = 600;
    alto = 160;
    barra = 0;
    izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
    arriba = (screen.height) ? (screen.height-alto)/2 : 100;
    opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars='+barra+',resizable=0,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
    url = "adicionarConcepto.jsp";
    window.open(url, 'popUp', opciones);
}