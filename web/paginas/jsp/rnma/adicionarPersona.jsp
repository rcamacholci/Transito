<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <%
try{
    Model modelo = (Model)session.getAttribute("model");
    Parametro parametro = new Parametro();
    Usuario usuario = (Usuario)session.getAttribute("usuario");
    UsuarioRunt userRunt = modelo.consultarUsuarioRunt(usuario.getId_usuario());
%>
<head>
    <title>Adicionar Persona N/J</title>

<LINK title=win2k-cold-1 media=all href="../../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<script src="../../html/scripts/calendar.js" type="text/javascript"></script>
<script src="../../html/scripts/calendar-es.js" type="text/javascript"></script>
<script src="../../html/scripts/calendar-setup.js" type="text/javascript"></script>
<script src="../../html/scripts/validarFecha.js" type="text/javascript"></script>
<style type="text/css">
<!--
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style3 {color: #FFFFFF}
.style31 {color: #333333; font-size: 12px; font-weight: bold; font-family: Tahoma; }
.Estilo2 {color: #FFFFFF; 	font-family: Tahoma; 	font-size: 12px; 	font-weight: bold; }
-->
</style>
<script language="javascript" type="text/javascript">	

   function validarDocumento(documento){
     if(documento.value==""){
       alert("El campo  Documento no puede estar vacio");
       return false;
     }else return true;
   }
   function validarDireccion(direccion){
     if(direccion.value==""){
       alert("El campo  Direccion es Obligatorio, Por Favor  Digitelo  !");
       return false;
     }else return true;
   }

   function validardoc(documento){
       if(isNaN(document.form.documento.value)){
            alert(" El Documento Es Invalido Favor Verifique !");
               return false;
          }

   }

   function validarPrimerNombre(primer_nombre){
     if(primer_nombre.value==""){
       alert("El campo Primer Nombre no puede estar vacio");
       return false;
    }else return true;
   }
   function validarPrimerApellido(primer_apellido){
     if(primer_apellido.value==""){
       alert("El campo   Primer Apellido no puede estar vacio");
       return false;
     }else return true;
   }
   function validarTelefono(telefono){
       if(isNaN(document.form.telefono.value)){
            alert("El Numero De Telefono No es Correcto");
               return false;
        }else return true;
 
   } 
   function validar_Sdo_Nombre(segundo_nombre){
	   if((!isNaN(document.form.segundo_nombre.value))&& (segundo_nombre.value!="")){
			alert("El Segundo Nombre No es Correcto !");
			   return false;
		  }
   }
   function validar_Sdo_Apellido(segundo_apellido){
	   if((!isNaN(document.form.segundo_apellido.value))&& (segundo_apellido.value!="")){
			alert("El Segundo Apellido No es Correcto");
			return false;
	   }else return true;
   }
	function validarFormulario(form)
	   {
		 with(form){

		  if(validarDocumento(documento)==false){
			   documento.focus();
			 return false;
			}
		 
		   if(validarPrimerNombre(primer_nombre)==false){
			 primer_nombre.focus();
			 return false;
		   }

		   if(validarPrimerApellido(primer_apellido)==false){
			 primer_apellido.focus();
			 return false;
		   }
		  if(document.form.tipo.value!='2'){
				if(validar_Sdo_Nombre(segundo_nombre)==false){
				 segundo_nombre.focus();
				 return false;
				}
				if(validar_Sdo_Apellido(segundo_apellido)== false){
				  segundo_apellido.focus();
				  return false;
				 }
		   }
			if(validarTelefono(telefono)==false){
			 telefono.focus();
			 return false;
		   }
		   if(validarDireccion(direccion)==false){
			 direccion.focus();
			 return false;
		   }
		   document.form.action = "procesar_persona.jsp";
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

function buscarDirMunicipios(){
	tabla = document.getElementById('dir_municipios');

	valor=document.form.dir_departamento.options[document.form.dir_departamento.selectedIndex].value;
	ajax1=new nuevoAjax();
	ajax1.open("POST", "../cargarCiudades.jsp",true);
	ajax1.onreadystatechange=function() {
		if (ajax1.readyState==4) {
			tabla.innerHTML = ajax1.responseText;
			document.form.direccion.disabled = false;
			document.form.telefono.disabled = false;
		}
	}
	ajax1.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	ajax1.send("fk_dpto="+valor+"&name=dir_municipio");

}
function consultaRunt(){
    document.form.action = "adicionarPersona.jsp?viewRunt=1";
    document.form.submit();
}

</script>


<META http-equiv=Content-Type content="text/html; charset=windows-1252">
<LINK title=win2k-cold-1 media=all href="../../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<script src="../../html/scripts/calendar.js" type="text/javascript"></script>
<script src="../../html/scripts/calendar-es.js"ol type="text/javascript"></script>
<script src="../../html/scripts/calendar-setup.js" type="text/javascript"></script>

<!--<META content="MSHTML 6.00.2900.3020" name=GENERATOR></HEAD>-->

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<script type="text/javascript"  src="../../html/scripts/jquery.js"></script>

</head>
<body>
<%
 String tipo = request.getParameter("tipo");
 String documento = request.getParameter("documento");
 String nombre_1 = "";
 String nombre_2 = "";
 String apellido_1 = "";
 String apellido_2 = "";
 String departamento = "5";
 String municipio = "";
 String direccion = "";
 String telefono = "";
 String state = "";
 int result = -1;
 if(request.getParameter("viewRunt")!=null)   {
     if(request.getParameter("viewRunt").equals("1"))   {
        String tipoDocumento = modelo.consultarParametro(Integer.parseInt(tipo),5).getNombreCorto();
        String numeroDocumento = documento;
        webservices.consultas.ServicioConsultaRUNTClient consultasService = new webservices.consultas.ServicioConsultaRUNTClient();

        consultasService.setUser(userRunt.getCodigo());
        consultasService.setTokenHuellaDigital("");

         if(session.getAttribute("token2")!=null){
             consultasService.setTokenHuellaDigital(session.getAttribute("token2").toString());
         }
         Model.userHandler = userRunt.getCodigo();
                                    Model.passUserHandler = userRunt.getPassword();
            
         if(Integer.parseInt(request.getParameter("tipo"))!=2){
            com.heinsohn.runt.general.consultas.PersonaNaturalOutDTO personaNaturalOut = consultasService.consultarDatosPersonaNatural(tipoDocumento, numeroDocumento);
            if(personaNaturalOut!=null){
                if(personaNaturalOut.getStatus()!=null){
                    if(personaNaturalOut.getStatus().getStatusCode().equals("1")){
                        javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.PersonaNaturalDTO> jaxbPersonaNatural = personaNaturalOut.getPersonaNatural();
                        com.heinsohn.runt.general.personas.PersonaNaturalDTO personaNatural = jaxbPersonaNatural.getValue();
                        if(personaNatural!=null){
                            if(personaNatural.getEstadoPersona().equals("ACTIVA")){
                                nombre_1 = personaNatural.getPrimerNombrePersona()!=null?personaNatural.getPrimerNombrePersona():"";
                                nombre_2 = personaNatural.getSegundoNombrePersona()!=null?personaNatural.getSegundoNombrePersona():"";
                                apellido_1 = personaNatural.getPrimerApellidoPersona()!=null?personaNatural.getPrimerApellidoPersona():"";
                                apellido_2 = personaNatural.getSegundoApellidoPersona()!=null?personaNatural.getSegundoApellidoPersona():"";
                                result = 3;
                                if(personaNatural.getDirecciones()!=null){
                                    if(personaNatural.getDirecciones().size()>0){
                                        for(int i=0; i<personaNatural.getDirecciones().size();i++){
                                            com.heinsohn.runt.general.personas.DireccionDTO direccionDTO = personaNatural.getDirecciones().get(i);
                                            if(direccionDTO!=null){
                                                if(direccionDTO.getMunicipio()!=null){
                                                    com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO dir_mun = direccionDTO.getMunicipio();
                                                    Divipo divipo = modelo.getDivipobyCodigo(dir_mun.getIdMunicipio());
                                                    if(divipo!=null){
                                                        departamento = divipo.getFk_departamento()+"";
                                                        municipio = divipo.getFk_municipio()+"";
                                                    }
                                                }
                                                if(direccionDTO.getDireccion()!=null)
                                                    direccion = direccionDTO.getDireccion();
                                                if(direccionDTO.getTelefono()!=null)
                                                    telefono = direccionDTO.getTelefono();
                                                break;
                                            }
                                        }
                                    }
                                }
                            }else{
                                result = 1;
                            }
                        }
                    }else{
                        result = 1;
                    }
                 }else{
                    result = 0;
                 }
             }else{
                result = 0;
             }
         }else{
              com.heinsohn.runt.general.consultas.PersonaJuridicaOutDTO personaJuridicaOut = consultasService.consultarDatosPersonaJuridica(tipoDocumento, numeroDocumento);
              if(personaJuridicaOut!=null){
                  if(personaJuridicaOut.getStatus()!=null){
                      if(personaJuridicaOut.getStatus().getStatusCode().equals("1")){
                          javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.PersonaJuridicaDTO> jaxbPersonaJuridica = personaJuridicaOut.getPersonaJuridica();
                          com.heinsohn.runt.general.personas.PersonaJuridicaDTO personaJuridica = jaxbPersonaJuridica.getValue();
                          if(personaJuridica!=null){
                              javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.EmpresaDTO> jaxbEmpresa = personaJuridica.getEmpresa();
                              if(jaxbEmpresa!=null){
                                  com.heinsohn.runt.general.personas.EmpresaDTO empresa = jaxbEmpresa.getValue();
                                  if(empresa!=null){
                                      if(empresa.getRazonSocial()!=null)
                                          nombre_1 = empresa.getRazonSocial();
                                      if(empresa.getSigla()!=null)
                                          apellido_1 = empresa.getSigla();
                                      if(empresa.getUbicacion()!=null){
                                           if(empresa.getUbicacion().getValue()!=null){
                                                com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO dir_mun = empresa.getUbicacion().getValue();
                                                Divipo divipo = modelo.getDivipobyCodigo(dir_mun.getIdMunicipio());
                                                if(divipo!=null){
                                                    departamento = divipo.getFk_departamento()+"";
                                                    municipio = divipo.getFk_municipio()+"";
                                                }
                                           }
                                      }
                                      if(empresa.getDireccion()!=null)
                                          direccion = empresa.getDireccion().getValue();
                                      if(empresa.getDireccionTelefono()!=null)
                                          telefono = empresa.getDireccionTelefono();
                                      result = 3;
                                  }
                              }
                          }
                     }else{
                        result = 1;
                     }
                  }else{
                      result = 0;
                  }
             }else{
                  result = 0;
             }
         }
     }
 }
 %>
<form  name="form"  method="post" action="procesar_persona.jsp" onsubmit="return validarFormulario(this)">
	<fieldset>
	   <table width="52%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr style="border:none; background:url(../../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="Estilo2">ADICIONAR NUEVA PERSONA NATURA/JURIDICA</span></td>
			</tr>
			<tr>
              <td colspan="4" align="center" class="<%=result!=-1?"style"+result:""%>">
                                    <% String mensaje = "";
                                        if(result!=-1){
                                            switch(result){
                                                case 0:mensaje="Sin acceso al servicio o Token Vencido, Por favor Vuelva autenticarse...";break;
                                                case 1:mensaje="Documento no se encuentra inscrito en el runt";break;
                                                case 2:mensaje="Documento existe pero no esta inscrito";break;
                                                case 3:mensaje="Documento se encuentra inscrito en el runt";break;
                                            }
                                        }
                                        out.print(mensaje);
                                        if(!mensaje.equals("")){
        %>
                                        <script language="javascript" type="text/javascript">
                                            alert('<%=mensaje %>');
                                        </script>
                                   <% } %>
                                   </td>
			</tr>
			<tr>
			    <td width="18%" align="left" class="Estilo2"><span class="style2">TIPO&nbsp;DOCUMENTO </span></td>
				<td width="34%"  align="left">
				<%  String nombreTipo = "";
					if(tipo!=null){
						nombreTipo = modelo.consultarParametroName(5, Integer.parseInt(tipo)); %>
                                                <input name="tipo" type="hidden" value="<%=tipo%>"/>
						<input name="ntipo" type="text" value="<%=nombreTipo%>" readonly="true" style="width:150px; text-align:center; font-size:10px"/>
				<%  }  %>
              </td>
				<td width="22%" align="left" class="Estilo2"><span class="style2">NUMERO&nbsp;DOCUMENTO </span></td>
				<td width="26%" align="left">
				<% if(documento!=null){ %>
						<input name="documento" type="text" value="<%=documento%>" readonly="true" style="width:150px; text-align:center"/>
				<% } %>
              </td>
			</tr>
		  <% if(Integer.parseInt(tipo)!=2){ %>
		  <tr>
				<td align="left" class="Estilo2"><span class="style2">PRIMER NOMBRE </span></td>
				<td align="left"><input name="primer_nombre" type="text" style="width:150px" value="<%=nombre_1%>"/></td>
				<td align="left" class="Estilo2"><span class="style2">SEGUNDO&nbsp;NOMBRE </span></td>
				<td  align="left"><input name="segundo_nombre" type="text"  style="width:150px" value="<%=nombre_2%>"/>      </td>
		  </tr>
		  <tr>
				<td align="left" height="30" class="Estilo2"><span class="style2"><strong>PRIMER APELLIDO </strong> </span></td>
				<td align="left"><input name="primer_apellido" type="text"  style="width:150px" value="<%=apellido_1%>"/></td>
				<td align="left" class="Estilo2"><span class="style2"><strong>SEGUNDO APELLIDO </strong> </span></td>
				<td align="left"><span class="Estilo4"><label><input type="text" name="segundo_apellido"  style="width:150px" value="<%=apellido_2%>"/></label></span></td>
		  </tr>
        <% }else{ %>
		  <tr>
				<td align="left" height="30" class="Estilo2"><span class="style2"><strong>RAZON&nbsp;SOCIAL </strong> </span></td>
				<td align="left"><input name="primer_nombre" type="text"  style="width:150px" value="<%=nombre_1%>"/></td>
				<td align="left" class="Estilo2"><span class="style2"><strong>SIGLA </strong> </span></td>
				<td align="left"><span class="Estilo4"><label><input type="text" name="primer_apellido"  style="width:150px" value="<%=apellido_1%>"/></label></span></td>
		  </tr>
		<% } %>
		<tr>
		  <td colspan="4">
			<fieldset>
			<table width="100%" border="0">
				<tr bgcolor="#CCCCCC">
				  <td width="150"   class="Estilo6"><div align="center" class="style2">DEPARTAMENTO</div></td>
					<td width="155" class="Estilo21"><label></label>
				  <div align="center" class="style2">MUNICIPIO</div></td>
				  <td width="223" class="Estilo6"><div align="center" class="style2">DIRECCION</div></td>
				  <td width="180" class="Estilo6"><div align="center" class="style2">TELEFONO</div></td>
				</tr>
				<tr>
					<td class="Estilo4">
                                            <select name="dir_departamento" style="width:150px; font-size:11px" onchange="buscarDirMunicipios(); return false" onfocus="buscarDirMunicipios(); return false">
                                                <% List listaDepar_per = modelo.crearListaDpto();
						   Iterator it_dep_per = listaDepar_per.iterator();
						   while (it_dep_per.hasNext()) {
                                                        modelo.Departamento dpto = (modelo.Departamento)it_dep_per.next();
                                                        if(departamento.equals(dpto.getId_departamento()+"")){ %>
                                                                <option value="<%=dpto.getId_departamento()+""%>" selected><%=dpto.getNombre()%></option>
							 <% }else{ %>
                                                                <option value="<%=dpto.getId_departamento()+""%>"><%=dpto.getNombre()%></option>
							 <% }
						   }%>
					</select></td>
					<td class="Estilo4">
                                            <div  style="width:150px" align="center" id="dir_municipios">
                                                <select name="dir_municipio" id="dir_municipio" style="width:150px; font-size:11px">
                                              <% if(departamento.length()>0&&municipio.length()>0){
                                                    java.util.List lista = modelo.crearListaMunicipios(Integer.parseInt(departamento));
                                                    for (int i = 0; i < lista.size(); i++) {
                                                        modelo.Municipio mncp = (modelo.Municipio) lista.get(i);
                                                        if(municipio.equals(mncp.getCodigo()+"")){ %>
                                                            <option value="<%=mncp.getCodigo() + ""%>" selected><%=mncp.getNombre()%></option>
                                                     <% }else{ %>
                                                            <option value="<%=mncp.getCodigo() + ""%>"><%=mncp.getNombre()%></option>
                                    <%                  }
                                                    }
                                                } %>
                                                </select>
                                            </div></td>
                                                <td class="Estilo4" align="left"><input type="text" name="direccion" style="width:200px; font-size:11px" value="<%=direccion%>"/></td>
                                                <td class="Estilo4"><input type="text" name="telefono" style=" width:80px;font-size:11px" value="<%=telefono%>"/></td>
				</tr>
			</table>
			</fieldset>
		</td>
		</tr>
		<tr>
			<td height="35" colspan="2" align="center">
<button type="button" name="consultar" onclick="consultaRunt()">Consulta Runt <img src="../../html/images/lupa.png" width="19" height="18" /></button>
                          <!--  <input type="button" name="consultar" value="Consulta Runt" onclick="consultaRunt()"/>-->
		  </td>
			<td colspan="2" align="center">
<button type="submit" name="guardar">Registrar Datos <img src="../../html/images/guardar.png" width="19" height="18" /></button>			
                           <!-- <input type="submit" name="guardar" value="Registrar Datos"/> -->
			</td>
		</tr>
	  </table>
	</fieldset>
</form>
</body>
</html>
<%
}catch(Exception mexe){ %>
    <jsp:forward page="../no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% } %>