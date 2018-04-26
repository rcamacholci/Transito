<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Documento sin t&iacute;tulo</title>
</head>

<body>
<table width="859" border="1" cellpadding="1">
  <tr>
    <th width="141" scope="row">Codigo tramite </th>
    <td width="144">
      <label>
      <input name="txtCodigoTramite" type="text" disabled="disabled" id="txtCodigoTramite" title="CodigoTramite" readonly="true" />
        </label>
     </td>
    <td width="120">Estado Tramite </td>
    <td width="144"><form id="form2" name="form2" method="post" action="">
      <select name="slctEstadoTramite" id="slctEstadoTramite">
        <option>&lt;--&gt;</option>
      </select>
    </form>    </td>
    <td width="122">Orden de ejecucion </td>
    <td width="148"><input name="txtOrdeEjecucion" type="text" id="txtOrdeEjecucion" readonly="true" /></td>
  </tr>
  <tr>
    <th scope="row">Declaracion Importacion </th>
    <td><input name="txtDeclaracionImportacion" type="text" id="txtDeclaracionImportacion" readonly="true" /></td>
    <td>Tipo de Registro </td>
    <td><select name="slctTipoRegistro" id="slctTipoRegistro">
      <option selected="selected">&lt;--&gt;</option>
            </select></td>
    <td>Fecha Ingreso </td>
    <td><input name="txtFechaIngreso" type="text" id="txtFechaIngreso" readonly="true" /></td>
  </tr>
  <tr>
    <th scope="row">Vin </th>
    <td><input name="txtDeclaracionImportacion2" type="text" id="txtDeclaracionImportacion2" readonly="true" /></td>
    <td>Serie</td>
    <td><input name="txtDeclaracionImportacion3" type="text" id="txtDeclaracionImportacion3" readonly="true" /></td>
    <td>Chasis</td>
    <td><input name="txtDeclaracionImportacion4" type="text" id="txtDeclaracionImportacion4" readonly="true" /></td>
  </tr>
  <tr>
    <th scope="row">Clase Maquinaria </th>
    <td><select name="select" id="select">
      <option selected="selected">&lt;--&gt;</option>
    </select></td>
    <td>Registro Motor </td>
    <td><input name="txtDeclaracionImportacion5" type="text" id="txtDeclaracionImportacion5" readonly="true" /></td>
    <td>Tipo Cabina </td>
    <td><select name="select3" id="select3">
      <option selected="selected">&lt;--&gt;</option>
    </select></td>
  </tr>
  <tr>
    <th scope="row">Combustible</th>
    <td><select name="select2" id="select2">
      <option selected="selected">&lt;--&gt;</option>
    </select></td>
    <td>Partida arancelaria </td>
    <td><input name="txtDeclaracionImportacion53" type="text" id="txtDeclaracionImportacion53" readonly="true" /></td>
    <td>Color Maquinaria </td>
    <td><input name="txtDeclaracionImportacion52" type="text" id="txtDeclaracionImportacion52" readonly="true" /></td>
  </tr>
  <tr>
    <th scope="row">Tipo Documento </th>
    <td><select name="select4" id="select4">
      <option selected="selected">&lt;--&gt;</option>
    </select></td>
    <td>Documento</td>
    <td><input name="txtDeclaracionImportacion532" type="text" id="txtDeclaracionImportacion532" readonly="true" /></td>
    <td>Nombre</td>
    <td><input name="txtDeclaracionImportacion533" type="text" id="txtDeclaracionImportacion533" readonly="true" /></td>
  </tr>
  <tr>
    <th scope="row">Factura </th>
    <td><input name="txtDeclaracionImportacion535" type="text" id="txtDeclaracionImportacion535" readonly="true" /></td>
    <td>Valor factura </td>
    <td><input name="txtDeclaracionImportacion534" type="text" id="txtDeclaracionImportacion534" readonly="true" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <th scope="row">Tipo Documento soporte </th>
    <td><select name="select4" id="select4">
        <option selected="selected">&lt;--&gt;</option>
    </select></td>
    <td>Documento soporte </td>
    <td><input name="txtDeclaracionImportacion532" type="text" id="txtDeclaracionImportacion532" readonly="true" /></td>
    <td>Fecha Soporte </td>
    <td><input name="txtDeclaracionImportacion533" type="text" id="txtDeclaracionImportacion533" readonly="true" /></td>
  </tr>
  <tr>
    <th scope="row">Espedido por </th>
    <td><input name="txtDeclaracionImportacion535" type="text" id="txtDeclaracionImportacion535" readonly="true" /></td>
    <td>Valor factura </td>
    <td><input name="txtDeclaracionImportacion534" type="text" id="txtDeclaracionImportacion534" readonly="true" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <th scope="row">&nbsp;</th>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>

</body>
</html>
