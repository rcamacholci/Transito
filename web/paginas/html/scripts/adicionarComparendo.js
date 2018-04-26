/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function validarFormulario(){
    var comparendo = document.form.comparendo.value;
    if(comparendo.length>0){
        if(!isNaN(comparendo)){
            if(document.form.horas.selectedIndex!=0&&document.form.minutos.selectedIndex!=0){
                if(document.form.fecha.value.length==10){
                    if(document.form.lugar.value.length>5){
                        if(document.form.placa.value.length>4||document.form.placa.value.length==0){
                            if((document.form.clase.selectedIndex!=0&&document.form.placa.value.length>4)||document.form.clase.selectedIndex==0){
                                if((document.form.servicio.selectedIndex!=0&&document.form.placa.value.length>4)||document.form.servicio.selectedIndex==0){
                                    if(document.form.documento.value.length>4&&document.form.nombres.value.length>5){
                                        if(document.form.infraccion.value.length>0&&document.form.nombreInfraccion.value.length>0){
                                            if(document.form.fecha.value.length==10||document.form.fecha.value.length==0){
                                                if(document.form.placaAgente.value.length>0&&document.form.nombreAgente.value.length>0){
                                                    document.form.target = "proceso";
                                                    document.form.action = "procesarComparendo.jsp";
                                                    document.form.submit();
                                                }else{
                                                    alert("Digite el numero de placa del agente");
                                                }
                                            }else{
                                                alert("Digite la fecha de vencimiento de la licencia");
                                            }
                                        }else{
                                            alert("Digite el numero de la infraccion");
                                        }
                                    }else{
                                        alert("Digite el numero de identificacion de la persona");
                                    }
                                }else{
                                    alert("Digite el servicio del vehiculo");
                                }
                            }else{
                                alert("Digite la clase del vehiculo");
                            }
                        }else{
                            alert("Digite el numero de placa del automotor");
                        }
                    }else{
                        alert("Digite el lugar del comparendo");
                    }
                }else{
                    alert("Digite una fecha valida del comparendo (dd/mm/yyyy)");
                }
            }else{
                alert("Seleccione hora y minuto de causacion del comparendo");
            }
        }else{
            alert("El comparendo solo posee valores numericos");
        }
    }else{
        alert("Digite un numero de comparendo");
    }
}

function existeComparendo(input){
    var valor = input.value;
    var ajax = new nuevoAjax();
    ajax.open("POST", "getComparendo.jsp",true);
    ajax.onreadystatechange=function() {
        if (ajax.readyState==4) {
            var docxml = ajax.responseXML;
            var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue;
            if(result=='si'){
                alert("El numero de comparendo ya se encuentra registrado");
                document.form.guardar.disabled = true;
                document.form.placaAgente.value = "";
                document.form.nombreAgente.value= "";
                document.form.placaAgente.readOnly = false;
                document.form.nombreAgente.readOnly = false;
            }else{
                document.form.guardar.disabled = false;
                document.form.placaAgente.readOnly = false;
                document.form.nombreAgente.readOnly = false;
                document.form.placaAgente.value = "";
                document.form.nombreAgente.value= "";
                ConsultarAgenteRango(input);
            }
        }
    }
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("numero="+valor);
}

// Creado por Jefrey ConsultarAgenteRango

function ConsultarAgenteRango(input){
    var valor = input.value;
    var ajax = new nuevoAjax()
    ajax.open("POST", "getAgenteRango.jsp",true)
    ajax.onreadystatechange=function() {
         if (ajax.readyState==4) {
            var docxml = ajax.responseXML
            var placaAgente = docxml.getElementsByTagName('placa')[0].childNodes[0].nodeValue
            var nombreAgente = docxml.getElementsByTagName('nombre')[0].childNodes[0].nodeValue

             if(placaAgente!=null && nombreAgente!=null){
                document.form.placaAgente.value= placaAgente;
                document.form.nombreAgente.value= nombreAgente;
                document.form.placaAgente.readOnly = true;
                document.form.nombreAgente.readOnly = true;
            }

    }
    }
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
    ajax.send("numero="+valor)

}

