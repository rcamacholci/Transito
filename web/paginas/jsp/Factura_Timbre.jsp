<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <%
try{
    Model modelo = (Model)session.getAttribute("model");


%>
<head>
    <title>Adicionar Valor Avaluo Factura</title>

<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<script src="../html/scripts/calendar.js" type="text/javascript"></script>
<script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
<script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<script src="../html/scripts/insertValTimbre.js" type="text/javascript"></script>
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

function validarcamposFac(){
               if(document.form.valor_timbre.value.length!=0){
                   if(document.form.vigencia.value.length!=0){
                       if(confirm("¿Desea adicionar el valor del timbre?")){
                           insertValTimbre();
                           //document.form.numfactura.disabled = false;
                           //document.form.valortimbre.disabled = false;
                           //selC();
                       }
                   }else{
                       alert("Digite el campo vigencia");
                   }
               }else{
                   alert("Digite el valor del timbre");
               }
             return false;
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

function selC(){
    //var valort = document.form.valortimbre.value;
    //var placa = document.form.numplaca.value;
    //valort = valort*0.01;
    //window.parent.close();

    //window.parent.opener.window.location.href = "verLiquidacion.jsp?id=204&tipo=3&varete="+valort+"&placa="+placa;
}




</script>

</head>
<body>
<%
 String placa = request.getParameter("placa");
 long idvehiculo = Long.parseLong(request.getParameter("id_veh"));
 String numfac = "";
 String valtimbre = "";

 if(request.getParameter("placa")!=null && request.getParameter("id_veh")!=null){
//onsubmit="return validarFormulario(this)"
 %>
<form  name="form"  method="post" action="">
    <input type="hidden" id="idvehicu" value="<%=idvehiculo%>"/>
    <input type="hidden" id="valor1" value="<%=request.getParameter("valor1")%>"/>
    <input type="hidden" id="valor2" value="<%=request.getParameter("valor2")%>"/>
    <input type="hidden" id="sede" value="<%=request.getParameter("sede")%>"/>
    <input type="hidden" id="numplaca" value="<%=placa%>"/>

	<fieldset>
	   <table width="52%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="Estilo2">ADICIONAR VALOR FACTURA TIMBRE</span></td>
			</tr>
		  <tr>
                      <td width="6%" scope="col" align="right"><label><span class="style2">PLACA&nbsp;&nbsp;</span></label></td>
                      <td width="13%" scope="col" align="left"><label><span class="style2">&nbsp;&nbsp;<%=placa%></span></label></td>
                      <td scope="col" align="right"><span class="style2">NUMERO&nbsp;FACTURA&nbsp;&nbsp;</span></td>
                                <td scope="col" align="left"><input name="num_factura" id="numfactura" type="text"  style="width:150px" value=""/></td>
		  </tr>
		  <tr>
				<td align="right" class="Estilo2"><span class="style2"><strong>&nbsp;&nbsp;VALOR&nbsp;AVALUO&nbsp;&nbsp;</strong> </span></td>
                                <td align="left"><input type="text" name="valor_timbre" id="valortimbre" style="width:150px" onKeyPress="return soloNumeros(event)" value=""/></td>
                                <td align="right" class="Estilo2"><span class="style2"><strong>&nbsp;&nbsp;AÑO&nbsp;VIGENCIA&nbsp;&nbsp;</strong> </span></td>
                                <td align="left"><input type="text" name="vigencia" id="vigencia" style="width:150px" onKeyPress="return soloNumeros(event)" value=""/></td>
                                    <!--<input name="valor_timbre" id="valortimbre" autocomplete="off"  type="text" style="width:150px" class="text"   onKeyPress="return soloNumeros(event)"/>-->

		  </tr>
		<tr>
			<td colspan="4" align="center">
                            <input name="adicionar" type="button" id="adicionar" value="Guardar" onclick="validarcamposFac()" >
<!--<button type="submit" name="guardar" onclick="validarcamposU()">Guardar <img src="../html/images/guardar.png" width="19" height="18" /></button>-->
                           <!-- <input type="submit" name="guardar" value="Registrar Datos"/> -->
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