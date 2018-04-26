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

/********************************************************************************/
/*funciones globales*/
var nav4 = window.Event ? true : false;
function teclaPresionada(event){
    return nav4 ? event.which : event.keyCode
}

function soloNumeros(event){
// NOTE: Backspace = 8, Enter = 13, '0' = 48, '9' = 57
    var key = teclaPresionada(event);    
    return (key <= 13 || (key >= 48 && key <= 57)|| key === 46);
}

function Cargando(Titulo){
    var div = document.createElement('div')
    var img = document.createElement('img')
    var fieldset = document.createElement('fieldset')
    var legend = document.createElement('legend')
    var label = document.createElement('label')
    
    img.src = '../html/images/loading.gif'    

    img.style.width='25px'
    img.style.height='25px'
    

    label.innerHTML = 'Por&nbsp;favor&nbsp;espere...'
    label.style.top='50%'
    label.style.position='absolute'


    
    
    legend.innerHTML=Titulo

    
    div.style.fontFamily='Tahoma'
    div.style.fontSize='12px'
    div.style.color = '#333333'
    div.style.fontWeight='bold'
    div.width='150px'

    
    fieldset.style.width='auto'
    fieldset.style.width='150px'
    fieldset.appendChild(legend)
    fieldset.appendChild(img)
    fieldset.appendChild(label)
    
    div.appendChild(fieldset)



    return div
    
}


function quitarVacios(txt){
    String.prototype.trim = function() { return this.replace(/^\s+|\s+$/g, ""); };
    return txt.trim()
}