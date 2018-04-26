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

function RetencionF(idV,numplaca){
    ajax = nuevoAjax();
    ajax.open("POST", "Retencion.jsp",true);
    ajax.onreadystatechange=function() {
        if (ajax.readyState==4) {
            var docxml = ajax.responseXML;
            var valorRetencion = docxml.getElementsByTagName('valorRetencion')[0].childNodes[0].nodeValue;
            if(valorRetencion=="0"){
                var sw = docxml.getElementsByTagName('sw')[0].childNodes[0].nodeValue;
                if(sw=="1"){
                    agregarValorAvaluo(idV);
                }else{
                    if(sw=="2"){
                        agregarValorRetencion(idV);
                    }else{
                        alert(sw);
                    }
                }
            }else{
                document.location.href = "verLiquidacion.jsp?id=204&tipo=3&valorRetencion="+valorRetencion+"&placa="+numplaca;
            }
        }
    }
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("placa="+numplaca);
}

function agregarSubServicio(idV){
    var ancho = 689;
    var alto = 150;
    var barra = 0;
    var izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
    var arriba = (screen.height) ? (screen.height-alto)/2 : 100;
    var opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars='+barra+',resizable=0,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
    var url = "adicionarSubservicio.jsp?id="+idV;
    window.open(url, 'popUp', opciones);
}


function agregarTipoPersona(idpersona,nplaca){
    var ancho = 689;
    var alto = 150;
    var barra = 0;
    var izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
    var arriba = (screen.height) ? (screen.height-alto)/2 : 100;
    var opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars='+barra+',resizable=0,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
    var url = "adicionarTipoPersona.jsp?id_persona="+idpersona+"&placa="+nplaca;
    window.open(url, 'popUpT', opciones);
}

function agregarValorAvaluo(idV){
    var ancho = 689;
    var alto = 150;
    var barra = 0;
    var izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
    var arriba = (screen.height) ? (screen.height-alto)/2 : 100;
    var opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars='+barra+',resizable=0,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
    var url = "adicionarValorAvaluo.jsp?id="+idV;
    window.open(url, 'popUpV', opciones);
}

function agregarValorRetencion(idVeh){
    var ancho = 689;
    var alto = 350;
    var barra = 0;
    var izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
    var arriba = (screen.height) ? (screen.height-alto)/2 : 100;
    var opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars='+barra+',resizable=0,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
    var url = "adicionarValorRetencion.jsp?id="+idVeh;
    window.open(url, 'popUpR', opciones);
}

function adicionarValorAvaluo(idVehiculo,placaVeh,valorAvaluo){
    var ajax = new nuevoAjax();
    ajax.open("POST", "procesarValorAvaluo.jsp",true);
    ajax.onreadystatechange=function() {
        if (ajax.readyState==4) {
            var docxml = ajax.responseXML;
            var sw = docxml.getElementsByTagName('sw')[0].childNodes[0].nodeValue;
            var valorRetencion = docxml.getElementsByTagName('valorRetencion')[0].childNodes[0].nodeValue;
            if(sw=="1"){
                window.parent.opener.location.href = "verLiquidacion.jsp?id=204&tipo=3&valorRetencion="+valorRetencion+"&placa="+placaVeh;
                window.parent.close();
            }else{
                alert("Avaluo no se pudo registrar !!!");
            }
        }
    }
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("idVehiculo="+idVehiculo+"&valorAvaluo="+valorAvaluo);
}

