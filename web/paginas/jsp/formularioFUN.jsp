<%@page import="com.heinsohn.runt.general.consultas.AutomotorOutDTO"%>
<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html;charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" errorPage="" %>
<%@page import = "modelo.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Documento sin t&iacute;tulo</title>
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script type="text/javascript" src="../html/scripts/calendar.js"></script>
        <script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
        <script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
        <script src="../html/scripts/personas.js" type="text/javascript"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript">
            function nuevoAjax() {
                var xmlhttp = false;
                try {
                    xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
                } catch (e) {
                    try {
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                    } catch (E) {
                        xmlhttp = false;
                    }
                }

                if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
                    xmlhttp = new XMLHttpRequest();
                }

                return xmlhttp;
            }


            function deshabilitar() {
                document.getElementById("actionS").style.display = 'none';
                document.getElementById("actionA").style.display = 'none';

            }
            function consultaPersona2() {
                var documento = document.getElementById("nitConc");
                if (!isNaN(documento.value) && documento.value.length > 0) {

                    var tipoDoc = 2;
                    var ajax2 = nuevoAjax();
                    ajax2.open("POST", "getPersona.jsp", true);
                    ajax2.onreadystatechange = function () {
                        if (ajax2.readyState == 4) {
                            var respuesta = "";
                            for (var i = 0; i < ajax2.responseText.length; i++) {
                                if (isNaN(ajax2.responseText.charAt(i)) || ajax2.responseText.charAt(i) == ' ')
                                    respuesta += ajax2.responseText.charAt(i);
                            }
                            if (respuesta.indexOf("nueva") != -1) {
                                viewPersona(tipoDoc, documento.value);
                            } else {
                                document.form.nombreConcesionario.value = respuesta;
                            }
                        }
                    }
                    ajax2.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    ajax2.send("documento=" + documento.value + "&tipo=" + tipoDoc);
                }
            }



            function consultaPersona() {
                tipo = document.getElementById("tipoDocumento");
                documento = document.getElementById("numeroDocumento").value;
                if (documento.length > 0 && !isNaN(documento)) {
                    tipoDoc = tipo.options[tipo.options.selectedIndex].value
                    ajax = nuevoAjax();
                    ajax.open("POST", "getPersona.jsp", true);
                    ajax.onreadystatechange = function () {
                        if (ajax.readyState == 4) {
                            var respuesta = "";
                            for (var i = 0; i < ajax.responseText.length; i++) {
                                if (isNaN(ajax.responseText.charAt(i)))
                                    respuesta += ajax.responseText.charAt(i);
                            }
                            if (respuesta == "nueva") {
                                viewPersona(tipoDoc, documento);
                            } else {
                                document.getElementById("nombreRadicador").value = ajax.responseText;
                            }
                        }
                    }
                    ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    ajax.send("documento=" + documento + "&tipo=" + tipoDoc);
                }
            }

            function consultaPersonaAlerta() {
                tipo = document.getElementById("tipoDocumentoAlerta");
                documento = document.getElementById("numeroDocumentoAlerta").value;
                if (documento.length > 0 && !isNaN(documento)) {
                    tipoDoc = tipo.options[tipo.options.selectedIndex].value
                    ajax = nuevoAjax();
                    ajax.open("POST", "getPersona.jsp", true);
                    ajax.onreadystatechange = function () {
                        if (ajax.readyState == 4) {
                            var respuesta = "";
                            for (var i = 0; i < ajax.responseText.length; i++) {
                                if (isNaN(ajax.responseText.charAt(i)))
                                    respuesta += ajax.responseText.charAt(i);
                            }
                            if (respuesta == "nueva") {
                                viewPersona(tipoDoc, documento);
                            } else {
                                document.getElementById("nombreAlerta").value = ajax.responseText;
                            }
                        }
                    }
                    ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    ajax.send("documento=" + documento + "&tipo=" + tipoDoc);
                }
            }

            function Despues() {
                document.getElementById('datosRadicacion').style.display = 'none';
                document.getElementById('formularioFUN').style.display = 'block';
            }

            function newP() {
                window.frames[0].location.href = "radicarPropietarios.jsp?tipo=1&tipopropiedad=1&proindiviso=N";
            }

            function newC() {
                ancho = 400;
                alto = 360;
                barra = 0;
                izquierda = (screen.width) ? (screen.width - ancho) / 2 : 100;
                arriba = (screen.height) ? (screen.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba;
                url = "busquedaColores.jsp";
                window.open(url, 'popUp', opciones);
            }

            function verInput(codigo, name) {
                if (isNaN(codigo.value) && codigo.value.length > 0) {
                    var salida = "";
                    for (i = 0; i < codigo.value.length; i++) {
                        if (!isNaN(codigo.value.charAt(i))) {
                            salida += codigo.value.charAt(i);
                        }
                    }
                    codigo.value = salida;
                }
                if (codigo.value.length > 0) {
                    combo = document.getElementById(name);
                    for (i = 0; i < combo.options.length; i++) {
                        if (combo.options[i].value == parseInt(codigo.value)) {
                            combo.options.selectedIndex = i;
                            break;
                        }
                    }
                    if (i == combo.options.length) {
                        codigo.value = combo.options[combo.options.selectedIndex].value
                    }
                } else {
                    combo = document.getElementById(name);
                    codigo.value = combo.options[combo.options.selectedIndex].value
                }
                if (name == "marcas") {
                    buscarLineas();
                }
            }

            function verOrganismo(obj, id) {
                combo = document.getElementById('organismos2');
                if (id == 1) {
                    document.getElementById('tipoOrganismo').value = combo.options[obj.options.selectedIndex].value;
                } else {
                    if (obj.value.length > 0 && !isNaN(obj.value)) {
                        for (i = 0; i < combo.options.length; i++) {
                            if (parseInt(combo.options[i].value) == parseInt(obj.value)) {
                                document.getElementById('organismos').options.selectedIndex = i;
                                break;
                            }
                        }
                        if (i == combo.options.length) {
                            document.getElementById('tipoOrganismo').value = combo.options[document.getElementById('organismos').options.selectedIndex].value;
                        }
                    } else {
                        document.getElementById('tipoOrganismo').value = combo.options[document.getElementById('organismos').options.selectedIndex].value;
                    }
                }
            }

            function verModelo(campo) {
                if (isNaN(campo.value)) {
                    campo.value = "";
                } else {
                    if (parseInt(campo.value) < 1940) {
                        campo.value = 1940;
                    } else {
                        if (parseInt(campo.value) > new Date().getFullYear() + 1) {
                            campo.value = new Date().getFullYear();
                        }
                    }
                }
            }
            function view(name) {
                document.getElementById('panelPropietarios').style.display = 'none';
                document.getElementById('panelEspecificaciones').style.display = 'none';
                document.getElementById('panelCaracteristicas').style.display = 'none';
                document.getElementById('panelColores').style.display = 'none';
                document.getElementById('panelImportacion').style.display = 'none';
                document.getElementById('panelAlertas').style.display = 'none';
                document.getElementById('panelOrganismos').style.display = 'none';
                document.getElementById('panelAseguradoras').style.display = 'none';
                document.getElementById('panelObservaciones').style.display = 'none';
                document.getElementById('panelRunt').style.display = 'none';
                document.getElementById('panelImportacionRNMA').style.display = 'none';
                document.getElementById('panelRNMA').style.display = 'none';
                document.getElementById('panel' + name).style.display = 'block';

            }

            function verCombo(combo, campo) {
                document.getElementById('tipo' + campo).value = combo.options[combo.options.selectedIndex].value;
                if (campo == 'Importacion') {
                    if (combo.options[combo.options.selectedIndex].value == 1) {
                        document.getElementById('tipoImpor').style.display = 'block';
                        document.getElementById('tipoD').style.display = 'block';
                        document.getElementById('tiposimpor').style.display = 'block';
                        document.getElementById('tipoEntidad').style.display = 'none';
                        document.getElementById('tipoE').style.display = 'none';
                        document.getElementById('tiposentidades').style.display = 'none';
                    } else {
                        document.getElementById('tipoImpor').style.display = 'none';
                        document.getElementById('tipoD').style.display = 'none';
                        document.getElementById('tiposimpor').style.display = 'none';
                        document.getElementById('tipoEntidad').style.display = 'block';
                        document.getElementById('tipoE').style.display = 'block';
                        document.getElementById('tiposentidades').style.display = 'block';
                    }
                } else {
                    if (campo == 'Departamento') {
                        buscarCiudades();
                    } else {
                        if (campo == 'Marca') {
                            buscarLineas();
                        } else {
                            if (campo == 'Clase') {
                                buscarCarrocerias();
                            }
                        }
                    }
                }
            }

            function buscarCiudades() {
                var campo = document.getElementById('tipoDepartamento');
                var codigo = document.getElementById('tipoCiudad');
                ajax = nuevoAjax();
                ajax.open("POST", "listarMunicipios_1.jsp", true);
                ajax.onreadystatechange = function () {
                    if (ajax.readyState == 4) {
                        document.getElementById('ciudad').innerHTML = ajax.responseText;
                        verCombo(document.getElementById('ciudades'), 'Ciudad');
                    }
                }
                ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                ajax.send("fk_dpto=" + campo.value + "&codigo=" + codigo.value);
            }

            function buscarCarrocerias() {
                var clase = document.form.clases.options[document.form.clases.selectedIndex].value;
                ajax2 = nuevoAjax();
                ajax2.open("POST", "consultarCarrocerias.jsp", true);
                ajax2.onreadystatechange = function () {
                    if (ajax2.readyState == 4) {
                        document.form.carrocerias.innerHTML = ajax2.responseText;
                        document.form.carrocerias.outerHTML = document.form.carrocerias.outerHTML;
                    }
                }
                ajax2.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                ajax2.send("clase=" + clase);

            }

            function buscarLineas() {
                var tabla = document.getElementById('lineasdiv');
                var ck_li = document.getElementById('tipoMarca').value;
                var tipo = document.getElementById('tipoL').value;
                var mr = ck_li;
                if (ck_li == 0) {
                    mr = document.getElementById('marca_cod').value;
                }
                ln = document.getElementById('linea_cod').value;
                valor = document.form.marcas.options[document.form.marcas.selectedIndex].value;
                ajax2 = nuevoAjax();
                ajax2.open("POST", "cargarLineas.jsp", true);
                ajax2.onreadystatechange = function () {
                    if (ajax2.readyState == 4) {
                        tabla.innerHTML = ajax2.responseText;
                    }
                }
                ajax2.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                ajax2.send("marca=" + mr + "&linea=" + ln + "&tipoL=" + tipo);

            }

            function validar(sector) {
                var tramite = document.getElementById("ntramites");
                var placa = document.getElementById("placa").value;
                for (i = 0; i < tramite.options.length; i++) {
                    var dato1 = document.getElementById("fun" + tramite.options[i].value).value;
                    var dato2 = document.getElementById("runt" + tramite.options[i].value).value;
                    if (dato1.length == 0) {//quitar para pagos false
                        alert("Digite Numero de Pago asociado al Tramite [" + tramite.options[i].value + "]");
                        return false;
                    } else {
                        /* if(dato2.length == 0){
                         alert("Digite Numero Liquidacion RUNT del Tramite ["+tramite.options[i].value+"]");
                         return false;
                         }*/
                    }
                }
                if (sector == "panelPropietarios") {
                    npropietarios = window.frames['prop'].document.getElementById("nprop").value;
                    sumap = window.frames['prop'].document.getElementById("sumap").value;
                    if (tramite.value != '9') {
                        for (i = 0; i < npropietarios; i++) {
                            if (window.frames['prop'].document.getElementById("tnombre" + i).value.length == 0) {
                                alert("Ingrese un propietario valido, no deben existir campos en blanco");
                                return false;
                            }
                        }
                        if (npropietarios == 0) {
                            alert("Debe ingresar por lo menos un propietario al vehiculo");
                            return false;
                        }
                        if (sumap != 100) {
                            alert("Los porcentajes de propiedad deben ser igual a 100%");
                            return false;
                        }
                    }
                    return true;
                } else {
                    if (sector == "panelColores") {
                        var colorv = document.getElementById("color").value;
                        if (colorv.length == 0) {
                            alert("Debe ingresar el color del vehiculo");
                            return false;
                        }
                        return true;
                    } else {
                        if (sector == "panelOrganismos") {
                            var org = document.getElementById("organismos");
                            if (org.options.selectedIndex == 0) {
                                alert("Seleccione el Organismo de Transito..");
                                return false;
                            }
                            return true;
                        } else {
                            if (sector == "panelAlertas") {
                                var alrt = document.getElementById("nombreAlerta").value;
                                if (alrt.length == 0) {
                                    alert("Ingrese Numero de documento entidad/persona que pignora");
                                    return false;
                                }
                                return true;
                            } else {
                                if (sector == "panelAseguradoras") {
                                    //var n_as = document.getElementById("comboAseguradora").options.selectedIndex;
                                    //if(n_as==0){
                                    //	alert("Seleccione una aseguradora de la lista");
                                    //	return false;
                                    //}
                                    //var npol = document.getElementById("poliza").value;
                                    //if(npol.length ==0){
                                    //	alert("Ingrese Numero de poliza de la aseguradora");
                                    //	return false;
                                    //}
                                    //var nven = document.getElementById("vence").value;
                                    //if(nven.length ==0){
                                    //	alert("Ingrese Fecha de vencimiento de la poliza de la aseguradora");
                                    //	return false;
                                    //}
                                    return true;
                                } else {
                                    if (sector == "panelEspecificaciones") {
                                        var nespc = window.frames['espc'].document.getElementById("nespc").value;
                                        var codespc = window.frames['espc'].document.getElementById("codespc");
                                        for (i = 0; i < codespc.options.length; i++) {
                                            if (window.frames['espc'].document.getElementById("obligado" + codespc.options[i].value) != null) {
                                                if (window.frames['espc'].document.getElementById("obligado" + codespc.options[i].value).value == "1") {
                                                    if (window.frames['espc'].document.getElementById("valor" + codespc.options[i].value).value.length == 0) {
                                                        alert("Ingrese algun valor en la especificacion [" + codespc.options[i].value + "]");
                                                        return false;
                                                    }
                                                }
                                            }
                                        }
                                        return true;
                                    } else {
                                        if (sector == "panelCaracteristicas") {
                                            clases = document.getElementById("clases");
                                            if (clases.options.selectedIndex != 0 || clases.disabled || clases.value != 0) {
                                                servicios = document.getElementById("servicios");
                                                if (servicios.options.selectedIndex != 0 || servicios.disabled || servicios.value != 0) {
                                                    marcas = document.getElementById("marcas");
                                                    if (marcas.options.selectedIndex != 0 || marcas.disabled || marcas.value != 0) {
                                                        carrocerias = document.getElementById("carrocerias");
                                                        if (carrocerias.options.selectedIndex != 1500 || carrocerias.disabled || carrocerias.value != 1500) {
                                                            modalidades = document.getElementById("modalidades");
                                                            if (modalidades.options.selectedIndex != 0 || modalidades.disabled || modalidades.value != 0) {
                                                                combustibles = document.getElementById("combustibles");
                                                                if (combustibles.options.selectedIndex != 0 || combustibles.disabled || combustibles.value != 0) {
                                                                    modelo = document.getElementById("modelo");
                                                                    if (modelo.value.length > 0 || modelo.disabled) {
                                                                        motor = document.getElementById("motor");
                                                                        if (motor.value.length > 0 || motor.disabled) {
                                                                            chasis = document.getElementById("chasis");
                                                                            if (chasis.value.length > 0 || chasis.disabled || true) {
                                                                                serie = document.getElementById("serie");
                                                                                if (serie.value.length > 0 || serie.disabled || true) {
                                                                                    nitcon = document.getElementById("nitConc");
                                                                                    Nomcon = document.getElementById("nombreConcesionario");
                                                                                    if (nitcon.value.length > 0 && Nomcon.value.length > 0) {
                                                                                        lineas = document.getElementById("lineas");
                                                                                        if (lineas != null) {
                                                                                            if (lineas.options.selectedIndex != 0 || lineas.disabled || lineas.value != 0) {
                                                                                                return true;
                                                                                            } else {
                                                                                                alert("Seleccione una linea para el vehiculo");
                                                                                            }
                                                                                        } else {
                                                                                            alert("Seleccione una linea para el vehiculo");
                                                                                        }
                                                                                    } else {
                                                                                        alert("Digite el nit del Concesionario");
                                                                                    }
                                                                                } else {
                                                                                    alert("Digite el numero de serie del vehiculo");
                                                                                }
                                                                            } else {
                                                                                alert("Digite el numero de chasis del vehiculo");
                                                                            }
                                                                        } else {
                                                                            alert("Digite el numero de motor del vehiculo");
                                                                        }
                                                                    } else {
                                                                        alert("Digite el modelo del vehiculo");
                                                                    }
                                                                } else {
                                                                    alert("Seleccione un tipo de combustible para el vehiculo");
                                                                }
                                                            } else {
                                                                alert("Seleccione una modalidad para el vehiculo");
                                                            }
                                                        } else {
                                                            alert("Seleccione una carroceria para el vehiculo");
                                                        }
                                                    } else {
                                                        alert("Seleccione una marca para el vehiculo");
                                                    }
                                                } else {
                                                    alert("Seleccione un servicio para el vehiculo");
                                                }
                                            } else {
                                                alert("Seleccione una clase para el vehiculo");
                                            }
                                            return false;
                                        } else {
                                            if (sector == "panelImportacion") {
                                                docimp = document.getElementById("documentoimp").value;
                                                fecimp = document.getElementById("fechadocumento").value;
                                                tipimp = document.getElementById("tiposimportaciones");
                                                tipdoc = document.getElementById("tiposimpor");
                                                tipent = document.getElementById("tiposentidades");
                                                depts = document.getElementById("departamentos");
                                                muncp = document.getElementById("ciudades");
                                                if (tipimp.options.selectedIndex != 0 || tipimp.value != 0) {
                                                    if (tipimp.value == 1) {
                                                        if (tipdoc.value == 0) {
                                                            alert("Seleccione tipo de documento de importacion del vehiculo");
                                                            return false;
                                                        }
                                                    } else {
                                                        if (tipent.value == 0) {
                                                            alert("Seleccione tipo de entidad de importacion del vehiculo");
                                                            return false;
                                                        }
                                                    }
                                                    if (depts.options.selectedIndex != 0) {
                                                        if (muncp.options.selectedIndex != 0) {
                                                            if (docimp.length > 0) {
                                                                if (fecimp.length > 0) {
                                                                    return true;
                                                                } else {
                                                                    alert("Digite fecha de documento de importacion del vehiculo");
                                                                }
                                                            } else {
                                                                alert("Digite numero de documento de importacion del vehiculo");
                                                            }
                                                        } else {
                                                            alert("Seleccione ciudad de importacion del vehiculo");
                                                        }
                                                    } else {
                                                        alert("Seleccione departamento de importacion del vehiculo");
                                                    }
                                                } else {
                                                    alert("Seleccione tipo de importacion del vehiculo");
                                                }
                                                return false;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                return true;
            }

            function next() {
                var secuencia = document.getElementById("secuencia");
                indice = parseInt(document.getElementById("idsecuencia").value) + 1;
                if (validar(secuencia.options[indice - 1].value)) {
                    if (secuencia.options.length > indice) {
                        document.getElementById("idsecuencia").value = indice;
                        panel = secuencia.options[indice].value;
                        document.getElementById("actionA").style.display = 'block';
                        view(panel.substr(5, panel.length));
                        if (indice + 1 == secuencia.options.length) {
                            document.getElementById("actionS").style.display = 'none';
                        }
                    } else {
                        alert("El tramite seleccionado no se encuentra parametrizado...");
                    }
                }
            }

            function past() {
                var secuencia = document.getElementById("secuencia");
                indice = parseInt(document.getElementById("idsecuencia").value) - 1;
                if (indice >= 0) {
                    document.getElementById("idsecuencia").value = indice;
                    panel = secuencia.options[indice].value;
                    document.getElementById("actionS").style.display = 'block';
                    view(panel.substr(5, panel.length));
                    if (indice == 0)
                        document.getElementById("actionA").style.display = 'none';
                }

            }

            function evaluar() {
                var tramite = document.getElementById("ntramites");
                var placa = document.getElementById("placa").value;
                var motor = "";
                if (document.getElementById("motor") != null)
                    motor = document.getElementById("motor").value;
                var chasis = "";
                if (document.getElementById("chasis") != null)
                    chasis = document.getElementById("chasis").value;
                var serie = "";
                if (document.getElementById("serie") != null)
                    serie = document.getElementById("serie").value;
                for (i = 0; i < tramite.options.length; i++) {
                    var runt = document.getElementById("runt" + tramite.options[i].value).value;
                    var fun = document.getElementById("fun" + tramite.options[i].value).value;
                    if (fun.length == 0 && false) {
                        alert("Digite Numero de Pago asociado al Tramite [" + tramite.options[i].value + "]");
                        return false;
                    } else {
                        /*     if(runt.length == 0){
                         alert("Digite Numero RUNT del Tramite ["+tramite.options[i].value+"]");
                         return false;
                         }*/
                    }
                    if (document.getElementById("fun" + tramite.options[i].value).style.color != document.getElementById("simit" + tramite.options[i].value).style.color) {
                        alert("No se encuentra un numero de pago asociado al tramite");
                        return false;
                    }
                    /*    if(document.getElementById("runt"+tramite.options[i].value).style.color!=document.getElementById("simit"+tramite.options[i].value).style.color){
                     alert("El numero de recibo runt, no se encuentra revisado");
                     return false;
                     }else{
                     revisarL(document.getElementById("runt"+tramite.options[i].value));
                     }*/
                    ajax3 = new nuevoAjax();
                    ajax3.open("POST", "verificarDatos.jsp", true);
                    ajax3.onreadystatechange = function () {
                        if (ajax3.readyState == 4) {
                            if (ajax3.responseText.indexOf("existe") == -1) {
                                document.form.submit();
                                return true;
                            } else {
                                alert(ajax3.responseText);
                                return false;
                            }
                        }
                    }
                    ajax3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    ajax3.send("placa=" + placa + "&motor=" + motor + "&chasis=" + chasis + "&serie=" + serie + "&tramite=" + tramite.options[i].value);
                }
            }
            function Biometria()
            {
                var obj
                var rta = ""
                var ID = document.form.documento.value;

                var TIPO = "CC";
                if (document.form.tipo.value == 3)
                    TIPO = "CE";
                if (document.form.tipo.value == 4)
                    TIPO = "TI";
                if (document.form.tipo.value == 5)
                    TIPO = "PP";

                var N1 = document.form.primer_nombre.value;
                var N2 = document.form.segundo_nombre.value;
                var A1 = document.form.primer_apellido.value;
                var A2 = document.form.segundo_apellido.value;
                var FECHA = document.form.date.value;
                var SEXO = document.form.sexo.value;

                obj = new ActiveXObject("Identica_Runt.Bio_Main")
                var bc = document.form.bc.style.color == "rgb(51, 51, 51)" ? 0 : 1;
                var br = document.form.br.style.color == "rgb(51, 51, 51)" ? 0 : 1;
                var bh = document.form.bh.style.color == "rgb(51, 51, 51)" ? 0 : 1;
                var bf = document.form.bf.style.color == "rgb(51, 51, 51)" ? 0 : 1;

                rta = obj.Enrolar(ID, TIPO, N1, N2, A1, A2, FECHA, SEXO, 1, 1, 0, 1);
                if (rta.indexOf("<>" + ID + "<><>" + TIPO + "<><>1<><>") != -1) {
                    //	rta = obj.Autenticar_Ciudadano(obj.RTemplate,ID,TIPO);
                    document.form.biometric.value = "1";
                    document.form.template.value = obj.RTemplate;
                    document.form.huella1.value = obj.Huella1;
                    document.form.huella2.value = obj.Huella2;
                    document.form.bidimensional.value = obj.BC2D;
                    document.form.dedo1.value = obj.N_DEDO1;
                    document.form.dedo2.value = obj.N_DEDO2;
                    document.form.foto.value = obj.FOTO;
                    document.form.firma.value = obj.FIRMA;
                    alert("OK. Datos biometricos recibidos");
                } else {
                    document.form.biometric.value = "0";
                    document.form.excepcion.value = obj.R_Excepcion;
                    alert(obj.R_Excepcion);
                }
            }

            function revisarL(lq) {
                lq.style.color = "#006699";
                lq.value = '600000000000000000'.substr(0, 18 - lq.value.length) + lq.value;
                if (lq.value.length == 18) {
                    if (isNaN(lq.value)) {
                        alert("Digite solo valores numericos.");
                    } else {
                        ajax2 = new nuevoAjax();
                        ajax2.open("POST", "verificarLiquidacion.jsp", true);
                        ajax2.onreadystatechange = function () {
                            if (ajax2.readyState == 4) {
                                var respuesta = ajax2.responseText;
                                if (respuesta.indexOf("PAGADO") != -1 || respuesta.indexOf("NO_ACCESO") != -1)
                                    lq.style.color = "#006699";
                                else
                                    lq.style.color = "#FF0000";
                            }
                        }
                        ajax2.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                        ajax2.send("runt=" + lq.value);
                    }
                } else {
                    lq.style.color = "#FF0000";
                }
            }
            function verMunicipios(text) {
                ancho = 300;
                alto = 180;
                barra = 0;
                izquierda = (screen.width) ? (screen.width - ancho) / 2 : 100;
                arriba = (screen.height) ? (screen.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba;
                url = "adicionarMunicipio.jsp?name=" + text.name + "&value=" + text.value;
                window.open(url, 'popUp', opciones);
            }
            function verificarCondicion(valor) {
                if (valor != "SIN REGISTRO ANTES DE INICIO RNMA") {
                    document.form.fechaIngreso.disabled = true;
                    document.form.bfechaIngreso.disabled = true;
                } else {
                    document.form.fechaIngreso.disabled = false;
                    document.form.bfechaIngreso.disabled = false;
                }
            }

            function buscarDirMunicipios() {
                tabla = document.getElementById('dir_municipios');

                valor = document.form.dir_departamento.options[document.form.dir_departamento.selectedIndex].value;
                ajax1 = new nuevoAjax();
                ajax1.open("POST", "cargarCiudades.jsp", true);
                ajax1.onreadystatechange = function () {
                    if (ajax1.readyState == 4) {
                        tabla.innerHTML = ajax1.responseText;
                        document.form.direccion.disabled = false;
                        document.form.telefono.disabled = false;
                    }
                }
                ajax1.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                ajax1.send("fk_dpto=" + valor + "&name=dir_municipio");

            }

        </script>
        <style type="text/css">
            <!--
            .Estilo1 {color: #0066CC}
            .Estilo2 {font-size: 12px}
            .Estilo3 {
                font-size: 14px;
                color: #333333;
            }
            .Estilo4 {color: #333333}
            .Estilo5 {
                color: #333333;
                font-size: 12px;
            }
            .Estilo6 {color: #333333}
            .Estilo7 {font-size: 24px}
            .Estilo9 {
                color: #333333;
                font-weight: bold;
                font-size: 12px;
            }
            .Estilo11 {color: #FFFFFF; font-size: 12px; }
            .Estilo12 {
                font-size: 14px;
                font-weight: bold;
                color: #0066CC;
            }
            .Estilo13 {color: #FFFFFF}
            .style1 {
                color: #FF0000;
                font-weight: bold;
            }
            .Estilo61 {font-size: 10px}
            .style2 {
                color: #FF0000;
                font-size: 12px;
            }
            -->
        </style>
    </head>
    <%  int psg = 0;

        try {
            Model model = (Model) session.getAttribute("model");
            if (model != null) {
                java.util.List listaTramites = (List) session.getAttribute("seleccionados");
                int claseT = 1;
                if (listaTramites.size() > 0) {
                    claseT = model.consultarTramite(Long.parseLong(listaTramites.get(0).toString())).getClase_tramite();
                }
                if (claseT == 1 || claseT == 4 || claseT == 5) {
                    String placa = "";
                    if (request.getParameter("placa") != null) {
                        placa = request.getParameter("placa").toUpperCase();
                    } else {
                        placa = "-";
                    }
                    Vehiculo vehiculo = model.consultarVehiculo(placa);
                    java.util.HashMap hash_especificaciones = new java.util.HashMap();
                    java.util.HashMap hash_caracteristicas = new java.util.HashMap();
                    java.util.List listaPropietarios = new java.util.LinkedList();
                    long radicacionColor = 0;
                    long idC = 0;
                    String nameC = "";
                    if (request.getParameter("tip_rad") == null) {
                        Sede sede = (Sede) session.getAttribute("sede");
                        Calendar calendar = Calendar.getInstance();
                        if (vehiculo != null) {
                            java.util.List lista = model.crear_Lista_Propietarios(vehiculo.getId_vehiculo());
                            for (int i = 0; i < lista.size(); i++) {
                                Propietario p = (Propietario) lista.get(i);
                                if (p.getFecha_final() == null) {
                                    Radicacion_Propietario rp = new Radicacion_Propietario();
                                    rp.setFk_persona(p.getFk_persona());
                                    rp.setPorcentaje(p.getPorcentaje());
                                    rp.setTipoPropiedad(p.getTipoPropiedad());
                                    rp.setProIndiviso(p.getProIndiviso());
                                    listaPropietarios.add(rp);
                                }
                            }
                        }
                        if (vehiculo != null) {
                            hash_caracteristicas = model.listarCaracteristicasVehiculo(vehiculo.getPlaca());
                            hash_especificaciones = model.listarEspecificacionesVehiculo(vehiculo.getPlaca());
                        }
                        if (vehiculo != null) {
                            java.util.List lista_colores = model.lista_historico_color(vehiculo.getPlaca());
                            for (int l = 0; l < lista_colores.size(); l++) {
                                Historico_Color hc = (Historico_Color) lista_colores.get(l);
                                radicacionColor = hc.getFk_color();
                                session.setAttribute("colores", radicacionColor);
                                break;
                            }
                        }
                        session.setAttribute("vehiculo", vehiculo);
                        session.setAttribute("propietarios", listaPropietarios);

                        session.setAttribute("especificaciones", hash_especificaciones);
                        session.setAttribute("caracteristicas", hash_caracteristicas);
                        session.removeAttribute("radicacion");
                    } else {
                        vehiculo = (Vehiculo) session.getAttribute("vehiculo");
                        listaPropietarios = (java.util.List) session.getAttribute("propietarios");
                        radicacionColor = session.getAttribute("colores") != null ? Long.parseLong(session.getAttribute("colores").toString()) : 0;
                        hash_especificaciones = (java.util.HashMap) session.getAttribute("especificaciones");
                        hash_caracteristicas = (java.util.HashMap) session.getAttribute("caracteristicas");
                    }
    %>
    <body>
        <select name="secuencia" id="secuencia" style="display:none">
            <option value="panelTramites">panelTramites</option>
            <%
                java.util.List lsec = new java.util.LinkedList();
                if (listaTramites.size() > 0) {
                    lsec = model.getSecuenciaByTramite(Integer.parseInt(listaTramites.get(0).toString()));
                    for (int j = 0; j < lsec.size(); j++) {%>
            <option value="<%=lsec.get(j)%>"><%=lsec.get(j)%></option>
            <%    }
                } %>
        </select>
        <input type="text" name="idsecuencia" id="idsecuencia" value="0" style="display:none"/>
        <select name="ntramites" id="ntramites" style="display:none">
            <%
                if (listaTramites.size() > 0) {%>
            <option value="<%=listaTramites.get(0)%>"><%=listaTramites.get(0)%></option>
            <%	}
            %>
        </select>
        <table width="80%" border="0" align="center">
            <tr>
                <td width="87%" height="26" align="center"><strong><span class="Estilo1 Estilo3">SOLICITUD DE TRAMITES</span></strong></td>
            </tr>
            <tr>
                <td height="481" align="center" valign="top">

                    <form name="form" id="form" method="post" action="radicarFormulario.jsp">
                        <input type="hidden" id="biometric" name="biometric" value="0"/>
                        <input type="hidden" id="template" name="template" value=""/>
                        <input type="hidden" id="huella1" name="huella1" value=""/>
                        <input type="hidden" id="huella2" name="huella2" value=""/>
                        <input type="hidden" id="bidimensional" name="bidimensional" value=""/>
                        <input type="hidden" id="dedo1" name="dedo1" value=""/>
                        <input type="hidden" id="dedo2" name="dedo2" value=""/>
                        <input type="hidden" id="foto" name="foto" value=""/>
                        <input type="hidden" id="firma" name="firma" value=""/>
                        <input type="hidden" name="placa" id="placa" value="<%=placa%>" />
                        <fieldset>
                            <legend><span class="Estilo9">DATOS GENERALES DE LA SOLICITUD</span></legend>
                            <table width="100%" border="0" align="center" id="panelTramites" style="display:block">
                                <tr>
                                    <th colspan="4" scope="col">&nbsp;</th>
                                </tr>
                                <tr>
                                    <th colspan="4" scope="col"><span class="Estilo12"><%=placa%></span></th>
                                </tr>
                                <tr>
                                    <th colspan="4" scope="col">&nbsp;</th>
                                </tr>
                                <tr>
                                    <td width="15%" align="left"><span class="Estilo5">
                                            <label><font face="Arial, Helvetica, sans-serif"><b>Solicitado&nbsp;Por</b></font></label>
                                        </span></td>
                                    <td width="23%" align="left"><span class="Estilo5">
                                            <select  name="tipoDocumento" id="tipoDocumento" style="width:250px; font-size:12px; color:#006699">
                                                <% java.util.List tipoDocumentos = model.listadoParametros(5);
                                                    int tip_rad = 0;
                                                    String doc_rad = "";
                                                    if (request.getParameter("tip_rad") != null) {
                                                        tip_rad = Integer.parseInt(request.getParameter("tip_rad"));
                                                        doc_rad = request.getParameter("doc_rad");
                                                    } else {
                                                        tip_rad = Integer.parseInt(request.getParameter("tipo"));
                                                        doc_rad = request.getParameter("documento");
                                                    }
                                                    Persona solT = model.consultarPersona(tip_rad, doc_rad);
                                                    String nameST = solT.getNombre_1() + " " + solT.getApellido_1() + " " + (solT.getApellido_2() != null ? solT.getApellido_2() : "");
                                                    for (int i = 0; i < tipoDocumentos.size(); i++) {
                                                        Parametro parametro = (Parametro) tipoDocumentos.get(i);
                                                        if (parametro.getCodigo() == tip_rad) {%>
                                                <option value="<%=parametro.getCodigo()%>" selected="selected"><%= parametro.getNombre()%> </option>
                                                <% }
                                                    }%>
                                            </select>
                                        </span> </td>
                                    <td width="14%" align="center"><span class="Estilo5">
                                            <label><font face="Arial, Helvetica, sans-serif"><b>Documento</b></font></label>
                                        </span></td>
                                    <td width="48%" align="left">
                                        <input name="numeroDocumento" type="text" id="numeroDocumento"  value="<%=doc_rad%>" readonly="true" style="width:180px; text-align:center; font-size:12px; color:#006699"/></td>
                                </tr>
                                <tr>
                                    <td align="left"><span class="Estilo5">
                                            <label><font face="Arial, Helvetica, sans-serif"><b>Nombre</b></font></label>
                                        </span></td>
                                    <td colspan="3" align="left">
                                        <input name="nombreRadicador" type="text" id="nombreRadicador" style="width:550px; font-size:12px; color:#006699" readonly="true" value="<%=nameST%>"/></td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <table width="99%" border="0">
                                            <tr style="background:url(../html/images/inicio_3.png)">
                                                <th width="5%" scope="col"><span class="Estilo11">
                                                        <label><font face="Arial, Helvetica, sans-serif"><b>ID</b></font></label>

                                                        <label></label>
                                                    </span></th>
                                                <th width="50%" scope="col"><span class="Estilo11">
                                                        <label><font face="Arial, Helvetica, sans-serif"><b>NOMBRE TRAMITE</b></font></label>

                                                        <label></label>
                                                    </span></th>
                                                <th width="15%" scope="col"><span class="Estilo11">
                                                        <label><font face="Arial, Helvetica, sans-serif"><b># PAGO TRANSITO</b></font></label>

                                                        <label></label>
                                                    </span></th>
                                                <th width="15%" scope="col"><span class="Estilo11">
                                                        <label><font face="Arial, Helvetica, sans-serif"><b>RECIBO RUNT</b></font></label>

                                                        <label></label>
                                                    </span></th>
                                                <th width="15%" scope="col"><span class="Estilo11">
                                                        <label><font face="Arial, Helvetica, sans-serif"><b>RECIBO RUNT 2</b></font></label>

                                                        <label></label>
                                                    </span></th>
                                            </tr>
                                            <%
                                                long id_tramite = 0;
                                                String valFun = "";
                                                if (listaTramites.size() > 0) {
                                                    id_tramite = Integer.parseInt(listaTramites.get(0).toString());
                                                    modelo.Tramite tramite = model.consultarTramite(id_tramite);
                                                    valFun = model.obtenerPosiblePagoTRANSITO(placa, tramite.getId_tramite());
                                                    if (valFun.length() == 0) {
                                                        valFun = model.consultarPagoReclamo(1, placa.toUpperCase(), tramite.getId_tramite());
                                                        valFun = valFun != null ? valFun : "";
                                                    }
                                                    String valRunt = model.obtenerPosiblePagoRUNT(placa, solT.getId_persona(), id_tramite, 1);
                                                    String valSimit = "";
                                            %>
                                            <tr style="color:#333333">
                                                <td align="center"><span class="Estilo5">
                                                        <label><font face="Arial, Helvetica, sans-serif"><b><%=tramite.getId_tramite()%></b></font></label>
                                                    </span></td>
                                                <td align="center"><span class="Estilo5">
                                                        <label><font face="Arial, Helvetica, sans-serif"><b><%=tramite.getNombre()%></b></font></label>
                                                    </span></td>
                                                <td align="center"><input name="fun<%=id_tramite%>" type="text" id="fun<%=id_tramite%>" style="text-align:center; color:#006699; font-size:13px" value="<%=valFun%>" readonly/></td>
                                                <td align="center"><input name="runt<%=id_tramite%>" type="text"  maxlength="18" id="runt<%=id_tramite%>" style="text-align:center; color:#333333; font-size:13px" value="<%=valRunt%>"  onblur="revisarL(this)"/></td>
                                                <td align="center"><input name="simit<%=id_tramite%>" type="text" id="simit<%=id_tramite%>" style="text-align:center; color:#006699; font-size:13px" value="<%=valSimit%>" onblur="revisarL(this)" /></td>
                                                <script type="text/javascript" language="javascript">
                                                    document.getElementById('runt<%=id_tramite%>').focus();
                                                </script>
                                            </tr>
                                            <%  } %>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="4" scope="col">&nbsp;</th>
                                </tr>
                                <tr>
                                    <th colspan="4" scope="col">
                                        <table width="100%" border="0" id="panelPropietarios" style="display:none" align="center" cellpadding="0" cellspacing="0">
                                            <% boolean enable = false;
                                                String state = "";
                                                if (lsec.contains("panelPropietarios")) { %>
                                            <tr>
                                                <td width="100%" align="center"><table width="100%" border="0" align="center">
                                                        <tr>
                                                            <td width="95%" align="center"><span class="Estilo5">
                                                                    <label><font face="Arial, Helvetica, sans-serif"><b>LISTADO DE PROPIETARIOS DEL VEHICULO</b></font></label>
                                                                </span></td>
                                                            <td width="5%" align="center"><span class="Estilo5">
                                                                    <% enable = model.isEnable(listaTramites, 1);
                                                                        if (enable) { %>
                                                                    <img src="../html/images/adicionar.gif" alt="Nuevo Propietario" width="16" height="16" style="cursor:pointer" onclick="newP()" id="adicionarPropietario"/>
                                                                    <% } else { %>
                                                                    <img src="../html/images/adicionar.gif" alt="Nuevo Propietario" width="16" height="16" style="cursor:pointer" id="adicionarPropietario"/>
                                                                    <% } %>
                                                                </span></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2" valign="top" align="center"><iframe src = "radicarPropietarios.jsp" id="prop" name="prop" marginwidth="0" height="200" width="775" marginheight="0" scrolling="auto" style="border:none" frameborder="0"></iframe></td>
                                                        </tr>
                                                    </table></td>
                                            </tr>
                                            <% } %>
                                        </table>
                                        <table width="100%" border="0" id="panelAlertas" style="display:none">
                                            <%  if (lsec.contains("panelAlertas")) { %>
                                            <tr style="background:url(../html/images/inicio_3.png)">
                                                <th colspan="6" scope="col"><span class="Estilo5">
                                                        <label><font face="Arial"><b><span class="Estilo13">ALERTAS/PIGNORACIONES DEL VEHICULO&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font></label>
                                                    </span></th>
                                            </tr>
                                            <tr>
                                                <th colspan="6"><label><font size="2" face="Arial, Helvetica, sans-serif" >&nbsp;</font></label></th>
                                            </tr>
                                            <% enable = model.isEnable(listaTramites, 2);
                                                state = enable ? "" : "disabled";%>
                                            <tr>
                                                <td align="left"><span class="Estilo6"> <span class="Estilo2">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Tipo&nbsp;Alerta</b></font></label>
                                                        </span> </span></td>
                                                <td align="left"><input name="tipoAlerta" type="text" id="tipoAlerta" style="color:#333333; text-align:center; width:35px" onblur="verInput(this, 'alertas')" <%=state%>/>
                                                    <select name="alertas" id="alertas" onchange="verCombo(this, 'Alerta')" style="width:180px; color:#333333" <%=state%>>
                                                        <% Alerta alerta = null;
                                                            if (vehiculo != null) {
                                                                alerta = model.consultarAlerta(vehiculo.getId_vehiculo());
                                                            }

                                                            java.util.List alertas = model.listadoParametros(4);
                                                            for (int i = 0; i < alertas.size(); i++) {
                                                                Parametro parametro = (Parametro) alertas.get(i);
                                                                if (alerta != null) {
                                                                    if (parametro.getCodigo() == alerta.getTipo()) {%>
                                                        <option value="<%=parametro.getCodigo()%>" selected><%=parametro.getNombre()%></option>
                                                        <script language="javascript" type="text/javascript">document.getElementById('tipoAlerta').value = <%=parametro.getCodigo()%>;</script>
                                                        <%	} else {%>
                                                        <option value="<%=parametro.getCodigo()%>"><%=parametro.getNombre()%></option>
                                                        <%	}
                                                        } else {%>
                                                        <script language="javascript" type="text/javascript">document.getElementById('tipoAlerta').value = 1;</script>
                                                        <option value="<%=parametro.getCodigo()%>" <%=(parametro.getCodigo() == 1 ? "selected" : "")%>><%=parametro.getNombre()%> </option>
                                                        <%	}
                                                            }%>
                                                    </select></td>
                                                <td><span class="Estilo6"> <span class="Estilo7"> <span class="Estilo2">
                                                                <label><font face="Arial, Helvetica, sans-serif"><b>Observacion</b></font></label>
                                                            </span> </span> </span></td>
                                                <td colspan="2"><input name="observacionAlerta" type="text" style="font-size:12px;color:#333333" id="observacionAlerta" size="60" <%=state%>/></td>
                                            </tr>
                                            <tr>
                                                <td width="9%" height="24" align="left"><span class="Estilo2"> <span class="Estilo6">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>A&nbsp;Favor&nbsp;de</b></font></label>
                                                        </span> </span></td>
                                                <td width="30%" align="left"><select  name="tipoDocumentoAlerta" id="tipoDocumentoAlerta" style="width:225px; color:#333333" <%=state%>>
                                                        <%
                                                            for (int i = 0; i < tipoDocumentos.size(); i++) {
                                                                Parametro parametro = (Parametro) tipoDocumentos.get(i);%>
                                                        <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                                                        <% }%>
                                                    </select></td>
                                                <td width="14%"><input name="numeroDocumentoAlerta" type="text" id="numeroDocumentoAlerta" onblur="consultaPersonaAlerta()" size="17" style="text-align:center; color:#333333" <%=state%>/></td>
                                                <td width="8%"><span class="Estilo6"> <span class="Estilo2">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Nombre</b></font></label>
                                                        </span> </span></td>
                                                <td width="39%"><input name="nombreAlerta" type="text" id="nombreAlerta" style="color:#333333" size="50" readonly="true" <%=state%>/></td>
                                            </tr>
                                            <tr>
                                                <td colspan="6">&nbsp;</td>
                                            </tr>
                                            <% } %>
                                        </table>
                                        <table width="100%" border="0" id="panelOrganismos" style="display:none">
                                            <%  if (lsec.contains("panelOrganismos")) { %>
                                            <tr style="background:url(../html/images/inicio_3.png)">
                                                <th colspan="5" scope="col"><span class="Estilo5">
                                                        <label><font face="Arial"><b><span class="Estilo13">ORGANISMO DE TRANSITO DE RADICACION/TRASLADO &nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font></label>
                                                    </span></th>
                                            </tr>
                                            <tr>
                                                <th colspan="5"><label><font size="2" face="Arial, Helvetica, sans-serif" >&nbsp;</font></label></th>
                                            </tr>
                                            <% enable = model.isEnable(listaTramites, 3);
                                                state = enable ? "" : "disabled";%>
                                            <tr>
                                                <td width="13%"><label class="Estilo5"><font face="Arial, Helvetica, sans-serif"><b>Organismo</b></font></label></td>
                                                <td width="13%"><input name="tipoOrganismo" type="text" id="tipoOrganismo" size="15" style="color:#333333; text-align:center" onblur="verOrganismo(this, 2)" <%=state%>/></td>
                                                <td width="31%">
                                                    <select name="organismos2" id="organismos2" style="display:none; color:#333333" <%=state%>>
                                                        <option value="0"><<--Seleccione Organismo-->></option>
                                                        <%	java.util.List organismos = model.consultarSedes();
                                                            for (int i = 0; i < organismos.size(); i++) {
                                                                Sede sede = (Sede) organismos.get(i);%>
                                                        <option value="<%=sede.getCodigo()%>"></option>
                                                        <%	 }%>
                                                    </select>
                                                    <select name="organismos" id="organismos" onchange="verOrganismo(this, 1)" <%=state%>>
                                                        <option value="0"><<--Seleccione Organismo-->></option>
                                                        <%
                                                            for (int i = 0; i < organismos.size(); i++) {
                                                                Sede sede = (Sede) organismos.get(i);
                                                                if (sede.getId_sede() != 234) {
                                                                    if (vehiculo != null) {
                                                                        if (vehiculo.getFk_sede() == sede.getId_sede()) {%>
                                                        <option value="<%=sede.getId_sede()%>" selected> <%=sede.getNombre_corto()%> </option>
                                                        <script language="javascript" type="text/javascript">document.getElementById('tipoOrganismo').value = <%=sede.getCodigo()%>;</script>
                                                        <%   } else {%>
                                                        <option value="<%=sede.getId_sede()%>"> <%=sede.getNombre()%> </option>
                                                        <%  }
                                                        } else {%>
                                                        <option value="<%=sede.getId_sede()%>"> <%=sede.getNombre()%> </option>
                                                        <%  }
                                                                }
                                                            }%>
                                                    </select>                 </td>
                                                <td width="20%"><span class="Estilo6"> <span class="Estilo2">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Numero&nbsp;Licencia</b></font></label>
                                                        </span> </span></td>
                                                <td width="23%"><input name="numeroLicencia" type="text" id="numeroLicencia" style="color:#333333" size="20" <%=state%>/></td>
                                            </tr>
                                            <% } %>
                                        </table>
                                        <table width="100%" border="0" id="panelAseguradoras" style="display:none">
                                            <%  if (lsec.contains("panelAseguradoras")) { %>
                                            <tr style="background:url(../html/images/inicio_3.png)">
                                                <th colspan="7" scope="col"><span class="Estilo5">
                                                        <label><font face="Arial"><b><span class="Estilo13">EMPRESA ASEGURADORA DEL VEHICULO</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font></label>
                                                    </span></th>
                                            </tr>
                                            <tr>
                                                <th colspan="7"><label><font size="2" face="Arial, Helvetica, sans-serif" >&nbsp;</font></label></th>
                                            </tr>
                                            <% enable = model.isEnable(listaTramites, 4);
                                                state = enable ? "" : "disabled";%>
                                            <tr>
                                                <td width="11%"><span class="Estilo6"> <span class="Estilo2">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Aseguradora</b></font></label>
                                                        </span> </span></td>
                                                <td width="37%"><select name="comboAseguradora" id="comboAseguradora" style="width:260px; font-size:12px; color:#333333" <%=state%>>
                                                        <option value="0"> <%="---- Seleccione Aseguradora ----"%> </option>
                                                        <%	java.util.List aseguradoras = model.listaAseguradoras();
                                                            for (int i = 0; i < aseguradoras.size(); i++) {
                                                                Aseguradora aseguradora = (Aseguradora) aseguradoras.get(i);
                                                                Persona persona = model.consultarPersona(aseguradora.getFk_persona());%>
                                                        <option value="<%=aseguradora.getId_aseguradora()%>"> <%=persona.getNombre_1() + " " + persona.getApellido_1()%> </option>
                                                        <%	}%>
                                                    </select></td>
                                                <td width="8%"><span class="Estilo6"> <span class="Estilo2">
                                                            <label><font face="Arial"><b>Poliza</b></font></label>
                                                        </span> </span></td>
                                                <td width="18%"><input name="poliza" type="text" id="poliza" size="20" style="text-align:center; font-family:Arial, Helvetica, sans-serif; color:#333333" <%=state%>/></td>
                                                <td width="8%"><span class="Estilo6"> <span class="Estilo2">
                                                            <label><font face="Arial"><b>Vence</b></font></label>
                                                        </span> </span></td>
                                                <td width="13%"><input name="vence" type="text" id="vence" size="15" style="color:#333333;text-align:center" onkeyup="mascara(this, '/', true)" maxlength="10" <%=state%>/></td>
                                                <td width="5%"><input name="fechavence" type="button" id="fechavence" value="<<" style="font-family:Arial, Helvetica;color:#333333" <%=state%>/></td>
                                                <script type="text/javascript">
                                                    Calendar.setup({
                                                        inputField: "vence", // id del campo de texto
                                                        ifFormat: "%d/%m/%Y", // formato de la fecha, cuando se escriba en el campo de texto
                                                        button: "fechavence"   // el id del bot?n que lanzar? el calendario
                                                    });
                                                </script>
                                            </tr>
                                            <% } %>
                                        </table>
                                        <table width="100%" border="0" id="panelEspecificaciones" style="display:none" align="center">
                                            <%  if (lsec.contains("panelEspecificaciones")) { %>
                                            <tr style="background:url(../html/images/inicio_3.png)">
                                                <th><span class="Estilo5 Estilo13"><font face="Arial">DETALLE DE ESPECIFICACIONES DEL VEHICULO</font></span></th>
                                            </tr>
                                            <tr>
                                                <th><label><font size="2" face="Arial, Helvetica, sans-serif" >&nbsp;</font></label></th>
                                            </tr>
                                            <tr>
                                                <td width="100%" align="center">
                                                    <iframe src = "radicarEspecificaciones.jsp?id=<%=id_tramite%>" id="espc" name="espc" marginwidth="0" height="150" width="800" marginheight="0" scrolling="auto" style="border:none"></iframe>
                                                </td>
                                            </tr>
                                            <% } %>
                                        </table>
                                        <%   Preasignacion preasignacion = null;
                                            int pre_clase = 0;
                                            int pre_servicio = 0;
                                            int pre_marca = 0;
                                            int pre_linea = 0;
                                            int pre_modelo = 0;
                                            int pre_modalidad = 0;
                                            int pre_combustible = 0;
                                            int pre_carroceria = 0;
                                            int pre_tipoImportacion = 0;
                                            int pre_tipoDocImportacion = 0;
                                            String pre_motor = null;
                                            String pre_chasis = null;
                                            String pre_serie = null;
                                            String pre_vin = null;
                                            String pre_acta = null;
                                            if (id_tramite == 1 || id_tramite == 62 || id_tramite == 91) {
                                                preasignacion = model.consultarPreasignacion(placa);
                                                if (preasignacion != null) {
                                                    pre_clase = preasignacion.getClase();
                                                    pre_servicio = preasignacion.getServicio();
                                                    pre_marca = preasignacion.getMarca();
                                                    pre_linea = preasignacion.getLinea();
                                                    pre_motor = preasignacion.getMotor();
                                                    pre_chasis = preasignacion.getChasis();
                                                    pre_serie = preasignacion.getSerie();
                                                    pre_vin = preasignacion.getVin();
                                                    pre_modelo = preasignacion.getModelo();
                                                    pre_acta = preasignacion.getActaImportacion();
                                                    if (pre_acta != null) {
                                                        pre_tipoImportacion = 1;
                                                        pre_tipoDocImportacion = 3;
                                                    }
                                                    if (pre_clase == 10 || pre_clase == 40 || pre_clase == 17 || pre_clase == 19) {
                                                        pre_modalidad = 1;
                                                        pre_combustible = 1;
                                                    }
                                                }
                                            }
                                            System.out.println("ID_TRAMITE: " + id_tramite);
                                            Tramite tipot = model.consultarTramite(id_tramite);
                                            AutomotorOutDTO auto = new AutomotorOutDTO();
                                            if (tipot.getClase_tramite() == 4 && id_tramite == 91) {
                                                if (session.getAttribute("RuntRnma") != null) {
                                                    auto = (AutomotorOutDTO) session.getAttribute("RuntRnma");
                                                }
                                            }
                                        %>
                                        <table width="100%" border="0" id="panelCaracteristicas" style="display:none">
                                            <%  if (lsec.contains("panelCaracteristicas")) { %>
                                            <tr style="background:url(../html/images/inicio_3.png)">
                                                <th colspan="6"><span class="Estilo5 Estilo13"><font face="Arial">CARACTERISTICAS DEL VEHICULO</font></span></th>
                                            </tr>
                                            <tr>
                                                <th colspan="6"><label><font size="2" face="Arial, Helvetica, sans-serif" >&nbsp;</font></label></th>
                                            </tr>
                                            <% enable = model.isEnable(listaTramites, 6);
                                                state = enable ? "" : "disabled";%>
                                            <tr align="left">
                                                <td width="12%"><span class="Estilo6"> <span class="Estilo2">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Clase</b></font></label>
                                                        </span> </span></td>
                                                <td width="5%" scope="col"><input name="tipoClase" type="text" id="tipoClase" style="width:35px;color:#333333; text-align:center" onblur="verInput(this, 'clases')" <%=state%>/></td>
                                                <td width="30%" scope="col"><strong>
                                                        <select name="clases" id="clases" onchange="verCombo(this, 'Clase')" style="width:200px; color:#333333" <%=state%>>
                                                            <% int claseCarr = 0;
                                                                if (pre_clase == 0) { %>
                                                            <option value="0"><<--Seleccione Clase-->></option>
                                                            <%  java.util.List clases = model.listadoParametros(1);
                                                                for (int i = 0; i < clases.size(); i++) {
                                                                    Parametro parametro = (Parametro) clases.get(i);
                                                                    if (vehiculo != null) {
                                                                        if (vehiculo.getClase_vehiculo() == parametro.getCodigo()) {
                                                                            claseCarr = (int) vehiculo.getClase_vehiculo(); %>
                                                            <% if (parametro.getNombreCorto().equals(tipot.getClase_tramite())) {%>
                                                            <option  value="<%=parametro.getCodigo()%>" selected="selected"><%= parametro.getNombre()%></option>
                                                            <script type="text/javascript" language="javascript">document.getElementById('tipoClase').value = <%=parametro.getCodigo()%>;</script>
                                                            <%}%>
                                                            <%   } else {%>
                                                            <option  value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                                                            <%   }
                                                            } else {%>
                                                            <% if (parametro.getNombreCorto().equals(tipot.getClase_tramite() + "")) {
                                                                    if (auto.getAutomotor() != null) {
                                                                        if (auto.getAutomotor().getValue().getClase().equals(parametro.getCodigo() + "")) {
                                                                            claseCarr = Integer.parseInt(auto.getAutomotor().getValue().getClase());
                                                            %>
                                                            <option  value="<%=parametro.getCodigo()%>" selected="selected" ><%= parametro.getNombre()%> </option>
                                                            <script type="text/javascript" language="javascript">document.getElementById('tipoClase').value = <%=parametro.getCodigo()%>;</script>
                                                            <%
                                                            } else {
                                                            %>
                                                            <option  value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                                                            <%
                                                                    }
                                                                }
                                                            %>
                                                            <script type="text/javascript" language="javascript">document.getElementById('tipoClase').value = <%=((Parametro) clases.get(0)).getCodigo()%>;</script>
                                                            <option  value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                                                            <%}
                                                                    }
                                                                }
                                                            } else {
                                                                claseCarr = pre_clase;
                                                                String pre_param = model.consultarParametroName(1, pre_clase);%>
                                                            <option  value="<%=pre_clase%>" selected="selected"><%= pre_param%></option>
                                                            <script type="text/javascript" language="javascript">document.getElementById('tipoClase').value = <%=pre_clase%>;</script>
                                                            <% }%>
                                                        </select>
                                                    </strong></td>
                                                    <% enable = model.isEnable(listaTramites, 7);
                                                        state = enable ? "" : "disabled";%>
                                                <td width="14%" scope="col"><span class="Estilo6"> <span class="Estilo2">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Servicio</b></font></label>
                                                        </span> </span></td>
                                                <td width="5%" scope="col"><input name="tipoServicio" type="text" id="tipoServicio" style="width:35px;color:#333333; text-align:center" onblur="verInput(this, 'servicios')" <%=state%>/></td>
                                                <td width="34%" scope="col">
                                                    <select name="servicios" id="servicios" onchange="verCombo(this, 'Servicio')" style="width:200px;color:#333333" <%=state%>>
                                                        <% if (pre_servicio == 0) { %>
                                                        <option value="0"><<--Seleccione Servicio-->></option>
                                                        <% java.util.List servicios = model.listadoParametros(3);
                                                            for (int i = 0; i < servicios.size(); i++) {
                                                                Parametro parametro = (Parametro) servicios.get(i);
                                                                if (vehiculo != null) {
                                                                    if (vehiculo.getServicio() == parametro.getCodigo()) {%>
                                                        <option value="<%=parametro.getCodigo()%>" selected="selected"><%= parametro.getNombre()%> </option>
                                                        <script type="text/javascript" language="javascript">document.getElementById('tipoServicio').value = <%=parametro.getCodigo()%>;</script>
                                                        <%	} else {%>
                                                        <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                                                        <%	}
                                                        } else {%>
                                                        <script type="text/javascript" language="javascript">document.getElementById('tipoServicio').value = <%=((Parametro) servicios.get(0)).getCodigo()%>;</script>
                                                        <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                                                        <%  }
                                                            }
                                                        } else {
                                                            String pre_param = model.consultarParametroName(3, pre_servicio);%>
                                                        <option  value="<%=pre_servicio%>" selected="selected"><%= pre_param%></option>
                                                        <script type="text/javascript" language="javascript">document.getElementById('tipoServicio').value = <%=pre_servicio%>;</script>
                                                        <%
                                                            }%>
                                                    </select></td>
                                            </tr>
                                            <tr align="left">
                                                <% enable = model.isEnable(listaTramites, 8);
                                                    state = enable ? "" : "disabled";%>
                                                <td><span class="Estilo6"> <span class="Estilo2">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Marca</b></font></label>
                                                        </span> </span></td>
                                                <td><input name="tipoMarca" type="text" id="tipoMarca" style="width:35px;color:#333333; text-align:center" onblur="verInput(this, 'marcas')" <%=state%>/></td>
                                                <td>
                                                    <script type="text/javascript" language="javascript">document.getElementById('tipoMarca').value = 0;</script>
                                                    <%long marca_cod = 0;
                                                        long linea_cod = 0;

                                                        if (tipot.getClase_tramite() == 1) {%>
                                                    <select name="marcas" id="marcas" onchange="verCombo(this, 'Marca')" style="width:200px;color:#333333" <%=state%>>
                                                        <% marca_cod = 0;
                                                            linea_cod = 0;
                                                            if (pre_marca == 0) { %>
                                                        <option value="0"><<--Seleccione Marca-->></option>
                                                        <%  Marca marca_veh = null;
                                                            java.util.List marcas = model.listadoMarcas();
                                                            if (vehiculo != null) {
                                                                marca_veh = model.consultaMarca(vehiculo.getPlaca().toUpperCase());
                                                                if (marca_veh != null) {
                                                                    marca_cod = marca_veh.getCodigo();
                                                                }
                                                                linea_cod = vehiculo.getFk_linea();
                                                            }
                                                            for (int i = 0; i < marcas.size(); i++) {
                                                                Marca marca = (Marca) marcas.get(i);
                                                                if (marca_cod == marca.getCodigo()) {%>
                                                        <option value="<%=marca.getCodigo()%>" selected="selected"><%= marca.getNombre()%> </option>
                                                        <script type="text/javascript" language="javascript">document.getElementById('tipoMarca').value = <%=marca.getId_marca()%>;</script>
                                                        <%  } else {%>
                                                        <option value="<%=marca.getCodigo()%>"><%= marca.getNombre()%> </option>
                                                        <%  }
                                                            }
                                                        } else {
                                                            Marca pre_param = model.getMarca(pre_marca);
                                                            marca_cod = pre_marca;
                                                            linea_cod = pre_linea;%>
                                                        <option  value="<%=pre_marca%>" selected="selected"><%=pre_param.getNombre()%></option>
                                                        <script type="text/javascript" language="javascript">document.getElementById('tipoMarca').value = <%=pre_marca%>;</script>
                                                        <%  }%>
                                                    </select>

                                                    <input type="hidden" id="marca_cod" name="marca_cod" value="<%=marca_cod%>" />
                                                    <input type="hidden" id="linea_cod" name="linea_cod" value="<%=linea_cod%>" />				</td>
                                                    <% } else if (tipot.getClase_tramite() == 4) {
                                                        System.out.println("Registro Inicial Maquinaria Agricola");
                                                    %>
                                                <select name="marcas" id="marcas" onchange="verCombo(this, 'Marca')" style="width:200px;color:#333333" <%=state%>>
                                                    <% marca_cod = 0;
                                                        linea_cod = 0;
                                                        if (pre_marca == 0) { %>
                                                    <option value="0"><<--Seleccione Marca-->></option>
                                                    <%  Marcas_maquinaria marca_veh = null;
                                                        java.util.List marcas = model.listadoMarcasRNMA();
                                                        if (vehiculo != null) {
                                                            marca_veh = model.consultaMarcaMquinaria(vehiculo.getPlaca().toUpperCase());
                                                            if (marca_veh != null) {
                                                                marca_cod = marca_veh.getCodigo_marca();
                                                                linea_cod = vehiculo.getFk_linea();
                                                            } else {
                                                                if (auto.getAutomotor() != null) {
                                                                    marca_cod = Long.parseLong(auto.getAutomotor().getValue().getMarca());
                                                                    linea_cod = Long.parseLong(auto.getAutomotor().getValue().getInformacion().getValue().getLinea());
                                                                }

                                                            }

                                                        }
                                                        for (int i = 0; i < marcas.size(); i++) {
                                                            Marcas_maquinaria marca = (Marcas_maquinaria) marcas.get(i);
                                                            if (marca_cod == marca.getCodigo_marca()) {%>
                                                    <option value="<%=marca.getCodigo_marca()%>" selected="selected"><%= marca.getDescripcion()%> </option>
                                                    <script type="text/javascript" language="javascript">document.getElementById('tipoMarca').value = <%=marca.getCodigo_marca()%>;</script>
                                                    <%  } else {%>
                                                    <option value="<%=marca.getCodigo_marca()%>"><%= marca.getDescripcion()%> </option>
                                                    <%  }
                                                        }
                                                    } else {
                                                        Marcas_maquinaria pre_param = model.getMarcaMaquinaria(pre_marca);
                                                        marca_cod = pre_marca;
                                                        linea_cod = pre_linea;
                                                    %>
                                                    <option  value="<%=pre_marca%>" selected="selected"><%=pre_param.getDescripcion()%></option>
                                                    <script type="text/javascript" language="javascript">document.getElementById('tipoMarca').value = <%=pre_marca%>;</script>
                                                    <%  }%>
                                                </select>

                                                <input type="hidden" id="marca_cod" name="marca_cod" value="<%=marca_cod%>" />
                                                <input type="hidden" id="linea_cod" name="linea_cod" value="<%=linea_cod%>" />				</td>
                                                <% } else if (tipot.getClase_tramite() == 5) {
                                                    System.out.println("Registro Inicial Remolques y Semi Remolques");
                                                %>
                                                <select name="marcas" id="marcas" onchange="verCombo(this, 'Marca')" style="width:200px;color:#333333" <%=state%>>
                                                    <% marca_cod = 0;
                                                        linea_cod = 0;
                                                        if (pre_marca == 0) { %>
                                                    <option value="0"><<--Seleccione Marca-->></option>
                                                    <%  Marcas_Remolques marca_veh = null;
                                                        java.util.List marcas = model.listadoMarcasRNRYS();
                                                        if (vehiculo != null) {
                                                            marca_veh = model.consultaMarcaRNRYS(vehiculo.getPlaca().toUpperCase());
                                                            if (marca_veh != null) {
                                                                marca_cod = marca_veh.getCodigo();
                                                            }
                                                            linea_cod = vehiculo.getFk_linea();
                                                        }
                                                        for (int i = 0; i < marcas.size(); i++) {
                                                            Marcas_Remolques marca = (Marcas_Remolques) marcas.get(i);
                                                            if (marca_cod == marca.getCodigo()) {%>
                                                    <option value="<%=marca.getCodigo()%>" selected="selected"><%= marca.getNombre()%> </option>
                                                    <script type="text/javascript" language="javascript">document.getElementById('tipoMarca').value = <%=marca.getId_marca_rem()%>;</script>
                                                    <%  } else {%>
                                                    <option value="<%=marca.getCodigo()%>"><%= marca.getNombre()%> </option>
                                                    <%  }
                                                        }
                                                    } else {
                                                        Marcas_Remolques pre_param = model.getMarcaRNRYS(pre_marca);
                                                        marca_cod = pre_marca;
                                                        linea_cod = pre_linea;
                                                    %>
                                                    <option  value="<%=pre_marca%>" selected="selected"><%=pre_param.getNombre()%></option>
                                                    <script type="text/javascript" language="javascript">document.getElementById('tipoMarca').value = <%=pre_marca%>;</script>
                                                    <%  }%>
                                                </select>

                                                <input type="hidden" id="marca_cod" name="marca_cod" value="<%=marca_cod%>" />
                                                <input type="hidden" id="linea_cod" name="linea_cod" value="<%=linea_cod%>" />				</td>
                                                <% }%>






                                                <td><span class="Estilo2"> <span class="Estilo6">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Linea</b></font></label>
                                                        </span> </span></td>
                                                <td>
                                                    <input name="tipoLinea" type="text" id="tipoLinea" style="width:35px;color:#333333; text-align:center" value="<%=linea_cod%>" onblur="verInput(this, 'lineas')" <%=state%>/></td>
                                                <td>
                                                    <%
                                                        if (tipot.getClase_tramite() == 1) {
                                                            if (pre_linea == 0) { %>
                                                    <input type="hidden" id="tipoL" name="tipoL" value="1"/>
                                                    <div id="lineasdiv"></div>				</td>
                                                <script language="javascript" type="text/javascript">verCombo(document.getElementById('marcas'), 'Marca');</script>
                                                <% } else {
                                                    Linea linea = model.getLinea(pre_linea);%>
                                                <select name="lineas" id="lineas" onchange="verCombo(this, 'Linea')" style="width:200px;color:#333333" <%=state%>>
                                                    <option value="<%=pre_linea%>" selected="selected"><%= linea.getNombre()%> </option>
                                                    <script type="text/javascript" language="javascript">document.getElementById('tipoLinea').value = <%=pre_linea%>;</script>
                                                </select>
                                                <%   }
                                                } else {
                                                    if (tipot.getClase_tramite() == 5) {
                                                        if (pre_linea == 0) { %>
                                                <input type="hidden" id="tipoL" name="tipoL" value="2"/>
                                                <div id="lineasdiv"></div>				</td>
                                                <script language="javascript" type="text/javascript">verCombo(document.getElementById('marcas'), 'Marca');</script>
                                                <% } else {
                                                    Linea_Remolques linea = model.getLineaRNRYS(pre_linea);%>
                                                <select name="lineas" id="lineas" onchange="verCombo(this, 'Linea')" style="width:200px;color:#333333" <%=state%>>
                                                    <option value="<%=pre_linea%>" selected="selected"><%= linea.getNombre()%> </option>
                                                    <script type="text/javascript" language="javascript">document.getElementById('tipoLinea').value = <%=pre_linea%>;</script>
                                                </select>
                                                <%          }
                                                } else {
                                                    if (tipot.getClase_tramite() == 4) {
                                                        if (pre_linea == 0) { %>
                                                <input type="hidden" id="tipoL" name="tipoL" value="3"/>
                                                <div id="lineasdiv"></div>				</td>
                                                <script language="javascript" type="text/javascript">verCombo(document.getElementById('marcas'), 'Marca');</script>
                                                <% } else {
                                                    Linea_maquinaria linea = model.getLineaMaquinaria(pre_linea);%>
                                                <select name="lineas" id="lineas" onchange="verCombo(this, 'Linea')" style="width:200px;color:#333333" <%=state%>>
                                                    <option value="<%=pre_linea%>" selected="selected"><%= linea.getDescripcion()%> </option>
                                                    <script type="text/javascript" language="javascript">document.getElementById('tipoLinea').value = <%=pre_linea%>;</script>
                                                </select>
                                                <%          }
                                                            }

                                                        }
                                                    }
                                                %>
                                            </tr>
                                            <tr align="left">
                                                <% enable = model.isEnable(listaTramites, 9);
                                                    state = enable ? "" : "disabled";%>
                                                <td><span class="Estilo6"> <span class="Estilo2">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Carroceria</b></font></label>
                                                        </span> </span></td>
                                                <td><input name="tipoCarroceria" type="text" id="tipoCarroceria" style="width:35px;color:#333333; text-align:center" onblur="verInput(this, 'carrocerias')" <%=state%>/></td>
                                                <td>
                                                    <select name="carrocerias" id="carrocerias" onchange="verCombo(this, 'Carroceria')" style="width:200px;color:#333333" <%=state%>>
                                                        <% if (pre_carroceria == 0) { %>
                                                        <option value="0"><<--Seleccione Carroceria-->></option>
                                                        <%
                                                            java.util.List carrocerias = model.listadoParametros(2);
                                                            for (int i = 0; i < carrocerias.size(); i++) {
                                                                Parametro parametro = (Parametro) carrocerias.get(i);
                                                                if (parametro.getNombreCorto().equals("" + claseCarr)) {
                                                                    if (hash_caracteristicas.get("2") != null) {
                                                                        if (Integer.parseInt(hash_caracteristicas.get("2") + "") == parametro.getCodigo()) {%>
                                                        <option value="<%=parametro.getCodigo()%>" selected><%= parametro.getNombre()%> </option>
                                                        <script type="text/javascript" language="javascript">document.getElementById('tipoCarroceria').value = <%=parametro.getCodigo()%>;</script>
                                                        <%  } else {%>
                                                        <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                                                        <%   }
                                                        } else {%>
                                                        <script type="text/javascript" language="javascript">document.getElementById('tipoCarroceria').value = <%=((Parametro) carrocerias.get(0)).getCodigo()%>;</script>
                                                        <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                                                        <%   }
                                                                }
                                                            }
                                                        } else {
                                                            String pre_param = model.consultarParametroName(2, pre_carroceria);%>
                                                        <option  value="<%=pre_carroceria%>" selected="selected"><%= pre_param%></option>
                                                        <script type="text/javascript" language="javascript">document.getElementById('tipoCarroceria').value = <%=pre_carroceria%>;</script>
                                                        <% }%>
                                                    </select>                 </td>
                                                    <% enable = model.isEnable(listaTramites, 10);
                                                        state = enable ? "" : "disabled";%>
                                                <td><span class="Estilo2"> <span class="Estilo6">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Modalidad Tra.</b></font></label>
                                                        </span> </span></td>
                                                <td><input name="tipoModalidad" type="text" id="tipoModalidad" style="width:35px;color:#333333; text-align:center" onblur="verInput(this, 'modalidades')" <%=state%>/></td>
                                                <td><select name="modalidades" id="modalidades" onchange="verCombo(this, 'Modalidad')" style="width:200px;color:#333333" <%=state%>>
                                                        <% if (pre_modalidad == 0) { %>
                                                        <option value="0"><<--Seleccione Modalidad-->></option>
                                                        <% java.util.List modalidades = model.listadoParametros(324);
                                                            for (int i = 0; i < modalidades.size(); i++) {
                                                                Parametro parametro = (Parametro) modalidades.get(i);
                                                                if (hash_caracteristicas.get("324") != null) {
                                                                    if (Integer.parseInt(hash_caracteristicas.get("324") + "") == parametro.getCodigo()) {%>
                                                        %>
                                                        <option value="<%=parametro.getCodigo()%>" selected><%= parametro.getNombre()%> </option>
                                                        <script type="text/javascript" language="javascript">document.getElementById('tipoModalidad').value = <%=parametro.getCodigo()%>;</script>
                                                        <%  } else {%>
                                                        <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                                                        <%   }
                                                        } else {%>
                                                        <script type="text/javascript" language="javascript">document.getElementById('tipoModalidad').value = <%=((Parametro) modalidades.get(0)).getCodigo()%>;</script>
                                                        <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                                                        <%   }
                                                            }
                                                        } else {
                                                            String pre_param = model.consultarParametroName(324, pre_modalidad);%>
                                                        <option  value="<%=pre_modalidad%>" selected="selected"><%= pre_param%></option>
                                                        <script type="text/javascript" language="javascript">document.getElementById('tipoModalidad').value = <%=pre_modalidad%>;</script>
                                                        <% }%>
                                                    </select>                 </td>
                                            </tr>
                                            <% enable = model.isEnable(listaTramites, 11);
                                                state = enable ? "" : "disabled"; %>
                                            <tr align="left">
                                                <td><span class="Estilo2"> <span class="Estilo6">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Modelo</b></font></label>
                                                        </span> </span></td>
                                                <td colspan="2"><% String modelo = "";
                                                    if (vehiculo != null) {
                                                        modelo = vehiculo.getModelo() + "";
                                                    }
                                                    if (pre_modelo != 0) {
                                                        modelo = pre_modelo + "";
                                                        state = "readonly";
                                                    }
                                                    %>
                                                    <input name="modelo" type="text" id="modelo" style="width:200px;color:#333333; text-align:center" value="<%=modelo%>" onblur="verModelo(this)" <%=state%>/></td>
                                                    <% enable = model.isEnable(listaTramites, 12);
                                                        state = enable ? "" : "disabled";%>
                                                <td><span class="Estilo6"> <span class="Estilo2">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Combustible</b></font></label>
                                                        </span> </span></td>
                                                <td><input name="tipoCombustible" type="text" id="tipoCombustible" style="width:35px;color:#333333; text-align:center" onblur="verInput(this, 'combustibles')" <%=state%>/></td>
                                                <td>
                                                    <select name="combustibles" id="combustibles" onchange="verCombo(this, 'Combustible')" style="width:200px;color:#333333" <%=state%>>
                                                        <% if (pre_combustible == 0) { %>
                                                        <option value="0"><<--Seleccione Tipo Comb.-->></option>
                                                        <% java.util.List combustibles = model.listadoParametros(75);
                                                            for (int i = 0; i < combustibles.size(); i++) {
                                                                Parametro parametro = (Parametro) combustibles.get(i);
                                                                if (hash_caracteristicas.get("75") != null) {
                                                                    if (Integer.parseInt(hash_caracteristicas.get("75").toString()) == parametro.getCodigo()) {%>
                                                        <option value="<%=parametro.getCodigo()%>" selected="selected"><%= parametro.getNombre()%> </option>
                                                        <script type="text/javascript" language="javascript">document.getElementById('tipoCombustible').value = <%=parametro.getCodigo()%>;</script>
                                                        <%  } else {%>
                                                        <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                                                        <%   }
                                                        } else {%>
                                                        <script type="text/javascript" language="javascript">document.getElementById('tipoCombustible').value = <%=((Parametro) combustibles.get(0)).getCodigo()%>;</script>
                                                        <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                                                        <%   }
                                                            }
                                                        } else {
                                                            String pre_param = model.consultarParametroName(75, pre_combustible);%>
                                                        <option  value="<%=pre_combustible%>" selected="selected"><%= pre_param%></option>
                                                        <script type="text/javascript" language="javascript">document.getElementById('tipoCombustible').value = <%=pre_combustible%>;</script>
                                                        <% }%>
                                                    </select>                 </td>
                                            </tr>

                                            <tr align="left">
                                                <td>
                                                    <span class="Estilo2">
                                                        <span class="Estilo6"><label><font face="Arial, Helvetica, sans-serif"><b>Modalidad Ser.</b></font></label>
                                                        </span> 
                                                    </span> 
                                                </td>
                                                <td colspan="2">
                                                    <select name="cmbModServicio" id="cmbModServicio" style="width:200px;color:#333333" >
                                                        <option value="0"><<--Seleccione Modalidad Servicio-->></option>
                                                        <%
                                                            java.util.List modServicio = model.listadoParametros(369);
                                                            for (int x = 0; x < modServicio.size(); x++) {
                                                                Parametro mods = (Parametro) modServicio.get(x);
                                                        %>
                                                        <option value="<%=mods.getCodigo()%>"><%=mods.getNombre()%> </option>
                                                        <%
                                                            }
                                                        %>                                                        
                                                    </select>                                                                    
                                                </td>
                                                <td>
                                                    <span class="Estilo2">
                                                        <span class="Estilo6"><label><font face="Arial, Helvetica, sans-serif"><b>Area Metropolitana</b></font></label>
                                                        </span> 
                                                    </span> 
                                                </td>
                                                <td>&nbsp;</td>
                                                <td>
                                                    <select name="cmbAmetropolitana" id="cmbAmetropolitana" style="width:200px;color:#333333" >
                                                        <option value="0"><<--Seleccione Area-->></option>
                                                        <%
                                                            java.util.List aream = model.listadoParametros(370);
                                                            for (int w = 0; w < aream.size(); w++) {
                                                                Parametro mods = (Parametro) aream.get(w);
                                                        %>
                                                        <option value="<%=mods.getNombre()%>"><%=mods.getNombre()%> </option>
                                                        <%
                                                            }
                                                        %>
                                                    </select> 
                                                </td>
                                            </tr>
                                            <tr align="left">
                                                <td>
                                                    <span class="Estilo2">
                                                        <span class="Estilo6"><label><font face="Arial, Helvetica, sans-serif"><b>Departamento</b></font></label>
                                                        </span> 
                                                    </span> 
                                                </td>
                                                <td colspan="2">
                                                    <select name="dir_departamento" id="dir_departamento" onchange="buscarDirMunicipios();
                                                            return false" onfocus="buscarDirMunicipios(); return false" style="width:200px;color:#333333" >
                                                        <option value="0"><<--Seleccione Departamento-->></option>
                                                        <%
                                                            java.util.List departamentos = model.crearListaDpto();
                                                            for (int w = 0; w < departamentos.size(); w++) {
                                                                Departamento mods = (Departamento) departamentos.get(w);
                                                        %>
                                                        <option value="<%=mods.getId_departamento()%>"><%=mods.getNombre()%> </option>
                                                        <%
                                                            }
                                                        %>
                                                    </select> 
                                                </td>
                                                <td>
                                                    <span class="Estilo2">
                                                        <span class="Estilo6"><label><font face="Arial, Helvetica, sans-serif"><b>Municipio</b></font></label>
                                                        </span> 
                                                    </span> 
                                                </td>
                                                <td colspan="2">
                                                    <div  style="width:150px" align="center" id="dir_municipios">
                                                        <select name="dir_municipio" id="dir_municipio" style="width:200px;color:#333333" >
                                                            <option value="0"><<--Seleccione Municipio-->></option>
                                                        </select> 
                                                    </div>
                                                </td>
                                            </tr>
                                            <!-- Fin-->

                                            <% enable = model.isEnable(listaTramites, 13);
                                                state = enable ? "" : "disabled"; %>
                                            <tr align="left">
                                                <td><span class="Estilo6"> <span class="Estilo2">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Motor</b></font></label>
                                                        </span> </span></td>
                                                <td colspan="2"><% String motor = "";
                                                    if (hash_especificaciones.get("19") != null) {
                                                        motor = hash_especificaciones.get("19").toString();
                                                    }
                                                    if (pre_motor != null) {
                                                        motor = pre_motor;
                                                        state = pre_motor.trim().length() > 0 ? "readonly" : "";
                                                    } else {
                                                        if (tipot.getClase_tramite() == 4 && motor.isEmpty()) {
                                                            motor = auto.getAutomotor().getValue().getIdentificador().getValue().getNumeroMotor();
                                                            state = motor.trim().length() > 0 ? "readonly" : "";
                                                        }
                                                    }
                                                    if (id_tramite == 17) {
                                                        motor = "";
                                                    }
                                                    %>
                                                    <input name="motor" type="text" id="motor" style="width:200px;color:#333333; text-align:center" value="<%=motor%>" <%=state%>/>
                                                    <% enable = model.isEnable(listaTramites, 14);
                                                        state = enable ? "" : "disabled";%>
                                                    <select name="reg_motor" id="reg_motor" style="width:35px;color:#333333" <%=state%>>
                                                        <%
                                                            if (hash_especificaciones.get("22") != null) {
                                                                if (hash_especificaciones.get("22").equals("0")) {%>
                                                        <option value="1">S</option>
                                                        <option value="0" selected="selected">N</option>
                                                        <%} else {%>
                                                        <option value="1" selected="selected">S</option>
                                                        <option value="0">N</option>
                                                        <%   }
                                                        } else {%>
                                                        <option value="1">S</option>
                                                        <option value="0" selected="selected">N</option>
                                                        <% }%>
                                                    </select></td>
                                                    <% enable = model.isEnable(listaTramites, 15);
                                                        state = enable ? "" : "disabled"; %>
                                                <td><span class="Estilo6"> <span class="Estilo2">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Chasis</b></font></label>
                                                        </span> </span></td>
                                                <td colspan="2"><% String chasis = "";
                                                    if (hash_especificaciones.get("20") != null) {
                                                        chasis = hash_especificaciones.get("20").toString();
                                                    }
                                                    if (pre_chasis != null) {
                                                        chasis = pre_chasis;
                                                        state = pre_chasis.trim().length() > 0 ? "readonly" : "";
                                                    } else {
                                                        if (tipot.getClase_tramite() == 4 && chasis.isEmpty()) {
                                                            chasis = auto.getAutomotor().getValue().getIdentificador().getValue().getNumeroChasis();
                                                            state = chasis.trim().length() > 0 ? "readonly" : "";
                                                        }
                                                    }
                                                    %>
                                                    <input name="chasis" type="text" id="chasis" style="width:200px;color:#333333; text-align:center" value="<%=chasis%>" <%=state%>/>
                                                    <% enable = model.isEnable(listaTramites, 16);
                                                        state = enable ? "" : "disabled";

                                                    %>
                                                    <select name="reg_chasis" id="reg_chasis" style="width:35px;color:#333333" <%=state%>>
                                                        <%
                                                            if (hash_especificaciones.get("23") != null) {
                                                                if (hash_especificaciones.get("23").equals("0")) {%>
                                                        <option value="1">S</option>
                                                        <option value="0" selected="selected">N</option>
                                                        <%} else {%>
                                                        <option value="1" selected="selected">S</option>
                                                        <option value="0">N</option>
                                                        <%   }
                                                        } else {%>
                                                        <option value="1">S</option>
                                                        <option value="0" selected="selected">N</option>
                                                        <% }%>
                                                    </select>                 </td>
                                            </tr>
                                            <% enable = model.isEnable(listaTramites, 17);
                                                state = enable ? "" : "disabled"; %>
                                            <tr align="left">
                                                <td><span class="Estilo2"> <span class="Estilo6">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Serie</b></font></label>
                                                        </span> </span></td>
                                                <td colspan="2"><% String serie = "";
                                                    if (hash_especificaciones.get("21") != null) {
                                                        serie = hash_especificaciones.get("21").toString();
                                                    }
                                                    if (pre_serie != null) {
                                                        serie = pre_serie;
                                                        state = pre_serie.trim().length() > 0 ? "readonly" : "";
                                                    } else {
                                                        if (tipot.getClase_tramite() == 4 && serie.isEmpty()) {
                                                            serie = auto.getAutomotor().getValue().getIdentificador().getValue().getNumeroSerie();
                                                            state = serie.trim().length() > 0 ? "readonly" : "";
                                                        }
                                                    }
                                                    %>
                                                    <input name="serie" type="text" id="serie" style="width:200px;color:#333333; text-align:center" value="<%=serie%>" <%=state%>/>
                                                    <% enable = model.isEnable(listaTramites, 18);
                                                        state = enable ? "" : "disabled";%>
                                                    <select name="reg_serie" id="reg_serie" style="width:35px;color:#333333" <%=state%>>
                                                        <%
                                                            if (hash_especificaciones.get("24") != null) {
                                                                if (hash_especificaciones.get("24").equals("0")) {%>
                                                        <option value="1">S</option>
                                                        <option value="0" selected="selected">N</option>
                                                        <%} else {%>
                                                        <option value="1" selected="selected">S</option>
                                                        <option value="0">N</option>
                                                        <%   }
                                                        } else {%>
                                                        <option value="1">S</option>
                                                        <option value="0" selected="selected">N</option>
                                                        <% }%>
                                                    </select></td>
                                                <td><span class="Estilo6"> <span class="Estilo2">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Vin</b></font></label>
                                                        </span> </span></td>
                                                <td colspan="2"><% String vin = "";
                                                    if (hash_especificaciones.get("25") != null) {
                                                        vin = hash_especificaciones.get("25").toString();
                                                    }
                                                    if (pre_vin != null) {
                                                        vin = pre_vin;
                                                        state = pre_vin.trim().length() > 0 ? "readonly" : "";
                                                    } else {
                                                        if (tipot.getClase_tramite() == 4 && vin.isEmpty()) {
                                                            vin = auto.getAutomotor().getValue().getIdentificador().getValue().getNumeroVIN();
                                                            state = vin.trim().length() > 0 ? "readonly" : "";
                                                        }
                                                    }
                                                    %>
                                                    <input name="vin" type="text" id="vin" style="width:200px;color:#333333; text-align:center" value="<%=vin%>" <%=state%>/>
                                                    <% enable = model.isEnable(listaTramites, 23);
                                                        state = enable ? "" : "disabled"; %>
                                                </td>
                                            </tr>
                                            <% } %>
                                            <tr>
                                                <td><font face="Arial, Helvetica, sans-serif" class="Estilo9"><b>Nit&nbsp;Concesionario </b></font></td>
                                                <td colspan="2"><input name="nitConc" type="text" id="nitConc"  style="width:200px; color:#333333; text-align:center" onblur="consultaPersona2()"/></td>

                                                <td colspan="3" align="center"><span class="Estilo61">
                                                        <input id="nombreConcesionario" name="nombreConcesionario" type="text"  style="width:500px; color:#333333; text-align:center" readonly="readonly"/>
                                                    </span></td>
                                            </tr>
                                        </table>
                                        <table width="100%" border="0" id="panelColores" style="display:none" align="center" cellpadding="0" cellspacing="0">
                                            <%  if (lsec.contains("panelColores")) {
                                                    if (radicacionColor != 0) {
                                                        Color cl = model.getColor(radicacionColor);
                                                        idC = cl.getId_color();
                                                        nameC = cl.getNombre();
                                                    }
                                            %>
                                            <tr>
                                                <td width="100%" align="center">
                                                    <table width="100%" border="0" align="center">
                                                        <tr style="background:url(../html/images/inicio_3.png)">
                                                            <th colspan="6"><span class="Estilo5 Estilo13"><font face="Arial">COLOR DEL VEHICULO</font></span></th>
                                                        </tr>
                                                        <tr>
                                                            <td width="100%" align="center" colspan="6">
                                                                <fieldset>
                                                                    <table width="100%" border="0" align="center">
                                                                        <tr>
                                                                            <td colspan="2" valign="top" align="center">&nbsp;
                                                                                <input type="hidden" id="r_color" name="r_color" value="<%=idC%>"/>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="1" valign="top" align="center" width="100%">
                                                                                <input type="text" name="color" id="color" readonly="true" style="width:300px; font-size:12px; font-weight:bold; text-align:center; color:#333333" value="<%=nameC%>" />
                                                                                <span class="Estilo5">
                                                                                    <%	enable = model.isEnable(listaTramites, 19);
                                                                                        if (enable) { %>
                                                                                    <img src="../html/images/adicionar.gif" width="16" height="16" style="cursor:pointer" onclick="newC()"/>
                                                                                    <% } else { %>
                                                                                    <img src="../html/images/adicionar.gif" width="16" height="16" style="cursor:pointer"/>
                                                                                    <% } %>
                                                                                </span> </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>&nbsp;</td>
                                                                        </tr>
                                                                    </table>
                                                                </fieldset>
                                                            </td>
                                                            <tr>
                                                                <td colspan="2" valign="top" align="center">&nbsp;</td>
                                                            </tr>
                                                    </table></td>
                                            </tr>
                                            <% } %>
                                        </table>
                                        <table width="100%" border="0" id="panelImportacion" style="display:none">
                                            <%  if (lsec.contains("panelImportacion")) { %>
                                            <tr style="background:url(../html/images/inicio_3.png)">
                                                <th colspan="6"><span class="Estilo5 Estilo13"><font face="Arial">DATOS ACTA DE IMPORTACION DEL VEHICULO</font></span></th>
                                            </tr>
                                            <tr>
                                                <th colspan="6"><label><font size="2" face="Arial, Helvetica, sans-serif" >&nbsp;</font></label></th>
                                            </tr>
                                            <% enable = model.isEnable(listaTramites, 20);
                                                state = enable ? "" : "disabled";%>
                                            <tr align="left">
                                                <td width="12%"><span class="Estilo6"> <span class="Estilo2">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Tipo&nbsp;Importacion</b></font></label>
                                                        </span> </span></td>
                                                <td width="5%" scope="col"><input name="tipoImportacion" type="text" id="tipoImportacion" style="width:35px;color:#333333; text-align:center" onblur="verInput(this, 'tiposimportaciones')" <%=state%>/></td>
                                                <td width="30%" scope="col"><strong>
                                                        <select name="tiposimportaciones" id="tiposimportaciones" onchange="verCombo(this, 'Importacion')" style="width:200px;" <%=state%>>
                                                            <% if (pre_tipoImportacion == 0) { %>
                                                            <option value="0"><<--Seleccione Tipo Imp.-->></option>
                                                            <%  java.util.List tiposimportaciones = model.listadoParametros(51);
                                                                for (int i = 0; i < tiposimportaciones.size(); i++) {
                                                                    Parametro parametro = (Parametro) tiposimportaciones.get(i);
                                                                    if (vehiculo != null) {
                                                                        if (vehiculo.getTipo_importacion() == parametro.getCodigo()) {%>
                                                            <option  value="<%=parametro.getCodigo()%>" selected="selected"><%= parametro.getNombre()%></option>
                                                            <script type="text/javascript" language="javascript">document.getElementById('tipoImportacion').value = <%=parametro.getCodigo()%>;</script>
                                                            <%   } else {%>
                                                            <option  value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                                                            <%   }
                                                            } else {%>
                                                            <script type="text/javascript" language="javascript">document.getElementById('tipoImportacion').value = <%=((Parametro) tiposimportaciones.get(0)).getCodigo()%>;</script>
                                                            <option  value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                                                            <%}
                                                                }
                                                            } else {
                                                                String pre_param = model.consultarParametroName(51, pre_tipoImportacion);%>
                                                            <option  value="<%=pre_tipoImportacion%>" selected="selected"><%= pre_param%></option>
                                                            <script type="text/javascript" language="javascript">document.getElementById('tipoImportacion').value = <%=pre_tipoImportacion%>;</script>
                                                            <%
                                                                }%>
                                                        </select>
                                                    </strong></td>
                                                <td width="14%" scope="col"><span class="Estilo5">
                                                        <label id="tipoD"><font face="Arial, Helvetica, sans-serif"><b>Tipo&nbsp;Documento</b></font></label>
                                                        <label id="tipoE" style="display:none"><font face="Arial, Helvetica, sans-serif"><b>Entidad</b></font></label>
                                                    </span></td>
                                                <td width="5%" scope="col"><input name="tipoImpor" type="text" id="tipoImpor" style="width:35px;color:#333333; text-align:center" onblur="verInput(this, 'tiposimpor')" <%=state%>/>
                                                    <input name="tipoEntidad" type="text" id="tipoEntidad" style="width:35px;color:#333333;text-align:center" onblur="verInput(this, 'tiposentidades')" <%=state%>/>                 </td>
                                                <td width="34%" scope="col">
                                                    <select name="tiposimpor" id="tiposimpor" onchange="verCombo(this, 'Impor')" style="width:200px;" <%=state%>>
                                                        <% if (pre_tipoDocImportacion == 0) { %>
                                                        <option value="0"><<--Seleccione Tipo Doc.-->></option>
                                                        <% java.util.List tiposimpor = model.listadoParametros(53);
                                                            for (int i = 0; i < tiposimpor.size(); i++) {
                                                                Parametro parametro = (Parametro) tiposimpor.get(i);
                                                                if (vehiculo != null) {
                                                                    if (vehiculo.getTipo_doc_importacion() == parametro.getCodigo()) {%>
                                                        <option value="<%=parametro.getCodigo()%>" selected><%= parametro.getNombre()%> </option>
                                                        <script type="text/javascript" language="javascript">document.getElementById('tipoImpor').value =<%=parametro.getCodigo()%>;</script>
                                                        <%		  } else {%>
                                                        <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                                                        <%   }
                                                        } else {%>
                                                        <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                                                        <%	}
                                                            }
                                                        } else {
                                                            String pre_param = model.consultarParametroName(53, pre_tipoDocImportacion);%>
                                                        <option  value="<%=pre_tipoDocImportacion%>" selected="selected"><%= pre_param%></option>
                                                        <script type="text/javascript" language="javascript">document.getElementById('tipoImpor').value = <%=pre_tipoDocImportacion%>;</script>
                                                        <%
                                                            }%>
                                                    </select>
                                                    <select name="tiposentidades" id="tiposentidades" onchange="verCombo(this, 'Entidad')" style="width:200px" <%=state%>>
                                                        <option value="0"><<--Seleccione Tipo Ent.-->></option>
                                                        <% java.util.List tiposentidades = model.listadoParametros(109);
                                                            for (int i = 0; i < tiposentidades.size(); i++) {
                                                                Parametro parametro = (Parametro) tiposentidades.get(i);
                                                                if (vehiculo != null) {
                                                                    if (vehiculo.getTipo_doc_importacion() == parametro.getCodigo()) {%>
                                                        <option value="<%=parametro.getCodigo()%>" selected><%= parametro.getNombre()%> </option>
                                                        <%		  } else {%>
                                                        <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                                                        <%   }
                                                        } else {%>
                                                        <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                                                        <%	}
                                                            }%>
                                                    </select>                 </td>
                                                <script language="javascript" type="text/javascript">verCombo(document.getElementById('tiposimportaciones'), 'Importacion');</script>
                                            </tr>
                                            <tr align="left">
                                                <td height="33"><span class="Estilo2"> <span class="Estilo6">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Departamento</b></font></label>
                                                        </span> </span></td>
                                                <td><input name="tipoDepartamento" type="text" id="tipoDepartamento" style="width:35px;color:#333333; text-align:center" onblur="verInput(this, 'departamentos')" <%=state%>/></td>
                                                <td>
                                                    <select name="departamentos" id="departamentos" onchange="verCombo(this, 'Departamento')" style="width:200px;" <%=state%>>
                                                        <option value="0"><<--Seleccione Dept.-->></option>
                                                        <%  int depto = 0;
                                                            Municipio muncp = null;
                                                            int cod_mun = 0;
                                                            java.util.List departamentos = model.crearListaDpto();
                                                            java.util.List municipios = new java.util.LinkedList();
                                                            if (vehiculo != null) {
                                                                if (vehiculo.getFk_divipo() != 0) {
                                                                    muncp = model.consultarMunicipioDivipo(vehiculo.getFk_divipo());
                                                                    municipios = model.crearListaMunicipios(muncp.getDepartamento());
                                                                    depto = muncp.getDepartamento();
                                                                }
                                                            }
                                                            if (muncp != null) {
                                                                cod_mun = muncp.getCodigo();
                                                            }

                                                            for (int i = 0; i < departamentos.size(); i++) {
                                                                Departamento departamento = (Departamento) departamentos.get(i);
                                                                if (depto == departamento.getId_departamento()) {%>
                                                        <option value="<%=departamento.getId_departamento()%>" selected="selected"><%= departamento.getNombre()%> </option>
                                                        <script type="text/javascript" language="javascript">document.getElementById('tipoDepartamento').value =<%=departamento.getId_departamento()%>;</script>
                                                        <% } else {%>
                                                        <option value="<%=departamento.getId_departamento()%>"><%= departamento.getNombre()%> </option>
                                                        <% }

                                                            }%>
                                                    </select></td>
                                                <td><span class="Estilo6"> <span class="Estilo2">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Ciudad</b></font></label>
                                                        </span> </span></td>
                                                <td>
                                                    <input name="tipoCiudad" type="text" id="tipoCiudad" style="width:35px;color:#333333; text-align:center" value="<%=cod_mun%>" onblur="verInput(this, 'ciudades')" <%=state%>/></td>
                                                <script language="javascript" type="text/javascript">verCombo(document.getElementById('departamentos'), 'Departamento');</script>
                                                <td><div class="Estilo4" id="ciudad"></div></td>
                                            </tr>
                                            <tr align="left">
                                                <td><span class="Estilo6"> <span class="Estilo2">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Documento</b></font></label>
                                                        </span> </span></td>
                                                <td colspan="2"><% String documentoimp = "";
                                                    if (vehiculo != null) {
                                                        if (vehiculo.getDocumento_importacion() != null) {
                                                            documentoimp = vehiculo.getDocumento_importacion();
                                                        }
                                                    }
                                                    if (pre_acta != null) {
                                                        documentoimp = pre_acta;
                                                        state = pre_acta.trim().length() > 0 ? "readonly" : "";
                                                    }%>
                                                    <input name="documentoimp" type="text" id="documentoimp" style="width:235px;color:#333333; text-align:center" value="<%=documentoimp%>" <%=state%>/></td>
                                                <td><span class="Estilo6"> <span class="Estilo2">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Fecha</b></font></label>
                                                        </span> </span></td>
                                                        <% if (pre_acta != null) {
                                                                state = pre_acta.trim().length() > 0 ? "" : state;
                                                            }%>
                                                <td colspan="2"><input name="fechadoc" type="button" id="fechadoc" value="&gt;" style="width:35px" <%=state%>/>
                                                    <input type="text" name="fechadocumento" id="fechadocumento" onkeyup="mascara(this, '/', true)" maxlength="10" style="width:200px;text-align:center" <%=state%>/>
                                                    <script type="text/javascript">
                                                        Calendar.setup({
                                                            inputField: "fechadocumento", // id del campo de texto
                                                            ifFormat: "%d/%m/%Y", // formato de la fecha, cuando se escriba en el campo de texto
                                                            button: "fechadoc"   // el id del bot?n que lanzar? el calendario
                                                        });
                                                    </script>                 </td>
                                            </tr>
                                            <% } %>
                                        </table>

                                        <table width="100%" border="0" id="panelRunt" style="display:none" align="center">
                                            <%  if (lsec.contains("panelRunt")) {
                                                    if (id_tramite == 500) {%>
                                            <tr>
                                                <td width="100%"  colspan="6" align="center"><span class="style1">ESTE TRAMITE NO ESTA HABILITADO DEBE REMITIR LOS DOCUMENTOS A LA OFICINA JURIDICA</span></td>
                                            </tr>
                                            <script type="text/javascript">
                                                alert("ESTE TRAMITE NO ESTA HABILITADO DEBE REMITIR LOS DOCUMENTOS A LA OFICINA JURIDICA");
                                                document.location.href = "seleccionTramites.jsp";
                                            </script>

                                            <%        } else {

                                            %>
                                            <tr style="background:url(../html/images/inicio_3.png)">
                                                <th colspan="6"><span class="Estilo5 Estilo13"><font face="Arial">INFORMACION ADICIONAL DEL RUNT</font></span></th>
                                            </tr>
                                            <tr>
                                                <td width="100%" align="center">
                                                    <table width="100%" border="0" align="center">
                                                        <%  java.util.List listaRunt = model.consultarConfiguracionTramitesRUNT(id_tramite);
                                                            for (int i = 0; i < listaRunt.size(); i++) {
                                                                int dupla[] = (int[]) listaRunt.get(i);
                                                                String nombreIndice = "";
                                                                if (dupla[0] == 1) {
                                                                    nombreIndice = model.consultarTablaRUNT(dupla[1]);
                                                                } else {
                                                                    nombreIndice = model.consultarEspecificacionRUNT(dupla[1]);
                                                                }%>
                                                        <tr>
                                                            <td width="60%" align="left">
                                                                <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b><%=nombreIndice%></b></font></label></span>					   		</td>
                                                            <td width="40%" align="left">
                                                                <span class="Estilo2">
                                                                    <%  if (dupla[0] == 1) {%>
                                                                    <select name="caracteristica<%=dupla[1]%>" id="caracteristica<%=dupla[1]%>" style="width:500px;color:#333333; size:12px">
                                                                        <option value="0"><<--Seleccione Parametro-->></option>
                                                                        <%	java.util.List listaParametrosRunt = model.consultarParametrosRUNT(dupla[1]);
                                                                            for (int j = 0; j < listaParametrosRunt.size(); j++) {
                                                                                String[] parametro = (String[]) listaParametrosRunt.get(j);%>
                                                                        <option value="<%=parametro[0]%>"><%=parametro[1]%></option>
                                                                        <%    } %>
                                                                    </select>
                                                                    <% } else {
                                                                        if (dupla[0] == 2) {
                                                                            if (dupla[1] != 48) {%>
                                                                    <input name="especificacion<%=dupla[1]%>" type="text" id="especificacion<%=dupla[1]%>" style="width:200px;color:#333333" value=""/>
                                                                    <%   } else {%>
                                                                    <input name="especificacion<%=dupla[1]%>" type="text" id="especificacion<%=dupla[1]%>" style="width:200px;color:#333333;text-align:center" readonly value="" onclick="verMunicipios(this)"/>
                                                                    <%   }
                                                                    } else {
                                                                        if (dupla[0] == 3) {%>
                                                                    <select name="especificacion<%=dupla[1]%>" id="especificacion<%=dupla[1]%>" style="width:200px;color:#333333">
                                                                        <option value="0"><<--Seleccione Parametro-->></option>
                                                                        <option value="S">SI</option>
                                                                        <option value="N">NO</option>
                                                                    </select>
                                                                    <%   	} else {
                                                                        if (dupla[0] == 4) {%>
                                                                    <input name="boton<%=dupla[1]%>" type="button" id="boton<%=dupla[1]%>" value="&gt;" style="width:30px"/>
                                                                    <input type="text" name="especificacion<%=dupla[1]%>" id="especificacion<%=dupla[1]%>" onkeyup="mascara(this, '/', true)" maxlength="10" style="width:155px;color:#333333; text-align:center"/>
                                                                    <script type="text/javascript">
                                                                        Calendar.setup({
                                                                            inputField: "especificacion<%=dupla[1]%>", // id del campo de texto
                                                                            ifFormat: "%d/%m/%Y", // formato de la fecha, cuando se escriba en el campo de texto
                                                                            button: "boton<%=dupla[1]%>"   // el id del bot?n que lanzar? el calendario
                                                                        });
                                                                    </script>
                                                                    <%             }
                                                                                }
                                                                            }
                                                                        }	    %>
                                                                </span></td>
                                                        </tr>
                                                        <% } %>
                                                        <tr>

                                                            <tr>

                                                                <td align="left">Ficha tecnica Homologacion Chasis (<span class="style2">Solo para vehiculos Publicos</span>) </td>
                                                                <td><span class="Estilo2">
                                                                        <input type="text" name="fthC" id="fthC"  style="width:155px;color:#333333; text-align:center"/>
                                                                    </span></td>
                                                            </tr>


                                                            <td align="left">Valor de la factura </td>
                                                            <td><span class="Estilo2">
                                                                    <input type="text" name="valorF" id="valorF"  style="width:155px;color:#333333; text-align:center"/>
                                                                </span></td>
                                                        </tr>
                                                        <tr>

                                                            <td align="left">Seleccione radio de Accion </td>
                                                            <td><span class="Estilo2">
                                                                    <select name="radio" id="radio" style="width:200px;color:#333333; size:12px">
                                                                        <option value="0">&lt;&lt;--Seleccione Opcion--&gt;&gt;</option>
                                                                        <option value="1">Municipal</option>
                                                                        <option value="2">Nacional</option>
                                                                        <option value="3">Metropolitano</option>
                                                                        <option value="4">Urbano</option>

                                                                    </select>
                                                                </span></td>
                                                        </tr>
                                                    </table>				 </td>
                                            </tr>
                                            <%

                                                    }
                                                }
                                            %>
                                        </table>
                                        <table width="100%" border="0" id="panelImportacionRNMA" style="display: none">
                                            <%  if (lsec.contains("panelImportacionRNMA")) { %>
                                            <tr style="background:url(../html/images/inicio_3.png)">
                                                <th colspan="6" scope="col"><span class="Estilo5">
                                                        <label><font face="Arial"><b><span class="Estilo13">DATOS IMPORTACION RNMA</span></b></font></label>
                                                    </span></th>
                                            </tr>
                                            <tr>
                                                <th colspan="6"><label><font size="2" face="Arial, Helvetica, sans-serif" >&nbsp;</font></label></th>
                                            </tr>
                                            <% enable = model.isEnable(listaTramites, 23);
                                                state = enable ? "" : "disabled";%>
                                            <tr>
                                                <td>
                                                    <span class="Estilo6"> <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b>Orden&nbsp;Ejecucion</b></font></label></span></span>
                                                </td>
                                                <td>
                                                    <select name="cmbordenejecucion" style="width:150px;">
                                                        <option value="0">*** Seleccione ***</option>
                                                    </select>
                                                </td>
                                                <td>
                                                    <span class="Estilo6"> <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b>Puerto&nbsp;Ingreso</b></font></label></span></span>
                                                </td>
                                                <td>
                                                    <select name="cmbpuertoingreso" style="width:200px;">
                                                        <option value="0">*** Seleccione ***</option>
                                                        <%  java.util.List puerto = model.listadoParametros(367);
                                                            for (int i = 0; i < puerto.size(); i++) {
                                                                Parametro parametro = (Parametro) puerto.get(i);
                                                        %>
                                                        <option value="<%=parametro.getCodigo()%>"><%=parametro.getNombre()%></option>
                                                        <%}%>
                                                    </select>
                                                </td>

                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="Estilo6"> <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b>No.&nbsp;Aceptacion</font></label></span></span>
                                                </td>
                                                <td>
                                                    <input type="text" name="txtnoaceptacion" style="width:155px;color:#333333; text-align:center" />
                                                </td>
                                                <td><span class="Estilo6"> <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b>Condicion Ingreso</b></font></label></span></span></td>
                                                <td>
                                                    <input type="text" name="txtcondicioningreso" style="width:155px;color:#333333; text-align:center" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><span class="Estilo6"> <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b>Entidad&nbsp;Revision</font></label></span></span></td>
                                                <td>
                                                    <input type="text" name="txtentidadrevision" style="width:155px;color:#333333; text-align:center" />
                                                </td>
                                                <td><span class="Estilo6"> <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b>Documento&nbsp;Revision</font></label></span></span></td>
                                                <td>
                                                    <input type="text" name="txtdocrevision" style="width:155px;color:#333333; text-align:center" />
                                                </td>
                                                <td><span class="Estilo6"> <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b>Fecha&nbsp;Revision</font></label></span></span></td>
                                                <td>
                                                    <input type="text" name="txtfecharevision" style="width:155px;color:#333333; text-align:center" />
                                                </td>
                                            </tr>

                                            <tr>
                                                <td><span class="Estilo6"> <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b>Resultado&nbsp;Revision</font></label></span></span></td>
                                                <td>
                                                    <input type="text" name="txtresultadorevision" style="width:155px;color:#333333; text-align:center" />
                                                </td>
                                                <td><span class="Estilo6"> <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b>Fecha&nbsp;Expedicion</font></label></span></span></td>
                                                <td>
                                                    <input type="text" name="txtfechaexpedicion" style="width:155px;color:#333333; text-align:center" />
                                                </td>
                                                <td><span class="Estilo6"> <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b>Fecha&nbsp;Vencimiento</b></font></label></span></span></td>
                                                <td>
                                                    <input type="text" name="txtfechavencimiento" style="width:155px;color:#333333; text-align:center" />
                                                </td>
                                            </tr>

                                            <% } %>
                                        </table>

                                        <table width="100%" border="0" id="panelRNMA" style="display: none">
                                            <%  if (lsec.contains("panelRNMA")) { %>
                                            <tr style="background:url(../html/images/inicio_3.png)">
                                                <th colspan="6" scope="col"><span class="Estilo5">
                                                        <label><font face="Arial"><b><span class="Estilo13">INFORMACI?&nbsp;MAQUINARIA&nbsp;AGRICOLA</span></b></font></label>
                                                    </span></th>
                                            </tr>
                                            <tr>
                                                <th colspan="6"><label><font size="2" face="Arial, Helvetica, sans-serif" >&nbsp;</font></label></th>
                                            </tr>
                                            <% enable = model.isEnable(listaTramites, 23);
                                                state = enable ? "" : "disabled";%>
                                            <tr>
                                                <td><span class="Estilo6"> <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b>Tipo&nbsp;Registro</b></font></label></span></span></td>
                                                <td>
                                                    <select name="cmbtiporegistro" style="width:200px;">
                                                        <option value="0">*** Seleccione ***</option>
                                                        <%  java.util.List clases = model.listadoParametros(1);
                                                            for (int i = 0; i < clases.size(); i++) {
                                                                Parametro parametro = (Parametro) clases.get(i);
                                                        %>
                                                        <option value="<%=parametro.getCodigo()%>"><%=parametro.getNombre()%></option>
                                                        <%}%>
                                                    </select>
                                                </td>

                                                <td><span class="Estilo6"> <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b>Tipo&nbsp;Rodaje</b></font></label></span></span></td>
                                                <td>
                                                    <select name="cmbtiporodaje" style="width:200px;">
                                                        <option value="0">*** Seleccione ***</option>
                                                        <%  java.util.List tiporodaje = model.listadoParametros(366);
                                                            for (int i = 0; i < tiporodaje.size(); i++) {
                                                                Parametro parametro = (Parametro) tiporodaje.get(i);
                                                        %>
                                                        <option value="<%=parametro.getCodigo()%>"><%=parametro.getNombre()%></option>
                                                        <%}%>
                                                    </select>
                                                </td>

                                                <td><span class="Estilo6"> <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b>Tipo&nbsp;Cabina</b></font></label></span></span></td>
                                                <td>
                                                    <select name="cmbtipocabina" style="width:200px;">
                                                        <option value="0">*** Seleccione ***</option>
                                                        <%  java.util.List tipocabina = model.listadoParametros(368);
                                                            for (int i = 0; i < tipocabina.size(); i++) {
                                                                Parametro parametro = (Parametro) tipocabina.get(i);
                                                        %>
                                                        <option value="<%=parametro.getCodigo()%>"><%=parametro.getNombre()%></option>
                                                        <%}%>
                                                    </select>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td><span class="Estilo6"> <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b>Nro.&nbsp;Sub.&nbsp;Partida&nbsp;Arancelaria</b></font></label></span></span></td>
                                                <td>
                                                    <select name="cmbsubpartida" style="width:200px;">
                                                        <option value="0">*** Seleccione ***</option>
                                                        <%  java.util.List subpartida = model.listadoParametros(365);
                                                            for (int i = 0; i < subpartida.size(); i++) {
                                                                Parametro parametro = (Parametro) subpartida.get(i);
                                                        %>
                                                        <option value="<%=parametro.getCodigo()%>"><%=parametro.getNombre()%></option>
                                                        <%}%>
                                                    </select>
                                                </td>
                                                <td><span class="Estilo6"> <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b>Identificacion&nbsp;GPS</b></font></label></span></span></td>
                                                <td>
                                                    <input type="text" id="textGps" name="textGps" style="width:155px;color:#333333; text-align:center" />
                                                    <!--<select name="cmbgps" style="width:200px;">
                                                        <option value="0">*** Seleccione ***</option>
                                                    <%  java.util.List gps = model.listadoParametros(364);
                                                        for (int i = 0; i < gps.size(); i++) {
                                                            Parametro parametro = (Parametro) gps.get(i);
                                                    %>
                                                    <option value="<=parametro.getCodigo() %>"><=parametro.getNombre() %></option>
                                                    <%}%>
                                                </select>-->
                                                </td>
                                                <td><span class="Estilo6"> <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b>Empresa&nbsp;Habilitaci?b></font></label></span></span></td>
                                                <td>
                                                    <input type="text" name="txtempresahabilitacion" style="width:155px;color:#333333; text-align:center" />
                                                </td>
                                            </tr>

                                            <tr>
                                                <td><span class="Estilo6"> <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b>Tipo&nbsp;Documento&nbsp;Soporte</b></font></label></span></span></td>
                                                <td>
                                                    <select style="width:200px;">
                                                        <option>*** Seleccione ***</option>
                                                    </select>
                                                </td>
                                                <td><span class="Estilo6"> <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b>Documento&nbsp;Soporte</b></font></label></span></span></td>
                                                <td>
                                                    <input type="text" name="txtdocsoporte" style="width:155px;color:#333333; text-align:center" />
                                                </td>
                                                <td><span class="Estilo6"> <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b>Fecha&nbsp;Expedicion</b></font></label></span></span></td>
                                                <td>
                                                    <input type="text" name="txtfechaexpsoporte" style="width:155px;color:#333333; text-align:center" />
                                                </td>
                                            </tr>

                                            <tr>
                                                <td><span class="Estilo6"> <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b>Entidad&nbsp;Expide&nbsp;Doc.&nbsp;Soporte</b></font></label></span></span></td>
                                                <td>
                                                    <input type="text" name="txtfechaexpsoporte" style="width:155px;color:#333333; text-align:center" />
                                                </td>
                                                <td colspan="4">&nbsp;</td>
                                            </tr>

                                            <% } %>
                                        </table>

                                        <table width="100%" border="0" id="panelObservaciones"  style="display:none" align="center">
                                            <%  if (lsec.contains("panelObservaciones")) { %>
                                            <tr>
                                                <td width="100%" align="center"><table width="100%" border="0" align="center">
                                                        <tr>
                                                            <td width="10%" align="left"><span class="Estilo1">
                                                                    <span class="Estilo6"> <span class="Estilo2">
                                                                            <label><font face="Arial, Helvetica, sans-serif"><b>Observaciones</b></font></label>
                                                                        </span> </span> </span> </td>
                                                            <td width="60%"><input name="observacion" type="text" id="observacion" style="width:450px;color:#333333;" value="" /></td>
                                                            <td width="40%" align="center"><input type="button" name="aceptar" id="aceptar" value="Enviar" style="width:150px" onclick="evaluar()"/></td>
                                                        </tr>

                                                    </table></td>
                                            </tr>
                                            <% } %>
                                        </table>

                                        <table width="100%" border="0" id="panelBotones" style="display:block" align="center">
                                            <tr>
                                                <td width="100%" align="center"><table width="100%" border="0" align="center">
                                                        <% //if(valFun.length()>0){ %>
                                                        <tr>
                                                            <td width="50%" align="center"><input type="button" name="actionA" id="actionA" value="Anterior" style="width:150px; display:collapse" onclick="past()"/>                       </td>
                                                            <td width="50%" align="center"><input type="button" name="actionS" id="actionS" value="Siguiente" style="width:150px; display:inherit" onclick="next()"/>                       </td>
                                                        </tr>
                                                        <%// }else{ %>
                                                        <!--      <tr>
                                                                <td width="100%" align="center" colspan="2"><div align="center"><span style="font-size:13px; color:#006699">Debe existir un pago valido para la realizacion del tramite</span></div></td>
                                                              </tr> -->
                                                        <%// } %>
                                                    </table></td>
                                            </tr>
                                        </table></th>
                                </tr>
                            </table>
                        </fieldset>
                    </form>	
                </td>
            </tr>
            <tr>
                <td height="21">&nbsp;</td>
            </tr>
        </table>
    </body>
</html>
<%  }else{
            //    String tipoD = request.getParameter("tipo");
            //String numeroD = request.getParameter("documento");

        }
    }
} catch (Exception exc) {
    exc.printStackTrace();
%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="3"></jsp:param>
    <jsp:param name="msgError" value="<%=exc.getMessage()%>" ></jsp:param>
</jsp:forward>
<%
    }%>
