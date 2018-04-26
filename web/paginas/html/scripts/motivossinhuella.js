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

function nuevoAjax2(){
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

function listadoTramitesByMotivo(){
	tabla = document.getElementById('cmbtramites');

	valor=document.form.cmbmotivo.options[document.form.cmbmotivo.selectedIndex].value;
	ajax1=new nuevoAjax();
	ajax1.open("POST", "cargarTramitesBymotivo.jsp",true);
	ajax1.onreadystatechange=function() {
		if (ajax1.readyState==4) {
			tabla.innerHTML = ajax1.responseText;
		}
	}
	ajax1.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	ajax1.send("motivo="+valor+"&name=cmbtramite");

}