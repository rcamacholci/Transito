/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


function procesarTaquilla(){
		var taquilla = document.getElementById("taquilla").value;
		var estado   = document.getElementById("estado").value;
                var codigo   = document.getElementById("codigo").value;
                var nombre   = document.getElementById("nombre").value;
                var date   = document.getElementById("date").value;
                var date2   = document.getElementById("date2").value;
		document.getElementById("accion").disabled = true;
		var ajax= new nuevoAjax();
		ajax.open("POST", "procesar_taquilla.jsp",true);
		ajax.onreadystatechange=function() {
			if (ajax.readyState==4) {
				if(ajax.responseText.indexOf("ERROR")==-1){
					document.location.href = "Transacciones_Taquilla.jsp?id_taquilla="+taquilla+"&codigo="+codigo+"&nombre="+nombre+"&date="+date+"&date2="+date2;
				}else{
					alert("No se pudo distribuir la taquilla!!");
					document.getElementById("accion").disabled = false;
				}
			}
		}
		ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		ajax.send("taquilla="+taquilla+"&estado="+estado);
	}
	function sombrear(tr){
		tr.style.backgroundColor="#CCCCCC";
	}
	function renovar(tr){
		tr.style.backgroundColor="#FFFFFF";
	}
	
	function atras(){
            	var nombre=document.getElementById("nombre").value;
            	var cod=document.getElementById("codigo").value;
            	var fechaI  = document.getElementById("date").value;
            	var fechaF  = document.getElementById("date2").value;
                window.location.href="lista_taquillas.jsp?codigo="+cod+"&nombre="+nombre+"&date="+fechaI+"&date2="+fechaF;
	}

function DetalleTiquete(id_tiquete){
    document.getElementById("tabla1").style.display = "none";
    document.getElementById("tabla2").style.display = "block";
    window.frames[0].location.href = "detallePago.jsp?id_tiquete="+id_tiquete;
    
}

function cerrar(){
    document.getElementById("tabla2").style.display = "none";
    document.getElementById("tabla1").style.display = "block";
}

function verReporte(dir,nombre){
    ancho = 789;
    alto = 600;
    barra = 0;
    izquierda = (document.width) ? (document.width-ancho)/2 : 100;
    arriba = (document.height) ? (document.height-alto)/2 : 100;
    opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
    url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
    window.open(url, 'popUp', opciones);
}

function verReporteNovedades(dir,nombre){
    ancho = 789;
    alto = 600;
    barra = 0;
    izquierda = (document.width) ? (document.width-ancho)/2 : 100;
    arriba = (document.height) ? (document.height-alto)/2 : 100;
    opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
    url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
    window.open(url, 'popUp', opciones);
}