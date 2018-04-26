<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html;charset=iso-8859-1" language="java"  errorPage="" %>
<%
  try {
    if (session.getAttribute("model") != null) {
      boolean permisoA = ((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%--
    Document   : editarDatosVehiculo
    Created on : 23-feb-2010, 10:56:07
    Author     : Jorge Lopez
--%>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Vehiculo</title>
    <style type="text/css">
      <!--
      .Estilo8 {color: #333333; font-weight: bold; font-size: 12px; }
      .Estilo13 {color: #333333}
      -->
    </style>
    <script src="../html/scripts/motorAjax.js" type="text/javascript"></script>
    <script src="../html/scripts/editar_vehiculo.js" type="text/javascript"></script>
    <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
    <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
    <script src="../html/scripts/calendar.js" type="text/javascript"></script>
    <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
    <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>


    <style type="text/css">
      <!--
      .style1 {font-family: Tahoma}
      .style2 {font-size: 12px}
      .Estilo15 {
        color: #FFFFFF;
        font-family: Tahoma;
        font-weight: bold;
        font-size: 12px;
      }
      .Estilo16 {color: #FFFFFF}
      .Estilo18 {font-weight: bold}
      -->
    </style>
  </head>
  <%@ page import="modelo.*"%>
  <%@page import="java.util.*"%>
  <%
    Model modelo = (Model) session.getAttribute("model");
    try {
      Usuario usuario = (Usuario) session.getAttribute("usuario");
      boolean infoEdit = false;
      if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("modificarInformacionPrincipalVehiculo")) {
        infoEdit = true;
      }
      String placa = "";

      int i;
      if (request.getParameter("id") != null) {
        if (request.getParameter("id").equals("0")) {
          placa = request.getParameter("placa");
        } else {
          placa = session.getAttribute("placa") + "";
        }
        if (placa != null) {
          Vehiculo vehiculo = new Vehiculo();
          vehiculo = modelo.consultarVehiculo(placa.toUpperCase());

          if (vehiculo != null) {
            session.setAttribute("vehiculo", vehiculo);
            session.setAttribute("placa", vehiculo.getPlaca());
            Sede sede = modelo.consultarSede(vehiculo.getFk_sede());
            java.util.HashMap caract = modelo.listarCaracteristicasVehiculo(vehiculo.getPlaca().toUpperCase());
            java.util.HashMap especif = modelo.listarEspecificacionesVehiculo(vehiculo.getPlaca().toUpperCase());
            String carroceria = caract.get("2") != null ? modelo.consultarParametro(Integer.parseInt(caract.get("2").toString()), 2).getNombre() : "";
            Parametro param = modelo.consultarParametro(Integer.parseInt(vehiculo.getClase_vehiculo() + ""), 1);
            Parametro param2 = modelo.consultarParametro(Integer.parseInt(vehiculo.getServicio() + ""), 3);
            Parametro param3 = modelo.consultarParametro(Integer.parseInt(vehiculo.getEstado() + ""), 66);
            String modalidad = "";
            if (caract.get("324") != null) {
              modalidad = modelo.consultarParametroName(324, Integer.parseInt(caract.get("324").toString()));
            }
            java.util.List lista_colores = modelo.lista_historico_color(vehiculo.getPlaca());
            String color = "";
            for (int l = 0; l < lista_colores.size(); l++) {
              Historico_Color hc = (Historico_Color) lista_colores.get(l);
              if (hc.getFecha_fin() == null) {
                Color cl = modelo.getColor(hc.getFk_color());
                color += cl.getNombre() + " " + (hc.getGama() != null ? hc.getGama() : "") + " ";
              }
            }

            Licencia_Transito licenciaTransito = modelo.consultarLicenciaTransito(vehiculo.getId_vehiculo());
            String numeroLt = "";
            String fechaLt = "";
            if (licenciaTransito != null) {
              numeroLt = licenciaTransito.getNumero();
              fechaLt = new java.text.SimpleDateFormat("dd/MM/yyyy").format(licenciaTransito.getFecha_expedicion());
            }
            Linea linea = modelo.consultaLinea(vehiculo.getPlaca().toUpperCase());
            Marca marca = null;//modelo.consultaMarca(vehiculo.getPlaca().toUpperCase());


  %>
  <body>
    <form action="actualizarVehiculo.jsp" method="get" name="formEditarV">
      <% if (permisoA) { %>
      <fieldset>
        <table width="80%" border="0" align="center">
          <tr style="border:none; background:url(../html/images/inicio_3.png)">
            <td colspan="6" align="center" valign="middle"><span class="Estilo18 Estilo15">INFORMACION DEL VEHICULO</span></td>
          </tr>
          <tr>
            <td width="13%"><span class="Estilo8 style1">PLACA</span></td>
            <td width="4%">&nbsp;</td>
            <td  width="30%"><span class="Estilo8">
                <%if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("editarPlaca")) {%>
                <input type="text" name="textfield" value="<%=vehiculo.getPlaca()%>" style="width:165px; color:#333333; text-align:center"/>
                <%} else {%>
                <input type="text" readonly name="textfield" value="<%=vehiculo.getPlaca()%>" style="width:165px; color:#333333; text-align:center"/>
                <%}%>
              </span></td>
            <td width="6%"><span class="Estilo8 style1">ESTADO</span></td>
            <td width="4%">&nbsp;</td>
            <td width="43%"><select name="estado" id="estado" style="width:200px; font-size:13px" >
                <option value="0"><<--Seleccione Estado-->></option>
                <% java.util.List estados = modelo.listadoParametros(66);
                  for (i = 0; i < estados.size(); i++) {
                    Parametro parametro = (Parametro) estados.get(i);
                    if (vehiculo != null) {
                      if (vehiculo.getEstado() == parametro.getCodigo()) {%>
                <option value="<%=parametro.getCodigo()%>" selected="selected"><%= parametro.getNombre()%> </option>
                <%	} else if (infoEdit) {%>
                <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                <%          }
                    }
                  } %>
              </select></td>
          </tr>
          <tr>


            <td><span class="Estilo6"> <span class="Estilo2"> <span class="style2"> <span class="style1"> <span class="Estilo13">
                        <label><b>MARCA</b></label>
                      </span> </span> </span> </span> </span></td>
            <td><input name="tipoMarca" type="text" id="tipoMarca" style="width:35px;color:#333333; text-align:center" onblur="verInput(this, 'marcas')" <%--=state--%>/></td>
            <td>
              <script type="text/javascript" language="javascript">document.getElementById('tipoMarca').value = 0;</script>
              <select name="marcas" id="marcas" onchange="verCombo(this, 'Marca')" style="width:170px; font-size:13px" >
                <option value="0"><<--Seleccione Marca-->></option>
                <%  long marca_cod = 0;
                  long linea_cod = 0;
                  long tipoL = 0;
                  Parametro chkClasevehiculo = modelo.consultarParametro((int) vehiculo.getClase_vehiculo(), 1);

                  if (chkClasevehiculo.getNombreCorto().equals("5")) {
                    tipoL = 2;
                    modelo.getLineaRNRYSMarca(vehiculo.getFk_linea(), vehiculo.getFk_marca());
                    modelo.getMarcaRNRYS(vehiculo.getFk_marca());
                  } else if (chkClasevehiculo.getNombreCorto().equals("4")) {

                  } else {
                    linea = modelo.consultaLinea(vehiculo.getPlaca().toUpperCase());
                    marca = modelo.consultaMarca(vehiculo.getPlaca().toUpperCase());
                  }
                  if (chkClasevehiculo.getNombreCorto().equals("4")) {
                    tipoL = 3;
                    Marcas_maquinaria marca_veh = null;
                    java.util.List marcas = modelo.listadoMarcasRNMA();
                    if (vehiculo != null) {
                      Linea_maquinaria lm = modelo.getLineaMaquinaria(vehiculo.getFk_linea());
                      if (lm != null) {
                        marca_veh = modelo.getMarcaMaquinaria(lm.getCodigo_marca());
                      if (marca_veh != null) {
                          marca_cod = marca_veh.getCodigo_marca();
                        }
                      }//end if

                      linea_cod = vehiculo.getFk_linea();
                    }
                    for (i = 0; i < marcas.size(); i++) {
                      Marcas_maquinaria marc = (Marcas_maquinaria) marcas.get(i);
                      if (marca_cod == marc.getCodigo_marca()) {%>
                <option value="<%=marc.getCodigo_marca()%>" selected="selected"><%= marc.getDescripcion()%> </option>
                <script type="text/javascript" language="javascript">document.getElementById('tipoMarca').value = <%=marc.getCodigo_marca()%>;</script>
                <%  } else if (infoEdit) {%>
                <option value="<%=marc.getCodigo_marca()%>"><%= marc.getDescripcion()%> </option>
                <%         }
                  }
                %>
                <script type="text/javascript" language="javascript">document.getElementById('tipoL').value = <%=tipoL%>;</script>
                <%
                } else if (true) {
                  tipoL = 1;
                  Marca marca_veh = null;
                  java.util.List marcas = modelo.listadoMarcas();
                  if (vehiculo != null) {
                    marca_veh = modelo.consultaMarca(vehiculo.getPlaca().toUpperCase());
                    if (marca_veh != null) {
                      marca_cod = marca_veh.getCodigo();
                    }
                    linea_cod = vehiculo.getFk_linea();
                  }
                  for (i = 0; i < marcas.size(); i++) {
                    marca = (Marca) marcas.get(i);
                    if (marca_cod == marca.getCodigo()) {%>
                <option value="<%=marca.getCodigo()%>" selected="selected"><%= marca.getNombre()%> </option>
                <script type="text/javascript" language="javascript">document.getElementById('tipoMarca').value = <%=marca.getId_marca()%>;</script>
                <%  } else if (infoEdit) {%>
                <option value="<%=marca.getCodigo()%>"><%= marca.getNombre()%> </option>
                <%         }
                    }
                  }
                %>
              </select>

              <input type="hidden" id="marca_cod" name="marca_cod" value="<%=marca_cod%>" />
              <input type="hidden" id="tipoL" name="tipoL" value="<%=tipoL%>" />
              <input type="hidden" id="linea_cod" name="linea_cod" value="<%=linea_cod%>" />				</td>
            <td><span class="Estilo2"> <span class="Estilo6">
                  <label class="Estilo8 style1"><b>LINEA</b></label>
                </span> </span></td>
            <td>
              <input name="tipoLinea" type="text" id="tipoLinea" style="width:35px;color:#333333; text-align:center" value="<%=linea_cod%>" onblur="verInput(this, 'lineas')" <%--=state--%>/></td>
            <td>
              <div id="lineasdiv" style="width:150px"></div>				</td>
            <script language="javascript" type="text/javascript">verCombo(document.getElementById('marcas'), 'Marca');</script>
          </tr>

          <tr align="left">
            <td width="13%"><span class="Estilo6"> <span class="Estilo2">
                  <label class="Estilo13 style1 style2"><b>CLASE</b></label>
                </span> </span></td>
            <td width="4%" scope="col"><input name="tipoClase" type="text" id="tipoClase" style="width:35px;color:#333333; text-align:center" onblur="verInput(this, 'clases')" /></td>
            <td width="30%" scope="col"><strong>
                <select name="clases" id="clases" onchange="verCombo(this, 'Clase')" style="width:170px; font-size:13px" >
                  <option value="0"><<--Seleccione Clase-->></option>
                  <%  java.util.List clases = modelo.listadoParametros(1);

                    for (i = 0; i < clases.size(); i++) {
                      Parametro parametro = (Parametro) clases.get(i);
                      if (vehiculo != null) {
                        if (vehiculo.getClase_vehiculo() == parametro.getCodigo()) {%>
                  <option  value="<%=parametro.getCodigo()%>" selected="selected"><%= parametro.getNombre()%></option>
                  <script type="text/javascript" language="javascript">document.getElementById('tipoClase').value = <%=parametro.getCodigo()%>;</script>
                  <%   } else if (infoEdit) {%>
                  <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                  <%          }
                  } else {%>
                  <script type="text/javascript" language="javascript">document.getElementById('tipoClase').value = <%=((Parametro) clases.get(0)).getCodigo()%>;</script>
                  <option  value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                  <%}
                    } %>
                </select>
              </strong></td>

            <td width="6%" scope="col"><span class="Estilo6"> <span class="Estilo2">
                  <label class="Estilo8 style1"><b>SERVICIO</b></label>
                </span> </span></td>
            <td width="4%" scope="col"><input name="tipoServicio" type="text" id="tipoServicio" style="width:35px;color:#333333; text-align:center" onblur="verInput(this, 'servicios')" /></td>
            <td width="43%" scope="col">
              <select name="servicios" id="servicios" onchange="document.getElementsByName('tipoServicio')[0].value = this.value" style="width:200px; font-size:13px" >
                <option value="0"><<--Seleccione Servicio-->></option>
                <% java.util.List servicios = modelo.listadoParametros(3);

                  for (i = 0; i < servicios.size(); i++) {
                    Parametro parametro = (Parametro) servicios.get(i);
                    if (vehiculo != null) {
                      if (vehiculo.getServicio() == parametro.getCodigo()) {%>
                <option value="<%=parametro.getCodigo()%>" selected="selected"><%= parametro.getNombre()%> </option>
                <script type="text/javascript" language="javascript">document.getElementById('tipoServicio').value = <%=parametro.getCodigo()%>;</script>
                <%	} else if (infoEdit) {%>
                <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                <%          }
                } else {%>
                <script type="text/javascript" language="javascript">document.getElementById('tipoServicio').value = <%=((Parametro) servicios.get(0)).getCodigo()%>;</script>
                <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                <%  }
                  }%>
              </select></td>
          </tr>
          <tr>
            <td><span class="Estilo8 style1">FECHA&nbsp;MATRICULA</span></td>
            <td><input name="Input" type="button" id="Bfecha_mat" value="<<" style="width:35px" /></td>
            <td><input type="text" name="fecha_mat"  style="width:170px;text-align:center"id="fecha_mat" value="<%=vehiculo.getFecha_matricula() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(vehiculo.getFecha_matricula()) : ""%>" onkeyup="mascara(this, '/', true)" maxlength="10"/></td>
            <td><span class="Estilo8 style1">MODELO </span></td>
            <td>&nbsp;</td>
            <td colspan="0"><select name="modelo" style="width:200px; font-size:13px">
                <%
                  int AnhoActual = Calendar.getInstance().get(Calendar.YEAR);
                  String selected = "";

                  for (i = AnhoActual + 1; i >= 1900; i--) {%>
                <option value="<%=i%>" <%=(i == vehiculo.getModelo() ? "selected" : "")%> ><%=i%></option>
                <%                             }%>
              </select></td>
          </tr>
          <tr>
            <td><span class="Estilo8 style1">L. TRANSITO </span></td>
            <td>&nbsp;</td>
            <td><script type="text/javascript">
              Calendar.setup({
                inputField: "fecha_mat", // id del campo de texto
                ifFormat: "%d/%m/%Y", // formato de la fecha, cuando se escriba en el campo de texto
                button: "Bfecha_mat"   // el id del bot?n que lanzar? el calendario
                        //onkeypress="return soloNumeros(event)"
              });
              </script>
              <input name="ltransito" type="text" size="4" value="<%=numeroLt%>"  style="width:165px"   maxlength="11"/></td>
            <td><span class="Estilo8 style1">F. EXPED </span></td>
            <td><input name="Bfecha_mat" type="button" id="Bfecha_mat" value="&lt;&lt;" style="width:35px" /></td>
            <td><input type="text" name="ftransito"  style="width:200px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" id="ftransito" value="<%=fechaLt%>" onkeyup="mascara(this, '/', true)" maxlength="10"/></td>
            <script type="text/javascript">
              Calendar.setup({
                inputField: "ftransito", // id del campo de texto
                ifFormat: "%d/%m/%Y", // formato de la fecha, cuando se escriba en el campo de texto
                button: "Bfecha_mat"   // el id del bot?n que lanzar? el calendario
              });
            </script>
          </tr>
        </table>
      </fieldset>
      </br>
      <fieldset>
        <table width="80%" border="0" id="panelImportacion" align="center" >
          <tr style="border:none; background:url(../html/images/inicio_3.png)">
            <td colspan="6" align="center" valign="middle"><span class="Estilo8 style1 Estilo16">INFORMACION DE IMPORTACION</span></td>
          </tr>
          <tr align="center">
            <td width="14%"><span class="Estilo6"> <span class="Estilo2">
                  <label class="Estilo8 style1"><b>T.&nbsp;IMPORTACION</b></label>
                </span> </span></td>
            <td width="5%" scope="col"><input name="tipoImportacion" type="text" id="tipoImportacion" style="width:35px;color:#333333; text-align:center" onblur="verInput(this, 'tiposimportaciones')" /></td>
            <td width="25%">
              <select name="tiposimportaciones" id="tiposimportaciones" onchange="verCombo(this, 'Importacion')" style="width:170px;" >
                <option value="0"><<--Seleccione Tipo Imp.-->></option>
                <%  java.util.List tiposimportaciones = modelo.listadoParametros(51);
                  for (i = 0; i < tiposimportaciones.size(); i++) {
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
                  } %>
              </select>                 </td>
            <td width="14%" scope="col"><span class="Estilo8"> <span class="style1">
                  <label id="tipoD"><b>T.&nbsp;DOCUMENTO</b></label>
                </span>
                <label id="tipoE" style="display:none"><font face="Arial, Helvetica, sans-serif"><b>Entidad</b></font></label>
              </span></td><td width="6%" scope="col"><input name="tipoImpor" type="text" id="tipoImpor" style="width:35px;color:#333333; text-align:center" onblur="verInput(this, 'tiposimpor')" />
              <input name="tipoEntidad" type="text" id="tipoEntidad" style="width:35px;color:#333333;text-align:center" onblur="verInput(this, 'tiposentidades')" />                 </td>
            <td width="36%" align="left">
              <select name="tiposimpor" id="tiposimpor" onchange="verCombo(this, 'Impor')" style="width:200px;" >
                <option value="0"><<--Seleccione Tipo Doc.-->></option>
                <% java.util.List tiposimpor = modelo.listadoParametros(53);
                  for (i = 0; i < tiposimpor.size(); i++) {
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
                  } %>
              </select>
              <select name="tiposentidades" id="tiposentidades" onchange="verCombo(this, 'Entidad')" style="width:200px" >
                <option value="0"><<--Seleccione Tipo Ent.-->></option>
                <% java.util.List tiposentidades = modelo.listadoParametros(109);
                  for (i = 0; i < tiposentidades.size(); i++) {
                    Parametro parametro = (Parametro) tiposimpor.get(i);
                    if (vehiculo != null) {
                      if (vehiculo.getTipo_doc_importacion() == parametro.getCodigo()) {%>
                <option value="<%=parametro.getCodigo()%>" selected><%= parametro.getNombre()%> </option>
                <%		  } else {%>
                <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                <%   }
                } else {%>
                <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                <%	}
                  } %>
              </select>                 </td>
            <script language="javascript" type="text/javascript">verCombo(document.getElementById('tiposimportaciones'), 'Importacion');</script>
          </tr>
          <tr align="left">
            <td><span class="Estilo2"> <span class="Estilo6">
                  <label class="Estilo8 style1"><b>DEPARTAMENTO</b></label>
                </span> </span></td>
            <td><input name="tipoDepartamento" type="text" id="tipoDepartamento" style="width:35px;color:#333333; text-align:center" onblur="verInput(this, 'departamentos')" /></td>
            <td>
              <select name="departamentos" id="departamentos" onchange="verCombo(this, 'Departamento')" style="width:170px;" >
                <option value="0"><<--Seleccione Dept.-->></option>
                <%  int depto = 0;
                  Municipio muncp = null;
                  int cod_mun = 0;
                  java.util.List departamentos = modelo.crearListaDpto();
                  java.util.List municipios = new java.util.LinkedList();
                  if (vehiculo != null) {
                    if (vehiculo.getFk_divipo() != 0) {
                      muncp = modelo.consultarMunicipioDivipo(vehiculo.getFk_divipo());
                      municipios = modelo.crearListaMunicipios(muncp.getDepartamento());
                      depto = muncp.getDepartamento();
                    }
                  }
                  if (muncp != null) {
                    cod_mun = muncp.getCodigo();
                  }

                  for (i = 0; i < departamentos.size(); i++) {
                    Departamento departamento = (Departamento) departamentos.get(i);
                    if (depto == departamento.getId_departamento()) {%>
                <option value="<%=departamento.getId_departamento()%>" selected="selected"><%= departamento.getNombre()%> </option>
                <script type="text/javascript" language="javascript">document.getElementById('tipoDepartamento').value =<%=departamento.getId_departamento()%>;</script>
                <% } else {%>
                <option value="<%=departamento.getId_departamento()%>"><%= departamento.getNombre()%> </option>
                <% }

                  }%>
              </select></td>
            <td><span class="Estilo6"> <span class="Estilo8"> <span class="style1">
                    <label><b>CIUDAD</b></label>
                  </span> </span> </span></td>
            <td>
              <input name="tipoCiudad" type="text" id="tipoCiudad" style="width:35px;color:#333333; text-align:center" value="<%=cod_mun%>" onblur="verInput(this, 'ciudades')" /></td>
            <td><div class="Estilo4" id="ciudad" style="width:200px"></div></td>
            <script language="javascript" type="text/javascript">verCombo(document.getElementById('departamentos'), 'Departamento');</script>
          </tr>
          <tr align="left">
            <td><span class="Estilo6"> <span class="Estilo8 style1">
                  <label><b>DOCUMENTO</b></label>
                </span> </span></td>
            <td colspan="2"><% String documentoimp = "";
              if (vehiculo != null) {
                if (vehiculo.getDocumento_importacion() != null) {
                  documentoimp = vehiculo.getDocumento_importacion();
                }
              }%>
              <input name="documentoimp" type="text" id="documentoimp" style="width:200px;color:#333333; text-align:center" value="<%=documentoimp%>" /></td>
            <td><span class="Estilo6"> <span class="Estilo8 style1">
                  <label><b>FECHA</b></label>
                </span> </span></td>
            <td colspan="2">
              <input name="fechadoc" type="button" id="fechadoc" value="<<" style="width:35px" />
              <input type="text" name="fechadocumento" id="fechadocumento" style="width:130px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" value="<%=vehiculo.getFecha_importacion() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(vehiculo.getFecha_importacion()) : ""%>"  onkeyup="mascara(this, '/', true)" maxlength="10" />
              <script type="text/javascript">
                Calendar.setup({
                  inputField: "fechadocumento", // id del campo de texto
                  ifFormat: "%d/%m/%Y", // formato de la fecha, cuando se escriba en el campo de texto
                  button: "fechadoc"   // el id del bot?n que lanzar? el calendario
                });
              </script>                 </td>
          </tr>
        </table>
      </fieldset>
      </br>
      <% }
        if (permisoA || modelo.tienePermiso(usuario.getId_usuario(), 137)) {
      %>

      <fieldset>

        <table width="80%" border="0" id="panelOrganismos"  align="center">
          <tr style="border:none; background:url(../html/images/inicio_3.png)">
            <td colspan="6" align="center" valign="middle"><span class="style2 style1 Estilo16"><strong>INFORMACION DE RADICACION Y TRASLADO</strong></span></td>
          </tr>

          <tr>
            <td width="14%"><label class="Estilo8 style1"><b>ORGANISMO</b></label></td>

            <%
              Movimiento movimiento = new Movimiento();
              movimiento = modelo.ConsultarMovimientoVehiculo(vehiculo.getId_vehiculo());

              String disabled1 = "disabled";
              String disabled2 = "disabled";
              if (movimiento != null) {
                if (movimiento.getTipo_movimiento() == 1) {
                  disabled1 = "";
                } else if (movimiento.getTipo_movimiento() == 2) {
                  disabled1 = "";
                  disabled2 = "";
                }
              }
            %>
            <td width="5%"><input name="mov_sede" type="text" <%=disabled1%> onkeypress="return soloNumeros(event)" style="color:#333333; text-align:center; width:35px" onblur="cambiarSede(this.value, 'mov_sedes')" /></td>
            <td width="30%">



              <select name="mov_sedes"  style="width:185px" <%=disabled1%>  onchange="document.getElementsByName('mov_sede')[0].value = this.value" >
                <option value="0"><<--Seleccione Organismo-->></option>


                <%
                  java.util.List organismos = modelo.consultarSedes();
                  for (i = 0; i < organismos.size(); i++) {
                    sede = (Sede) organismos.get(i);
                    if (movimiento != null) {
                      if (movimiento.getFk_sede() == sede.getId_sede()) {%>
                <option  value="<%=sede.getId_sede()%>" selected> <%=sede.getNombre_corto()%> </option>
                <script language="javascript" type="text/javascript">
                  document.getElementsByName('mov_sede')[0].value = <%=sede.getId_sede()%>;</script>
                  <%   } else {%>

                <option value="<%=sede.getId_sede()%>"> <%=sede.getNombre_corto()%> </option>
                <%  }
                } else {%>
                <option value="<%=sede.getId_sede()%>"> <%=sede.getNombre_corto()%> </option>
                <%  }
                  }


                %>
              </select>                 </td>
            <td width="16%" class="Estilo8 style1" align="center"><span class="Estilo6"><span class="Estilo2 style1"><b>LICENCIA</b></span></span></td>
            <td width="35%"><input name="mov_numeroLicencia" <%=disabled1%> type="text"  style="width:200px" value="<%
              if (movimiento != null) {
                out.print(movimiento.getNumero_licencia() != null ? movimiento.getNumero_licencia() : "");
              }
                                   %>" /></td>
          </tr>
          <tr>
            <td class="Estilo8 style1">F.&nbsp;MOVIMIENTO</td>
            <td><input name="Bfecha_mov" type="button" <%=disabled2%> id="Bfecha_mov" value="<<" style="width:35px" /></td>
            <td><input type="text" name="mov_fecha"  id="fecha_mov" <%=disabled2%> style="width:180px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center"  value="<%
              if (movimiento != null) {
                if (movimiento.getFecha_movimiento() != null) {
                  out.print(new java.text.SimpleDateFormat("dd/MM/yyyy").format(movimiento.getFecha_movimiento()));
                }
              }

                       %>"  onkeyup="mascara(this, '/', true)" maxlength="10"/>
              <script type="text/javascript">
                Calendar.setup({
                  inputField: "fecha_mov", // id del campo de texto
                  ifFormat: "%d/%m/%Y", // formato de la fecha, cuando se escriba en el campo de texto
                  button: "Bfecha_mov"   // el id del bot?n que lanzar? el calendario
                });
              </script>		</td>

            <td class="Estilo8 style1" align="center">F. ENVIO </td>
            <td><input name="Bfecha_env" type="button" id="Bfecha_env" value="<<" <%=disabled2%> style="width:35px" />
              <input type="text" name="mov_fecha_env" id="fecha_env" <%=disabled2%> style="width:160px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat" value="<%
                if (movimiento != null) {
                  out.print(movimiento.getFecha_envio() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(movimiento.getFecha_envio()) : "");
                }
                     %>" onkeyup="mascara(this, '/', true)" maxlength="10"/>
              <script type="text/javascript">
                Calendar.setup({
                  inputField: "fecha_env", // id del campo de texto
                  ifFormat: "%d/%m/%Y", // formato de la fecha, cuando se escriba en el campo de texto
                  button: "Bfecha_env"   // el id del bot?n que lanzar? el calendario
                });
              </script>                 </td>
          </tr>
          <tr>
            <td class="Estilo8 style1">ESTADO</td>

            <td>&nbsp;</td>
            <td><select name="mov_estado" id="select" <%=disabled2%> onchange="" style="width:185px" >
                <option value="0"><<--Seleccione-->></option>
                <%

                  java.util.List estadosMov = modelo.listadoParametros(116);

                  for (i = 0; i < estadosMov.size(); i++) {
                    Parametro parametro = (Parametro) estadosMov.get(i);
                    if (movimiento != null) {
                      if (movimiento.getEstado_envio() == parametro.getCodigo()) {%>
                <option value="<%=parametro.getCodigo()%>" selected><%= parametro.getNombre()%> </option>
                <%} else {%>
                <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                <%    }
                    }
                  }


                %>
              </select></td>

            <td align="center"><span class="Estilo8 style1">NUMERO&nbsp;GUIA </span></td>
            <td><input name="mov_numeroguia" type="0" <%=disabled2%> style="width:200px" value="<%
              if (movimiento != null) {
                out.print(movimiento.getNumero_guia() != null ? movimiento.getNumero_guia() : "");
              }
                       %>" /></td>
          </tr>
          <tr>
            <td><span class="Estilo6"><span class="Estilo2 style1">
                  <label class="Estilo8"></label>
                  <span class="Estilo8 style1">RESPONSABLE</span></span></span></td>
            <td>&nbsp;</td>
            <td><input name="mov_respenvio" type="0" <%=disabled2%> style="width:180px" value="<%
              if (movimiento != null) {
                out.print(movimiento.getResponsable_envio() != null ? movimiento.getResponsable_envio() : "");
              }


                       %>" /></td>
            <td colspan=""><span class="Estilo6"><span class="Estilo2 style1">
                  <label class="Estilo8"></label>
                </span> </span></td>
            <td colspan="">&nbsp;</td>
          </tr>
        </table>
      </fieldset>



      <%     }
      } else {
        session.removeAttribute("placa");%>
      <script>
        alert("El vehiculo no se encuentra Registrado  <%=placa%>");
        window.href = "consultar_Vehiculo.jsp";
      </script>
      <%

              }
            }
          }

        } catch (Exception exc) {
          exc.printStackTrace();
        }
      %>

      <table align="center">

        <tr>
          <td>
            <input type="submit" value="Actualizar Vehiculo">
          </td>
          <td>
            <input type="button" value="Cancelar" onclick="document.location.href = 'verDatosVehiculo.jsp?id=1'">
          </td>
        </tr>

      </table>
    </form>
  </body>
</html>
<%
} else { %>
<script>
  window.parent.document.location.href = "../../index.jsp";
</script>  <%
  }
} catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
  }%>