function verComboRetencion(campo){
    if(campo=='TablaAvaluo'){
        document.getElementById('TRClaseVeh').style.display = "none";
        document.getElementById('TRMarcas').style.display = "none";
        document.getElementById('TRLineas').style.display = "none";
        document.getElementById('TRCilindrajes').style.display = "none";
        document.getElementById('TRCantPasajeros').style.display = "none";
        document.getElementById('TRCapaTonelaje').style.display = "none";
        document.getElementById('TRModelos').style.display = "none";
        document.getElementById('TRValorAvaluo').style.display = "none";
        document.getElementById('TRValorAvaluoM').style.display = "none";
        document.getElementById('TRGuardar').style.display = "none";

        var idtablaAva = document.getElementById('tablasAvaluo').value;
        if(idtablaAva != 0 ){
            if(idtablaAva == 5 || idtablaAva == 6 || idtablaAva == 7){
                document.getElementById('TRClaseVeh').style.display = "";
                buscarClases();
            }else{
                document.getElementById('TRMarcas').style.display = "";
                buscarMarcas();
            }
        }
    }

    if(campo=='Clase'){
        document.getElementById('TRMarcas').style.display = "none";
        document.getElementById('TRLineas').style.display = "none";
        document.getElementById('TRCilindrajes').style.display = "none";
        document.getElementById('TRCantPasajeros').style.display = "none";
        document.getElementById('TRCapaTonelaje').style.display = "none";
        document.getElementById('TRModelos').style.display = "none";
        document.getElementById('TRValorAvaluo').style.display = "none";
        document.getElementById('TRValorAvaluoM').style.display = "none";
        document.getElementById('TRGuardar').style.display = "none";

        var idclase = document.getElementById('clases').value;
        if(idclase != 0){
            document.getElementById('TRMarcas').style.display = "";
            buscarMarcas();
        }
    }

    if(campo=='Marca'){
        document.getElementById('TRCilindrajes').style.display = "none";
        document.getElementById('TRCantPasajeros').style.display = "none";
        document.getElementById('TRCapaTonelaje').style.display = "none";
        document.getElementById('TRModelos').style.display = "none";
        document.getElementById('TRValorAvaluo').style.display = "none";
        document.getElementById('TRValorAvaluoM').style.display = "none";
        document.getElementById('TRGuardar').style.display = "none";

        var idmarca = document.getElementById('marcas').value;
        if(idmarca!=0){
            document.getElementById('TRLineas').style.display = "";
            buscarLineas();
        }
    }

    if(campo=='Linea'){
        document.getElementById('TRCantPasajeros').style.display = "none";
        document.getElementById('TRCapaTonelaje').style.display = "none";
        document.getElementById('TRModelos').style.display = "none";
        document.getElementById('TRValorAvaluo').style.display = "none";
        document.getElementById('TRValorAvaluoM').style.display = "none";
        document.getElementById('TRGuardar').style.display = "none";

        var idtablaAva = document.getElementById('tablasAvaluo').value;
        var idlinea = document.getElementById('lineas').value;
        if(idlinea != 0){
            if(idtablaAva!=4){
                document.getElementById('TRCilindrajes').style.display = "";
                buscarCilindraje();
            }else{
                document.getElementById('TRCilindrajes').style.display = "none";
                buscarModelo();
            }
        }
    }

    if(campo=='Cilindraje'){
        document.getElementById('TRModelos').style.display = "none";
        document.getElementById('TRValorAvaluo').style.display = "none";
        document.getElementById('TRValorAvaluoM').style.display = "none";
        document.getElementById('TRGuardar').style.display = "none";

        var idtablaAva = document.getElementById('tablasAvaluo').value;
        if(idtablaAva==6){
            document.getElementById('TRCantPasajeros').style.display = "";
            document.getElementById('TRCapaTonelaje').style.display = "none";
            buscarCantPasajeros();
        }else{
            if(idtablaAva==7){
                document.getElementById('TRCantPasajeros').style.display = "none";
                document.getElementById('TRCapaTonelaje').style.display = "";
                buscarCapaTonelaje();
            }else{
                document.getElementById('TRModelos').style.display = "";
                buscarModelo();
            }
        }
    }

    if(campo=='CantPasajero'){
        document.getElementById('TRValorAvaluo').style.display = "none";
        document.getElementById('TRValorAvaluoM').style.display = "none";
        document.getElementById('TRGuardar').style.display = "none";
        document.getElementById('TRModelos').style.display = "";
        buscarModelo();
    }

    if(campo=='CapaTonelaje'){
        document.getElementById('TRValorAvaluo').style.display = "none";
        document.getElementById('TRValorAvaluoM').style.display = "none";
        document.getElementById('TRGuardar').style.display = "none";
        document.getElementById('TRModelos').style.display = "";
        buscarModelo();
    }

    if(campo=='Modelo'){
        document.getElementById('TRValorAvaluo').style.display = "";
        document.getElementById('TRValorAvaluoM').style.display = "none";
        document.getElementById('TRGuardar').style.display = "";
        buscarValorAvaluo();
    }

    if(campo=='ValorAvaluo'){
        var valorRetencion = document.getElementById('valorRetencion').value;
        if(valorRetencion>0){
            VerificarCampos();
        }else{
            var valorAvaluo = document.getElementById('valorAvaluoM').value;
            if(valorAvaluo>0){
                VerificarCampos();
            }else{
                document.getElementById('TRValorAvaluoM').style.display = "";
            }
        }
    }
}

function buscarClases(){
    var divtabla = document.getElementById('clasesdiv');
    var idtablaAva = document.getElementById('tablasAvaluo').value;
    var idclaseveh = document.getElementById('codClase').value;
    ajax2=nuevoAjax();
    ajax2.open("POST", "cargarCamposRetencion.jsp",true);
    ajax2.onreadystatechange=function() {
        if (ajax2.readyState==4) {
                divtabla.innerHTML = ajax2.responseText;
                verComboRetencion('Clase');
        }
    }
    ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax2.send("tablaAva="+idtablaAva+"&codClase="+idclaseveh+"&tipoC=1");
}

