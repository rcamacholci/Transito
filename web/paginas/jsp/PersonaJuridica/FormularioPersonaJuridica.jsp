<%@page import="modelo.Departamento"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Parametro"%>
<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    modelo.Model model = (modelo.Model) session.getAttribute("model");
    String departamento = "5";
    String municipio = "";
%>
<html>
    <head>
        <LINK title=win2k-cold-1 media=all href="../../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script type="text/javascript" src="../../html/scripts/calendar.js"></script>
        <script type="text/javascript" src="../../html/scripts/calendar-setup.js"></script>

        <script type="text/javascript" src="../../html/scripts/calendar-es.js"></script>
        <script src="../../html/scripts/validarFecha.js" type="text/javascript"></script>
        <style type="text/css">
            <!--
            .Estilo1 {font-family: "Vendana";font-weight: bold;color: #0066CC;font-size: 13px;}
            .Estilo2 {font-family: "Vendana";font-weight: bold;color: #006666;font-size: 14px;}
            .Estilo3 {font-family: "Vendana";font-weight: bold;color: #0066CC;font-size: 12px;}
            .style1 {color: #003366}
            .style3 {font-weight: bold}
            .Estilo4 {font-weight: bold}
            .Estilo6 {font-size: 12px}
            .Estilo7 {font-size: 14px;color: #000000;font-family: Vendana;font-weight: bold;font-style: italic;}
            .Estilo9 {color: #FF6600}
            .Estilo11 {color: #0066CC}
            .Estilo12 {color: #FF0000}
            .Estilo13 {color: #333333}
            .Estilo14 {font-family: "Vendana"; font-weight: bold; color: #333333; font-size: 12px; }
            .style7 {
                font-family: Tahoma;
                font-weight: bold;
                font-size: 12px;
                color: #FFFFFF;
            }
            .style15 {font-family: Tahoma}
            .style19 {font-family: Tahoma; font-weight: bold; color: #333333; font-size: 11px; }
            .style20 {font-size: 11px}
            .style21 {color: #333333; font-family: Tahoma; font-size: 11px; }
            .style22 {
                color: #333333;
                font-size: 11px;
                font-weight: bold;
            }
            .style23 {
                color: #FFFFFF;
                font-family: Tahoma;
                font-size: 11px;
            }
            .style26 {font-family: Tahoma; font-weight: bold; color: #FFFFFF; font-size: 11px; }
            -->
        </style>
        <script language="javascript" type="text/javascript">
            function buscarDirMunicipios() {
                tabla = document.getElementById('dir_municipios');

                valor = document.form.dir_departamento.options[document.form.dir_departamento.selectedIndex].value;
                ajax1 = new nuevoAjax();
                ajax1.open("POST", "../cargarCiudades.jsp", true);
                ajax1.onreadystatechange = function () {
                    if (ajax1.readyState == 4) {
                        tabla.innerHTML = ajax1.responseText;
                    }
                }
                ajax1.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                ajax1.send("fk_dpto=" + valor + "&name=dir_municipio");

            }

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
            function consultaPersonaC(id_tipoDoc, id_Documento, id_input_set) {

                var tipo = document.getElementById(id_tipoDoc);
                var documento = document.getElementById(id_Documento);
                if (documento.value.length > 0) {

                    var ajax = new nuevoAjax();
                    ajax.open("POST", "../getPersona2.jsp", true);
                    ajax.onreadystatechange = function () {

                        if (ajax.readyState == 4 && ajax.status == 200) {
                            var docxml = ajax.responseXML
                            var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue

                            if (result == 'si') {
                                var nombres = docxml.getElementsByTagName('nombre1')[0].childNodes[0].nodeValue + ' ' + (docxml.getElementsByTagName('nombre2')[0].childNodes[0].nodeValue != 'null' ? docxml.getElementsByTagName('nombre2')[0].childNodes[0].nodeValue : '')
                                var apellidos = docxml.getElementsByTagName('apellido1')[0].childNodes[0].nodeValue + ' ' + (docxml.getElementsByTagName('apellido2')[0].childNodes[0].nodeValue != 'null' ? docxml.getElementsByTagName('apellido2')[0].childNodes[0].nodeValue : '')
                                document.getElementById(id_input_set).value = nombres + ' ' + apellidos
                            } else {
                                viewPersonaC(tipo.value, documento.value);
                                document.getElementById(id_input_set).value = ''
                            }
                        }
                    }
                    ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    ajax.send("documento=" + documento.value + "&tipo=" + tipo.value);
                }
            }
            function viewPersonaC(tipo, numero) {
                if (!isNaN(numero)) {
                    ancho = 689;
                    alto = 250;
                    barra = 0;
                    izquierda = (screen.width) ? (screen.width - ancho) / 2 : 100;
                    arriba = (screen.height) ? (screen.height - alto) / 2 : 100;
                    opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba;
                    url = "../adicionarPersona.jsp?tipo=" + tipo + "&documento=" + numero;
                    window.open(url, 'popUp', opciones);
                }
            }
            function validarLetras(e) {
                tecla = (document.all) ? e.keyCode : e.which;

                if (tecla == 8)
                    return true; // backspace
                if (tecla == 32)
                    return true; // espacio
                if (e.ctrlKey && tecla == 86) {
                    return true;
                } //Ctrl
                if (e.ctrlKey && tecla == 67) {
                    return true;
                } //Ctrl
                if (e.ctrlKey && tecla == 88) {
                    return true;
                } //Ctrl

                patron = /[a-zA-Z]/; //patron
                te = String.fromCharCode(tecla);
                return patron.test(te); // prueba de patron
            }
            function validarNumeros(e) { // 1
                var key = window.Event ? e.which : e.keyCode
                return ((key >= 48 && key <= 57) || (key == 8))

            }
            function validateMail(txtcorreo)
            {
                //Creamos un objeto
                object = document.getElementById(txtcorreo);
                valueForm = object.value;

                // Patron para el correo
                var patron = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/;
                if (valueForm.search(patron) == 0)
                {
                    //Mail correcto
                    object.style.color = "#000";
                    return;
                }
                //Mail incorrecto
                object.style.color = "#f00";
            }
            function Cambiar(Control) {
                if (Control.value.length != 0) {
                    Control.style.borderColor = '#666666';
                }
            }
            function validarDatos() {
                if (document.form.txt_Liquidacion.value.length != 0) {
                    if (document.form.txt_razonSocial.value.length != 0) {
                        if (document.form.txt_sigla.value.length != 0) {
                            if (document.form.txt_CapitalPagado.value.length != 0) {
                                if (document.form.txt_PatrimonioLiquido.value.length != 0) {
                                    if (document.form.txt_Certificado.value.length != 0) {
                                        if (document.form.txt_NResgistroMercantil.value.length != 0) {
                                            if (document.form.fecha.value.length != 0) {
                                                if (document.form.txt_Direccion.value.length != 0) {
                                                    if (document.form.txt_Telefono.value.length != 0) {
                                                        if (document.form.txt_Celular.value.length != 0) {
                                                            if (document.form.txt_Correo.value.length != 0) {
                                                                if (document.form.txt_Fax.value.length != 0) {
                                                                    if (document.form.numerodocumento.value.length != 0) {
                                                                        document.form.action = "ProcesarRegistrarPersonaJuridica.jsp";
                                                                        document.form.submit();
                                                                    } else {
                                                                        document.form.numerodocumento.style.borderColor = '#FC0000';
                                                                    }
                                                                } else {
                                                                    document.form.txt_Fax.style.borderColor = '#FC0000';
                                                                }
                                                            } else {
                                                                document.form.txt_Correo.style.borderColor = '#FC0000';
                                                            }
                                                        } else {
                                                            document.form.txt_Celular.style.borderColor = '#FC0000';
                                                        }
                                                    } else {
                                                        document.form.txt_Telefono.style.borderColor = '#FC0000';
                                                    }
                                                } else {
                                                    document.form.txt_Direccion.style.borderColor = '#FC0000';
                                                }
                                            } else {
                                                document.form.fecha.style.borderColor = '#FC0000';
                                            }
                                        } else {
                                            document.form.txt_NResgistroMercantil.style.borderColor = '#FC0000';
                                        }
                                    } else {
                                        document.form.txt_Certificado.style.borderColor = '#FC0000';
                                    }
                                } else {
                                    document.form.txt_PatrimonioLiquido.style.borderColor = '#FC0000';
                                }
                            } else {
                                document.form.txt_CapitalPagado.style.borderColor = '#FC0000';
                            }
                        } else {
                            document.form.txt_sigla.style.borderColor = '#FC0000';
                        }
                    } else {
                        document.form.txt_razonSocial.style.borderColor = '#FC0000';
                    }
                } else {
                    document.form.txt_Liquidacion.style.borderColor = '#FC0000';
                }
            }
        </script>
    </head>
    <body>
        <form name="form" method="post" action="javascript:validarDatos()">
            <table width="90%" border="0" align="center">
                <tr>
                    <td colspan="4" background="../../html/images/inicio_3.png"> <div align="center" class="Estilo15 Estilo26 style7">REGISTRAR DATOS PERSONA JURIDICA</div></td>
                </tr>
                <tr>
                    <td>
                        <fieldset>
                            <legend><span class="Estilo2">Datos Persona Juridica</span></legend>
                            <table width="100%" border="0">
                                <tr>
                                    <td>
                                        <input type="text" readonly="true" name="documento" id="documento" value="<%=request.getParameter("documento")%>">
                                    </td>
                                    <td>
                                        <input type="text" name="digitoV" id="digitoV" value="<%=request.getParameter("digitoV")%>">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="1"><span class="style19">NUMERO DE LIQUIDACION</span></td>
                                    <td colspan="1"><input type="text" style="width:400px;border: 1px solid #666666" id="txt_Liquidacion" name="txt_Liquidacion" onkeypress="return validarNumeros(event)" onblur="Cambiar(this)"/></td>
                                </tr>
                                <tr>
                                    <td><span class="style19">RAZON SOCIAL</span></td>
                                    <td><input type="text" style="width:400px;border: 1px solid #666666" onblur="Cambiar(this)" id="txt_razonSocial" name="txt_razonSocial" /></td>
                                    <td><span class="style19">SIGLA</span></td>
                                    <td><input type="text" style="width:80px;border: 1px solid #666666" onblur="Cambiar(this)" id="txt_sigla" name="txt_sigla" /></td>
                                </tr>
                                <tr>
                                    <td><span class="style19">CAPITAL PAGADO</span></td>
                                    <td><input type="text" style="width:100px;border: 1px solid #666666" onblur="Cambiar(this)" id="txt_CapitalPagado" name="txt_CapitalPagado" onkeypress="return validarNumeros(event)"/></td>
                                    <td><span class="style19">PATRIMONIO LIQUIDO</span></td>
                                    <td><input type="text" style="width:100px;border: 1px solid #666666" onblur="Cambiar(this)" id="txt_PatrimonioLiquido" name="txt_PatrimonioLiquido" onkeypress="return validarNumeros(event)"/></td>
                                </tr>
                                <tr>
                                    <td><span class="style19">EMPRESA PRESTADORA</span></td>
                                    <td>
                                        <select name="txt_EmpresaPrestadora" id="txt_EmpresaPrestadora" onblur="Cambiar(this)" style="width:250px;border: 1px solid #666666">
                                            <option value="S">SI</option>
                                            <option value="N">NO</option>
                                        </select>
                                    </td>
                                    <td><span class="style19">CERTIFICADO</span></td>
                                    <td><input type="text" style="border: 1px solid #666666" width="80px"  onblur="Cambiar(this)" id="txt_Certificado" name="txt_Certificado" onkeypress="return validarNumeros(event)"/></td>
                                </tr>
                                <tr>
                                    <td><span class="style19">TIPO SOCIEDAD</span></td>
                                    <td>
                                        <select name="tipoSociendad" onblur="Cambiar(this)" id="tipoSociendad" style="width:250px;border: 1px solid #666666">
                                            <%
                                                Parametro parametro_tiposociedad = new Parametro();
                                                java.util.List listaTiposSociedad = model.listadoParametros(329);
                                                for (int i = 0; i < listaTiposSociedad.size(); i++) {
                                                    parametro_tiposociedad = (Parametro) listaTiposSociedad.get(i);
                                            %>
                                            <option value="<%=parametro_tiposociedad.getNombre() + ""%>"><%=parametro_tiposociedad.getNombre()%></option>
                                            <%
                                                }%>
                                        </select>
                                    </td>
                                    <td><span class="style19">TIPO ENTIDAD</span></td>
                                    <td>
                                        <select name="tipoEntidad" onblur="Cambiar(this)" id="tipoEntidad" style="width:250px;border: 1px solid #666666">
                                            <%
                                                Parametro parametro_tipoentidad = new Parametro();
                                                java.util.List listaTiposentidad = model.listadoParametros(328);
                                                for (int i = 0; i < listaTiposentidad.size(); i++) {
                                                    parametro_tipoentidad = (Parametro) listaTiposentidad.get(i);
                                            %>
                                            <option value="<%=parametro_tipoentidad.getNombre() + ""%>"><%=parametro_tipoentidad.getNombre()%></option>
                                            <%
                                                }%>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><span class="style19">DEPARTAMENTO</span></td>
                                    <td>
                                        <select name="dir_departamento" style="width:150px; font-size:11px;border: 1px solid #666666" onblur="Cambiar(this)" onchange="buscarDirMunicipios();
                                                return false" onfocus="buscarDirMunicipios();
                                                        return false">
                                            <% List listaDepar_per = model.crearListaDpto();
                                                Iterator it_dep_per = listaDepar_per.iterator();
                                                while (it_dep_per.hasNext()) {
                                                    modelo.Departamento dpto = (modelo.Departamento) it_dep_per.next();
                                                    if (departamento.equals(dpto.getId_departamento() + "")) {%>
                                            <option value="<%=dpto.getId_departamento() + ""%>" selected><%=dpto.getNombre()%></option>
                                            <% } else {%>
                                            <option value="<%=dpto.getId_departamento() + ""%>"><%=dpto.getNombre()%></option>
                                            <% }
                                                }%>
                                        </select>
                                    </td>
                                    <td><span class="style19">MUNICIPIO</span></td>
                                    <td>
                                        <div  style="width:150px" align="center" id="dir_municipios">
                                            <select name="dir_municipio" onblur="Cambiar(this)" id="dir_municipio" style="width:150px; font-size:11px;border: 1px solid #666666">
                                                <% if (departamento.length() > 0 && municipio.length() > 0) {
                                                        java.util.List lista = model.crearListaMunicipios(Integer.parseInt(departamento));
                                                        for (int i = 0; i < lista.size(); i++) {
                                                            modelo.Municipio mncp = (modelo.Municipio) lista.get(i);
                                                            if (municipio.equals(mncp.getCodigo() + "")) {%>
                                                <option value="<%=mncp.getCodigo() + ""%>" selected><%=mncp.getNombre()%></option>
                                                <% } else {%>
                                                <option value="<%=mncp.getCodigo() + ""%>"><%=mncp.getNombre()%></option>
                                                <%                  }
                                                        }
                                                    }%>
                                            </select>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td><span class="style19">N° REGISTRO MERCANTIL</span></td>
                                    <td><input type="text" width="200px" style="border: 1px solid #666666" onblur="Cambiar(this)" id="txt_NResgistroMercantil" name="txt_NResgistroMercantil" onkeypress="return validarNumeros(event)"/></td>
                                    <td><span class="style19">FECHA VENCIMIENTO REGISTRO MERCANTIL</span></td>
                                    <td>
                                        <input  id="fecha" name="fecha" onblur="Cambiar(this)"  style="text-align:center;width:120px;border: 1px solid #666666" onkeyup="mascara(this, '/', true)" maxlength="10"/> <input name="button" type="button" id="lanzador2" style="width:25px; color:#000000" value="<<" />
                                        <SCRIPT type="text/javascript">
                                            Calendar.setup({
                                                inputField: "fecha", // id del campo de texto
                                                ifFormat: "%d/%m/%Y", // formato de la fecha, cuando se escriba en el campo de texto
                                                button: "lanzador2"   // el id del botón que lanzará el calendario
                                            });
                                        </SCRIPT>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td>
                        <fieldset>
                            <legend><span class="Estilo2">Datos Direccion</span></legend>
                            <table width="100%" border="0">
                                <tr>
                                    <td><span class="style19">DIRECCION</span></td>
                                    <td><input type="text" style="width:400px;border: 1px solid #666666" onblur="Cambiar(this)" id="txt_Direccion" name="txt_Direccion"/></td>
                                    <td><span class="style19">TELEFONO</span></td>
                                    <td><input type="text" style="width:100px;border: 1px solid #666666" onblur="Cambiar(this)" id="txt_Telefono" name="txt_Telefono" onkeypress="return validarNumeros(event)"/></td>
                                </tr>
                                <tr>
                                    <td><span class="style19">CELULAR</span></td>
                                    <td><input type="text" style="width:100px;border: 1px solid #666666" onblur="Cambiar(this)" id="txt_Celular" name="txt_Celular" onkeypress="return validarNumeros(event)"/></td>
                                    <td><span class="style19">CORREO</span></td>
                                    <td><input type="text" style="width:400px;border: 1px solid #666666" id="txt_Correo" name="txt_Correo" onkeypress="validateMail(this)"/></td>
                                </tr>
                                <tr>
                                    <td colspan="1"><span class="style19">FAX</span></td>
                                    <td colspan="1"><input type="text" style="width:100px;border: 1px solid #666666" onblur="Cambiar(this)" id="txt_Fax" onkeypress="return validarNumeros(event)" name="txt_Fax"/></td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td>
                        <fieldset>
                            <legend><span class="Estilo2">Datos Representante Legal</span></legend>
                            <table width="100%" border="0">
                                <tr>
                                    <td><span class="style19">TIPO DOCUMENTO</span></td>
                                    <td>
                                        <select name="tipoDocumentop" style="border: 1px solid #666666" onblur="Cambiar(this)" id="tipoDocumentop" class="select" onChange="consultaPersonaC(this.id, 'numerodocumento', 'nombre_persona')">
                                            <%  List lista_id1 = model.listadoParametros(5);
                                                Parametro parametro = new Parametro();
                                                Iterator itrtor1 = lista_id1.iterator();
                                                while (itrtor1.hasNext()) {
                                                    parametro = (Parametro) itrtor1.next();%>
                                            <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
                                            <%  }%>
                                        </select>
                                    </td>
                                    <td><span class="style19">DOCUMENTO</span></td>
                                    <td><input name="numerodocumento" style="border: 1px solid #666666" type="text" onblur="Cambiar(this)" id="numerodocumento"  onkeypress="return validarNumeros(event)" class="text" onBlur="consultaPersonaC('tipoDocumentop', this.id, 'nombre_persona')"/></td>
                                </tr>
                                <tr>
                                    <td colspan="1"><span class="style19">NOMBRE</span></td>
                                    <td colspan="1"><input type="text" style="width:500px;border: 1px solid #666666" onblur="Cambiar(this)" id="nombre_persona" name="nombre_persona" onkeypress="return validarLetras(event)"/></td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <td>
                    <table width="100%" border="0">
                        <tr>
                            <td>
                                <input type="submit" id="almacenar" name="almacenar" value="GUARDAR REGISTRO"/>
                            </td>
                        </tr>
                    </table>
                </td>
                </tr>
            </table>
        </form>
    </body>
</html>