function buscarPlaca(input){
    var placa = input.value;
    var ajax = new nuevoAjax();
    ajax.open("POST", "getPlacaVehiculo.jsp",true)
    ajax.onreadystatechange=function() {
        if (ajax.readyState==4){
            var docxml = ajax.responseXML;
            var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue;
            if(result=='si'){
                var clase = docxml.getElementsByTagName('clase')[0].childNodes[0].nodeValue;
                var servicio = docxml.getElementsByTagName('servicio')[0].childNodes[0].nodeValue;
                var licenciaT = docxml.getElementsByTagName('licenciaT')[0].childNodes[0].nodeValue;
                if(licenciaT=='0'){
                    document.form.licenciaTransito.value = "";
                    document.form.licenciaTransito.disabled = false;
                }else{
                    document.form.licenciaTransito.value = licenciaT;
                    document.form.licenciaTransito.disabled = true;
                }

                document.form.clase.value = clase;
                document.form.servicio.value = servicio;
                document.form.clase.disabled = true;
                document.form.servicio.disabled = true;
                CargarPub()
                buscarPropietario()
            }else{
                document.form.licenciaTransito.value = "";
                document.form.clase.disabled =false;
                document.form.servicio.disabled =false;
                document.form.licenciaTransito.disabled = false;
            }
        }
    }
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
    ajax.send("numero="+placa)
}

function listaInfraccion(){
    ancho = 400;
    alto = 360;
    barra = 0;
    izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
    arriba = (screen.height) ? (screen.height-alto)/2 : 100;
    opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars='+barra+',resizable=0,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
    url = "buscarInfraccion.jsp";
    window.open(url, 'popUp', opciones);
}

function buscarAgente(input){
    var placa = input.value
    if(placa.length>0){
        var ajax = new nuevoAjax()
        ajax.open("POST", "getAgente.jsp",true)
        ajax.onreadystatechange=function() {
            if (ajax.readyState==4) {
                var docxml = ajax.responseXML;
                var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue;
                if(result=='si'){
                    var nombre = docxml.getElementsByTagName('nombre')[0].childNodes[0].nodeValue
                    document.form.nombreAgente.value = nombre;
                }else{
                    document.form.nombreAgente.value='';
                    adicionarAgente(placa);
                }
            }
        }
        ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
        ajax.send("numero="+placa);
    }

}

function adicionarAgente(placa){
    ancho = 400;
    alto = 200;
    barra = 0;
    izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
    arriba = (screen.height) ? (screen.height-alto)/2 : 100;
    opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars='+barra+',resizable=0,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
    url = "adicionarAgente.jsp?placa="+placa;
    window.open(url, 'popUp', opciones);
}

function activarParqueadero(check){
    document.form.parqueaderos.disabled = !check.checked;
    document.form.Npatio.disabled = !check.checked;
    document.form.Dpatio.disabled = !check.checked;
    document.form.GruaN.disabled = !check.checked;
    document.form.Ncop.disabled = !check.checked;
    
}

function buscarLicenciaConduccion(){
    var numero=document.form.licenciaConduccion;
    var categoria = document.form.categoria;
    var sede_exp = document.form.sedeExpedicion;
    var fecha_venc = document.form.fechaVencimiento;
    var tipo = document.form.tipoDocumento.value;
    var documento = document.form.documento.value;
    var Bfecha_venc = document.form.bfechaVencimiento;
    var ajax= new nuevoAjax()
    ajax.open("POST", "getLicenciaConduccion.jsp",true)
    ajax.onreadystatechange=function() {
        if (ajax.readyState==4 && ajax.status == 200) {
            var docxml = ajax.responseXML
            var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue
            if(result=='si'){
                numero.value= docxml.getElementsByTagName('numero')[0].childNodes[0].nodeValue
                categoria.value= docxml.getElementsByTagName('categoria')[0].childNodes[0].nodeValue
                sede_exp.value = docxml.getElementsByTagName('sede_exp_id')[0].childNodes[0].nodeValue
                fecha_venc.value=docxml.getElementsByTagName('fecha_venc')[0].childNodes[0].nodeValue!='null'?docxml.getElementsByTagName('fecha_venc')[0].childNodes[0].nodeValue:''
                fecha_venc.disabled=true
                categoria.disabled=true
                sede_exp.disabled=true
                Bfecha_venc.disabled=true
                numero.disabled=true
            }else{
                categoria.selectedIndex=0
                sede_exp.selectedIndex=0
                fecha_venc.value=''
                numero.value=''
                numero.disabled=false
                Bfecha_venc.disabled=false
                fecha_venc.disabled=false
                categoria.disabled=false
                sede_exp.disabled=false
            }
        }
    }
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
    ajax.send('tipo='+tipo+'&documento='+documento)

}

