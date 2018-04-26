<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
            try {
                if (session.getAttribute("model") != null) {
                    if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                        Model modelo = (Model) session.getAttribute("model");
                        Parametro parametro = new Parametro();
                        Sede sede = new Sede();
                        if (modelo != null) {
%>
<html>
    <head>
        <title>Adicionar Comparendo</title>
        <style type="text/css">
            .label {font-size: 11px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold ; width:110px}
            .text {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; width:120px; text-transform:uppercase}
            .date {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; width:100px }
            .bdate {font-size: 10px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold; width:20px }
            .select {font-size: 11px; color:#003366; text-align:left ; font-family:Arial; font-weight:bold; width:120px }
            .input { width:130px }
            .check { font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; }
        </style>
        <link title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
        <script type="text/javascript" src="../html/scripts/adicionarComparendo.js"></script>
        <script type="text/javascript" src="../html/scripts/consultasGenerales.js"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>

    </head>
    <body>
        <div align="center">
            <div align="center" style="width:660px">
                <form name="form" method="post" action="javascript:validarFormulario()">
                    <fieldset>
                        <legend></legend>
                        <table border="0" align="center" width="650px" cellpadding="1" cellspacing="1">
                            <tr>
                                <td align="center"><div class="text">INGRESO&nbsp;DE&nbsp;COMPARENDOS</div></td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>

                                    <table border="0" align="center" width="650px" cellpadding="1" cellspacing="2" style="border:none">
                                        <tr>
                                            <td class="label"># Comparendo</td>
                                            <td class="input"><input name="comparendo" autocomplete="off"  type="text" class="text" onBlur="existeComparendo(this)"  onKeyPress="return soloNumeros(event)"/></td>
                                            <td>&nbsp;<font color="red">*</font></td>
                                            <td class="label" colspan="2">Si el comparendo posee los numeros 9999999900000, debe ingresarlos!</td>
                                        </tr>
                                        <tr>
                                            <td class="label">Fecha</td>
                                            <td colspan="2" class="input"><input type="text"  name="fecha" id="fecha" class="date"  style="background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onKeyUp="mascara(this,'/',true)" maxlength="10" />
                                        <button name="bfecha" type="button" id="bfecha" class="bdate" ><img src="../html/images/calendario.png" width="19" height="18"/></button>
                                          <!--      <input name="bfecha" type="button" id="bfecha" class="bdate" value="<<"/> -->
                                                <script type="text/javascript">
                                                    Calendar.setup({
                                                        inputField     :    "fecha",      // id del campo de texto
                                                        ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                                        button         :    "bfecha"   // el id del botón que lanzará el calendario
                                                    });
                                                </script><font color="red">*</font>
                                            </td>

                                            <td class="label">Hora&nbsp;<label class="label" style="font-size:9px; color:#003366">(hh:mm)</label></td>
                                            <td class="input">
                                                <select name="horas" class="select" style="width:45px">
                                                    <option>< - ></option>
                                                    <% for (int m = 0; m < 24; m++) {%>
                                                    <option><%=m%></option>
                                                    <% }%>
                                                </select>
                                                <select name="minutos" class="select" style="width:45px">
                                                    <option>< - ></option>
                                                    <% for (int s = 0; s < 60; s=s+10) {%>
                                                    <option><%=s%></option>
                                                    <% }%>
                                                </select>
                                                <font color="red">*</font>
                                            </td>
                                         </tr>
                                         <tr>
                                            <td class="label">Departamento</td>
                                            <td align="left"><span class="Estilo4 Estilo27 Estilo13 style15 style20">
				  <select name="departamentos" class="select" onchange="buscarMunicipios(); return false" >
                    <option value="0">---Seleccionar---</option>
                    <% List listaDepar_per = modelo.crearListaDpto();
                                       Iterator it_dep_per = listaDepar_per.iterator();
                                       while (it_dep_per.hasNext()) {
                                            Departamento dpto = (Departamento)it_dep_per.next();
                                       %><option value="<%=dpto.getId_departamento()+""%>"><%=dpto.getNombre()%></option>
                    <%}%>
                  </select>
				</span></td>
                                            <td>&nbsp;</td>
                                            <td class="label">Municipio</td>
                                            <td class="input" align="left"><span class="Estilo4 Estilo27 Estilo13 style15 style20">
                                <div class="input" id="municipios">
                                    <select name="municipio" class="select" id="municipio">
                                    <%
                                        java.util.List lista = modelo.crearListaMunicipios(0);
                                        for (int i = 0; i < lista.size(); i++) {
                                            Municipio municipio = (Municipio) lista.get(i);
                                            %><option value="<%=municipio.getCodigo() + ""%>"><%=municipio.getNombre()%></option>
                        <%              }
                                             %>
                                    </select>
                                </div></span></td>
                                       </tr>
                                        <tr>
                                            <td class="label">Lugar</td>
                                            <td colspan="4">                      <select id="vias" name="vias" style="width:130px;text-align:center" class="select">
                                                                                    <%
                                                                                    java.util.List<Vias> Vi = modelo.listarVias();
                                                                                    for(int i=0;i<Vi.size();i++){
                                                                                        Vias temp = Vi.get(i);

                                                                                     %>|
                                                                                     <option value="<%=temp.getId_Via()%>"><%=temp.getNombre()%></option>
                                                                                    <%}%>

										  </select><input name="lugar" autocomplete="off" type="text" onkeypress="javascript: return BloquearComa(event)" class="text" style="width:200px"/>
                                            <font color="red">*</font>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td class="label">Placa</td>
                                            <td class="input"><input name="placa" type="text" onkeypress="javascript: return BloquearComa(event)" maxlength="6"  class="text" onBlur="buscarPlaca(this)"/>                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label">Licencia Transito</td>
                                            <td class="input"><input name="licenciaTransito" id="licenciaTransito" type="text"  class="text" onKeyPress="return soloNumeros(event)"/></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Clase Vehiculo </td>
                                            <td class="input"><select name="clase" class="select">
                                                    <option value="0" ><-Seleccione-></option>
                                                    <% List list2 = modelo.listadoParametros(1);
                            Iterator it2 = list2.iterator();
                            while (it2.hasNext()) {
                                parametro = (Parametro) it2.next();%>
                                                    <option value="<%=parametro.getCodigo()%>"> <%=parametro.getNombre()%> </option>
                                                    <%}%>
                                                </select>                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label">Servicio Vehiculo</td>
                                            <td class="input"><select name="servicio" class="select">
                                                    <option value="0" ><-Seleccione-></option>
                                                    <%  List listServicio = modelo.listadoParametros(3);
                            Iterator itr = listServicio.iterator();
                            while (itr.hasNext()) {
                                parametro = (Parametro) itr.next();%>
                                                    <option value="<%=parametro.getCodigo()%>"> <%=parametro.getNombre()%> </option>
                                                    <%}%>
                                                </select>                                            </td>
                                        </tr>

                                        <tr>
                                             <td class="label">Tipo Pasajeros</td>
                                            <td class="input"><select name="tipoPasajeros" class="select">
                                                    <option value="0" ><-Seleccione-></option>
                                                    <% List pasajeros = modelo.listadoParametros(356);
                            Iterator pj = pasajeros.iterator();
                            while (pj.hasNext()) {
                                parametro = (Parametro) pj.next();%>
                                                    <option value="<%=parametro.getCodigo()%>"> <%=parametro.getNombre()%> </option>
                                                    <%}%>
                                                </select>                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>

                                        <tr>
                                            <td colspan="5" align="center">
                                                <label style="font-size:9px; text-align:center; color:#FFFFFF">---------------------------------------------------------------</label></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Tipo Documento </td>
                                            <td class="input"><select name="tipoDocumento" id="tipoDocumento" class="select" onChange="consultaPersona(this.id, 'documento', 'nombres')">
                                                    <%  List lista_id = modelo.listadoParametros(5);
                            Iterator itrtor = lista_id.iterator();
                            while (itrtor.hasNext()) {
                                parametro = (Parametro) itrtor.next();%>
                                                    <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
                                                    <%  }%>
                                                </select>                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label">Numero Documento</td>
                                            <td class="input"><input name="documento" type="text" id="documento" class="text" onKeyPress="return soloNumeros(event)" onBlur="consultaPersonaINF('tipoDocumento', this.id, 'nombres');buscarLicenciaConduccion()"/></td>
                                            <td><font color="red">*</font></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Nombre y Apellido </td>
                                            <td colspan="4"><input name="nombres" type="text" id="nombres" class="text" style="width:420px" readonly="true"/></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Direccion infractor</td>
                                            <td colspan="4"><input name="dir_infractor" type="text" id="dir_infractor" class="text" style="width:420px" readonly="true"/></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Email</td>
                                            <td class="input"><input name="email" type="text" class="text"/>                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label">Telefono</td>
                                            <td class="input"><input name="telefono" id="telefono" type="text"  class="text"/></td>
                                        </tr>
                                        <tr>
                                            <td colspan="5" align="center">
                                                <label style="font-size:9px; text-align:center; color:#FFFFFF">---------------------------------------------------------------</label></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Tipo Infractor </td>
                                            <td class="input"><select name="tipoInfractor" id="tipoInfractor" class="select">
                                                    <% List L_tipo_inf = modelo.listadoParametros(6);
                            Iterator itt = L_tipo_inf.iterator();
                            while (itt.hasNext()) {
                                parametro = (Parametro) itt.next();%>
                                                    <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
                                                    <%}%>
                                                </select>                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label">Numero Infraccion</td>
                                            <td class="input">
                                                <input name="infraccion" id="infraccion" type="text" class="date" readonly/>
                                                <input name="button" type="button" id="binfraccion" class="bdate" value="<<" onClick="listaInfraccion()"/>
                                            </td>
                                            <td><font color="red">*</font></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Nombre Infraccion </td>
                                            <td colspan="4"><textarea rows="5" name="nombreInfraccion" type="text" class="text" readonly style="font-size:11px; width:420px; height:50px"></textarea>                                            </td>
                                        </tr>

                                        <tr>
                                            <td class="label">Lic.Conduccion</td>
                                            <td class="input"><input name="licenciaConduccion" type="text" id="lic_conduccion" class="text" onKeyPress="return soloNumeros(event)"/></td>
                                            <td>&nbsp;</td>
                                            <td class="label">Fecha Vencimiento </td>
                                            <td class="input"><input name="fechaVencimiento" type="text" id="fechaVencimiento" class="date" style="background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onKeyUp="mascara(this,'/',true)" maxlength="10"/>
                                                <input name="button" type="button" id="bfechaVencimiento" class="bdate" value="<<"/>
                                                <script type="text/javascript">
                                                    Calendar.setup({
                                                        inputField     :    "fechaVencimiento",      // id del campo de texto
                                                        ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                                        button         :    "bfechaVencimiento"   // el id del botón que lanzará el calendario
                                                    });
                                                </script>                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label">Categoria</td>
                                            <td class="input"><select name="categoria" id="categoria" class="select">
                                                    <option value="0" ><<--Seleccione-->></option>
                                                    <% java.util.List categorias = modelo.listadoParametros(221);
                            for (int i = 0; i < categorias.size(); i++) {
                                parametro = (Parametro) categorias.get(i);%>
                                                    <option value="<%=parametro.getNombre()%>"><%= parametro.getNombreCorto()%> </option>
                                                    <%  }%>
                                                </select>                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label">Sede Expedicion </td>
                                            <td class="input"><select name="sedeExpedicion" id="sedeExpedicion" class="select">
                                                    <option value="0" ><<--Seleccione-->></option>
                                                    <%  List sedes = modelo.consultarSedes();
                            itt = sedes.iterator();
                            while (itt.hasNext()) {
                                sede = (Sede) itt.next();%>
                                                    <option value="<%=sede.getId_sede()%>"><%=sede.getCodigo() + " - " + sede.getNombre_corto()%></option>
                                                    <%}%>
                                                </select>                                            </td>
                                        </tr>

                                        <tr>
                                            <td colspan="5" align="center">
                                                <label style="font-size:9px; text-align:center; color:#FFFFFF">---------------------------------------------------------------</label></td>
                                        </tr>

                                        <tr>
                                            <td class="label">Tipo Documento </td>
                                            <td class="input"><select name="tipoDocumentoPro" id="tipoDocumentoPro" class="select" onChange="consultaPersona(this.id, 'documento', 'nombres')">
                                                    <%  List lista_Pro = modelo.listadoParametros(5);
                            Iterator itrtor2 = lista_Pro.iterator();
                            while (itrtor2.hasNext()) {
                                parametro = (Parametro) itrtor2.next();%>
                                                    <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
                                                    <%  }%>
                                                </select>                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label">Documento Propietario</td>
                                            <td class="input"><input name="documentoPro" type="text" id="documentoPro" class="text" onKeyPress="return soloNumeros(event)" onBlur="consultaPersona('tipoDocumento', this.id, 'nombres');buscarLicenciaConduccion()"/>                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5" align="center">
                                                <label style="font-size:9px; text-align:center; color:#FFFFFF">---------------------------------------------------------------</label></td>
                                        </tr>

                                        <tr>
                                            <td class="label">Nombre y Apellido </td>
                                            <td colspan="4"><input name="nombresPro" type="text" id="nombresPro" class="text" style="width:420px" readonly="true"/></td>
                                        </tr>

                                        <tr>
                                            <td colspan="5" align="center">
                                                <label style="font-size:9px; text-align:center; color:#FFFFFF">---------------------------------------------------------------</label></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Nit Empresa</td>
                                            <td class="input"><input name="nitEmpresa" type="text" class="text"/>                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label">Tarjeta Operación</td>
                                            <td class="input"><input name="toperacion" id="toperacion" type="text"  class="text"/></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Nombre de la Empresa</td>
                                            <td colspan="4"><input name="nombreEmpresa" type="text" id="nombreEmpresa" class="text" style="width:420px" readonly="true"/></td>
                                        </tr>
                                        <tr>
                                            <td colspan="5" align="center">
                                                <label style="font-size:9px; text-align:center; color:#FFFFFF">---------------------------------------------------------------</label></td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                                    <tr>
                                                        <td class="label">Placa Agente </td>
                                                        <td><input type="text" name="placaAgente" onKeyPress="return soloNumeros(event)" onBlur="buscarAgente(this)" class="text"/><font color="red">*</font></td>
                                                        <td align="left">&nbsp;</td>
                                                        <td colspan="2"><input name="nombreAgente" type="text" class="text" readonly="true" autocomplete="off" style="width:300px"/></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="5" align="center">
                                                        <label style="font-size:9px; text-align:center; color:#FFFFFF">---------------------------------------------------------------</label></td>
                                                    </tr>

                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label">Parqueadero</td>
                                            <td colspan="4">
                                                <select id="parqueaderos" name="parqueaderos" class="select" disabled style="width:420px" >
                                                    <option value="0" ><- Seleccione Parqueadero -></option>
                                                    <% sede = (Sede) session.getAttribute("sede");
                                                       java.util.List listaP = listaP = modelo.listarPatios(sede.getId_sede());
                                                       for (int i = 0; i < listaP.size(); i++) {
                                                           Patio patio = (Patio) listaP.get(i);%>
                                                           <option  value="<%=patio.getId_patio()%>"><%=patio.getNombre()%></option>
                                                    <% }%>
                                                </select>                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label">Grua Numero</td>
                                            <td class="input"><input name="gruaNumero" type="text" class="text"/></td>
                                            <td>&nbsp;</td>
                                            <td class="label">Placa Grua</td>
                                            <td class="input"><input name="placaGrua" id="placaGrua" type="text"  class="text"/></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Tipo Documento </td>
                                            <td class="input"><select name="tipoDocumentoTest" id="tipoDocumentoTest" class="select" onChange="consultaPersona(this.id, 'documento', 'nombres')">
                                                    <%  List lista_test = modelo.listadoParametros(5);
                            Iterator itrtor3 = lista_test.iterator();
                            while (itrtor3.hasNext()) {
                                parametro = (Parametro) itrtor3.next();%>
                                                    <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
                                                    <%  }%>
                                                </select>                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label">Documento Testigo</td>
                                            <td class="input"><input name="documentoTest" type="text" id="documentoTest" class="text" onKeyPress="return soloNumeros(event)" onBlur="consultaPersona('tipoDocumento', this.id, 'nombres');buscarLicenciaConduccion()"/>                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label">Nombre y Apellido </td>
                                            <td colspan="4"><input name="nombresTest" type="text" id="nombresTest" class="text" style="width:420px" readonly="true"/></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Direccion Testigo</td>
                                            <td colspan="4"><input name="dir_testigo" type="text" id="dir_testigo" class="text" style="width:420px" readonly="true"/></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Email</td>
                                            <td class="input"><input name="emailTest" type="text" class="text"/>                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label">Telefono</td>
                                            <td class="input"><input name="telefonoTest" id="telefonoTest" type="text"  class="text"/></td>
                                        </tr>
                                        <tr>
                                             <td colspan="5" align="center">
                                             <label style="font-size:9px; text-align:center; color:#FFFFFF">---------------------------------------------------------------</label></td>
                                        </tr>

                                                    <tr>
                                                        <td width="20%" align="center" class="check"> Accidente
                                                            <input name="accidente" type="checkbox" id="accidente" value="1" />                                                        </td>
                                                        <td width="20%" align="center" class="check"> Inmovilizacion
                                                            <input name="inmovilizacion" type="checkbox" id="inmovilizacion" value="1" onClick="activarParqueadero(this)" />                                                        </td>
                                                        <td width="20%" align="center" class="check"> Fuga
                                                            <input name="fuga" type="checkbox"  value="1" id="fuga" />                                                        </td>
                                                        <td width="20%" align="center" class="check">Electronico
                                                            <input name="electronico" type="checkbox" id="electronico" value="1" onClick="activarElectronico(this)"/>                                                        </td>
                                                        <td width="20%" align="center" class="check">Polca
                                                            <input name="polca" type="checkbox" id="polca" value="1" checked/>                                                        </td>
                                                        <td width="20%" align="center" class="check">Firmado
                                                            <input name="firma" type="checkbox" id="firma" value="1" checked/>                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6" align="center">
                                                        <label style="font-size:9px; text-align:center; color:#FFFFFF">---------------------------------------------------------------</label></td>
                                                    </tr>
                                        <tr>
                                            <td class="label"> Fecha Notificacion</td>
                                            <td colspan="2" class="input"><input type="text" disabled name="Fecha_notificacion" id="Fecha_notificacion" class="date"  style="background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onKeyUp="mascara(this,'/',true)" maxlength="10" />
                                        <button name="bfecha2" type="button" id="bfecha2" class="bdate" ><img src="../html/images/calendario.png" width="19" height="18"/></button>
                                          <!--      <input name="bfecha" type="button" id="bfecha" class="bdate" value="<<"/> -->
                                                <script type="text/javascript">
                                                    Calendar.setup({
                                                        inputField     :    "Fecha_notificacion",      // id del campo de texto
                                                        ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                                        button         :    "bfecha2"   // el id del botón que lanzará el calendario
                                                    });
                                                </script>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label"> Observaciones</td>
                                            <td colspan="4"><input name="observaciones" onkeypress="javascript: return BloquearComa(event)" type="text" id="observaciones" class="text" style="width:420px"/></td>
                                        </tr>
                                    </table></td>
                            </tr>
                            <tr>
                                <td colspan="5" align="center">
<button type="submit" name="guardar" id="guardar" class="check" disabled="disabled">Guardar Comparendo <img src="../html/images/guardar.png" width="19" height="18"/></button>
                            <!--        <input type="submit" name="guardar" id="guardar" class="check" disabled value="Guardar Comparendo" />  -->
                                    <iframe src="#" name="proceso" id="proceso" style="display:none"></iframe>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </form>
            </div>
        </div>
    </body>
</html>
<%   }
                    } else {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<% }
                } else {%>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%            }
            } catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="2"></jsp:param>
    <jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param>
</jsp:forward>
<%  }%>

