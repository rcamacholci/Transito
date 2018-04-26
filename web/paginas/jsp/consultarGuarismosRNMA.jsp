<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                     if(session.getAttribute("model")!=null){
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Documento sin t&iacute;tulo</title>
<style type="text/css">
<!--
.Estilo3 {font-size: 12px; font-weight: bold; color: #333333; }
.Estilo4 {
	color: #333333;
	font-weight: bold;
	font-size: 14px;
}
.Estilo5 {color: #FFFFFF}
.Estilo7 {font-size: 11px; font-weight: bold; color: #333333; }
.Estilo8 {font-size: 12px; color: #FF0000; font-weight: bold; font-style: italic; }
.Estilo9 {font-size: 12px; color: #0066CC; font-weight: bold; font-style: italic; }
-->
</style>
<script src="../html/scripts/personas.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
	function evaluarCampos(){
            document.form.solicitar.disabled = true;
	   if(document.form.nombre.value.length==0){
                document.form.solicitar.disabled = false;
                alert("Ingrese identificacion del Solicitante");
                return false;
            }
            if(document.form.motor.value.length==0&&document.form.chasis.value.length==0&&document.form.serie.value.length==0&&document.form.vin.value.length==0){
                document.form.solicitar.disabled = false;
                alert("Digite al menos uno de los datos como Motor, Serie, Chasis");
                return false;
            }
            if(document.form.servicio.value=='0'){
                document.form.solicitar.disabled = false;
                alert("Seleccione tipo de servicio del vehiculo");
                return false;
            }
	    if(document.form.clase.value=='0'){
                document.form.solicitar.disabled = false;
                alert("Seleccione origen de registro del vehiculo");
                return false;
            }
            if(document.form.registro.value=='0'){
                document.form.solicitar.disabled = false;
                alert("Seleccione origen de registro del vehiculo");
                return false;
            }
            return true;
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

        function queryPerson(){
            var doc = document.form.documento.value;
            var tipo = document.form.tipodocumento.value;
            if(doc.length>0&&tipo.length>0){
                ajax=new nuevoAjax();
                ajax.open("POST", "getPersona.jsp",true);
                ajax.onreadystatechange=function() {
                    if (ajax.readyState==4) {
                        var respuesta = "" ;
                        for(var i = 0; i < ajax.responseText.length ; i++){
                            if(isNaN(ajax.responseText.charAt(i))||ajax.responseText.charAt(i)==' ')
                                respuesta += ajax.responseText.charAt(i);
                        }
                        if(respuesta == "nueva"){
                            viewPersona(tipo,doc);
                        }else{
                            document.form.nombre.value = respuesta;
                        }
                    }
                }
                ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                ajax.send("documento="+doc+"&tipo="+tipo);
            }
        }

        function verificarDatos(){
            var pla = document.form.placaRNMA.value;
            var mot = document.form.motor.value;
            var cha = document.form.chasis.value;
            var ser = document.form.serie.value;
            var vin = document.form.vin.value;
                if(pla!=null||mot!=null||cha!=null||ser!=null||vin!=null){
                    document.form.action = "verificarDatosRNMA.jsp";
                    document.form.submit();
                }else{
                    alert("Debe ingresar por lo menos un filtro de Busqueda");
                }

        }


        function verificarDatos2(){
                var pla = document.form.placaRNMA.value;
                var mot = document.form.motor.value;
                var cha = document.form.chasis.value;
                var ser = document.form.serie.value;
                var vin = document.form.vin.value;
                document.form.solicitar.value ="Verificando...";
                document.form.solicitar.disabled = true;
               var ajax = new nuevoAjax();
                ajax.open("POST", "verificarDatosRNMA.jsp",true);
                ajax.onreadystatechange=function() {
                    if (ajax.readyState==4) {
                        alert("Entro");
                        var docxml = ajax.responseXML;
                        var result = docxml.getElementsByTagName("result")[0].childNodes[0].nodeValue;
                        
                            if(result=='2'){
                              	document.form.submit();
                            }else{
                                alert(" No se encontro registro ");
                                document.form.motor.readOnly = false;
                                document.form.chasis.readOnly = false;
                                document.form.serie.readOnly = false;
                                document.form.vin.readOnly = false;
                                document.form.servicio.readOnly = false;
                                document.form.clase.readOnly = false;
                                document.form.solicitar.value ="Verificar Datos";
                                document.form.solicitar.disabled = false;
                            }
                       }                        
                    }
                    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                    ajax.send("motor="+mot+"&chasis="+cha+"&serie="+ser+"&vin="+vin+"&placa="+pla);
        }

function verificarGuarismo(){
                var pla = document.form.placaRNMA.value;
                var mot = document.form.motor.value;
                var cha = document.form.chasis.value;
                var ser = document.form.serie.value;
                var vin = document.form.vin.value;
              //  document.form.solicitar.value ="Verificando...";
                document.form.solicitar.disabled = true;
               var ajax = new nuevoAjax();
                ajax.open("POST", "verificarDatosRNMA.jsp",true);
                ajax.onreadystatechange=function() {
                    if (ajax.readyState==4) {
                        var docxml = ajax.responseXML;
                        var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue;
                            if(result=='1'){
                              	window.location.href = "seleccionTramites.jsp?placaRNMA=1";
                            }else{
                                alert(" No se encontro registro ");
                                document.form.motor.readOnly = false;
                                document.form.chasis.readOnly = false;
                                document.form.serie.readOnly = false;
                                document.form.vin.readOnly = false;
                                document.form.servicio.readOnly = false;
                                document.form.clase.readOnly = false;
                                document.form.solicitar.value ="Verificar Datos";
                                document.form.solicitar.disabled = false;
                            }
                       }                        
                    }
                    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                    ajax.send("motor="+mot+"&chasis="+cha+"&serie="+ser+"&vin="+vin+"&placa="+pla);
            
        }


     
</script>
</head>
<%
Model model= (Model)session.getAttribute("model");
long tipoP = 0;
if(request.getParameter("tipoP")!=null){
tipoP = Long.parseLong(request.getParameter("tipoP")) ;
}
%>
<body>
<form name="form" method="post" action="seleccionTramites.jsp">
    <input type="hidden" name="rnma" value="1" id="rnma" />
<input type="hidden" name="tipoP" value="<%=tipoP%>" />
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <% String mensajeRunt = request.getParameter("mensajeRunt");
       String tipoMensajeRunt = request.getParameter("tipoMensajeRunt");
       mensajeRunt = mensajeRunt!=null?mensajeRunt:"";
      if(mensajeRunt.length()>0){ %>
        <tr>
            <td align="center" class="<%=tipoMensajeRunt.equals("0")?"Estilo8":"Estilo9"%>">
               <%=mensajeRunt%>
            </td>
        </tr>
   <% } %>
  <tr>
    <td width="80%" align="center">
		<fieldset>
		<table width="80%" border="0" cellspacing="2" cellpadding="2" align="center">
			  <tr>
			  	<td colspan="5" background="../html/images/inicio_3.png"><div align="center" class="Estilo4 Estilo5">CONSULTA POR GUARISMO DE RNMA</div></td>
			  </tr>
			 
			  <tr>
				<td align="left" colspan="5">&nbsp;</td>
			  </tr>
			   <tr>
                               <td align="left"><span class="Estilo3">IDENTIFICACION</span></td>
                               <td align="center"><input type="text" name="placaRNMA" id="placaRNMA" value="" style="text-align:center; font-size:12px; color:#000033; font-weight:bold; width:170px"/></td>
                <td>&nbsp;</td>
                <td><span class="Estilo3">NUMERO&nbsp;MOTOR</span></td>
                <td align="center"><input type="text" name="motor" id="motor" value="" style="text-align:center; font-size:12px; color:#000033; font-weight:bold; width:170px"/></td>
              
			   </tr>
			  
			  <tr>
				<td align="left" colspan="5">&nbsp;</td>
				
			  </tr>
			  <tr>
				<td align="left"><span class="Estilo3">NUMERO&nbsp;CHASIS</span></td>
				<td align="center"><input type="text" name="chasis" id="chasis" value="" style="text-align:center; font-size:12px; color:#000033; font-weight:bold; width:170px"/></td><td align="left">&nbsp;</td>
				<td align="left"><span class="Estilo3">NUMERO&nbsp;SERIE</span></td>
                				<td align="center"><input type="text" name="serie" id="serie" value="" style="text-align:center; font-size:12px; color:#000033; font-weight:bold; width:170px"/></td>
			 
			  </tr>
                          <tr>
				<td align="left" colspan="5">&nbsp;</td></tr>
			  <tr>
				<td align="left"><span class="Estilo3">NUMERO&nbsp;VIN</span></td>
				<td align="center"><input type="text" name="vin" id="vin" value="" style="text-align:center; font-size:12px; color:#000033; font-weight:bold; width:170px"/></td>
  
                              <td colspan="3" align="center">
                                  <input type="button" name="solicitar" value="Verificar Datos" style="width:200px" onclick="verificarDatos()" />
                              </td>
          
			  </tr>
			 
			
		</table>
		</fieldset>
	</td>
  </tr>
</table>
</form>
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
