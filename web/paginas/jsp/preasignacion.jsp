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
        
        
          function cargarTokenSolicitante(){
              
            var ajax = new nuevoAjax();
                ajax.open("POST", "getTramaSolPreasigancion.jsp",true);
                ajax.onreadystatechange=function() {
                    if (ajax.readyState==4) {
                        var docxml = ajax.responseXML;
                        var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue;
                        if(result=='1'){
                            var trama = docxml.getElementsByTagName('trama')[0].childNodes[0].nodeValue;
                            AUTENTICAR(trama);
                           
                        }else{
                            alert("Token del Solicitante no Pudo ser Cargado, Intente Nuevamente");
                        }
                    }
                }

            ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
            ajax.send("tipoD=1");
        }
        
        
         function AUTENTICAR(token) {
            var rta = "";
            var template_R = token;
            
            var obj = new ActiveXObject("IEActiveRUNT.IEActiveRUNT");
            rta = obj.Autenticar_Ciudadano(template_R);
            document.form.tokenSolicitante.value = rta;
            
            document.form.autenticar.style.display = 'none';
            document.form.solicitar.style.display = 'block';
            document.form.solicitar.disabled = false;

       }

        function verificarDatos(){
            if(document.form.solicitar.value!='Preasignar'){
                var mot = document.form.motor.value;
                var cha = document.form.chasis.value;
                var ser = document.form.serie.value;
                var vin = document.form.vin.value;
                var srv = document.form.servicio.value;
                var cls = document.form.clase.value;
                var td = document.form.tipodocumento.value;
                var doc = document.form.documento.value;
                if(srv!='0'&&cls!='0'){
                    document.form.motor.readOnly = true;
                    document.form.chasis.readOnly = true;
                    document.form.serie.readOnly = true;
                    document.form.vin.readOnly = true;
                    document.form.servicio.readOnly = true;
                    document.form.clase.readOnly = true;
                    document.form.solicitar.value ="Verificando...";
                    document.form.solicitar.disabled = true;
                    ajax=new nuevoAjax();
                    ajax.open("POST", "verificarDatosPreasignacion.jsp",true);
                    ajax.onreadystatechange=function() {
                        if (ajax.readyState==4) {
                            if(ajax.responseText.indexOf("Alerta")==-1){
                                var salida = ajax.responseText;
                                if(!isNaN(salida)){
                                    var respuesta = parseInt(salida)+"";
                                    if(document.form.motor.value.length>0)
                                        document.form.motor.style.backgroundColor = respuesta.charAt(0)=='2'?'#A8FFA8':'#FA9492';
                                    if(document.form.chasis.value.length>0)
                                        document.form.chasis.style.backgroundColor = respuesta.charAt(1)=='2'?'#A8FFA8':'#FA9492';
                                    if(document.form.serie.value.length>0)
                                        document.form.serie.style.backgroundColor = respuesta.charAt(2)=='2'?'#A8FFA8':'#FA9492';
                                    if(document.form.vin.value.length>0)
                                        document.form.vin.style.backgroundColor = respuesta.charAt(3)=='2'?'#A8FFA8':'#FA9492';
                                    if(respuesta!='0000'){
                                        document.form.solicitar.value ="Preasignar";
                                        document.form.editar.style.display = 'block';
                                        document.form.autenticar.style.display = 'block';
                                        document.form.solicitar.disabled = true;
                                        document.form.solicitar.style.display = 'none';
                                      //  cargarTokenSolicitante();
                                    }else{
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
                            }else{
                                document.form.motor.readOnly = false;
                                document.form.chasis.readOnly = false;
                                document.form.serie.readOnly = false;
                                document.form.vin.readOnly = false;
                                document.form.servicio.readOnly = false;
                                document.form.clase.readOnly = false;
                                document.form.solicitar.value ="Verificar Datos";
                                document.form.solicitar.disabled = false;
                                alert(ajax.responseText);
                            }
                        }
                    }
                    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                    ajax.send("motor="+mot+"&chasis="+cha+"&serie="+ser+"&vin="+vin+"&tipoD="+td+"&documento="+doc);
                }else{
                    alert("Seleccione clase y servicio");
                }
            }else{
                if(evaluarCampos()){
                    document.form.submit();
                }
            }
        }

        function editarDatos(){
            document.form.motor.readOnly = false;
            document.form.chasis.readOnly = false;
            document.form.serie.readOnly = false;
            document.form.vin.readOnly = false;
            document.form.servicio.readOnly = false;
            document.form.clase.readOnly = false;
            document.form.solicitar.disabled = false;
            document.form.solicitar.value ="Verificar Datos";
            document.form.motor.style.background = '#FFFFFF';
            document.form.chasis.style.background = '#FFFFFF';
            document.form.serie.style.background = '#FFFFFF';
            document.form.vin.style.background = '#FFFFFF';
            document.form.editar.style.display = 'none';
        }
</script>
</head>
<%
Model model= (Model)session.getAttribute("model");  

System.out.println("entre por aqui");

long tipoP = 0;
if(request.getParameter("tipoP")!=null){
tipoP = Long.parseLong(request.getParameter("tipoP")) ;
}
%>
<body>
<form name="form" method="post" action="procesarPreasignacion.jsp" onSubmit="return evaluarCampos()">
<input type="hidden" name="tipoP" value="<%=tipoP%>" />
<input type="hidden" id="tokenSolicitante" name="tokenSolicitante" value=""/>
<table width="35%" border="0" cellspacing="0" cellpadding="0" align="center">
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
    <td width="100%" align="center">
		<fieldset>
		<table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">
			  <tr>
			  	<td colspan="2" background="../html/images/inicio_3.png"><div align="center" class="Estilo4 Estilo5">PREASIGNACION DE PLACA</div></td>
			  </tr>
			  <tr>
			  	<td colspan="2"><div align="center"><span class="Estilo7"><%=(tipoP==0?"AUTOMATICA":"MANUAL")%></span></div></td>
			  </tr>
			  <tr>
			  	<td colspan="2">&nbsp;</td>
			  </tr>
			  <tr>
				<td align="left" colspan="2"><span class="Estilo3">IDENTIFICACION DEL SOLICITANTE</span></td>
			  </tr>
			   <tr>
                               <td align="left">
                                   <select  name="tipodocumento" id="tipodocumento" style="text-align:center; font-size:11px; color:#333333;width:170px" onchange="queryPerson()">
                                <%  java.util.List parametros = model.listadoParametros(5);
                                    for (int i = 0; i < parametros.size(); i++) {
                                        modelo.Parametro parametro = (modelo.Parametro) parametros.get(i);%>
                                        <option value="<%=parametro.getCodigo()%>"><%=parametro.getNombre()%></option>
                                 <% } %>
                                   </select>                               </td>
                               <td align="center">
				<input type="text" name="documento" id="documento" value="" style="text-align:center;font-size:12px;color:#0066CC;width:170px" onblur="queryPerson()"/>                               </td>
			   </tr>
			   <tr>
				<td align="center" colspan="2">
                    <input type="text" name="nombre" id="nombre" value="" style="text-align:center;font-size:12px;color:#0066CC;width:360px" readonly/>				</td>
			  </tr>
			  <tr>
				<td align="left"><span class="Estilo3">TIPO DE SERVICIO</span></td>
				<td align="center">
					<select  name="servicio" id="servicio" style="text-align:center; font-size:12px;; color:#000033; font-weight:bold;width:170px">
						<option value="0"><<--Seleccionar-->></option>
					 <%	java.util.List listaParametrosRunt = model.consultarParametrosRUNT(50);
						for (int i = 0; i < listaParametrosRunt.size(); i++) {
							String[] parametro = (String[]) listaParametrosRunt.get(i);%>
							<option value="<%=parametro[0]%>"><%=parametro[1]%></option>
						<% } %>	
				   </select>				 </td>
			  </tr>
			  <tr>
				<td align="left"><span class="Estilo3">CLASE DE VEHICULO</span></td>
				<td align="center">
					<select  name="clase" id="clase" style="text-align:center; font-size:12px; color:#000033; font-weight:bold;width:170px">
						<option value="0"><<--Seleccionar-->></option>
					 <%  parametros = model.listadoParametros(1);
							for (int i = 0; i < parametros.size(); i++) {
								modelo.Parametro parametro = (modelo.Parametro) parametros.get(i);%>
						  		<option value="<%=parametro.getCodigo()%>"><%=parametro.getNombre()%></option>
						<% } %>
				   </select>				</td>
			  </tr>
                          <tr>
				<td align="left"><span class="Estilo3">NUMERO DE MOTOR</span></td>
				<td align="center"><input type="text" name="motor" id="motor" value="" style="text-align:center; font-size:12px; color:#000033; font-weight:bold; width:170px"/></td>
			  </tr>
			  <tr>
				<td align="left"><span class="Estilo3">NUMERO DE CHASIS</span></td>
				<td align="center"><input type="text" name="chasis" id="chasis" value="" style="text-align:center; font-size:12px; color:#000033; font-weight:bold; width:170px"/></td>
			  </tr>
			  <tr>
				<td align="left"><span class="Estilo3">NUMERO DE SERIE</span></td>
				<td align="center"><input type="text" name="serie" id="serie" value="" style="text-align:center; font-size:12px; color:#000033; font-weight:bold; width:170px"/></td>
			  </tr>
			  <tr>
				<td align="left"><span class="Estilo3">NUMERO VIN</span></td>
				<td align="center"><input type="text" name="vin" id="vin" value="" style="text-align:center; font-size:12px; color:#000033; font-weight:bold; width:170px"/></td>
			  </tr>
			  <tr>
				<td align="left"><span class="Estilo3">ORIGEN DE REGISTRO</span></td>
				<td align="center">
					<select  name="registro" id="registro" style="text-align:center; font-size:12px; color:#000033; font-weight:bold;width:170px">
						<option value="0"><<--Seleccionar-->></option>
					 <%	listaParametrosRunt = model.consultarParametrosRUNT(32);
						for (int i = 0; i < listaParametrosRunt.size(); i++) {
							String[] parametro = (String[]) listaParametrosRunt.get(i);%>
							<option value="<%=parametro[0]%>"><%=parametro[1]%></option>
						<% } %>	
				   </select>				 </td>
			  </tr>
                          <tr>
				<td align="left"><span class="Estilo3">LIQUIDACION RUNT</span></td>
				<td align="center">
					<select  name="runt" id="runt" style="text-align:center; font-size:12px; color:#000033; font-weight:bold;width:170px">
                                                <option value="0" selected>NO GENERAR</option>
                                                <option value="1">MATRICULA</option>
                                                <option value="2">MATRICULA Y ALERTA</option>
                                        </select>
                                </td>
			  </tr>
			  <tr>
			  	<td colspan="2">&nbsp;</td>
			  </tr>
			  <tr>
                              <td colspan="1" align="center"><input type="button" name="editar" value="Editar Datos" style="display:none" onclick="editarDatos()" /></td>
                              <td colspan="1" align="center">
                                  <input type="button" name="solicitar" value="Verificar Datos" onclick="verificarDatos()" />
                              <input name="autenticar" type="button" id="autenticar" onclick="cargarTokenSolicitante()" value="Autenticar" style="color:#333333; display:none" /></td>
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
