/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

  function nuevoAjax(){
		var xmlhttp= false;
		try{
			xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		}catch(e){
			try {
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}catch(E){
				xmlhttp = false;
			}
		}

		if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
			xmlhttp = new XMLHttpRequest();
		}

		return xmlhttp;
	}

function abrirVentanaAutenticar(tipo){
        var ancho = 400;
        var alto = 360;
        var izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
        var arriba = (screen.height) ? (screen.height-alto)/2 : 100;
        var opciones = 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
        var url = "autenticarUser.jsp?tipo="+tipo;
        var ventana = window.open(url, 'popUp', opciones);
}

