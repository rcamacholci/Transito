<%-- 
    Document   : FormularioRNMA
    Created on : 23/11/2015, 08:27:43 AM
    Author     : Desarrollo
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.List"%>
<%@page import="modelo.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <LINK title=win2k-cold-1 media=all href="../../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="../../html/scripts/calendar.js"></script>
    <script type="text/javascript" src="../../html/scripts/calendar-setup.js"></script>
    <script type="text/javascript" src="../../html/scripts/calendar-es.js"></script>
    <script src="../../html/scripts/personas.js" type="text/javascript"></script>
    <script src="../../html/scripts/validarFecha.js" type="text/javascript"></script>
    <link rel=stylesheet href="../../html/css/Style.css" type="text/css" media=screen>
    <script type="text/javascript" src="../../html/scripts/motorAjax.js"></script>
    <script type="text/javascript" src="../../html/scripts/personas.js"></script>
    <script type="text/javascript">
        function validar(sector) {
            var tramite = document.getElementById("ntramites");
            if (sector == "panelTramites") {
                for (i = 0; i < tramite.options.length; i++) {
                    var dato1 = document.getElementById("fun" + tramite.options[i].value).value;
                    if (dato1.length == 0) {
                        //quitar para pagos false-->
                        return true;
                    }
                }
            }
            if (sector == "panelPropietario") {
                npropietarios = window.frames['frpropietario'].document.getElementById("hdpropietarios").value;
                if (window.frames['frpropietario'].document.getElementById("sumap") != null) {
                    sumap = window.frames['frpropietario'].document.getElementById("sumap").value;
                } else {
                    sumap = 0;
                }

                if (tramite.value != '9') {
                    for (i = 0; i < npropietarios; i++) {
                        if (window.frames['frpropietario'].document.getElementById("txtnombres" + i).value.length == 0) {
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
            }
            return true;
        }
        /**/
        function newC() {
            ancho = 400;
            alto = 360;
            barra = 0;
            izquierda = (screen.width) ? (screen.width - ancho) / 2 : 100;
            arriba = (screen.height) ? (screen.height - alto) / 2 : 100;
            opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba;
            url = "../busquedaColores.jsp";
            window.open(url, 'popUp', opciones);
            document.getElementById("color").focus() = false;
        }
        /**/
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
        function view(name) {
            document.getElementById('panelVendedor').style.display = 'none';
            document.getElementById('panelCaracteristicas').style.display = 'none';
            document.getElementById('panelInfoTramites').style.display = 'none';
            document.getElementById('panelTramites').style.display = 'none';
            document.getElementById('panelPropietario').style.display = 'none';
            document.getElementById('panelObservaciones').style.display = 'none';
            document.getElementById('panel' + name).style.display = 'block';
        }
        function evaluar() {
            var tramite = document.getElementById("ntramites");
            var registro = document.getElementById("hddnregistro").value;
            var motor = "";
            if (document.getElementById("txtnumeroregistromotor") != null)
                motor = document.getElementById("txtnumeroregistromotor").value;
            var chasis = "";
            if (document.getElementById("txtnumerochasis") != null)
                chasis = document.getElementById("txtnumerochasis").value;
            var serie = "";
            if (document.getElementById("textnumeroserie") != null)
                serie = document.getElementById("textnumeroserie").value;
            var vin = ""
            if (document.getElementById("txtnumerovin") != null)
                vin = document.getElementById("txtnumerovin").value;
            for (i = 0; i < tramite.options.length; i++) {
                ajax3 = new nuevoAjax();
                ajax3.open("POST", "EvaluarDatos.jsp", true);
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
                ajax3.send("registro=" + registro + "&motor=" + motor + "&chasis=" + chasis + "&serie=" + serie + "&tramite=" + tramite.options[i].value + "&vin=" + vin +"&opcion=1");
            }
        }//fun
        /***/
function consultaPersona(campoP) {
            if (!isNaN(campoP.value) && campoP.value.length > 0) {
                tipo = document.getElementById("cmdtipodocvendedor");
                tipoDoc = tipo.options[tipo.options.selectedIndex].value
                ajax = nuevoAjax();
                ajax.open("POST", "../getPersona.jsp", true);
                ajax.onreadystatechange = function () {
                    if (ajax.readyState == 4) {
                        var respuesta = "";
                        for (var i = 0; i <= ajax.responseText.length + 1; i++) {
                            if (isNaN(ajax.responseText.charAt(i)))
                                document.getElementById("txtnombrevendedor").value = respuesta;
                            respuesta += ajax.responseText.charAt(i);
                            document.getElementById("txtnombrevendedor").disabled = true;
                        }
                        if (respuesta == "nueva") {
                            document.getElementById("txtnombrevendedor").value = "";
                            viewPersona(tipoDoc, campoP.value);
                        } else {
                            //consultaCartera(id,ajax.responseText,tipoDoc,campoP.value);
                        }
                    }
                }
                ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                ajax.send("documento=" + campoP.value + "&tipo=" + tipoDoc);
            }
        }
        /**/



    </script>

    <%  int psg = 0;

            try {
                Model model = (Model) session.getAttribute("model");
                if (model != null) {
                    java.util.List<Tramite> listaTramites = (List<Tramite>) session.getAttribute("ListTramites");
                    String registro = "";
                    if (request.getParameter("txtnumeromaquinaria") != null) {
                        registro = request.getParameter("txtnumeromaquinaria").toUpperCase();
                    } else {
                        registro = "-";
                    }

    %>
    <body>
        <form name="form" id="form" method="post" action="RadicarTramite.jsp">
            <!--// Secuencia seleccion//-->
            <select name="secuencia" id="secuencia" style="display:none">
                <option value="panelTramites">panelTramites</option>
                <%                java.util.List lsec = new java.util.LinkedList();
                if (listaTramites.size() > 0) {
                    lsec = model.getSecuenciaByTramiteRnma((int) listaTramites.get(0).getId_tramite());
                    for (int j = 0; j < lsec.size(); j++) {%>
                <option value="<%=lsec.get(j)%>"><%=lsec.get(j)%></option>
                <%    }
                %>
                <option value="panelObservaciones">panelObservaciones</option>
                <%
                }%>
            </select>
            <input type="text" name="idsecuencia" id="idsecuencia" value="0" style="display:none"/>
            <select name="ntramites" id="ntramites" style="display:none">
                <%
                if (listaTramites.size() > 0) {%>
                <option value="<%=listaTramites.get(0).getId_tramite()%>"><%=listaTramites.get(0).getId_tramite()%></option>
                <%	}
                %>
            </select>
            <!--// Fin//-->
            <table width="80%" border="0" align="center">
                <tr>
                    <td width="87%" height="26" align="center"><strong><span class="label"><h1>SOLICITUD DE TRAMITES</h1> </span></strong></td>
                </tr>
                <tr><td>
                        <fieldset>
                            <legend><span class="label">DATOS GENERALES DE LA SOLICITUD</span></legend>
                            <table width="100%" border="0" align="center" >
                                <tr>
                                    <th colspan="4" scope="col"><span class="label"><%=registro%></span>

                                    </th>

                                </tr>
                                <tr>
                                    <td width="15%" align="left"><span class="label"> <b>Solicitado&nbsp;Por</b> </span></td>
                                    <td width="23%" align="left">
                                        <select  name="tipoDocumento" id="tipoDocumento" class="select" style="width: auto" >
                                            <%
               java.util.List tipoDocumentos = model.listadoParametros(5);
                int tip_rad = 0;
                String doc_rad = "";
                tip_rad = Integer.parseInt(request.getParameter("cmdtipodocumento"));
                doc_rad = request.getParameter("txtdocumento");

                Persona solT = model.consultarPersona(tip_rad, doc_rad);
                String nameST = solT.getNombre_1() + " " + solT.getApellido_1() + " " + (solT.getApellido_2() != null ? solT.getApellido_2() : "");
                for (int i = 0; i < tipoDocumentos.size(); i++) {
                    Parametro parametro = (Parametro) tipoDocumentos.get(i);
                    if (parametro.getCodigo() == tip_rad) {%>
                                            <option value="<%=parametro.getCodigo()%>" selected="selected"><%= parametro.getNombre()%> </option>
                                            <% }
                }%>
                                        </select>
                                    </td>
                                    <td width="14%" align="center"><span class="label"><b>Documento</b> </span>
                                        <input type="hidden" id="hddnregistro"name="hddnregistro" value="<%=registro%>" /> 
                                        <input type="hidden" id="hddndocumento"name="hddndocumento" value="<%=tip_rad%>" /> 
                                        <input type="hidden" id="hddntipodocumento"name="hddntipodocumento" value="<%=doc_rad%>" /> 
                                        <input type="hidden" id="hddntramite"name="hddntramite" value="<%=listaTramites.get(0).getId_tramite()%>" />
                                    </td>
                                    <td width="48%" align="left">
                                        <input name="numeroDocumento" class="text" type="text" id="numeroDocumento"  value="<%=doc_rad%>" readonly="true"/></td>
                                </tr>
                                <tr>
                                    <td align="left" class="label"><b>Nombre</b></td>
                                    <td colspan="3" align="left">
                                        <input name="nombreRadicador" type="text" class="text" id="nombreRadicador" readonly="true" value="<%=nameST%>"/></td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <fieldset id="panelTramites" style="display:block"><legend class="label" style="width: auto"><b>Pagos</b></legend>
                                            <table width="99%" border="0">
                                                <tr style="background:url(../../html/images/inicio_3.png)" class="labelTr">
                                                    <th width="5%" scope="col"><span>
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>ID</b></font></label>
                                                        </span></th>
                                                    <th width="50%" scope="col"><span >
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>NOMBRE TRAMITE</b></font></label>

                                                            <label></label>
                                                        </span></th>
                                                    <th width="15%" scope="col"><span >
                                                            <label><font face="Arial, Helvetica, sans-serif"><b># PAGO TRANSITO</b></font></label>
                                                            <label></label>
                                                        </span></th>
                                                    <th width="15%" scope="col"><span >
                                                            <label><font face="Arial, Helvetica, sans-serif"><b>CUPL</b></font></label>
                                                            <label></label>
                                                        </span></th>
                                                </tr>
                                                <%
                long id_tramite = 0;
                String valFun = "";
                if (listaTramites.size() > 0) {
                    id_tramite = listaTramites.get(0).getId_tramite();
                    modelo.Tramite tramite = model.consultarTramite(id_tramite);
                    valFun = model.obtenerPosiblePagoTRANSITO(registro, tramite.getId_tramite());
                    if (valFun.length() == 0) {
                        valFun = model.consultarPagoReclamo(1, registro.toUpperCase(), tramite.getId_tramite());
                        valFun = valFun != null ? valFun : "";
                    }
                    String valRunt = model.obtenerPosiblePagoRUNT(registro, solT.getId_persona(), id_tramite, 1);
                    String valSimit = "";
                                                %>
                                                <tr style="vertical-align:top" >
                                                    <td align="char"><span class="text">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b><%=tramite.getId_tramite()%></b></font></label>
                                                        </span></td>
                                                    <td align="char"><span class="text">
                                                            <label><font face="Arial, Helvetica, sans-serif"><b><%=tramite.getNombre()%></b></font></label>
                                                        </span></td>
                                                    <td align="cahr"><input name="fun<%=id_tramite%>" class="text" type="text" id="fun<%=id_tramite%>" style="text-align:center; color:#006699; font-size:13px" value="<%=valFun%>" readonly /></td>
                                                    <td><iframe src = "CargarCupl.jsp" id="frmCargarCupl" name="frmCcargarCupl" marginwidth="0" height="10%" width="210" marginheight="0" scrolling="auto" style="border:none" frameborder="0"></iframe></td>
                                                </tr>
                                                <%  }%>
                                            </table>
                                        </fieldset>
                                    </td></tr>

                                <tr>
                                    <th colspan="4" scope="col">&nbsp;</th>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <fieldset  id="panelInfoTramites" style="display: none">
                                            <legend class="label" style="width: auto"><b>Informacion Tramite</b></legend>
                                            <table table width="100%" border="0" align="center">
                                                <tr >
                                                    <th width="141" scope="row" style="display:none" >Codigo tramite </th>
                                                    <td width="144" style="display:none">
                                                        <label>
                                                            <input type="text" disabled="disabled" id="txtcodigotipotramite" name="txtcodigotipotramite" title="CodigoTramite" readonly="true" />
                                                        </label>
                                                    </td>
                                                    <td style="display:none" width="120">Estado Tramite </td>
                                                    <td style="display:none" width="144">
                                                        <select name="cmdestadotramite" id="cmdestadotramite">
                                                            <option>&lt;--&gt;</option>
                                                        </select>
                                                    </td>
                                                    <td width="122" class="label">Orden de ejecucion </td>
                                                    <td width="148" class="text"><input class="text" name="txtordeejecucion" type="text" id="txtordeejecucion"  /></td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">Declaracion Importacion </th>
                                                    <td><input name="txtnumerodeclaracionimportacion" type="text" id="txtnumerodeclaracionimportacion"  /></td>
                                                    <td class="label">Tipo de Registro </td>
                                                    <td><select class="select" name="cmdnombretiporegistro" id="cmdnombretiporegistro">
                                                            <option selected="selected">&lt;--&gt;</option>
                                                            <%
                                                            try{
                                                            List listParametros = model.listadoParametros(53);
                                                            for (int i = 0; i < listParametros.size(); i++) {
                                                                Parametro par = (Parametro)listParametros.get(i);
                                                            %>
                                                            <option value="<%=par.getCodigo() %>"><%=par.getNombre() %></option>
                                                            <%
                                                            }
                                                            }catch(Exception ex){
                                                                ex.printStackTrace();
                                                            }
                                                            %>
                                                        </select></td>
                                                        <td class="label">Fecha Ingreso </td>
                                                    <td><input class="text" name="txtfechaIngreso" type="text" id="txtfechaIngreso"  onkeyup="mascara(this, '/', true)" maxlength="10"  readonly />
                                                        <input name="btnfechaIngreso" type="button" id="btnfechaIngreso" value="&gt;" class="text" style="width:35px"/>
                                                        <script type="text/javascript">
                                                            Calendar.setup({
                                                                inputField: "txtfechaIngreso", // id del campo de texto
                                                                ifFormat: "%d/%m/%Y", // formato de la fecha, cuando se escriba en el campo de texto
                                                                button: "btnfechaIngreso"   // el id del bot?n que lanzar? el calendario
                                                            });
                                                        </script>  
                                                    </td>
                                                </tr>                        
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <fieldset id="panelCaracteristicas" style="display: none">
                                            <legend>Caracteristicas</legend>
                                            <table table width="100%" border="0" align="center" >
                                                <tr>
                                                    <th scope="row" class="label">Vin </th>
                                                    <td><input name="txtnumerovin" type="text" class="text" id="txtnumerovin" /></td>
                                                    <td class="label">Serie</td>
                                                    <td><input name="txtnumeroserie" type="text" class="text" id="txtnumeroserie" /></td>
                                                    <td class="label">Chasis</td>
                                                    <td><input name="txtnumerochasis" type="text" class="text" id="txtnumerochasis" /></td>
                                                </tr>
                                                <tr>
                                                    <th class="label" scope="row" >Clase Maquinaria </th>
                                                    <td><select class="select" name="cmdclasemaquinaria" id="cmdclasemaquinaria">
                                                            <%
                                                            try{
                                                            List listParametros = model.listadoParametros(1);
                                                            for (int i = 0; i < listParametros.size(); i++) {
                                                                Parametro par = (Parametro)listParametros.get(i);
                                                                if(par.getNombreCorto().equals("4")){
                                                            %>
                                                            <option selected="selected" value="<%=par.getCodigo() %>"><%=par.getNombre() %></option>
                                                            <%
                                                                }
                                                            }
                                                            }catch(Exception ex){
                                                                ex.printStackTrace();
                                                            }
                                                            %>
                                                        </select></td>
                                                    <td class="label">Registro Motor </td>
                                                    <td><input class="text" name="txtnumeroregistromotor" type="text" id="txtnumeroregistromotor"/></td>
                                                    <td class="label">Tipo Cabina </td>
                                                    <td><select class="select" name="cmbidtipocabina" id="cmbidtipocabina">
                                                            <option selected="selected" value="1">NO APLICA</option>
                                                        </select></td>
                                                </tr>
                                                <tr>
                                                    <th class="label"  scope="row">Combustible</th>
                                                    <td><select class="select" name="cmdidtipocombustible" id="cmdidtipocombustible">
                                                            <option value="0"><<--Seleccione Tipo Comb.-->></option>
                                                            <% java.util.List combustibles = model.listadoParametros(75);
                for (int i = 0; i < combustibles.size(); i++) {
                    Parametro parametro = (Parametro) combustibles.get(i);%>
                                                            <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                                                            <%   }%>
                                                        </select></td>
                                                    <td class="label">Partida arancelaria </td>
                                                    <td><input class="text" name="txtnrosubpartidaarancelaria" type="text" id="txtDeclaracionImportacion53"  /></td>
                                                    <td class="label">Color Maquinaria </td>
                                                    <td style="vertical-align: bottom"><input class="text" name="color" type="text" id="color"  readonly  />&nbsp;<img src="../../html/images/adicionar.gif" width="16" height="16" style="cursor:pointer" onclick="newC()"/>
                                                        <input  type="hidden" name="r_color" id="r_color" values=""/>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="4">
                                        <fieldset id="panelPropietario" style="display: none">
                                            <legend class="label">Propietario(s)</legend>
                                            <table width='100%' align="center" >
                                                <tr>
                                                    <td style="width: 100%">
                                                        <iframe id="frpropietario" name="frpropietario"  src="ListarPropietario.jsp" marginwidth="0" height="200" width="100%" marginheight="0" scrolling="auto" style="border:none" frameborder="0"></iframe>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>



                                <tr>
                                    <td colspan="4" >
                                        <fieldset id="panelVendedor" style="display: none">
                                            <legend>Vendedor(es)</legend>
                                            <table table width="100%" border="0" align="center" >
                                                <tr>
                                                    <th class="label" scope="row">Tipo Documento </th>
                                                    <td><select class="select" name="cmdtipodocvendedor" id="cmdtipodocvendedor">
                                                            <option selected="selected">&lt;--&gt;</option>
                                                            <%
                                                            for(int i =0;i<tipoDocumentos.size();i++){
                                                                Parametro doc = (Parametro)tipoDocumentos.get(i);
                                                                %><option value="<%=doc.getCodigo()%>"><%=doc.getNombreCorto()%></option><%
                                                            }
                                                            %>
                                                        </select></td>
                                                    <td class="label">Documento</td>
                                                    <td><input class="text" name="txtnumerodocvendedor" type="text" id="txtnumerodocvendedor" onblur="consultaPersona(this)"/></td>
                                                    <td class="label">Nombre</td>
                                                    <td><input class="text" name="txtnombrevendedor" type="text" id="txtnombrevendedor" readonly/></td>
                                                </tr>
                                                <tr>
                                                    <th class="label" scope="row">Factura </th>
                                                    <td><input class="text" name="txtnumerofacturavendedor" type="text" id="txtnumerofacturavendedor" /></td>
                                                    <td class="label">Valor factura </td>
                                                    <td><input class="text" name="txtvalorfacturavendedor" type="text" id="txtvalorfacturavendedor"  /></td>
                                                    <td class="label">Fecha factura</td>
                                                    <td><input class="text" name="txtfechafacturavendedor" type="text" id="txtfechafacturavendedor"  onkeyup="mascara(this, '/', true)" maxlength="10"  readonly />
                                                        <input name="btnfechafacturavendedor" type="button" class="text" id="btnfechafacturavendedor" value="&gt;" style="width:35px"/>
                                                        <script type="text/javascript">
                                                            Calendar.setup({
                                                                inputField: "txtfechafacturavendedor", // id del campo de texto
                                                                ifFormat: "%d/%m/%Y", // formato de la fecha, cuando se escriba en el campo de texto
                                                                button: "btnfechafacturavendedor"   // el id del bot?n que lanzar? el calendario
                                                            });
                                                        </script>  
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr>
                                <table width="100%" border="0" id="panelObservaciones"  style="display:none" align="center">
                                    <tr>
                                        <td width="100%" align="center"><table width="100%" border="0" align="center">
                                                <tr>
                                                    <td width="10%" align="left" class="label">Observaciones</td>
                                                    <td width="60%"><input name="txtobservacion" type="text" id="txtobservacion" class="text" style="width:450px;color:#333333;" value="" /></td>
                                                    <td width="40%" align="center"><input type="button" name="aceptar" id="aceptar" value="Enviar" style="width:150px" onclick="evaluar()"/></td>
                                                </tr>

                                            </table></td>
                                    </tr>
                                </table>
                                </tr>
                            </table>
                            <table width="100%" border="0" id="panelBotones" style="display:block" align="center">
                                <tr>
                                    <td width="100%" align="center"><table width="100%" border="0" align="center">
                                            <tr>
                                                <td width="50%" align="center"><input type="button" class="input" name="actionA" id="actionA" value="Anterior" style="width:150px; display:collapse" onClick="past()"/>                       </td>
                                                <td width="50%" align="center"><input type="button" class="input" name="actionS" id="actionS" value="Siguiente" style="width:150px; display:inherit" onClick="next()"/>                       </td>
                                            </tr>
                                        </table></td>
                                </tr>
                            </table>
                            <%

            } else {
                            %>
                            <jsp:forward page="no_access.jsp">
                                <jsp:param name="tipo" value="1"></jsp:param>
                            </jsp:forward>
                            <%                }
            } catch (Exception exc) {
                exc.printStackTrace();
            }%>
                            </form>
                            </body>
                            </html>
