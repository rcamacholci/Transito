<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html;charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" errorPage="" %>
<%@page import = "modelo.*" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                    Model model = (Model)session.getAttribute("model");
                    Usuario usuario = (Usuario)session.getAttribute("usuario");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache/cache">
<title>Licencias de Conduccion</title>
<link title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<script src="../html/scripts/personas.js" type="text/javascript"></script>
<script src="../html/scripts/MotorAjax.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
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


         function cargarTokenSesion(tipo){
         //  alert("yuju");
            var ID = document.form.numeroDocumento.value;
            var TIPO = "C";
                if(document.form.tipoDocumento.value==3)
			TIPO = "E";
		if(document.form.tipoDocumento.value==4)
			TIPO = "T";
		if(document.form.tipoDocumento.value==5)
			TIPO = "P";
            //  alert("tipod doc : "+TIPO+" Docu : "+ID+" bidi : "+bc+" huella : "+bh+" firma : "+br+" foto : "+bf);
            var ajax = new nuevoAjax();
                ajax.open("POST", "generarTokenInscripcion.jsp",true);
                ajax.onreadystatechange=function() {
                    if (ajax.readyState==4) {
                        var docxml = ajax.responseXML;
                        var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue;
                        if(result=='1'){
                            var trama = docxml.getElementsByTagName('trama')[0].childNodes[0].nodeValue;
                            var tipoR = docxml.getElementsByTagName('tipoR')[0].childNodes[0].nodeValue;
                            if(tipoR=='1'){
                                document.form.fotoSolicitante.value = trama;
                                document.getElementById('generarToken').style.display = "none";
                                document.getElementById('btfoto').style.display = "block";
                            }else{
                                if(tipoR=='2'){
                                    document.form.tokenSolicitante.value = trama;
                                }
                            }

                           // alert("Token  generado Exisotamente ...");
                           
                        }else{
                            alert("Token No generado, Intente Nuevamente");
                        }
                    }
                }

            ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
            ajax.send("tipoD="+TIPO+"&documento="+ID+"&tipo="+tipo);
        }


	
	function paso(){
		if(document.form.pago.value.length>0){
			document.getElementById("actionS").disabled = false;
		}else{
			document.getElementById("actionS").disabled = true;
		}
		
	}

    function consultaPersona(){
		document.form.consultar.disabled = true;
		document.form.consultar.value = "Espere...";
		tipo = document.getElementById("tipoDocumento") ;
		documento = document.getElementById("numeroDocumento").value ;
		document.getElementById("respuesta1").innerHTML = "&nbsp;";
                document.getElementById("tramite").selectedIndex = 0;
		document.getElementById("tramite").disabled = true;
                document.getElementById("categoria").selectedIndex = 0;
		document.getElementById("categoria").disabled = true;
                document.getElementById("categoriaAn").selectedIndex = 0;
		document.getElementById("categoriaAn").disabled = true;
                document.getElementById("runt").value = "";
		document.getElementById("runt").disabled = true;
                document.getElementById("simit").value = "";
		document.getElementById("simit").disabled = true;
                document.getElementById("pago").value = "";
		document.getElementById("licencia").value = "";
                document.getElementById("licencia").disabled = true;
		document.getElementById("foto").value = "";
		document.getElementById("huella").value = "";
		document.getElementById("imagen").innerHTML = "";
		document.form.nombre.value = "";
		document.getElementById("nombreRadicador").innerHTML = "";
		if(documento.length>0){
			tipoDoc = tipo.options[tipo.options.selectedIndex].value
			ajax=nuevoAjax();
			ajax.open("POST", "getPersonaLicencia.jsp",true);
			ajax.onreadystatechange=function() {
				if (ajax.readyState==4) {
					document.form.consultar.disabled = false;
					document.form.consultar.value = "Consultar";
					var xmldoc = ajax.responseXML;
					var respuesta = xmldoc.getElementsByTagName('respuesta')[0];
					var estadoN = respuesta.getElementsByTagName('estadoN')[0].childNodes[0].nodeValue;
					var estadoT = respuesta.getElementsByTagName('estadoT')[0].childNodes[0].nodeValue;
					var estadoF = respuesta.getElementsByTagName('estadoF')[0].childNodes[0].nodeValue;
					if(estadoN==1){
						var datoN = respuesta.getElementsByTagName('datoN')[0].childNodes[0].nodeValue;
						document.getElementById("nombreRadicador").innerHTML = "<label class='Estilo5'><b>"+datoN+"</b><label>";
						document.form.nombre.value = datoN;
						if(estadoT==1){
							if(estadoF==1){
								document.getElementById("respuesta1").innerHTML = "<label class='estado1'><b>La persona se encuentra inscrita en el Runt.</b><label>";
								document.getElementById("foto").value = "1";
								document.getElementById("tramite").disabled = false;
								document.getElementById("categoria").disabled = false;
                                                                document.getElementById("categoriaAn").disabled = false;
								document.getElementById("pago").disabled = false;
								document.getElementById("runt").disabled = false;
								document.getElementById("simit").disabled = false;
								document.getElementById("generarToken").disabled = false;
								
							}else{
								document.getElementById("respuesta1").innerHTML = "<label class='estado0'><b>La persona no posee foto</b><label>";
							}
						}else
						if(estadoT==0){
							document.getElementById("respuesta1").innerHTML = "<label class='estadoM1'><b>La persona no posee huella digital</b><label>";
						}else
						if(estadoT==2){
							document.getElementById("respuesta1").innerHTML = "<label class='estado0'><b>Licencia saldra sin huella, ya que la persona no posee</b><label>";
						}else
						if(estadoT==-1){
							document.getElementById("respuesta1").innerHTML = "<label class='estadoM1'><b>No se pudo acceder al servicio Web, para consultar huella</b><label>";
						}
					}else
					if(estadoN==0){
                         document.getElementById("respuesta1").innerHTML = "<label class='estado0'><b>La persona no se encuentra inscrita en el Runt.</b><label>";
                    }else
                        if(estadoN==-1){
                   document.getElementById("respuesta1").innerHTML = "<label class='estadoM1'><b>No se pudo acceder al servicio Web o token vencido, Favor vuelva autenticarse</b><label>";
                        }else{
                            if(estadoN==3){
                                 document.getElementById("respuesta1").innerHTML = "<label class='estadoM1'><b>Token vencido o inválido, Favir vuelva autenticarse</b><label>";
                            }
                        }
                   }
			}
			ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			ajax.send("tipoDocumento="+tipoDoc+"&numeroDocumento="+documento);
		}else{
			alert("Digite un numero de identificacion valido");
			document.form.consultar.disabled = false;
			document.form.consultar.value = "Consultar";
		}	
	}

    function TramitesPendientes(){
                //alert("si señor");
                document.form.consultar.value = "Espere...";
		tipo = document.getElementById("tipoDocumento") ;
		documento = document.getElementById("numeroDocumento").value ;
                document.form.nombre.value = "";
		document.getElementById("mensaje").innerHTML = "";
                if(documento.length>0){
                        // alert("oye no si ve");
			tipoDoc = tipo.options[tipo.options.selectedIndex].value
			ajax=nuevoAjax();
			ajax.open("POST", "TramitesPendientesPersona.jsp",true);
			ajax.onreadystatechange=function() {
				if (ajax.readyState==4) {
                                    // alert("como le parece a todos ustedes");
					document.form.consultar.disabled = false;
					document.form.consultar.value = "Consultar";
					var xmldoc = ajax.responseXML;
					var respuesta = xmldoc.getElementsByTagName('respuesta')[0];
					var estadoN = respuesta.getElementsByTagName('estadoN')[0].childNodes[0].nodeValue;
					if(estadoN==1){
                                           document.getElementById("mensaje").innerHTML = "<label class='Estilo5'><b>"+"PERSONA TIENE TRAMITES PENDIENTES, FAVOR FINALIZARLOS"+"</b><label>";
                                           document.form.actionS.disabled = true
                                        }else{
                                             consultaPersona();
                                              
                                        }
                                }
			}
			ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			ajax.send("tipoDocumento="+tipoDoc+"&numeroDocumento="+documento);
		}else{
			alert("Digite un numero de identificacion valido");
			document.form.consultar.disabled = false;
			document.form.consultar.value = "Consultar";
		}
               
	}





        function revisarPago(td,nd,tr){
            document.getElementById("pago").value = "";
            document.getElementById("actionS").disabled = true;
            if(nd.length>0){
		if((nd==0)){
                    alert("Digite un numero de cedula.");
		}else{
                    ajax2=new nuevoAjax();
                    ajax2.open("POST", "verificarPago.jsp",true);
                    ajax2.onreadystatechange=function() {
                        if (ajax2.readyState==4) {
                            var respuesta = ajax2.responseText;
                            if(respuesta.indexOf("&")!=-1&&respuesta.lastIndexOf("&")!=-1){
                                var pago = respuesta.substring(respuesta.indexOf("&")+1,respuesta.lastIndexOf("&"));
                                if(pago.length>0){
                                    document.getElementById("pago").value = pago;
                                  //  document.getElementById("actionS").disabled = false;
                                }else{
                                    alert("Verifique que la persona Con Documento:"+nd+" posee pagos Activos , y si se encuentra aplicado para el año actual, de lo contrario favor realizar el respectivo Excedente.")
                                }
                            }
                        }
                    }
                    ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                    ajax2.send("tramite="+tr+"&tipo="+td+"&documento="+nd);
		}
            }
	}

        function BiometriaFoto(tipo){
                var temp_R = "";
                var mensaje = "";
                if(tipo=='1'){
                    temp_R = document.form.fotoSolicitante.value;
                    mensaje = "OK. Foto Capturada Correctamente ";
                }else{
                   if(tipo=='2'){
                        temp_R = document.form.tokenSolicitante.value;
                        mensaje = "OK. Huellas Capturadas Correctamente ";
                   }
                }                
                //alert(temp_R);
		var obj;
		var rta = "";
		obj = new ActiveXObject("IEActiveRUNT.IEActiveRUNT")
		rta = obj.Enrolar(temp_R);
             //   alert("rta : "+rta);
                    alert(mensaje);
                 if(tipo=='1'){
                         document.form.fotoSolicitante.value = rta;
                         cargarTokenSesion(3);
                         document.getElementById('btfoto').style.display = "none";
                         document.getElementById('bthuellas').style.display = "block";
                         
                 }else{
                       if(tipo=='2'){
                            document.form.tokenSolicitante.value = rta;
                       }
                 }     
		
        }

          function AUTENTICAR() {
            alert("Autenticando");
            var rta = "";
            var template_R = document.form.tokenSolicitante.value;
            // alert(template_R);
            var obj = new ActiveXObject("IEActiveRUNT.IEActiveRUNT");
            rta = obj.Autenticar_Ciudadano(template_R);
            document.form.tokenSolicitante.value = rta;
            document.form.actionS.disabled = false;
            // alert("rta : "+rta);

       }


	
	

        function revisarL(lq){
            lq.style.color = "#000033";
            if(lq.value.length>0){
                lq.value = '600000000000000000'.substr(0, 18-lq.value.length)+lq.value;
                if(lq.value.length==18){
                        if(isNaN(lq.value)){
                             alert("Digite solo valores numericos.");
                        }else{
                                ajax2=new nuevoAjax();
                                ajax2.open("POST", "verificarLiquidacion.jsp",true);
                                ajax2.onreadystatechange=function() {
                                        if (ajax2.readyState==4) {
                                                var respuesta = ajax2.responseText;
                                                if(respuesta.indexOf("PAGADO")==-1)
                                                        lq.style.color = "#CC0000";
                                                else
                                                        if(respuesta.indexOf("NO_ACCESO")!=-1)
                                                                lq.style.color = "#CC0000";
                                                        else
                                                                lq.style.color = "#68A805";
                                        }
                                }
                                ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                                ajax2.send("runt="+lq.value);
                        }
                }else{
                        lq.style.color = "#FF0000";
                }
            }
        }

        function revisarLicencia(lice){
            lice.style.color = "#000033";
            if(lice.value.length>0){
                
                    ajax2=new nuevoAjax();
                    ajax2.open("POST", "verificarLicenciaConduccion.jsp",true);
                    ajax2.onreadystatechange=function() {
                        if (ajax2.readyState==4) {
                            var respuesta = ajax2.responseText;
                            if(respuesta.indexOf("SI_EXISTE")==-1)
                                lice.style.color = "#CC0000";
                            else
                                if(respuesta.indexOf("NO_ACCESO")!=-1)
                                    lice.style.color = "#CC0000";
                                else
                                    lice.style.color = "#68A805";
                        }
                    }
                    ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                    ajax2.send("numero="+lice.value);
                
            }
        }
	
	function validarDatos(){
		if(document.form.nombre.value.length>0){
			if(document.form.tramite.value!=0){
				if(document.form.runt.value.length>0){
					if(document.form.runt.style.color==document.form.simit.style.color){
                                                if(document.form.pago.value.length>0){
							
								if(document.form.categoria.value!=0){
                                                                    if((document.form.licencia.value.length>0&&document.form.licencia.style.color==document.form.licencia.style.color)||document.form.licencia.disabled){
									
                                                                            return true;
									
                                                                    }else{
									alert("Digite un numero de licencia anterior");
									return false;
                                                                    }
								}else{
									alert("Seleccione una categoria para la licencia");
									return false;	
								}
						
						}else{
							alert("El recibo de pago del TRANSITO, no esta relacionado");
							return false;
                                                }
					}else{
						alert("El recibo de pago RUNT, no se encuentra en estado PAGADO");
						return false;	
					}
				}else{
					alert("Ingrese un numero de recibo de pago RUNT");
					return false;	
				}
			}else{
				alert("Seleccione un tramite a realizar");
				return false;	
			}
		}else{
			alert("Ingrese un solicitante para el tramite a realizar");
			return false;
		}
	}
	
	

        function selTramite(idt){
            revisarPago(document.getElementById("tipoDocumento").value,document.getElementById("numeroDocumento").value,idt.value);
            if(idt.value==31||idt.value==34){
                document.form.licencia.disabled = false;
            }else{
                document.form.licencia.disabled = true;
                document.form.licencia.value = "";
            }
        }