function buscarMarcas(){
    var divtabla = document.getElementById('marcasdiv');
    var idtablaAva = document.getElementById('tablasAvaluo').value;
    var marcaVeh = document.getElementById('marcaVeh').value;
    ajax2=nuevoAjax();
    ajax2.open("POST", "cargarCamposRetencion.jsp",true);
    ajax2.onreadystatechange=function() {
        if (ajax2.readyState==4) {
                divtabla.innerHTML = ajax2.responseText;
                verComboRetencion('Marca');
        }
    }
    ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax2.send("tablaAva="+idtablaAva+"&marcaVeh="+marcaVeh+"&tipoC=2");
}

function buscarLineas(){
    var divtabla = document.getElementById('lineasdiv');
    var idtablaAva = document.getElementById('tablasAvaluo').value;
    var idmarca = document.getElementById('marcas').value;
    ajax2=nuevoAjax();
    ajax2.open("POST", "cargarCamposRetencion.jsp",true);
    ajax2.onreadystatechange=function() {
        if (ajax2.readyState==4) {
                divtabla.innerHTML = ajax2.responseText;
        }
    }
    ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax2.send("tablaAva="+idtablaAva+"&marca="+idmarca+"&tipoC=3");
}

function buscarCilindraje(){
    var divtabla = document.getElementById('cilindrajediv');
    var idtablaAva = document.getElementById('tablasAvaluo').value;
    var idmarca = document.getElementById('marcas').value;
    var idlinea = document.getElementById('lineas').value;
    var clase = 0;
    if(idtablaAva==5 || idtablaAva==6 || idtablaAva==7 ){
        clase = document.getElementById('clases').value;
    }
    var cilindrajeVeh = document.getElementById('cilindrajeVeh').value;
    ajax2=nuevoAjax();
    ajax2.open("POST", "cargarCamposRetencion.jsp",true);
    ajax2.onreadystatechange=function() {
        if (ajax2.readyState==4) {
                divtabla.innerHTML = ajax2.responseText;
                verComboRetencion('Cilindraje');
        }
    }
    ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax2.send("clase="+clase+"&tablaAva="+idtablaAva+"&marca="+idmarca+"&linea="+idlinea+"&cilindrajeVeh="+cilindrajeVeh+"&tipoC=4");
}

function buscarCantPasajeros(){
    var divtabla = document.getElementById('pasajerosdiv');
    var idtablaAva = document.getElementById('tablasAvaluo').value;
    var idmarca = document.getElementById('marcas').value;
    var idlinea = document.getElementById('lineas').value;
    var cilindraje = document.getElementById('cilindrajes').value;
    var clase = 0;
    if(idtablaAva==5 || idtablaAva==6 || idtablaAva==7 ){
        clase = document.getElementById('clases').value;
    }
    ajax2=nuevoAjax();
    ajax2.open("POST", "cargarCamposRetencion.jsp",true);
    ajax2.onreadystatechange=function() {
        if (ajax2.readyState==4) {
                divtabla.innerHTML = ajax2.responseText;
        }
    }
    ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax2.send("clase="+clase+"&tablaAva="+idtablaAva+"&marca="+idmarca+"&linea="+idlinea+"&cilindraje="+cilindraje+"&tipoC=5");
}

function buscarCapaTonelaje(){
    var divtabla = document.getElementById('tonelajediv');
    var idtablaAva = document.getElementById('tablasAvaluo').value;
    var idmarca = document.getElementById('marcas').value;
    var idlinea = document.getElementById('lineas').value;
    var cilindraje = document.getElementById('cilindrajes').value;
    var clase = 0;
    if(idtablaAva==5 || idtablaAva==6 || idtablaAva==7 ){
        clase = document.getElementById('clases').value;
    }
    ajax2=nuevoAjax();
    ajax2.open("POST", "cargarCamposRetencion.jsp",true);
    ajax2.onreadystatechange=function() {
        if (ajax2.readyState==4) {
                divtabla.innerHTML = ajax2.responseText;
        }
    }
    ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax2.send("clase="+clase+"&tablaAva="+idtablaAva+"&marca="+idmarca+"&linea="+idlinea+"&cilindraje="+cilindraje+"&tipoC=6");
}

