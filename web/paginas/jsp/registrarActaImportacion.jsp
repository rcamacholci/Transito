<%-- 
    Document   : registrarActaImportacion
    Created on : 19/04/2010, 02:42:41 PM
    Author     : SISTEMAS
--%>
<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html;charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                       modelo.Model modelo = (modelo.Model)session.getAttribute("model");
                       String departamentoExpedicion="";
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
.style1 {
	font-family: Tahoma;
	font-weight: bold;
	font-size: 12px;
	color: #333333;
}
.Estilo5 {	color: #333333;
	font-size: 10px;
}
.style2 {
	color: #FFFFFF;
	font-weight: bold;
	font-size: 12px;
	font-family: Tahoma;
}
.Estilo6 {font-size: 10px}
.Estilo4 {color: #333333;font-size: 14px;}
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

        function buscarMunicipios(){
		tabla = document.getElementById('municipios');
		document.getElementById('municipio').style.display = 'none';
		valor=document.form.departamentos.options[document.form.departamentos.selectedIndex].value;
		ajax=nuevoAjax();
		ajax.open("POST", "cargarMunicipiosActa.jsp",true);
		ajax.onreadystatechange=function() {
			if (ajax.readyState==4) {
				tabla.innerHTML = ajax.responseText
			}
		}
		ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		ajax.send("fk_dpto="+valor)

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
        var documento = document.getElementById("numeroImportador");
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
                                  document.form.nombreImportador.value = respuesta;
                                }
                        }
                }
                ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                ajax2.send("documento="+documento.value+"&tipo="+tipoDoc); 
        }
    }

    function validar(){
                  if(document.getElementById("nombreImportador").value.length>0){
                        if(document.getElementById("fechaLevantamiento").value.length>0){
                             if(document.getElementById("numeroLevante").value.length>0){
                                  if(document.getElementById("fechaManifiesto").value.length>0){
                                      if(document.getElementById("numeroManifiesto").value.length>0){
                                          if(document.getElementById("tipoRegistro").value!=0){
                                              if(document.getElementById("departamentos").value!=0){
                                                  if(document.getElementById("municipio").value!=0){
                                                        if(document.getElementById("clases").value!=0){
                                                             if(document.getElementById("marcas").value!=0){
                                                                if(document.getElementById("lineas").value!=0){
                                                                     if(document.getElementById("carrocerias").value!=0){
                                                                         if(document.getElementById("modelo").value.length>0&&!isNaN(document.getElementById("modelo").value)){
                                                                             if(document.getElementById("combustibles").value!=0){
                                                                                   if(document.getElementById("motor").value.length>0){
                                                                                         if(document.getElementById("chasis").value.length>0){
                                                                                             if(!isNaN(document.getElementById("ejes").value)){
                                                                                                    if(document.getElementById("cilindraje").value.length>0){
                                                                                                        if(document.getElementById("pasajeros").value.length>0&&!isNaN(document.getElementById("pasajeros").value)){
                                                                                                                if(document.getElementById("tipoAutomotor").value!=0){
                                                                                                                    if(document.getElementById("origenVehiculo").value!=0){
                                                                                                                        document.form.submit();
                                                                                                                    }else{
                                                                                                                        alert("Digite el origen del vehiculo");
                                                                                                                    }
                                                                                                                }else{
                                                                                                                    alert("Digite el tipo de automotor");
                                                                                                                }
                                                                                                        }else{
                                                                                                            alert("Digite el numero de pasajeros Valido para este campo");
                                                                                                        }
                                                                                                 }else{
                                                                                                    alert("Digite el cilindraje");
                                                                                                }
                                                                                             }else{
                                                                                                  alert("No puede digitar letras en Nro de ejes");
                                                                                             }
                                                                                         }else{
                                                                                              alert("Digite el numero de chasis");
                                                                                         }
                                                                                   }else{
                                                                                         alert("Digite el numero de motor");
                                                                                   }
                                                                             }else{
                                                                                  alert("seleccione el tipo de combustible");
                                                                             }
                                                                         }else{
                                                                             alert("Digite un numero Valido para el modelo");
                                                                         }

                                                               }else{
                                                                     alert("Seleccione la carroceria");
                                                               }
                                                          }else{
                                                               alert("Seleecione la linea");
                                                          }
                                                     }else{
                                                         alert("Seleccione la marca");
                                                     }

                                           }else{
                                                 alert("Seleccione la clase");
                                           }
                                                  }else{
                                                          alert("Seleccione el municipio de expedicion");
                                                  }
                                              }else{
                                                  alert("Seleccione el departamento de expedicion");
                                              }
                                      }else{
                                          alert("Seleccione el tipo de registro");
                                      }
                                  }else{
                                       alert("Digite el numero del manifiesto");
                                  }
                            }else{
                                 alert("Digite la fecha del manifiesto");
                            }
                         }else{
                              alert("Digite el numero de levante");
                         }
                    }else{
                         alert("Digite la fecha de levante");
                    }

                }else{
                    alert("Digite nombre del importado");
                }
         }


    </script>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
    <body>

        <form id="form" name="form" method="post" target="acta" action="procesarImportacion.jsp">
      <fieldset>
		
		<table border="0" align="center" width="90%">
			<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="6" align="center"><span class="style2">DATOS DEL IMPORTADOR</span></td>
		  </tr>
		  <tr>
		  	<td colspan="6">&nbsp;</td>
		  </tr>
			
			<tr class="style1">
			<td width="14%"><span class="Estilo6">IMPORTADOR</span></td>
			<td width="20%"><span class="Estilo5">
			  <select  name="tipoDocumento" id="tipoDocumento" style="width:152px; font-size:10px; color:#333333">
                <% java.util.List tipoDocumentos = modelo.listadoParametros(5);
		   for (int i = 0; i < tipoDocumentos.size(); i++) {
			   Parametro parametro = (Parametro) tipoDocumentos.get(i);
                            if(parametro.getCodigo()==2){
                                %>
                             <option value="<%=parametro.getCodigo()%>" selected="selected"><%= parametro.getNombre()%> </option>
                <%   
                            }
                  } %>
            </select>
			</span></td>
			<td width="14%"><span class="Estilo6">NUMERO NIT</span></td>
			<td width="18%"><input name="numeroImportador" type="text" id="numeroImportador"  style="width:150px; font-size:10px; color:#333333; text-align:center" onblur="consultaPersona()"/></td>
			<td colspan="2"><span class="Estilo6">&nbsp;
	            <input id="nombreImportador" name="nombreImportador" type="text"  style="width:270px; font-size:10px; color:#333333; text-align:center" readonly/>
			</span></td>
			</tr>
			<tr class="style1">
			<td><span class="Estilo6">FEC.&nbsp;MANIFIESTO </span></td>
			<td><span style="font-size: 10px">
			  <input id="fechaManifiesto" name="fechaManifiesto" type="text" style="width:130px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; font-size:10px; color:#333333; text-align:center"  onKeyUp="mascara(this,'/',true)" maxlength="10"/>
			 
              <input name="button2" type="button" id="lanzador2" style="width:15px; color:#000000; font-size:10px" value="<"/>
			   <SCRIPT type="text/javascript">
				   Calendar.setup({
				   inputField     :    "fechaManifiesto",      // id del campo de texto
				   ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				   button         :    "lanzador2"   // el id del botón que lanzará el calendario
				  });
	    		</SCRIPT>
			</span></td>
			<td><span class="Estilo6">NUM.&nbsp;MANIFIESTO</span></td>
			<td><input name="numeroManifiesto" type="text" id="numeroManifiesto" style="width:150px; font-size:10px; color:#333333; text-align:center"/></td>
			<td width="15%"><span class="Estilo6">TIPO&nbsp;REGISTRO </span></td>
			<td width="19%"><span style="font-size: 10px">
			  <select name="tipoRegistro" id="tipoRegistro" style="width:155px; font-size:10px; color:#333333">
                <option value="0"><<--Seleccione Tipo Registro-->></option>
                <% java.util.List tipoRegistro = modelo.consultarParametrosRUNT(95);
                 for (int i = 0; i < tipoRegistro.size(); i++) {
                    String[] valores = (String[])tipoRegistro.get(i); %>
                <option  value="<%=valores[0]%>"><%= valores[1] %></option>
                <%} %>
              </select>
		    
            </span></td>
			</tr>
			<tr class="style1">
			<td><span class="Estilo6">FEC.&nbsp;LEVANTE</span></td>
			<td><span style="font-size: 10px">
			  <input id="fechaLevantamiento" name="fechaLevantamiento" type="text"  style="width:130px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; font-size:10px; color:#333333; text-align:center"  onKeyUp="mascara(this,'/',true)" maxlength="10"/>
			  <input name="button" type="button" id="lanzador" style="width:15px;color:#333333; font-size:10px" value="<"/>
			   <SCRIPT type="text/javascript">
				   Calendar.setup({
				   inputField     :    "fechaLevantamiento",      // id del campo de texto
				   ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				   button         :    "lanzador"   // el id del botón que lanzará el calendario
				  });
	    		</SCRIPT>
			</span></td>
			<td><span class="Estilo6">NUM. LEVANTE </span></td>
			<td><input name="numeroLevante" type="text" id="numeroLevante" style="width:150px; font-size:10px; color:#333333; text-align:center"/></td>
			<td><span class="Estilo6">PAIS ORIGEN </span></td>
			<td><span style="font-size: 10px">
			  <select name="pais" id="pais" style="width:155px; font-size:10px; color:#333333">
			    <option value="0"><<--Seleccione Pais Origen-->></option>
			    <% java.util.List paisO = modelo.consultarParametrosRUNT(33);
                 for (int i = 0; i < paisO.size(); i++) {
                    String[] valores = (String[])paisO.get(i); %>
			    <option  value="<%=valores[0]%>"><%= valores[1] %></option>
			    <%} %>
		    </select>
			  </span></td>
			</tr>
			
		  <tr class="style1">
		  	<td colspan=""><span class="Estilo6">DEPARTAMENTO</span></td>
			<td colspan=""><span class="Estilo6"><span class="Estilo4">
			  <select name="departamentos" id="departamentos" style="width:152px; font-size:10px; color:#333333"  onchange="buscarMunicipios(); return false" >
                <% List listaDepar_per = modelo.crearListaDpto();

		   Iterator it_dep_per = listaDepar_per.iterator();
                       while (it_dep_per.hasNext()) {
                        	Departamento dpto = (Departamento)it_dep_per.next();
                %>
                       <option value="<%=dpto.getId_departamento()+""%>"><%=dpto.getNombre()%></option>
                       <%
                   }%>
              </select>
			</span></span></td>
			<td colspan=""><span class="Estilo6">MUNICIPIO</span></td>
			<td colspan=""><div class="Estilo4" id="municipios">
			  <select name="municipio" id="municipio" style="width:152px; font-size:10px; color:#333333">
                <%
			 if(departamentoExpedicion.length()>0){
                                java.util.List lista = modelo.crearListaMunicipios(Integer.parseInt(departamentoExpedicion));
				for (int i = 0; i < lista.size(); i++) {
				Municipio municipio = (Municipio) lista.get(i);
				%>
                                <option value="<%=municipio.getCodigo() + ""%>"><%=municipio.getNombre()%></option>
                     <%         }
                         } %>
              </select>
              </div></td>
			<td colspan=""><span class="Estilo6"></span></td>
			<td colspan=""><span class="Estilo6"></span></td>
		  </tr>
		  <tr>
		  	<td colspan="6">&nbsp;</td>
		  </tr>
	</table>
	
		
		
		 <table width="90%" border="0" align="center" id="panelCaracteristicas">
            
               <tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="6" align="center"><span class="style2">DATOS DEL VEHICULO</span></td>
		  </tr>           
            <tr>
		  	<td colspan="6">&nbsp;</td>
		  </tr>
			
               <tr align="left" class="style1">
                 <td width="18%" class="Estilo6"> 
                   CLASE                </td>
                 <td width="5%" scope="col">&nbsp;</td>
                 <td width="27%" scope="col"><span style="font-size: 10px">
                   <select name="clases" id="clases"  style="width:202px; font-size:10px; color:#333333">
                     <option value="0"><<--Seleccione Clase-->></option>			
                     <%  java.util.List clases = modelo.listadoParametros(1);
                            for (int i = 0; i < clases.size(); i++) {
                                Parametro parametro = (Parametro) clases.get(i);%>
                     <option  value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%></option>
                      <%} %>
                   </select>
                 </span> </td>
                 <td width="17%" scope="col"><span class="Estilo6"> 
                   CARROCERIA</font></span></td>
                 <td width="5%" scope="col">&nbsp;</td>
                 <td width="28%" scope="col"><select name="carrocerias" id="carrocerias" style="width:202px; font-size:10px; color:#333333" >
                   <option value="0"><<--Seleccione Carroceria-->></option>
                   <%
		java.util.List carrocerias = modelo.listadoParametros(2);
		for (int i = 0; i < carrocerias.size(); i++) {
			Parametro parametro = (Parametro) carrocerias.get(i); %>
                   <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                   <% }%>
                 </select></td>
           </tr>
               <tr align="left" class="style1">
                   <td><span class="Estilo6"> 
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
                   <td><span class="Estilo6">
                 LINEA</span></td>
				 <td>&nbsp;</td>
                 <td><div id="lineasdiv"></div></td>
           </tr>
              
                             <tr align="left" class="style1">
                 <td><span class="Estilo6">MODELO</span></td>
				 <td>&nbsp;</td>
                 <td colspan="">
                     <input name="modelo" type="text" id="modelo" style="width:200px; font-size:10px; color:#333333;text-align:center"/></td>
                 <td><span class="Estilo6"> 
                   COMBUSTIBLE
                  </span></td>
                 <td>&nbsp;</td>
                 <td>
		<select name="combustibles" id="combustibles"  style="width:202px; font-size:10px; color:#333333">
		<option value="0"><<--Seleccione Tipo Comb.-->></option>	
                     <% java.util.List combustibles = modelo.listadoParametros(75);
                         for (int i = 0; i < combustibles.size(); i++) {
                                Parametro parametro = (Parametro) combustibles.get(i);
                      %>
                     <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                     <%   } %>
                </select></td>
           </tr>
              
               <tr align="left" class="style1">
                 <td><span class="Estilo6">
                   MOTOR
                 </span></td>
                 <td>&nbsp;</td>
				 <td>
                     <input name="motor" type="text" id="motor" style="width:200px; font-size:10px; color:#333333; text-align:center"/>                 </td>
                 
                 <td><span class="Estilo6"> 
                   CHASIS
                 </span></td>
                 <td>&nbsp;</td>
				 <td><span class="Estilo6">
                 <input name="chasis" type="text" id="chasis" style="width:200px; font-size:10px; color:#333333; text-align:center" />
                 </span></td>
           </tr>
               
               <tr align="left" class="style1">
                 <td> <span class="Estilo6">
                   SERIE
                 </span> </td>
                 <td>&nbsp;</td>
				 <td>
                     <input name="serie" type="text" id="serie" style="width:200px; font-size:10px; color:#333333; text-align:center" />                    </td>
                 <td><span class="Estilo6">VIN</span></td>
                 <td>&nbsp;</td>
				 <td><input id="vin" name="vin" type="text" style="width:200px; font-size:10px; color:#333333; text-align:center"/></td>
           </tr>
		    <tr align="left" class="style1">
                 <td> <span class="Estilo6">
                 EJES</span></td>
                 <td>&nbsp;</td>
				 <td>
                     <input name="ejes" type="text" id="ejes" style="width:200px; font-size:10px; color:#333333; text-align:center" />                    </td>
                 <td><span class="Estilo6">CILINDRAJE</span></td>
                 <td>&nbsp;</td>
				 <td><input id="cilindraje" name="cilindraje" type="text" style="text-align:center;width:200px; font-size:10px; color:#333333"/></td>
           </tr>
		   
		   <tr align="left" class="style1">
                 <td><span class="Estilo6">
                 PASAJEROS </span></td>
                 <td>&nbsp;</td>
				 <td>
                     <input name="pasajeros" type="text" id="pasajeros" style="width:200px; font-size:10px; color:#333333; text-align:center" />                    </td>
                 <td><span class="Estilo6">FICHA&nbsp;HOMOLOG.</span></td>
                 <td>&nbsp;</td>
				 <td><input id="fichaHomologacion" name="fichaHomologacion" type="text" style="text-align:center;width:200px; font-size:10px; color:#333333"/></td>
           </tr>
		   <tr align="left" class="style1">
             <td><span class="Estilo6"> TIPO&nbsp;AUTOMOTOR </span></td>
                 <td>&nbsp;</td>
		         <td><span style="font-size: 10px">
		           <select name="tipoAutomotor" id="tipoAutomotor" style="width:202px; font-size:10px; color:#333333">
		             <option value="0"><<--Seleccione Tipo Automotor-->></option>
		             <option  value="V"> V </option>
		             <option  value="C"> C </option>
	             </select>
		           </span></td>
		         <td><span class="Estilo6">PESO BRUTO </span></td>
                 <td>&nbsp;</td>
				 <td><input id="pesoBruto" name="pesoBruto" type="text" style="text-align:center;width:200px; font-size:10px; color:#333333"/></td>
           </tr>
		   <tr class="style1">
		   	<td><span class="Estilo6">PUERTAS</span></td>
			<td>&nbsp;</td>
			<td><input name="puertas" type="text" id="puertas" style="width:200px; font-size:10px; color:#333333; text-align:center" />			</td>
			<td><span class="Estilo6">ORIGEN&nbsp;VEHICULO</span></td>
			<td>&nbsp;</td>
			<td><select name="origenVehiculo" id="origenVehiculo" style="width:202px; font-size:10px; color:#333333">
              <option value="0"><<--Seleccione Origen -->></option>
              <% java.util.List origen = modelo.consultarParametrosRUNT(32);
                 for (int i = 0; i < origen.size(); i++) {
                    String[] valores = (String[])origen.get(i); %>
              <option  value="<%=valores[0]%>"><%= valores[1] %></option>
              <%} %>
            </select></td>
		   </tr>
                   <tr class="style1">
		   	<td><span class="Estilo6">PUERTAS</span></td>
			<td>&nbsp;</td>
			<td><input name="capacidadCarga" type="text" id="capacidadCarga" style="width:200px; font-size:10px; color:#333333; text-align:center" />			</td>
                        <td><span class="Estilo6">CAPACIDAD&nbsp;DE&nbsp;CARGA</span></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		   </tr>
			<tr>
		  	<td colspan="6"><iframe src="#" width="100%"  name="acta" id="acta" height="500" style="display:none"  frameborder="0" scrolling="auto"></iframe></td>
		  </tr>
         </table>
   
		 <table width="90%" border="0" align="center">
          <tr>
            
            <th width="50%" scope="col" style="border:none"><input name="adicionar" type="button" id="adicionar" value="Registrar" style="width:100px; text-align:center" onClick="validar()"/></th>
          </tr>
        </table>
   </fieldset>
        </form>
				
    </body>
</html>
<% }else{ %>
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