</script>
<style type="text/css">
<!--
.estadoM1{ 	font-family: "Segoe Script";	color: #CC0000;	font-size: 10px; }
.estado0 { 	font-family: "Segoe Script";	color: #FF6600;	font-size: 10px; }
.estado1 { 	font-family: "Segoe Script";	color: #006699;	font-size: 10px; }
.Estilo5 {
	font-family: "Segoe Script";
	color: #68A805;
	font-size: 12px;
}
.Estilo26 {
	color: #333333;
	font-size: 12px;
	font-family: "Segoe Script";
	font-weight: bold;
}
.Estilo27 {
	font-size: 12px;
	font-weight: bold;
	color: #333333;
}
.Estilo28 {
	font-family: Tahoma;
	font-size: 12px;
	color: #FFFFFF;
}
.Estilo29 {
	font-size: 10px;
	font-family: Tahoma;
}
.Estilo30 {color: #333333; font-size: 10px; font-family: Tahoma; font-weight: bold; }
.Estilo31 {font-family: Tahoma}
.Estilo32 {color: #333333; font-size: 10px; font-family: "Segoe Script"; font-weight: bold; }
-->
</style>
</head>
<%  int psg = 0; 

try {
        String td = request.getParameter("tipo");
        String nd = request.getParameter("documento");
        td = td!=null?td:"";
        nd = nd!=null?nd:"";
        boolean sw =nd!=null?model.ValidarPagosAnteriorPersona(nd):false;
        if(!sw){
%>
<body> 
<form name="form" id="form" method="post" action="radicarLicencia.jsp" onsubmit="return validarDatos()">
<fieldset>
<table width="75%" border="0" align="center" bordercolor="#999999" cellpadding="1" >
  <tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="style3 style14 style2 Estilo28"><strong>SOLICITUD DE LICENCIA DE CONDUCCION  </strong></span></td>
    </tr>
	<tr>
		  <td colspan="2" height="20" align="center"><div id="mensaje" style="width:360px"></div></td>
				   <tr>
 
  <tr style="border:none">
    <td height="304" align="center" valign="top" style="border:none">
		
	   <input type="hidden" id="foto" name="foto" value=""/>
	   <input type="hidden" id="huella" name="huella" value=""/>
           <input type="hidden" id="huella_usuario" name="huella_usuario" value=""/>
	   <input type="hidden" id="nombre" name="nombre" value=""/>
           <input type="hidden" id="tokenSolicitante" name="tokenSolicitante" value=""/>
           <input type="hidden" id="fotoSolicitante" name="fotoSolicitante" value=""/>

	   </br>
	 <table width="100%" border="0" align="center" id="panelTramites" style="display:block" cellpadding="0" cellspacing="0">
		<tr>
			<td colspan="4">
			
				<fieldset>
				<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="style3 style14 style2 Estilo28"><strong>INFORMACION DEL SOLICITANTE  </strong></span></td>
		  </tr>
		  <tr>
		  <td colspan="4" height="5px">&nbsp; </td>
				   <tr>
				   
					 <td width="14%" align="left"> <label class="Estilo26 Estilo29">TIPO&nbsp;DOCUMENTO </label></td>
					 <td width="40%" align="left">
					   <select  name="tipoDocumento" id="tipoDocumento" style="width:230px; font-size:12px; color:#000033">
						 <% java.util.List tipoDocumentos = model.listadoParametros(5);
						 for (int i = 0; i < tipoDocumentos.size(); i++) {
						   Parametro parametro = (Parametro) tipoDocumentos.get(i); %>
                                                   <option value="<%=parametro.getCodigo()%>" <%= (td.equals(""+parametro.getCodigo())?"selected":"")%> ><%= parametro.getNombre()%> </option>
						<% } %>
					   </select>					 </td>
					 <td width="13%" align="center"><label class="Estilo27 Estilo29">DOCUMENTO</label></td>
					 <td width="33%" align="left">
					 <input name="numeroDocumento" type="text" id="numeroDocumento"  value="<%=nd%>" style="width:150px; text-align:center; font-size:12px; color:#000033"/></td>
				   </tr>
				   <tr>
					 <td height="32" align="left">
					   <label class="Estilo30">NOMBRE </label></td>
					 <td colspan="2" align="left"><div id="nombreRadicador" style="width:360px"></div></td>
					 <td colspan="1" align="left"><input type="button" name="consultar" id="consultar" value="Consultar" style="width:150px;" onclick="TramitesPendientes()"/></td>
				   </tr>
			    </table>  
			  </fieldset>			</td>
		</tr>	   
		<tr>
			<td colspan="4" align="center"><div id="respuesta1" style="width:450px">&nbsp;</div></td>
		</tr>
        <tr>
         <td height="56" colspan="4">
		 	 <fieldset>
			 <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			 <tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center" class="Estilo28 style2 style14 style3"><strong>INFORMACION DEL TRAMITE </strong></td>
		  </tr>
				 <tr style="color:#333333">
				 <td width="13%" rowspan="3" align="center">
				 <div name="imagen" id="imagen" style="width:83; height:100"></div>
				    <label class="Estilo26"></label>				   </td>
				   <td width="14%" height="29" align="left">
					 <label class="Estilo30">
					 TIPO	TRAMITE				 </label>				   </td>
				   <td align="left" ><span class="Estilo5">
                                           <select  name="tramite" id="tramite" style="width:220px; font-size:11px; color:#000033" disabled="disabled" onchange="selTramite(this)">
				   		<option value="0">---Seleccione Tramite---</option>
                                       <% Sede sede = (Sede)session.getAttribute("sede");
                                            java.util.List tramites = model.consultarTramites(2,sede.getId_sede());
						 for (int i = 0; i < tramites.size(); i++) {
							   Tramite tramite = (Tramite) tramites.get(i); %>
							   <option value="<%=tramite.getId_tramite()%>"><%= tramite.getNombre()%> </option>
					  <% } %>
				   </select>
				   </span></td>
				   <td width="13%" align="left"><label class="Estilo26 Estilo29">
				     CATEGORIA&nbsp;NUEVA</label></td>
				   <td width="25%" align="center"><span class="Estilo5">
				     <select  name="categoria" id="categoria" style="width:100px; text-align:center;color:#000033;font-size:13px; font-weight:bold" disabled="disabled">
                       <option value="0">---- / ----</option>
                       <% java.util.List categorias = model.listadoParametros(221);
						for (int i = 0; i < categorias.size(); i++) {
						   Parametro parametro = (Parametro) categorias.get(i); %>
                       <option value="<%=parametro.getNombre()%>"><%= parametro.getNombre()%> </option>
                       <%  } %>
                     </select>
				   </span></td>
				 </tr>
				 <tr style="color:#333333">
				   <td width="14%" height="33" align="left"><label class="Estilo30">
				     PAGO RUNT
				   </label></td>
				   <td width="35%" align="left">
				   <input name="runt" type="text" maxlength="18" id="runt" style="text-align:center;color:#000033;font-size:13px; font-weight:bold; width:220px" value="" onblur="revisarL(this)" disabled="disabled"/>				   </td>
				   <td width="13%" align="left"><label class="Estilo30">
				     PAGO&nbsp;TRANSITO
				   </label></td>
					<td width="25%" align="center">
                                            <input name="pago" type="text" maxlength="18" id="pago" style="text-align:center;color:#000033;font-size:13px; font-weight:bold; width:100px" value="" readonly  disabled="disabled"/>
                                        </td>
				 </tr>
				 <tr style="color:#333333">
				   <td width="14%" height="33" align="left">
				     <label class="Estilo26 Estilo29">
				     PAGO RUNT 2</label></td>
				    <td width="35%" align="left"><input name="simit" type="text" id="simit" style="text-align:center; color:#68A805; font-size:13px; font-weight:bold; width:220px" onblur="revisarL(this)" value="" disabled="disabled"/></td>
                                    <td width="13%" align="left">&nbsp;</td>
				   <td width="25%" align="center">
                                       <input type="button" name="generarToken" id="generarToken" value="generar Token" style="width:110px; font-size:11px" disabled="disabled" onclick="cargarTokenSesion(2)"/>
                                       <input type="button" name="btfoto" id="btfoto" value="Capturar Foto" style="width:110px; font-size:11px ;display:none" onclick="BiometriaFoto(1)"/>
                                       <input type="button" name="bthuellas" id="bthuellas" value="Autenticar" style="width:110px; font-size:11px ;display:none" onclick="AUTENTICAR()"/>
                                   </td>
				 </tr>
				 <tr style="color:#333333">
				 	<td width="14%" height="33" align="center">&nbsp;</td>
				    <td width="14%" height="33" align="center">
				     <label class="Estilo32"><span class="Estilo31">NUMERO&nbsp;LICENCIA</span> </label></td>
				    <td width="35%" align="left">
                                        <input name="licencia" type="text" id="licencia" style="text-align:center; color:#68A805;font-size:13px; font-weight:bold; width:220px" value="" onblur="revisarLicencia(this)" disabled="disabled"/>				    </td>
				  <td width="13%" align="left"><label class="Estilo26 Estilo29">
				     CATEGORIA&nbsp;ANTERIOR</label></td>
				   <td width="25%" align="center"><span class="Estilo5">
				     <select  name="categoriaAn" id="categoriaAn" style="width:100px; text-align:center;color:#000033;font-size:13px; font-weight:bold" disabled="disabled">
                       <option value="0">---- / ----</option>
                       <% java.util.List categoriasAn = model.listadoParametros(221);
						for (int i = 0; i < categoriasAn.size(); i++) {
						   Parametro parametro = (Parametro) categoriasAn.get(i); %>
                       <option value="<%=parametro.getNombre()%>"><%= parametro.getNombre()%> </option>
                       <%  } %>
                     </select>
				   </span></td>
				 </tr>
                 <tr>
                 <td>&nbsp;</td>
<td align="left"><span class="Estilo30">TIENE HUELLA</span></td>
<td>   <select  name="huellaT" id="huellaT" style="width:230px; font-size:12px; color:#000033">
						   <option value="1" > -- SI -- </option>
                                                   <option value="2" > -- NO -- </option>
						</select></tr>
			 </table>	
			 </fieldset>		 </td>
        </tr>
		<tr>
			<td colspan="4" align="center">&nbsp;</td>
		</tr>
		<tr>
		 <td colspan="4" scope="col" align="center">
                     <input type="submit" name="actionS" disabled="disabled" id="actionS" value="Guardar" style="width:150px"/> 		</td>
       </tr>
     </table>	</td>
  </tr>
</table>
</fieldset>
                                        
</form>	
</body>
<%  }else{%>
<script language="javascript" type="text/javascript">
alert("La Persona Tiene un Pago Relacionado a Tramites de un año anterior, Por favor Aplicar el excedente!");
</script>
                                    <%

}
	 }catch(Exception exc){
        exc.printStackTrace();
    }    %>
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