function buscarModelo(){
    var divtabla = document.getElementById('modelodiv');
    var idtablaAva = document.getElementById('tablasAvaluo').value;
    var idmarca = document.getElementById('marcas').value;
    var idlinea = document.getElementById('lineas').value;
    var cilindraje = document.getElementById('cilindrajes').value;
    var clase = 0;
    var cantpasajeros = 0;
    var capatonelaje = 0;
    if(idtablaAva==5 || idtablaAva==6 || idtablaAva==7 ){
        clase = document.getElementById('clases').value;
        if(idtablaAva==6){
            cantpasajeros = document.getElementById('pasajeros').value;
        }else{
            if(idtablaAva==7){
                capatonelaje = document.getElementById('toneladas').value;
            }
        }
    }
    var modeloVeh = document.getElementById('modeloVeh').value;
    ajax2=nuevoAjax();
    ajax2.open("POST", "cargarCamposRetencion.jsp",true);
    ajax2.onreadystatechange=function() {
        if (ajax2.readyState==4) {
                divtabla.innerHTML = ajax2.responseText;
                verComboRetencion('Modelo');
        }
    }
    ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax2.send("clase="+clase+"&tablaAva="+idtablaAva+"&marca="+idmarca+"&linea="+idlinea+"&cilindraje="+cilindraje+"&cantpasajeros="+cantpasajeros+"&capatonelaje='"+capatonelaje+"'&modeloVeh="+modeloVeh+"&tipoC=7");
}

function buscarValorAvaluo(){
    var divtabla = document.getElementById('valoresdiv');
    var idtablaAva = document.getElementById('tablasAvaluo').value;
    var idmarca = document.getElementById('marcas').value;
    var idlinea = document.getElementById('lineas').value;
    var cilindraje = document.getElementById('cilindrajes').value;
    var modelo = document.getElementById('modelos').value;
    var clase = 0;
    var cantpasajeros = 0;
    var capatonelaje = 0;
    if(idtablaAva==5 || idtablaAva==6 || idtablaAva==7 ){
        clase = document.getElementById('clases').value;
        if(idtablaAva==6){
            cantpasajeros = document.getElementById('pasajeros').value;
        }else{
            if(idtablaAva==7){
                capatonelaje = document.getElementById('toneladas').value;
            }
        }
    }
    ajax2=nuevoAjax();
    ajax2.open("POST", "cargarCamposRetencion.jsp",true);
    ajax2.onreadystatechange=function() {
        if (ajax2.readyState==4) {
                divtabla.innerHTML = ajax2.responseText;
        }
    }
    ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax2.send("clase="+clase+"&tablaAva="+idtablaAva+"&marca="+idmarca+"&linea="+idlinea+"&cilindraje="+cilindraje+"&cantpasajeros="+cantpasajeros+"&capatonelaje='"+capatonelaje+"'&modelo="+modelo+"&tipoC=8");
}

function VerificarCampos(){
    var idVehiculo = document.getElementById('idVehiculo').value;
    var idclase = document.getElementById('clases').value;
    var idmarca = document.getElementById('marcas').value;
    var idlinea = document.getElementById('lineas').value;
    var cilindraje = document.getElementById('cilindrajes').value;
    var modelo = document.getElementById('modelos').value;
    var modalidadVeh = document.getElementById('modalidadVeh').value;
    var carroceriaVeh = document.getElementById('carroceriaVeh').value;
    var codServicio = document.getElementById('codServicio').value;
    var subServicioVeh = document.getElementById('subServicioVeh').value;
    var cantpasajeros = document.getElementById('pasajeros').value;
    var capatonelaje = document.getElementById('toneladas').value;

    var valorAvaluo = document.getElementById('valorAvaluo').value;
    var valorRetencion = document.getElementById('valorRetencion').value;
    var idtablaAva = document.getElementById('tablasAvaluo').value;

    var placaVeh = document.getElementById('placaVeh').value;
    if(valorRetencion>0){
        var ajax = new nuevoAjax();
        ajax.open("POST", "procesarValorRetencion.jsp",true);
        ajax.onreadystatechange=function() {
            if (ajax.readyState==4) {
                var docxml = ajax.responseXML;
                var sw = docxml.getElementsByTagName('sw')[0].childNodes[0].nodeValue;
                if(sw=="1"){
                    window.parent.opener.window.location.href = "verLiquidacion.jsp?id=204&tipo=3&valorRetencion="+valorRetencion+"&placa="+placaVeh;
                    window.parent.close();
                }else{
                    alert("No se pudo registrar el valor de la retencion !!!");
                }
            }
        }
        ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
        ajax.send("idVehiculo="+idVehiculo+"&idclase="+idclase+"&idmarca="+idmarca+"&idlinea="+idlinea+"&cilindraje="+cilindraje+"&modelo="+modelo+"&modalidadVeh="+modalidadVeh+"&carroceriaVeh="+carroceriaVeh+"&codServicio="+codServicio+"&subServicioVeh="+subServicioVeh+"&cantpasajeros="+cantpasajeros+"&capatonelaje="+capatonelaje+"&valorAvaluo="+valorAvaluo+"&valorRetencion="+valorRetencion+"&idtablaAva="+idtablaAva);
    }else{
        //El valor de retencion es 0
        var valorAvaluoM = document.getElementById('valorAvaluoM').value;
        adicionarValorAvaluo(idVehiculo,placaVeh,valorAvaluoM);
    }
}