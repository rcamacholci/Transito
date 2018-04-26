<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" import="modelo.*" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
 Model model= (Model)session.getAttribute("model");
                    %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Liquidacion de Carteras</title>
        <style type="text/css">
            <!--
            .Estilo4 {
                font-weight: bold;
                font-family: "Times New Roman", Times, serif;
                color: #FFFF99;
                font-size:12px;
            }
			
            -->
            
        </style>
	    <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <META http-equiv=Content-Type content="text/html; charset=windows-1252">
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script src="../html/scripts/personas.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript">
            function consultarPlacas(){
                if(document.form.placa.value.length>=2&&document.form.placa.value.length<=6){
					var nplaca = document.form.placa.value;
					document.form.placax.value = document.form.placa.value;
                    window.frames[0].location.href = "verCarteraLiquidacion.jsp?id=1&referencia="+nplaca;
					window.frames[4].location.href = "verLiquidacion.jsp?id=0&tipo=7";
                    consultarPlacas2();
                }else{
                    alert("Digite un numero de placa correcta");
                }
            }
                
            function consultarPlacas2(){
                if(document.form.placa.value.length>=2&&document.form.placa.value.length<=6){
                    var nplaca = document.form.placa.value;
                    window.frames[1].location.href = "verCarteraLiquidacion.jsp?id=2&referencia="+nplaca;
                    buscarPropietarios();
                    if(document.form.documento.value.length>=0&&document.form.documento.value.length<=11){
                        window.frames[1].location.href = "verCarteraLiquidacion.jsp?id=4&tipo="+document.form.tipos.options[document.form.tipos.selectedIndex].value+"&referencia="+document.form.documento.value;
                    }
                }else{
                    alert("Digite un numero de placa correcta");
                }          
            }
    
            function consultarDocumentos(){
                if(document.form.documento.value.length>=0&&document.form.documento.value.length<=11){
                    window.frames[0].location.href = "verCarteraLiquidacion.jsp?id=3&referencia=";
                    window.frames[1].location.href = "verCarteraLiquidacion.jsp?id=4&tipo="+document.form.tipos.options[document.form.tipos.selectedIndex].value+"&referencia="+document.form.documento.value;
                    window.frames[4].location.href = "verLiquidacion.jsp?id=0&tipo=7";
                    buscarPropietarios();
                }else{
                    alert("Digite un numero de documento correcto");
                }
            }

            function consultarConceptos(){
                var sede = document.getElementById('sede');
                if(sede!=null){
                    if(sede.options.selectedIndex==-1){
                        sede.options.selectedIndex = 0;
                    }
                    opcion = sede.options[sede.options.selectedIndex].value;
                    window.frames[3].location.href = "cargarConceptos.jsp?parametro="+opcion+"&like=";
                }		
            }
        
            function consultarTramites(){
                var sede = document.getElementById('sede');
                if(sede!=null){
                    if(sede.options.selectedIndex==-1){
                        sede.options.selectedIndex = 0;
                    }
		    		placa = document.form.placa.value;
                    opcion = sede.options[sede.options.selectedIndex].value;
                    window.frames[2].location.href = "liquidarTramites.jsp?parametro="+opcion+"&placa="+placa;
              }
            }
			
			function actualizarListados(){
				consultarTramites();
				consultarConceptos();
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

            function nuevoAjax1(){
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
			
			function nuevoAjax2(){
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

            function buscarPropietarios(){
                var opcion = document.getElementById('opciones');
                Nplaca= document.form.placa.value;
                Ntipo= document.form.tipos.options[document.form.tipos.options.selectedIndex].value;
                Ndoc= document.form.documento.value;
                ajax=nuevoAjax();
                ajax.open("POST", "cargarPropietarios.jsp",true);
                ajax.onreadystatechange=function() {
                    if (ajax.readyState==4) {
                        opcion.innerHTML = ajax.responseText
                        buscarSedes();
                    }
                }
                ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                ajax.send("parametro="+Nplaca+"&tipo="+Ntipo+"&documento="+Ndoc);
            }

            function buscarSedes(){
                var opcion1 = document.getElementById('sedes');
                valor1= document.form.placa.value;
                ajax1=nuevoAjax1();
                ajax1.open("POST", "cargarSedes.jsp",true);
                ajax1.onreadystatechange=function() {
                    if (ajax1.readyState==4) {
                        opcion1.innerHTML = ajax1.responseText
                        consultarConceptos();
                        consultarTramites();
			          }
                }
                ajax1.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                ajax1.send("parametro="+valor1)
            }

            function cambiarPago(){
                var tpago = document.getElementById('tipoPagos');
                var lvalor = document.getElementById('lvalor');
                var valor = document.getElementById('valor');	
                var lreferencia = document.getElementById('lreferencia');
                var referencia = document.getElementById('referencia');
                var lfecha = document.getElementById('lfecha');
                var fecha = document.getElementById('fecha');	
				var lbanco = document.getElementById('lbanco');
				var banco = document.getElementById('banco');
                var lanzador = document.getElementById('lanzador');		
                opcion = tpago.options[tpago.options.selectedIndex].value;
                if(opcion==1){
                    lvalor.style.display = 'none';
                    valor.style.display = 'none';
                    lreferencia.style.display = 'none';
                    referencia.style.display = 'none';
                    lfecha.style.display = 'none';
                    fecha.style.display = 'none';
                    lanzador.style.display = 'none';
                    lbanco.style.display = 'none';
                    banco.style.display = 'none';
                }else{
                    if(opcion>3){
                        lbanco.style.display = 'block';
                        banco.style.display = 'block';
                    }else{
                        lbanco.style.display = 'none';
                        banco.style.display = 'none';
                    }
                    lvalor.style.display = 'block';
                    valor.style.display = 'block';
                    lreferencia.style.display = 'block';
                    referencia.style.display = 'block';
                    lfecha.style.display = 'block';
                    fecha.style.display = 'block';
                    lanzador.style.display = 'block';
                    if(opcion==2){
                        //valor.value = "";
                        //fecha.value = "";
                        //valor.readOnly = true;
                        //fecha.readOnly = true;
                        //lanzador.disabled = true;
                    }else{
                        valor.readOnly = false;
                        fecha.readOnly = false;
                        lanzador.disabled = false;
                    }
                }
            }

            function buscarReferencia(ref){
                var referencia = ref;
                var tpago = document.getElementById('tipoPagos');
                opcion = tpago.options[tpago.options.selectedIndex].value;
                if(opcion==2&&referencia.value.length>0){
                    document.getElementById('valor').value = "";
                    document.getElementById('fecha').value = "";
                    var ajax=nuevoAjax2();
                    ajax.open("POST", "consultarReferenciaTipoPago.jsp",true);
                    ajax.onreadystatechange=function() {
                        if (ajax.readyState==4) {
                            var respuesta = "";
                            var xmldoc = ajax.responseXML;
                            var respuesta = xmldoc.getElementsByTagName('respuesta')[0];
                            var estado = respuesta.getElementsByTagName('estado')[0].childNodes[0].nodeValue;
                            var valor = respuesta.getElementsByTagName('valor')[0].childNodes[0].nodeValue;
                            var fecha = respuesta.getElementsByTagName('fecha')[0].childNodes[0].nodeValue;
                            if(estado.length>0){
                                if(estado==-1){
                                    alert("No existe registrado un titulo valor con esa referencia");
                                }else{
                                    if(estado==2){
                                        alert("E titulo valor ya fue aplicado");
                                    }else{
                                        if(estado==3){
                                            alert("El titulo valor se encuentra anulado");
                                        }else{
                                            if(estado==1){
                                                document.getElementById('valor').value = valor;
                                                document.getElementById('fecha').value = fecha;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                    ajax.send("tipoPago="+opcion+"&referencia="+referencia.value);
                }
            }

            function mostrarPanel(caso){
			    var carteraVehiculo = document.getElementById('carteraVehiculo');	
                var carteraPersona = document.getElementById('carteraPersona');	
                var conceptos = document.getElementById('conceptos');	
                var tramites = document.getElementById('tramites');	
                var im1 = document.getElementById('im1');
                var im2 = document.getElementById('im2');
                var im3 = document.getElementById('im3');
                var im4 = document.getElementById('im4');
                if(caso == 1){
                    carteraVehiculo.style.display = 'block';
                    carteraPersona.style.display = 'none';
                    conceptos.style.display = 'none';
                    tramites.style.display = 'none';
                    im1.src = "../html/images/vehiculo_on.png";
                    im2.src = "../html/images/personas_off.png";
                    im3.src = "../html/images/tramites_off.png";
                    im4.src = "../html/images/conceptos_off.png";		
                }else{
                    if(caso == 2){
                        carteraVehiculo.style.display = 'none';
                        carteraPersona.style.display = 'block';
                        conceptos.style.display = 'none';
                        tramites.style.display = 'none';
                        im1.src = "../html/images/vehiculo_off.png";
                        im2.src = "../html/images/personas_on.png";
                        im3.src = "../html/images/tramites_off.png";
                        im4.src = "../html/images/conceptos_off.png";				
                    }else{
                        if(caso == 3){
                            carteraVehiculo.style.display = 'none';
                            carteraPersona.style.display = 'none';
                            conceptos.style.display = 'none';
                            tramites.style.display = 'block';
                            im1.src = "../html/images/vehiculo_off.png";
                            im2.src = "../html/images/personas_off.png";
                            im3.src = "../html/images/tramites_on.png";
                            im4.src = "../html/images/conceptos_off.png";	
                        }else{
                            if(caso == 4){
                                carteraVehiculo.style.display = 'none';
                                carteraPersona.style.display = 'none';
                                conceptos.style.display = 'block';
                                tramites.style.display = 'none';
                                im1.src = "../html/images/vehiculo_off.png";
                                im2.src = "../html/images/personas_off.png";
                                im3.src = "../html/images/tramites_off.png";
                                im4.src = "../html/images/conceptos_on.png";	
                            }
                        }	
                    }
                }
            }
			function cleaner(){
				if(confirm("Esta seguro de borrar, la lista de Conceptos?")){
					window.frames[4].location.href = "verLiquidacion.jsp?id=0&tipo=7";
					consultarPlacas();
				}
			}
			
			function liquidacion(id){
				var accept = true;
                                var paso = true;
				valor = parseFloat(document.getElementById('totalidad').value);
                                var codeSec = "";
                                if(document.getElementById("tipoPagos").value.length>0){
                                    if(parseInt(document.getElementById("tipoPagos").value)!=1){
                                            valor_tipo = parseFloat(document.getElementById("valor").value==''?0:document.getElementById("valor").value);
                                            if(valor_tipo<parseFloat(document.getElementById('totalidad').value)){
                                                    if(valor_tipo<parseFloat(document.getElementById('totalidadT').value)){
                                                            accept = false;
                                                            alert("El valor a pagar, debe ser igual o mayor al total por conceptos y tramites");
                                                    }else{
                                                            valor = valor_tipo;
                                                    }
                                            }else{
                                                if(parseInt(document.getElementById("tipoPagos").value)==2||parseInt(document.getElementById("tipoPagos").value)==7){
                                                    valor = valor_tipo;
                                                }
                                            }
                                        if(parseInt(document.getElementById("tipoPagos").value)==7){
                                            while(true){
                                                codeSec = prompt("Digite codigo de securidad","");
                                                if(codeSec!=null){
                                                    var verSec = "" ;
                                                    for(var i = 0; i < codeSec.length ; i++){
                                                        if(!isNaN(codeSec.charAt(i)))
                                                            verSec += codeSec.charAt(i);
                                                    }
                                                    if(codeSec==verSec&&codeSec.length==4){
                                                        paso = true;
                                                        break;
                                                    }else{
                                                        alert("Codigo debe ser solo de cuatro digitos numericos");
                                                    }
                                                }else{
                                                    paso = false;
                                                }
                                            }
                                        }
                                    }
                                }
                                if(accept&&paso){
					if(document.getElementById("propietario")!=null){
						if(confirm("Esta seguro aplicar esta liquidacion")){
                                                        document.getElementById('impresion').style.display = 'none';
                                                        //document.getElementById('liquidar').style.display = 'none';
                                                        document.getElementById('aplicar').style.display = 'none';
                                                        document.getElementById('limpiar').style.display = 'none';
							persona = document.getElementById("propietario").value;
                                                        sede = document.getElementById("sede").value;
                                                        pago = document.getElementById("tipoPagos").value;
                                                        placa = document.getElementById("placax").value;
                                                        referencia = document.getElementById("referencia").value;
                                                        banco = document.getElementById("banco").value;
                                                        fecha = document.getElementById("fecha").value;
							var liqrunt = document.getElementById("liqrunt").checked?1:0;
							var liqtransito = document.getElementById("liqtransito").checked?1:0;
							if(liqrunt!=0||liqtransito!=0){
                                                        window.frames[5].location.href = "factura.jsp?persona="+persona+"&sede="+sede+"&pago="+pago+"&placa="+placa+"&valor="+valor+"&referencia="+referencia+"&fecha="+fecha+"&banco="+banco+"&liqrunt="+liqrunt+"&liqtransito="+liqtransito+"&scnc="+codeSec;
							}else{
								alert("Debe seleccionar al menos una generacion de pagos");
							}	
						}
					}else{
						alert("No existe persona registrada para la liquidacion del Tramite");
					}	
				}	
			}
			
			function nueva_liquidacion(){
				document.location.href = "Liquidacion.jsp";
			}
			
			function consultaPersona(){
				var documento = document.getElementById("documento");
				if(!isNaN(documento.value)&&documento.value.length>0){
					var tipos = document.getElementById("tipos");
					var tipoDoc = tipos.options[tipos.options.selectedIndex].value
					var ajax2=nuevoAjax2();
					ajax2.open("POST", "getPersona.jsp",true);
					ajax2.onreadystatechange=function() {
						if (ajax2.readyState==4) {
							var respuesta = "" ;
							for(var i = 0; i < ajax2.responseText.length ; i++){
								if(isNaN(ajax2.responseText.charAt(i))||ajax2.responseText.charAt(i)==' ')
									respuesta += ajax2.responseText.charAt(i);
							}
							if(respuesta.indexOf("nueva")!=-1){
								viewPersona(tipoDoc,documento.value);
							}        
						}
					}
					ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
					ajax2.send("documento="+documento.value+"&tipo="+tipoDoc); 
				}
			}
			
			function deshBoton(){
                            if(document.form.placa.value!=0)
                                document.form.consultarDocumento.disabled = true;
                            else
                                document.form.consultarDocumento.disabled = false;
                        }
        </script>
        <style type="text/css">
<!--
.Estilo7 {color: #006699}
.Estilo10 {
	color: #333333;
	font-weight: bold;
	font-size: 14px;
}
.Estilo15 {
	color: #003399;
	font-size: 16px;
}
.Estilo16 {color: #333333}
.Estilo19 {
	font-size: 12px;
	font-weight: bold;
	color: #333333;
}
.Estilo20 {
	font-size: 13px;
	font-weight: bold;
	color: #0066CC;
}
-->
        </style>
</head>
    <%
            try {
                session.removeAttribute("reporteOT");
                session.removeAttribute("reporteRUNT");
		session.removeAttribute("claseV");
            } catch (Exception exc) {
                exc.printStackTrace();
            }
    %>
    <body>
	<form name="form" method="post" action="#">
        <table width="92%" height="615" border="0" align="left">
            <tr>
                <th height="30" colspan="2" scope="col">
					<fieldset>
					<legend class="Estilo20">CAJA DE APLICACION DE PAGOS</legend>
                        <table width="94%" border="0">
                            <tr>
                              <th width="6%" scope="col"><label style="color:#CC0000"><span class="Estilo19">PLACA</span></label></th>
                                <th width="13%" scope="col">
                                    <input id="placa" name="placa" type="text" size="20" maxlength="6" style="text-align:center;color:#333333;text-transform:uppercase" onkeyup="deshBoton()"/>
				<input type="hidden" id="placax" value=""/>
                               </th>
                             
                                    <th width="15%" scope="col"><input id="consultarPlaca" type="button" value="Consultar" onclick="consultarPlacas()"/></th>
                              
                              <th width="12%" scope="col"><label style="color:#CC0000"><span class="Estilo19">TIPO&nbsp;DOCUMENTO </span></label></th>
                                <th width="17%" scope="col">
                                    
                                    
                                <select name="tipos" id="tipos" size="1" style="width:10;size:4;color:#333333; ">
                                        <%
            try {
                long fk_grupo = 5;
                java.util.List listaTipos = model.listadoParametros(fk_grupo);
                for (int i = 0; i < listaTipos.size(); i++) {
                    Parametro parametro = (Parametro) listaTipos.get(i);%>
                                        <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
                                        <%	}
            } catch (Exception exc) {
                out.println(exc.getMessage());
            }%>	
                                  </select>		
                              </th>
                              <th width="10%" scope="col"><label style="color:#CC0000"><span class="Estilo19">DOCUMENTO</span></label></th>
                              <th width="13%" scope="col">
                   <input name="documento" id="documento" type="text" size="20" maxlength="11" style="text-align:center; color:#333333;" onblur="consultaPersona()"/>
							  </th>
                         
                                    <th width="14%" scope="col"><input id="consultarDocumento" type="button" value="Consultar" onclick="consultarDocumentos()"/></th>
                             
                            </tr>
                      </table>
               		</fieldset>
                </th>
            </tr>
            <tr valign="top">
                <th width="55%" height="511" scope="row" valign="top" align="left">
                    <table width="100%" border="1" align="left" style="border:none" cellpadding="0" cellspacing="0">
                        <tr style="border:none" bgcolor="#FFFFFF" >
                           
                            <th align="center" class="Estilo4" style="border:none" scope="col" onclick="mostrarPanel(1)">
                            <img src="../html/images/vehiculo_on.png" width="85" height="19" id="im1"  style="cursor:pointer"/></th>
                            <th align="center" class="Estilo4" style="border:none" scope="col" onclick="mostrarPanel(2)">
                            <img src="../html/images/personas_off.png" width="85" height="19" id="im2"   style="cursor:pointer"/></th>
                            <th align="center" class="Estilo4" style="border:none" scope="col" onclick="mostrarPanel(3)">
                            <img src="../html/images/tramites_off.png" width="85" height="19" id="im3"   style="cursor:pointer"/></th>
                            <th align="center" class="Estilo4" style="border:none" scope="col" onclick="mostrarPanel(4)">
                            <img src="../html/images/conceptos_off.png" width="85" height="19" id="im4"  style="cursor:pointer"/></th>
                      </tr>
                        <tr>
                            <th height="469" colspan="4" class="Estilo4" scope="col" valign="top">
                                <iframe src="verCarteraLiquidacion.jsp?id=0" id="carteraVehiculo"  marginwidth="0" height="400" width="100%" marginheight="0" align="top" scrolling="auto" style="display:block; border:none"></iframe>
                                <iframe src="verCarteraLiquidacion.jsp?id=0" id="carteraPersona" marginwidth="0" height="400"  width="100%" marginheight="0" align="top" scrolling="auto" style="display:none; border:none"></iframe>
                                <iframe src="verCarteraLiquidacion.jsp?id=0" id="tramites" marginwidth="0" height="400"  width="100%" marginheight="0" align="top" scrolling="auto" style="display:none; border:none"></iframe>
                                <iframe src="verCarteraLiquidacion.jsp?id=0" id="conceptos" marginwidth="0" height="403"  width="100%" marginheight="0" align="top" scrolling="auto" style="display:none; border:none"></iframe>                            </th>
                        </tr>
                  </table>
              </th>
                <th width="45%" valign="top">
                    <table width="100%" border="0" id="contenedor" style="border:0" cellpadding="0" cellspacing="0">
						<tr id="propieta_sede">
                            <td>
							  <fieldset>
							    <legend class="Estilo19">INFORMACION DEL PROPIETARIO</legend>
                                <table width="100%" border="0" style="border:none" cellpadding="0" cellspacing="0">
									
									 <tr>
                                         <td colspan="4" align="left">
                                            <div id="opciones" align="center" style="width:430px;font-size:11px"></div>                                        </td>
                                    </tr>
                                    <tr>
                                        <th align="left" colspan="1"><label style="color:#CC0000"><span class="Estilo19">SEDE</span></label></th>
                                         <td colspan="3" align="left">
                                            <div id="sedes" align="left" style="width:350px;font-size:11px"></div>                                        </td>
                                    </tr>
                                    <tr>
                                        <th colspan="1" align="left"><label id="ltipo" style="color:#CC0000"><span class="Estilo7"><span class="Estilo19">TIPO PAGO </span></span></label></th>
                                        <th align="left" colspan="1"><select name="tipoPagos" id="tipoPagos" size="1" style="width:170px;size:4;color:#333333; font-size:11px " onchange="cambiarPago()" onclick="cambiarPago()">
                                                <%
                Usuario user = (Usuario)session.getAttribute("usuario");
                Taquilla taq= model.consultar_Taquilla_Actual(user.getFk_sede(),user.getId_usuario());
                java.util.List listaTiposPagos = model.consultarTipoPagoByUsuario(user.getId_usuario(),taq!=null?taq.getFk_caja():0);
                for (int i = 0; i < listaTiposPagos.size(); i++) {
                    Parametro parametro = (Parametro) listaTiposPagos.get(i);%>
                                                <option value="<%=parametro.getCodigo() + ""%>" <%=(parametro.getCodigo()==1?"selected":"")%>><%=parametro.getNombre()%></option>
             <%	}    %>	
                                        </select></th>
                                        
                                        <th colspan="1" align="left">
                                            <label id="lreferencia" style="color:#CC0000; display:none"><span class="Estilo19">REFERENCIA</span></label></th>
                                        <th align="left" colspan="1">
                                            <input name="referencia" type="text" id="referencia" value="" style="color:#333333; width:170px; display:none;font-size:11px "/><!-- onblur="buscarReferencia(this)" /-->
                                            </th>
                                    </tr>
									
									
                                    <tr>
                                        <th colspan="1" align="left"><label id="lvalor" style="color:#CC0000; display:none"><span class="Estilo19">VALOR</span></label>                                        </th>
                                        <th align="left" colspan="1">	<input name="valor" type="text" id="valor" style="text-align:right;color:#333333; width:110px; display:none;font-size:11px " value="" size="20"/>   </th>
                                        <th colspan="1"  align="left"><label id="lfecha" style="color:#CC0000; display:none"><span class="Estilo19">FECHA</span></label></th>
                                        
                                        <th colspan="1" align="left">
											<table width="100%" border="0">
												<tr>
													<th width="79%" align="left" scope="col">
														
												  <input  id="fecha" name="date" style="text-align:center; width:90px; display:none;font-size:11px"/>                                                	</th>
													<th width="21%" scope="col">
														
												  <input name="button" style="color:#0066CC;width:18px; display:none ;font-size:11px" type="button" id="lanzador" value="<"  />
													<script type="text/javascript">
														Calendar.setup({
															inputField     :    "fecha",      // id del campo de texto\par
															ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto\par
															button         :    "lanzador"   // el id del bot\'f3n que lanzar\'e1 el calendario\par
														});
													</script>                                                  </th>
												</tr>
											</table>										</th>
								  </tr>
								  <tr>
                                        <th align="left" colspan="1">
										<label id="lbanco" style="color:#CC0000;display:none"><span class="Estilo19">BANCO</span></label></th>
                                         <td colspan="3" align="left">
                                            <select name="banco" id="banco" size="1" style="width:350px;size:4;color:#333333;display:none;font-size:11px">
                                                <%
                                                    try {
                                                            java.util.List listaBancos = model.listado_bancos();
                                                            for (int i = 0; i < listaBancos.size(); i++) {
                                                                    Banco banco = (Banco) listaBancos.get(i);%>
                                                                    <option value="<%=banco.getId_banco()%>" </option>
                                                                    <%	}
                                                    } catch (Exception exc) {
                                                            out.println(exc.getMessage());
                                                    }%>
											</select>										</td>
                                  </tr>
                                </table>
                              </fieldset>                            </td>
                        </tr>
                        <% boolean aplicarSinTaquilla = false; %>
						<tr>
                           <td valign="top" width="100%" align="right">
						   		<table align="center" border="0" cellspacing="0" cellpadding="0" width="100%">
									<tr>
										<td width="40%" align="center">
											<span class="Estilo19">Generar&nbsp;liquidacion&nbsp;ITA</span>
                                                                                        <% if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("aplicarPagosTransito")){
                                                                                                if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("aplicarPagosRunt")){ %>
                                                                                                    <input type="checkbox" name="liqtransito" id="liqtransito" value="1" checked/>
                                                                                             <% }else{ %>
                                                                                                    <input type="checkbox" name="liqtransito" id="liqtransito" value="1" checked disabled/>
                                                                                        <%      }
                                                                                           }else{ %>
                                                                                               <input type="checkbox" name="liqtransito" id="liqtransito" value="0" disabled/>
                                                                                        <% } %>										</td>
										<td width="40%" align="right">
											<span class="Estilo19">Generar&nbsp;liquidacion&nbsp;RUNT</span>
                                                                                        <% if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("aplicarPagosRunt")){
                                                                                                if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("aplicarPagosTransito")){ %>
                                                                                                    <input type="checkbox" name="liqrunt" id="liqrunt" value="1"/>
                                                                                             <% }else{
                                                                                                    aplicarSinTaquilla = true;  %>
                                                                                                    <input type="checkbox" name="liqrunt" id="liqrunt" value="1" checked disabled/>
                                                                                        <%      }
                                                                                           }else{ %>
                                                                                               <input type="checkbox" name="liqrunt" id="liqrunt" value="0" disabled/>
                                                                                        <% } %>										</td>
										<td width="20%" align="center">
											<input name="impresion" id="impresion" style="display:none" type="button" value="Nuevo" onclick="nueva_liquidacion()"/>										</td>
									</tr>	
								</table>						  </td>
                        </tr>
                        <tr>
                            <td height="250" valign="top" width="100%"><iframe src="verLiquidacion.jsp" id="liquidacion" width="480" height="250"  frameborder="0" scrolling="auto"></iframe>
                              <iframe src="#" width="480" id="liquidacionf" height="500"  frameborder="0" scrolling="auto" style="display:none"></iframe>						  </td>
                        </tr>
						<tr id="totalizador">
							<td>
								<fieldset>
									<table width="100%" border="0" >
                                                                        <%
                                                                           boolean estadoT = taq!=null?(taq.getEstado()==1?true:false):false;
                                                                           if(estadoT||aplicarSinTaquilla){  %>
                                                                              <tr>
                                                                                    <th width="17%" scope="col"><input name="limpiar" id="limpiar" type="button" value="Limpiar" onclick="cleaner()" disabled/></th>
                                                                                    <th width="15%" align="left" scope="col"><span style="color: #0066CC">
                                                                                      <label style="color: #333333"><span class="Estilo16"><span class="Estilo19">TOTAL</span>:</span></label>
                                                                                    </span>
                                                                                    <input type="hidden" name="totalidad" id="totalidad" value="0" />
                                                                                    <input type="hidden" name="totalidadT" id="totalidadT" value="0" />                                                                                    </th>
                                                                                    <th width="28%" align="right" scope="col"><label id="total"><span class="Estilo15">$&nbsp;0</span></label></th>
                                                                                  
                                                                                    <th width="20%" scope="col">&nbsp;<!--input name="liquidar" id="liquidar" type="button" value="Liquidar" onclick="liquidacion(0)" disabled/--></th>
                                                                                   
                                                                                  
                                                                                        <th width="20%" scope="col"><input name="aplicar" id="aplicar" type="button" value="Aplicar" onclick="liquidacion(1)" disabled/></th>
                                                                              </tr>
                                                                          <% }else{  %>
                                                                               <tr>
                                                                                    <th width="100%" scope="col" colspan="5"><span class="Estilo19">NO EXISTEN TAQUILLAS ABIERTAS</span></th>
                                                                              </tr>
                                                                          <% }  %>
								   </table>
							  </fieldset>						  </td>
						</tr>
                    </table>
              </th>
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