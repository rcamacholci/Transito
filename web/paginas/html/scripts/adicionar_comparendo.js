/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var comparendoValido = false
var docAgenteValido = false
var licenciaCondvalida = false

function validarFormulario(form)
{
    with(form){

        if(quitarVacios(numero.value)==''){
            alert('Debe escribir el Numero del Comparendo')
            numero.focus()
            return false
        }
        if(!comparendoValido){
            alert('El Comparendo No.'+numero.value+' ya esta registrado,\nverifique el numero')
            numero.focus()
            return false

        }
        if(fecha_comp.value.length<10 ){
            alert("Seleccione fecha del comparendo")
            return false
        }
        if(quitarVacios(lugar.value)==''){
            alert('Debe escribir el Lugar')
            lugar.focus()
            return false
        }

        if(quitarVacios(placa.value)!=''){
            if(clase.selectedIndex==0){
                alert('Debe elejir una clase')
                clase.focus()
                return false
            }
            if(servicio.selectedIndex==0){
                alert('Debe elejir un Servicio')
                servicio.focus()
                return false
            }
             
        }
        if(quitarVacios(documento.value)==''){
            alert('Debe escribir un documento')
            documento.focus()
            return false
        }else if(nombre.value==''){
            alert('El Documento No. '+documento.value+' No se encuentra registrado!')
            return false
        }
         
        if(inmovilizacion.checked){
            if(parqueaderos.selectedIndex==0){
                alert('Elija un Parqueadero')
                parqueaderos.focus()
                return false
            }
        }
        if(!docAgenteValido){
            alert('EL AGENTE NO EXISTE')
            return false
        }

        if(quitarVacios(placa_agente.value)==''){
            alert("Digite La Placa del Agente")
            placa_agente.focus()
            return false
        }
        if(quitarVacios(id_infraccion.value)==''){
            alert("Digite o Seleccione el Tipo de Infraccion")
            id_infraccion.focus()
            return false
        }

        if(lic_conduccion.value!=''){
            if(categoria.selectedIndex==0){
                alert('Por favor seleccione una actegoria para la Licencia')
                return false
            }
            if(expedido_en.selectedIndex==0){
                alert('Por favor seleccione la Sede de Expedicion de la Licencia')
                return false
            }
        }
        if(quitarVacios(lic_conduccion.value)!=''){
            if(!licenciaCondvalida && !lic_conduccion.disabled){
                alert('La licencia de conduccion ya se encuentra registrada')
                return false
            }
        }
        return true
        }
}

 

	
function existeComparendo(){
    var valor = document.form.comparendo.value
    var ajax = new nuevoAjax()
    ajax.open("POST", "getComparendo.jsp",true)
    ajax.onreadystatechange=function() {
        if (ajax.readyState==4 && ajax.status == 200) {
            var docxml = ajax.responseXML
            var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue
            if(result=='si'){
						
                comparendoValido = false
                alert("EL COMPARENDO YA EXISTE EN LA BASE DE DATOS ")

            }else{
						
                comparendoValido = true
            }
        }
    }
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
    ajax.send("numero="+valor)

}

function validarPlacaVehiculo(){
    var placa=document.form.placa.value.toUpperCase()
    if(quitarVacios(placa)!=''){
        var ajax= new nuevoAjax()
        ajax.open("POST", "getPlacaVehiculo.jsp",true)
        ajax.onreadystatechange=function() {
            if (ajax.readyState==4 && ajax.status == 200) {
                var docxml = ajax.responseXML
                var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue
                if(result=='si'){
                    var clase = docxml.getElementsByTagName('clase')[0].childNodes[0].nodeValue
                    var servicio = docxml.getElementsByTagName('servicio')[0].childNodes[0].nodeValue
                    var licenciaT = docxml.getElementsByTagName('licenciaT')[0].childNodes[0].nodeValue
                    if(licenciaT=='0'){
                        document.form.licencia_transito.value = licenciaT
                    }else{
                        document.form.licencia_transito.value = licenciaT
                        document.form.licencia_transito.disabled = true
                    }

                    document.form.clase.value = clase
                    document.form.servicio.value = servicio
                    document.form.clase.disabled =true
                    document.form.servicio.disabled =true
                }else{
                    document.form.licencia_transito.value = ''
                    document.form.clase.disabled =false
                    document.form.servicio.disabled =false
                    document.form.licencia_transito.disabled = false
                }
            }
        }
        ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
        ajax.send("numero="+placa)
    }
}

function validarAgente(){
    var placa_agente=document.form.placa_agente.value
    if(placa_agente.length>0){
        var ajax = new nuevoAjax()
        ajax.open("POST", "getAgente.jsp",true)
        ajax.onreadystatechange=function() {
            if (ajax.readyState==4 && ajax.status == 200) {
                var docxml = ajax.responseXML
                var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue
                if(result=='si'){
                    var nombre = docxml.getElementsByTagName('nombre')[0].childNodes[0].nodeValue
                    document.form.nombre_agente.value = nombre
                    docAgenteValido=true
                }else{
                    document.form.nombre_agente.value=''
                    alert("AGENTE NO EXISTE , POR FAVOR VERIFIQUE LA PLACA DEL AGENTE")
                    docAgenteValido=false
                }
            }
        }
        ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
        ajax.send("numero="+placa_agente)
    }

}

function seleccionarInfraccion(){
    document.form.infraccion.value = document.form.id_infraccion.value
}

function verParqueadero(){
    var parqueadero = document.getElementById("parqueaderos")
    var lparqueadero = document.getElementById("lparqueadero")
    var inmovilizacion = document.getElementById("inmovilizacion")
    if(inmovilizacion.checked){
        parqueadero.style.display = 'block'
        lparqueadero.style.display = 'block'
    }else{
        parqueadero.style.display = 'none'
        lparqueadero.style.display = 'none'
    }
}

function setInfraccion(){
    document.form.id_infraccion.value = document.form.infraccion.value
}

function recargarDatos(form){
    with(form){
        if(quitarVacios(comparendo.value)!=''){
            Validar_Comparendo()
        }
        if(quitarVacios(placa.value)!=''){
            validarPlacaVehiculo()
        }         
       
        if(quitarVacios(lic_conduccion.value)!='' && !lic_conduccion.disabled){
            validarLicenciaConduccion()
        }
        }

}

function ConsultarLicenciaConduccion(){
    var numero=document.form.lic_conduccion
    var categoria = document.form.categoria
    var sede_exp = document.form.expedido_en
    var fecha_venc = document.form.fecha_venc
    var tipo = document.form.tipo_doc.value
    var documento = document.form.documento.value
    var Bfecha_venc = document.form.Bfecha_venc
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
                licenciaCondvalida=true
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
                licenciaCondvalida=false
            }
        }
    }
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
    ajax.send('tipo='+tipo+'&documento='+documento)

}

function validarLicenciaConduccion(){
    var numero=document.form.lic_conduccion.value
        
    var ajax= new nuevoAjax()
    ajax.open("POST", "getLicenciaConduccion.jsp",true)
    ajax.onreadystatechange=function() {
        if (ajax.readyState==4 && ajax.status == 200) {
            var docxml = ajax.responseXML
            var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue
            if(result=='si'){
                alert('La Licencia de Conduccion No'+numero+' Ya se encuentra registrada')
                licenciaCondvalida=false
            }else{
                licenciaCondvalida=true
            }
        }
    }
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
    ajax.send('numero='+numero)

}