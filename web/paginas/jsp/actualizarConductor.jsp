<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelo.*" import="java.util.*"%>
<%
try{
	String placa = "";
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                    Model modelo= (Model)session.getAttribute("model");
                    long id_persona = Integer.parseInt(request.getParameter("id_persona"));
                    String resultado = "";
                    try{
                            Persona persona = modelo.consultarPersona(id_persona);
                            if(persona!=null){
                                webservices.sincronizacion.SincronizacionServiceClient sincronizar = new webservices.sincronizacion.SincronizacionServiceClient();
                                sincronizar.setTokenHuellaDigital(Model.userToken);
                                sincronizar.setUser(Model.userHandler);

                                com.heinsohn.runt.general.consultas.ConductorDTO conductor = new com.heinsohn.runt.general.consultas.ConductorDTO();

                                com.heinsohn.runt.general.personas.PersonaNaturalDTO personaNatural = new com.heinsohn.runt.general.personas.PersonaNaturalDTO();

                                com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacionPersona = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                String nombreTipo = modelo.consultarParametro((int)persona.getTipo_documento(),5).getNombreCorto();
                                identificacionPersona.setTipoDocumento(nombreTipo);
                                identificacionPersona.setNumeroDocumento(persona.getDocumento());

                                javax.xml.namespace.QName name_DP = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com","identificacion");
                                java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DP = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                java.lang.Class scope_DP = javax.xml.bind.JAXBElement.GlobalScope.class;
                                javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DP = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DP,declaredType_DP,scope_DP,identificacionPersona);
                                personaNatural.setIdentificacion(jax_DP);
                                if(persona.getNombre_1()!=null);
                                    personaNatural.setPrimerNombrePersona(persona.getNombre_1());
                                if(persona.getNombre_2()!=null);
                                    personaNatural.setSegundoNombrePersona(persona.getNombre_2());
                                if(persona.getApellido_1()!=null)
                                    personaNatural.setPrimerApellidoPersona(persona.getApellido_1());
                                if(persona.getApellido_2()!=null)
                                    personaNatural.setSegundoApellidoPersona(persona.getApellido_2());
                                personaNatural.setEstadoPersona("ACTIVA");
                                personaNatural.setGrupoSanguineoPersona(persona.getGrupo_sanguineo()+persona.getRh());
                                personaNatural.setTipoPersona("PERSONA NATURAL");

                                //personaNatural.setFechaVencimiento(fechav);
                                personaNatural.setSexoPersona(persona.getSexo());
                                if(persona.getEmail()!=null)
                                    personaNatural.setEmailPersona(persona.getEmail());
                                if(persona.getFecha_exp()!=null){
                                    java.util.GregorianCalendar fexp = new java.util.GregorianCalendar();
                                    fexp.setTime(new java.sql.Date(persona.getFecha_exp().getTime()));
                                    javax.xml.datatype.XMLGregorianCalendar fechaFex = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fexp);
                                    personaNatural.setFechaExpedicionDocumento(fechaFex);
                                }
                                if(persona.getFecha_nac()!=null){
                                    java.util.GregorianCalendar fexp = new java.util.GregorianCalendar();
                                    fexp.setTime(new java.sql.Date(persona.getFecha_nac().getTime()));
                                    javax.xml.datatype.XMLGregorianCalendar fechaFex = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fexp);
                                    personaNatural.setFechaNacimientoPersona(fechaFex);
                                }
                                if(persona.getFecha_reg()!=null){
                                    java.util.GregorianCalendar fexp = new java.util.GregorianCalendar();
                                    fexp.setTime(new java.sql.Date(persona.getFecha_reg().getTime()));
                                    javax.xml.datatype.XMLGregorianCalendar fechaFex = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fexp);
                                    personaNatural.setFechaRegistroInicialPersona(fechaFex);
                                }
                                if(persona.getCelular()!=null)
                                    personaNatural.setCelularPersona(persona.getCelular());

                                java.util.List listaD = modelo.listado_direcciones_persona(persona.getId_persona());
                                if(listaD.size()>0){
                                    for(int d = 0; d <listaD.size();d++){
                                        Direccion dir = (Direccion)listaD.get(d);
                                        com.heinsohn.runt.general.personas.DireccionDTO direcciones = new com.heinsohn.runt.general.personas.DireccionDTO();
                                        if(dir.getDescripcion()!=null)
                                            direcciones.setDireccion(dir.getDescripcion());
                                        if(dir.getFax()!=null)
                                            direcciones.setFax(dir.getFax());
                                        if(dir.getTelefono()!=null)
                                            direcciones.setTelefono(dir.getTelefono());
                                        if(dir.getUbicacion()!=0)
                                            direcciones.setTipoDireccion("CASA");
                                        if(dir.getFk_divipo()!=0){
                                            Divipo divipo = modelo.getDivipo(dir.getFk_divipo());
                                            if(divipo!=null){
                                                com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO dir_municipio = new com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO();
                                                dir_municipio.setIdMunicipio(divipo.getCodigo());
                                                direcciones.setMunicipio(dir_municipio);
                                            }
                                        }
                                        personaNatural.getDirecciones().add(direcciones);
                                    }
                                }


                                javax.xml.namespace.QName name_PN = new javax.xml.namespace.QName("http://consultas.general.runt.heinsohn.com","personaNaturalDTO");
                                java.lang.Class<com.heinsohn.runt.general.personas.PersonaNaturalDTO> declaredType_PN = com.heinsohn.runt.general.personas.PersonaNaturalDTO.class;
                                java.lang.Class scope_PN = javax.xml.bind.JAXBElement.GlobalScope.class;
                                javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.PersonaNaturalDTO> jax_PN = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.PersonaNaturalDTO>(name_PN,declaredType_PN,scope_PN,personaNatural);
                                conductor.setPersonaNaturalDTO(jax_PN);
                                //Empieza la implementacion del servicio web

                                com.heinsohn.runt.general.personas.AutoridadTransitoDTO autoridad = new com.heinsohn.runt.general.personas.AutoridadTransitoDTO();
                                autoridad.setIdentificador("8634001");
                                autoridad.setNombreAutoridadTransito("SABANAGRANDE - ATLANTICO(DPTAL)");
                                
                                conductor.setAutoridadTransito(autoridad);

                                com.heinsohn.runt.general.consultas.LicenciaConduccionDTO licenciaConduccionDTO = new com.heinsohn.runt.general.consultas.LicenciaConduccionDTO();

                                Licencia_Conduccion licenciaConduccion = modelo.consultarLicenciaIdPersona(persona.getId_persona());
                                if(licenciaConduccion!=null){

                                    licenciaConduccionDTO.setNumeroLC("05154001142300");
                                    licenciaConduccionDTO.setCategoria("C2");
                                    licenciaConduccionDTO.setEstado("VENCIDA");
                                    licenciaConduccionDTO.setEstadoImpresion("I");
                                    java.util.GregorianCalendar fc = new java.util.GregorianCalendar();
                                    fc.setTime(new java.text.SimpleDateFormat("dd/MM/yyyy").parse("06/07/2004"));
                                    javax.xml.datatype.XMLGregorianCalendar fechafc = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fc);
                                    licenciaConduccionDTO.setFechaExpedicion(fechafc);
                                    fc = new java.util.GregorianCalendar();
                                    fc.setTime(new java.text.SimpleDateFormat("dd/MM/yyyy").parse("06/07/2007"));
                                    fechafc = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fc);
                                    licenciaConduccionDTO.setFechaExpedicion(fechafc);
                                    com.heinsohn.runt.general.personas.AutoridadTransitoDTO autoridad2 = new com.heinsohn.runt.general.personas.AutoridadTransitoDTO();
                                    autoridad2.setIdentificador("5154000");
                                    autoridad2.setNombreAutoridadTransito("CAUCASIA");
                                    javax.xml.namespace.QName name_AT = new javax.xml.namespace.QName("http://consultas.general.runt.heinsohn.com","autoridadTransito");
                                    java.lang.Class<com.heinsohn.runt.general.personas.AutoridadTransitoDTO> declaredType_AT = com.heinsohn.runt.general.personas.AutoridadTransitoDTO.class;
                                    java.lang.Class scope_AT = javax.xml.bind.JAXBElement.GlobalScope.class;
                                    javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.AutoridadTransitoDTO> jax_AT = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.AutoridadTransitoDTO>(name_AT,declaredType_AT,scope_AT,autoridad2);
                                    licenciaConduccionDTO.setAutoridadTransito(jax_AT);
                                    
                                    /*
                                    licenciaConduccionDTO.setNumeroLC(licenciaConduccion.getNumeroLicencia());

                                    javax.xml.namespace.QName name_AT = new javax.xml.namespace.QName("http://consultas.general.runt.heinsohn.com","autoridadTransito");
                                    java.lang.Class<com.heinsohn.runt.general.personas.AutoridadTransitoDTO> declaredType_AT = com.heinsohn.runt.general.personas.AutoridadTransitoDTO.class;
                                    java.lang.Class scope_AT = javax.xml.bind.JAXBElement.GlobalScope.class;
                                    javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.AutoridadTransitoDTO> jax_AT = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.AutoridadTransitoDTO>(name_AT,declaredType_AT,scope_AT,autoridad);
                                    licenciaConduccionDTO.setAutoridadTransito(jax_AT);

                                    licenciaConduccionDTO.setCategoria(licenciaConduccion.getCategoria());

                                    String estadoL = "";
                                    if(licenciaConduccion.getEstadoLicencia()==1)
                                        estadoL = "ACTIVA";
                                    licenciaConduccionDTO.setEstado(estadoL);
                                    
                                    if(licenciaConduccion.getEstadoImpresion()!=null)
                                        licenciaConduccionDTO.setEstadoImpresion(licenciaConduccion.getEstadoImpresion());
                                    else
                                        licenciaConduccionDTO.setEstadoImpresion("P");

                                    if(licenciaConduccion.getFechaRegistro()!=null){
                                        java.util.GregorianCalendar fc = new java.util.GregorianCalendar();
                                        fc.setTime(new java.sql.Date(licenciaConduccion.getFechaRegistro().getTime()));
                                        javax.xml.datatype.XMLGregorianCalendar fechafc = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fc);
                                        licenciaConduccionDTO.setFechaExpedicion(fechafc);
                                    }

                                    if(licenciaConduccion.getFechaVencimiento()!=null){
                                        java.util.GregorianCalendar fc = new java.util.GregorianCalendar();
                                        fc.setTime(new java.sql.Date(licenciaConduccion.getFechaVencimiento().getTime()));
                                        javax.xml.datatype.XMLGregorianCalendar fechafc = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fc);
                                        licenciaConduccionDTO.setFechaExpedicion(fechafc);
                                    }

                                    if(licenciaConduccion.getCertificadoAptitudFisica()!=null)
                                        licenciaConduccionDTO.setNumeroCertificadoAptitudFisica(licenciaConduccion.getCertificadoAptitudFisica());

                                    if(licenciaConduccion.getCertificadoCentroEnsenanza()!=null)
                                        licenciaConduccionDTO.setNumeroCertificadoCentroEnsenanza(licenciaConduccion.getCertificadoCentroEnsenanza());

                                    if(licenciaConduccion.getNumeroResolucion()!=null){
                                        com.heinsohn.runt.general.consultas.ResolucionLCDTO resolucion = new com.heinsohn.runt.general.consultas.ResolucionLCDTO();
                                        javax.xml.namespace.QName name_R = new javax.xml.namespace.QName("String","resolucion");
                                        java.lang.Class<String> declaredType_R = String.class;
                                        java.lang.Class scope_R = javax.xml.bind.JAXBElement.GlobalScope.class;
                                        javax.xml.bind.JAXBElement<String> jax_R = new javax.xml.bind.JAXBElement<String>(name_R,declaredType_R,scope_R,licenciaConduccion.getNumeroResolucion());

                                        resolucion.setNumeroResolucion(jax_R);
                                        licenciaConduccionDTO.setResolucion(resolucion);
                                    }
                                    */

                                    conductor.getLicenciaConduccion().add(licenciaConduccionDTO);
                                }

                                com.heinsohn.runt.general.identificaciones.StatusDTO status = sincronizar.actualizarConductor(conductor);
                             if(status!=null){
                                 if(status.getStatusCode().equals("1")){
                                    resultado = "La actualizacion del conductor fue "+status.getStatusDesc();
                                 }else{
                                     resultado = status.getStatusDesc();
                                 }
                             }else{
                                 resultado = "No se pudo acceder al servicio, intente nuevamente";
                             }
                          }

                    }catch(Exception exc){ exc.printStackTrace();
                        resultado = "Error de consulta de los datos "+exc.getMessage();
                    } %>
<style type="text/css">
<!--
.Estilo1 {
	font-size: 12px;
	font-weight: bold;
	color: #FFFFFF;
}
.Estilo2 {
	color: #333333;
	font-weight: bold;
	font-size: 11px;
}
-->
</style>
<form name="form" method="post" action="verDatosVehiculo.jsp?id=0&placa="<%=placa%>>
					<table width="43%" border="0" align="center">
  <tr>
    <th scope="col" background="../html/images/inicio_3.png"><span class="Estilo1">RESULTADO ACTUALIZACION VEHICULO AL RUNT </span></th>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><div align="center" class="Estilo2"><%=resultado%></div></td>
  </tr>
</table>
</form>

<%                }else{ %>
                   <jsp:forward page="no_access.jsp">
                         <jsp:param name="tipo" value="1"></jsp:param>
                   </jsp:forward>
	<%  }
	}else{ %>
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){mexe.printStackTrace(); %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>