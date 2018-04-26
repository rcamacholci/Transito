<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Documento sin t&iacute;tulo</title>
</head>
<body>
<form name="form" id="form" method="post">
<table align="center" border="0" cellpadding="1" width="100%">
<tr>
	<td>Tipo&nbsp;Referencia</td>
	<td>
	<select name="Tref" id="Tref" style="width:auto">
	<option>V.I.N</option>
	<option>Serie</option>
	<option>Motor</option>
	</select>
	</td>
	<td>Referencia</td>
	<td><input type="text" name="Ref" id="Ref" /></td>
	<td><input type="button" value="Consultar"  /></td>
	
</tr>
<tr>
    <td colspan="5">
        <iframe name="target" id="target" src="ConsultarTramiteRNMA.jsp" width="100%" height="600"/>
    </td>
</tr>
</table>
</form>
</body>
</html>
