<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <%
try{
    Model modelo = (Model)session.getAttribute("model");


%>
<head>
    <title>Adicionar Tipo Persona</title>

<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<script src="../html/scripts/calendar.js" type="text/javascript"></script>
<script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
<script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<script src="../html/scripts/insertTipopersona.js" type="text/javascript"></script>
<script type="text/javascript" src="../html/scripts/motorAjax.js"></script>

<META http-equiv=Content-Type content="text/html; charset=windows-1252" />
<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>

<!--<META content="MSHTML 6.00.2900.3020" name=GENERATOR>-->

<!--<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />-->
<script type="text/javascript"  src="../html/scripts/jquery.js"></script>



<style type="text/css">
<!--
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style3 {color: #FFFFFF}
.style31 {color: #333333; font-size: 12px; font-weight: bold; font-family: Tahoma; }
.Estilo2 {color: #FFFFFF; 	font-family: Tahoma; 	font-size: 12px; 	font-weight: bold; }
-->
</style>
<script language="javascript" type="text/javascript">

function validarcamposTipo(){
        insertTipoPersona();
}

function ver(){
    if(document.form.busqueda[0].checked){
        document.form.tipo.value = "1";
    }else{
        if(document.form.busqueda[1].checked){
            document.form.tipo.value = "2";
          }
    }
}
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

</script>

</head>
<body>
<%
if(request.getParameter("id_persona")!=null && request.getParameter("placa")!=null){
    long idpersona = Long.parseLong(request.getParameter("id_persona"));
    String nplaca = request.getParameter("placa");

 %>
<form  name="form"  method="post" action="">
    <input type="hidden" id="idpersona" value="<%=idpersona%>"/>
    <input type="hidden" id="placa" value="<%=nplaca%>"/>
    <input type="hidden" id="tipo" value="<%=nplaca%>"/>

	<fieldset>
	   <table width="52%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr style="border:none; background:url(../html/images/inicio_3.png)">
                            <td colspan="11" align="center"><span class="Estilo2">ESTA&nbsp;PERSONA&nbsp;ES&nbsp;RETENEDORA? </span></td>
			</tr>
		  <tr>
                                <td colspan="2" valign="middle" align="center"><span class="Estilo11">
                                        <input type="radio" name="busqueda" id="busqueda" value="1" checked="checked" onclick="ver()">
				  <span class="style6">SI</span></span></td>
					<td colspan="2" valign="middle" align="center" width="50%"><span class="Estilo11">
                                                <input type="radio" name="busqueda" id="busqueda" value="2" onclick="ver()">
				  </span><span class="style6">NO</span></td>
		  </tr>
		<tr>
			<td colspan="4" align="center">
                            <input name="adicionar" type="button" id="adicionar" value="Guardar" onclick="insertTipoPersona()" >
			</td>
		</tr>
	  </table>
	</fieldset>
</form>
</body>
</html>
<%
 }
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% } %>