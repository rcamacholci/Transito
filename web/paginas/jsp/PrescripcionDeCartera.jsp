<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<META http-equiv=Content-Type content="text/html; charset=windows-1252">
        <link title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
        <script type="text/javascript" src="../html/scripts/consultasGenerales.js"></script>
		
<title>Adicionar Comparendo</title>
<style type="text/css">
<!--
.Estilo3 {color: #0066CC}
.style4 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style7 {font-size: 12px; font-weight: bold; color: #FFFFFF; font-family: Tahoma; }
.Estilo24 {
	font-family: Tahoma;
	color: #333333;
}
.Estilo25 {font-size: 10px}
.Estilo26 {color: #333333; font-family: Tahoma; font-weight: bold;}
-->
</style>
<script language="javascript" type="text/javascript">
</script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
</head>

<body>
<%
Model modelo= (Model)session.getAttribute("model");
Parametro parametro=new Parametro();
%>


<center>
<form name="form" method="post" action="procesar_prescripcion.jsp">

<fieldset>

	<table width="80%" border="0" align="center">
	<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="style2 style14 style7">PRESCRIPCION DE CARTERA</span></td>
	  </tr>
	  <tr><td>&nbsp;</td></tr>
		<tr>
			<td>
				<fieldset class="Estilo25">
				<table width="90%" border="0" align="center">
                  <tr style="border:none; background:url(../html/images/inicio_3.png)"> </tr>
                  <tr>
                    <td width="15%" class="Estilo26"><div align="left">NUMERO&nbsp;</div></td>
                    <td width="28%" class="Estilo26"><input  id="numero"name="numero" type="text" class="Estilo3" style="width:150px; text-align:center" /></td>
                    <td width="4%">&nbsp;</td>
                    <td><div align="left"><span class="Estilo26">FECHA </span></div></td>
                    <td><strong>
                      <input type="text" name="fecha" id="fecha"  style="width:100px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10" />
                      <input name="Bfecha_comp" type="button" id="Bfecha_comp" value="<" style="width:20px"/>
                      <script type="text/javascript">
						   Calendar.setup({
						   inputField     :    "fecha",      // id del campo de texto
						   ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
						   button         :    "Bfecha_comp"   // el id del botón que lanzará el calendario
						  });
						</script>
                    </strong></td>
                  </tr>
                  <tr>
                    <td align="center"><div align="left"><span class="Estilo26">PLACA</span></div></td>
                    <td><strong>
                      <input name="placa" type="text" style="width:150px; text-align:center"/>
                    </strong></td>
                    <td>&nbsp;</td>
                    <td></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td><span class="Estilo26">TIPO DOC</span></td>
                    <td><strong>
                      <select name="tipo_doc" id="tipo_doc" style="width:150px" onchange="consultaPersona(this.id, 'documento', 'nombre') ">
                        <% 
					 List lista_id=modelo.listadoParametros(5);
					 Iterator itrtor = lista_id.iterator(); 
					 while (itrtor.hasNext()) {
						   parametro = (Parametro)itrtor.next();%>
                        <option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
                        <%}%>
                      </select>
                    </strong></td>
                    <td>&nbsp;</td>
                    <td><span class="Estilo26">DOCUMENTO</span></td>
                    <td><input name="documento" type="text" id="documento" style="width:120px;text-align:center" onkeypress="return soloNumeros(event)" onblur="consultaPersona('tipo_doc', this.id, 'nombre')"/></td>
                  </tr>
                  <tr>
                    <td><div align="left"><span class="Estilo26">SOLICITANTE</span></div></td>
                    <td colspan="4"  align="justify"><input name="nombre" type="text" id="nombre"  style="width:450px" readonly=""/></td>
                  </tr>
                  <tr>
                    <td><div align="left"><span class="Estilo26">VIGENCIA&nbsp;INICIAL</span></div></td>
                    <td><strong>
                      <select name="vigenciaI" style="width:100px">
                        <% for(int m=2004;m<=2004;m++){ %>
                        <option value="<%=m%>"><%=m%></option>
                        <% } %>
                      </select>
                    </strong></td>
                    <td>&nbsp;</td>
                    <td align="center"><div align="left"><span class="Estilo26">VIGENCIA FINAL</span></div></td>
                    <td><strong>
                      <select name="vigenciaF" style="width:100px">
                        <% for(int m=2004;m<=2014;m++){ %>
                        <option value="<%=m%>"><%=m%></option>
                        <% } %>
                      </select>
                    </strong></td>
                  </tr>
                  <tr class="Estilo26">
                    <td><strong>OBSERVACIONES</strong></td>
                    <td colspan="4"  align="justify"><input name="observaciones" type="text" id="observaciones"  style="width:450px; height:50px; font-size:10px"/></td>
                  </tr>
                </table>
				</fieldset>		</td>
	</tr>
	</br>
		<tr>
				<td colspan="5" align="center"><input type="submit" name="guardar" id="guardar" value="Guardar Registro" /></td>
	  </tr>
	</table>	
	</fieldset>
</form>
</center>
</body>
</html>
<%  }else{ %>
			   <jsp:forward page="no_access.jsp">
				 <jsp:param name="tipo" value="1"></jsp:param>
			   </jsp:forward>
	<%  }
	}else{ %>
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>


