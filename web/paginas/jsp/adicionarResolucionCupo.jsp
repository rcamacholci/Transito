<%-- 
    Document   : registrarActaImportacion
    Created on : 19/04/2010, 02:42:41 PM
    Author     : SISTEMAS
--%>
<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html;charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" errorPage="" %>
<%
//try{
//	if(session.getAttribute("model")!=null){
//		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                       modelo.Model modelo = (modelo.Model)session.getAttribute("model");
    //                   String departamentoExpedicion="";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <title>JSP Page</title>
        <style type="text/css">
<!--
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style3 {color: #FFFFFF}
.style31 {color: #333333; font-size: 12px; font-weight: bold; font-family: Tahoma; }
.Estilo2 {color: #FFFFFF; 	font-family: Tahoma; 	font-size: 12px; 	font-weight: bold; }
-->
</style>
		<script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
		<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
                <script src="../html/scripts/personas.js" type="text/javascript"></script>
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

            function buscarLineas(){
		var tabla = document.getElementById('lineasdiv');
		var mr = document.getElementById('marcas').value;
		ajax2=nuevoAjax();
		ajax2.open("POST", "cargarLineas2.jsp",true);
		ajax2.onreadystatechange=function() {
			if (ajax2.readyState==4) {
				tabla.innerHTML = ajax2.responseText;
			}
		}
		ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		ajax2.send("marca="+mr+"&linea=0");
	}
    
    function consultaPersona(){
        var documento = document.getElementById("numeroSolicitante");
        if(!isNaN(documento.value)&&documento.value.length>0){
                var tipos = document.getElementById("tipoDocumento");
                var tipoDoc = tipos.options[tipos.options.selectedIndex].value
                var ajax2=nuevoAjax();
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
                                }else{
                                  document.form.nombreSolicitante.value = respuesta;
                                }
                        }
                }
                ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                ajax2.send("documento="+documento.value+"&tipo="+tipoDoc); 
        }
    }

    function consultaPersona2(){
        var documento = document.getElementById("numeroAseguradora");
        if(!isNaN(documento.value)&&documento.value.length>0){
                var tipos = document.getElementById("tipoDocumentos2");
                var tipoDoc = tipos.options[tipos.options.selectedIndex].value
                var ajax2=nuevoAjax();
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
                                }else{
                                  document.form.nombreAseguradora.value = respuesta;
                                }
                        }
                }
                ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                ajax2.send("documento="+documento.value+"&tipo="+tipoDoc);
        }
    }


    function validar(){
                  if(document.getElementById("mt").value.length>0){
                     if(document.getElementById("consecutivo").value.length>0){
                        if(document.getElementById("fecha").value.length>0){
                           if(document.getElementById("nombreSolicitante").value.length>0){
							  if(document.getElementById("modelo").value.length>0){
							     if(document.getElementById("motor").value.length>0){
                                    if(document.getElementById("lineas").value!=0){
									   if(document.getElementById("servicios").value!=0){
									      if(document.getElementById("pbv").value.length>0){
                                    			document.form.submit();
										  }else{
                                           	alert("Digite el valor PBV");
                                          }
                                       }else{
                                          alert("Seleccione el tipo de Servicio");
                                       }
                                  	}else{
                                       alert("Seleccione la linea del vehiculo");
                                  	}
                            	}else{
                                 	alert("Digite el numero del Motor");
                            	}
                         	}else{
                              alert("Digite el modelo");
                         	}
                    	  }else{
                            alert("Digite el nombre del solicitante");
                    	  }
	                	}else{
                    		alert("Seleccione la fecha");
                		}
					  }else{
                    	alert("Digite el Consecutivo");
                	  }
					 }else{
                    	alert("Digite el MT");
                	 }
      }


    </script>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
    <body>

        <form id="form" name="form" method="post" target="acta" action="procesarResolucionCupo.jsp">
      <fieldset>
		
		
	
		
		
		 <table width="79%" border="0" align="center" id="panelCaracteristicas">
            
               <tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="6" align="center"><span class="Estilo2">ADICIONAR RESOLUCION CUPO </span></td>
		  </tr>           
            <tr>
		  	<td colspan="6">&nbsp;</td>
		  </tr>
			<tr align="left" class="style1">
                 <td><span class="style2">
                   MT</span></td>
                 <td>&nbsp;</td>
				 <td>
                     <input name="mt" type="text" id="mt" style="width:200px; font-size:10px; color:#333333; text-align:center"/>                 </td>
                 
                 <td><span class="style2"> 
                   CONSECUTIVO
                 </span></td>
                 <td>&nbsp;</td>
				 <td><span class="Estilo6">
                 <input name="consecutivo" type="text" id="consecutivo" style="width:200px; font-size:10px; color:#333333; text-align:center" />
                 </span></td>
           </tr>
		   <tr align="left">
                 <td><span class="style2">
                   RESOLUCION
                 </span></td>
                 <td>&nbsp;</td>
				 <td>
                     <input name="resolucion" type="text" id="resolucion" style="width:200px; font-size:10px; color:#333333; text-align:center"/>                 </td>
                 
                 <td><span class="style2"> 
                   FECHA
                 </span></td>
                 <td>&nbsp;</td>
				 <td><span style="font-size: 10px">
			  <input id="fecha" name="fecha" type="text" style="width:130px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; font-size:10px; color:#333333; text-align:center"  onKeyUp="mascara(this,'/',true)" maxlength="10"/>
			 
              <input name="lanzador2" type="button" id="lanzador2" style="width:15px; color:#000000; font-size:10px" value="<"/>
			   <SCRIPT type="text/javascript">
				   Calendar.setup({
				   inputField     :    "fecha",      // id del campo de texto
				   ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				   button         :    "lanzador2"   // el id del botón que lanzará el calendario
				  });
	    		</SCRIPT>
			</span></td>
           </tr>
		   <tr align="left" class="style1">
		   <td><span class="style2">SOLICITANTE</span></td>
		   <td>&nbsp;</td>
		   <td><span class="Estilo5">
		     <select  name="tipoDocumento" id="tipoDocumento" style="width:152px; font-size:10px; color:#333333">
               <% java.util.List tipoDocumentos = modelo.listadoParametros(5);
		   for (int i = 0; i < tipoDocumentos.size(); i++) {
			   Parametro parametro = (Parametro) tipoDocumentos.get(i);
                                %>
               <option value="<%=parametro.getCodigo()%>" selected="selected"><%= parametro.getNombre()%> </option>
               <%          
                  } %>
             </select>
		   </span></td>
		   <td><input name="numeroSolicitante" type="text" id="numeroSolicitante"  style="width:120px; font-size:10px; color:#333333; text-align:center" onBlur="consultaPersona()"/></td>
		   <td colspan="2"><span class="Estilo6">
		     <input id="nombreSolicitante" name="nombreSolicitante" type="text"  style="width:270px; font-size:10px; color:#333333; text-align:center" readonly/>
		   </span></td>
		   </tr>
		   <tr align="left" class="style1">
		   <td><span class="style2">ASEGURADORA</span></td>
		   <td>&nbsp;</td>
		   <td><span class="Estilo5">
		     <select  name="tipoDocumentos2" id="tipoDocumentos2" style="width:152px; font-size:10px; color:#333333">
               <% java.util.List tipoDocumentos2 = modelo.listadoParametros(5);
		   for (int i = 0; i < tipoDocumentos2.size(); i++) {
			   Parametro parametro2 = (Parametro) tipoDocumentos2.get(i);
                            
                                %>
               <option value="<%=parametro2.getCodigo()%>" selected="selected"><%= parametro2.getNombre()%> </option>
               <%                              
                  } %>
             </select>
		   </span></td>
		   <td><input name="numeroAseguradora" type="text" id="numeroAseguradora"  style="width:120px; font-size:10px; color:#333333; text-align:center" onBlur="consultaPersona2()"/></td>
		   <td colspan="2"><span class="Estilo6">
		     <input id="nombreAseguradora" name="nombreAseguradora" type="text"  style="width:270px; font-size:10px; color:#333333; text-align:center" readonly/>
		   </span></td>
		   </tr>
           
               <tr align="left" class="style1">
                 <td width="18%" class="style2"> 
                   CLASE                </td>
                 <td width="5%" scope="col">&nbsp;</td>
                 <td width="27%" scope="col"><input name="clase" type="text" id="clase" style="width:200px; font-size:10px; color:#333333; text-align:center"/></td>
                 <td width="17%" scope="col"><span class="style2"> 
                   POLIZA</font></span></td>
                 <td width="5%" scope="col">&nbsp;</td>
                 <td width="28%" scope="col"><input name="poliza" type="text" id="poliza" style="width:200px; font-size:10px; color:#333333; text-align:center"/></td>
           </tr>
               <tr align="left" class="style1">
                   <td><span class="style2"> 
                   MARCA
                  </span></td>
                   <td>&nbsp;</td>
                   <td><span style="font-size: 10px">
                     <select name="marcas" id="marcas" onChange="buscarLineas()" style="width:202px; font-size:10px; color:#333333" >
                       <option value="0"><<--Seleccione Marca-->></option>
                       <% 
					java.util.List marcas = modelo.listadoMarcas();
					for (int i = 0; i < marcas.size(); i++) {
						 Marca marca = (Marca) marcas.get(i);
                                  %>
                       <option value="<%=marca.getCodigo()%>"><%= marca.getNombre()%> </option>
                       <% }%>
                   </select>
                   </span></td>
                   <td><span class="style2">
                 LINEA</span></td>
				 <td>&nbsp;</td>
                 <td><div id="lineasdiv"></div></td>
           </tr>
              
                             <tr align="left" class="style1">
                 <td><span class="style2">MODELO</span></td>
				 <td>&nbsp;</td>
                 <td colspan="">
                     <input name="modelo" type="text" id="modelo" maxlength="4" style="width:200px; font-size:10px; color:#333333;text-align:center"/></td>
                 <td><span class="style2"> 
                   SERVICIO
                  </span></td>
                 <td>&nbsp;</td>
                 <td>
		<select name="servicios" id="servicios"  style="width:202px; font-size:10px; color:#333333">
		<option value="0"><<--Seleccione Tipo Servicio-->></option>	
                     <% java.util.List servicios = modelo.listadoParametros(3);
                         for (int i = 0; i < servicios.size(); i++) {
                                Parametro parametro = (Parametro) servicios.get(i);
                      %>
                     <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                     <%   } %>
                </select></td>
           </tr>
              
               <tr align="left" class="style1">
                 <td><span class="style2">
                   MOTOR
                 </span></td>
                 <td>&nbsp;</td>
				 <td>
                     <input name="motor" type="text" id="motor" style="width:200px; font-size:10px; color:#333333; text-align:center"/>                 </td>
                 
                 <td><span class="style2"> 
                   CHASIS
                 </span></td>
                 <td>&nbsp;</td>
				 <td><span class="Estilo6">
                 <input name="chasis" type="text" id="chasis" style="width:200px; font-size:10px; color:#333333; text-align:center" />
                 </span></td>
           </tr>
               
               <tr align="left" class="style1">
                 <td> <span class="style2">
                   SERIE
                 </span> </td>
                 <td>&nbsp;</td>
				 <td>
                     <input name="serie" type="text" id="serie" style="width:200px; font-size:10px; color:#333333; text-align:center" />                    </td>
                 <td><span class="style2">PBV</span></td>
                 <td>&nbsp;</td>
				 <td><input id="pbv" name="pbv" type="text" style="width:200px; font-size:10px; color:#333333; text-align:center"/></td>
           </tr>
		    <tr align="left" class="style1">
                 <td> <span class="style2">
                 OBSERVACION</span></td>
                 <td>&nbsp;</td>
				 <td colspan="4">
                     <input name="observacion" type="text"  id="observacion" style="width:600px; height:40px; font-size:10px; color:#333333; text-align:center" />                    </td>
                 
           </tr>
		   
		   
			<tr>
		  	<td colspan="6"><iframe src="#" width="100%"  name="acta" id="acta" height="500" style="display:none"  frameborder="0" scrolling="auto"></iframe></td>
		  </tr>
      </table>
   
		 <table width="90%" border="0" align="center">
          <tr>
            
            <th width="50%" scope="col" style="border:none">
<button name="adicionar" type="button" id="adicionar" onClick="validar()" class="style2">Registrar <img src="../html/images/guardar.png" width="19" height="18" /></button>			
		<!--	<input name="adicionar" type="button" id="adicionar" value="Registrar" style="width:100px; text-align:center" onClick="validar()"/> --> </th>
          </tr>
        </table>
   </fieldset>
        </form>
				
    </body>
</html>

