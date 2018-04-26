<%@ page  contentType="text/html; charset=iso-8859-1"%>
<%@ page import="modelo.*" import="java.util.*"%>
<%
try{
	String placa = "";
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                    Model modelo= (Model)session.getAttribute("model");
                    long id_vehiculo = Long.parseLong(request.getParameter("vehiculo"));
                    String resultado = "";
                    boolean alertaValida = true;
                    try{
                            Vehiculo vehiculo = modelo.consultarVehiculoById(id_vehiculo);
                            if(vehiculo!=null){
                                webservices.sincronizacion.SincronizacionServiceClient sincronizar = new webservices.sincronizacion.SincronizacionServiceClient();
                                sincronizar.setTokenHuellaDigital(Model.userToken);
                                sincronizar.setUser(Model.userHandler);
                                com.heinsohn.runt.general.sincronizacion.SincronizarAutomotorDTO sincAutomotor = new com.heinsohn.runt.general.sincronizacion.SincronizarAutomotorDTO();

                                //Empieza la implementacion del servicio web
                                HashMap especificaciones = modelo.listarEspecificacionesVehiculo(vehiculo.getPlaca());
                                HashMap caracteristicas = modelo.listarCaracteristicasVehiculo(vehiculo.getPlaca());
				placa = vehiculo.getPlaca();

                                if(especificaciones.get("11")!=null)
                                    sincAutomotor.setCilindraje(especificaciones.get("11").toString());

                                sincAutomotor.setClase(modelo.consultarClaseRUNT((int)vehiculo.getClase_vehiculo()));

                                sincAutomotor.setTipoVehiculo(vehiculo.getClase_vehiculo()+"");

                                com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO automotor = new com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO();
                                if(vehiculo.getPlaca()!=null)
                                   automotor.setNumeroPlaca(vehiculo.getPlaca());

                                if(especificaciones.get("19")!=null)
                                    automotor.setNumeroMotor(especificaciones.get("19").toString());

                                if(especificaciones.get("20")!=null)
                                    automotor.setNumeroChasis(especificaciones.get("20").toString());

                                if(especificaciones.get("21")!=null)
                                    automotor.setNumeroSerie(especificaciones.get("21").toString());

                                javax.xml.namespace.QName name_IA = new javax.xml.namespace.QName("http://sincronizacion.general.runt.heinsohn.com","identificador");
                                java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO> declaredType_IA = com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO.class;
                                java.lang.Class scope_IA = javax.xml.bind.JAXBElement.GlobalScope.class;
                                javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO> jax_IA = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO>(name_IA,declaredType_IA,scope_IA,automotor);
                                sincAutomotor.setIdentificador(jax_IA);

                                com.heinsohn.runt.general.consultas.InformacionAutomotorDTO infoAutomotor = new com.heinsohn.runt.general.consultas.InformacionAutomotorDTO();

                                infoAutomotor.setAntiguoClasico("NORMAL");

                                com.heinsohn.runt.general.personas.AutoridadTransitoDTO autoridad = new com.heinsohn.runt.general.personas.AutoridadTransitoDTO();
                                autoridad.setIdentificador("8634001");
                                autoridad.setNombreAutoridadTransito("SABANAGRANDE - ATLANTICO(DPTAL)");
                                javax.xml.namespace.QName name_AT = new javax.xml.namespace.QName("http://consultas.general.runt.heinsohn.com","autoridadTransito");
                                java.lang.Class<com.heinsohn.runt.general.personas.AutoridadTransitoDTO> declaredType_AT = com.heinsohn.runt.general.personas.AutoridadTransitoDTO.class;
                                java.lang.Class scope_AT = javax.xml.bind.JAXBElement.GlobalScope.class;
                                javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.AutoridadTransitoDTO> jax_AT = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.AutoridadTransitoDTO>(name_AT,declaredType_AT,scope_AT,autoridad);
                                infoAutomotor.setAutoridadTransito(jax_AT);

                                if(especificaciones.get("2")!=null)
                                    infoAutomotor.setCapacidadCarga(especificaciones.get("2").toString());
                                else
                                    infoAutomotor.setCapacidadCarga("0");

                                if(especificaciones.get("1")!=null)
                                    infoAutomotor.setCapacidadPasajeros(Integer.parseInt(especificaciones.get("1").toString()));
                                else
                                    infoAutomotor.setCapacidadPasajeros(0);

                                java.util.List lista_colores = modelo.lista_historico_color(vehiculo.getPlaca());
                                for(int l=0;l<lista_colores.size();l++){
                                    Historico_Color hc = (Historico_Color)lista_colores.get(l);
                                    if(hc.getFecha_fin()==null){
                                        infoAutomotor.setColor(hc.getFk_color()+"");
                                        break;
                                    }
                                }
                                
                                infoAutomotor.setEsEnsenanza("N");
                                infoAutomotor.setEsReposicion("N");
                                if(especificaciones.get("14")!=null){
                                    infoAutomotor.setEstaBlindado("S");
                                    infoAutomotor.setNivelBlindaje(especificaciones.get("14").toString());
                                }else{
                                    infoAutomotor.setEstaBlindado("N");
                                }
                                infoAutomotor.setEsImportado("IMPORTADO");
                                infoAutomotor.setEstaRepotenciado("N");
                                
                                if(vehiculo.getEstado()!=3)
                                    infoAutomotor.setEstado("ACTIVO");
                                else{
                                    infoAutomotor.setEstado("CANCELADO");

                                    List list=modelo.consultar_Formularios(vehiculo.getPlaca());
                                    Iterator it = list.iterator();
                                    while (it.hasNext()) {
                                        Formulario formulario = (Formulario)it.next();
                                        if(formulario.getFk_tramite()==15){
                                            if(modelo.consultar_Radicacion(formulario.getFk_radicacion()).getEstado()==5){
                                                if(formulario.getFecha_tramite()!=null){
                                                    java.util.GregorianCalendar fc = new java.util.GregorianCalendar();
                                                    fc.setTime(new java.sql.Date(formulario.getFecha_tramite().getTime()));
                                                    javax.xml.datatype.XMLGregorianCalendar fechafc = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fc);
                                                    infoAutomotor.setFechaCancelacion(fechafc);
                                                    
                                                    String valorR = modelo.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 29);
                                                    if(valorR!=null)
                                                        infoAutomotor.setMotivoCancelacion(valorR);
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                }
                                    
                                Licencia_Transito licenciaTransito = modelo.getLicencia(vehiculo.getId_vehiculo());
                                if(licenciaTransito!=null){

                                    if(licenciaTransito.getFecha_expedicion()!=null){
                                        java.util.GregorianCalendar flv = new java.util.GregorianCalendar();
                                        flv.setTime(new java.sql.Date(licenciaTransito.getFecha_expedicion().getTime()));
                                        javax.xml.datatype.XMLGregorianCalendar fechaflv = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(flv);
                                        infoAutomotor.setFechaExpedicionLicencia(fechaflv);
                                        infoAutomotor.setNumeroLicenciaVigente(licenciaTransito.getNumero());
                                    }
                                }

                                if(vehiculo.getFecha_matricula()!=null){
                                    java.util.GregorianCalendar fc = new java.util.GregorianCalendar();
                                    fc.setTime(new java.sql.Date(vehiculo.getFecha_matricula().getTime()));
                                    javax.xml.datatype.XMLGregorianCalendar fechafc = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fc);
                                    infoAutomotor.setFechaRegistro(fechafc);
                                }

                                if(vehiculo.getClase_vehiculo()!=0){
                                    long cl = vehiculo.getClase_vehiculo();
                                    String gr = "";
                                    if(cl==1||cl==5||cl==6)
                                        gr = "A";
                                    if(cl==7)
                                        gr = "B";
                                    if(cl==2||cl==3)
                                        gr = "C";
                                    if(!gr.equals(""))
                                        infoAutomotor.setGrupo(gr);
                                }

                                if(caracteristicas.get("2")!=null)
                                    infoAutomotor.setIdCarrocerria(caracteristicas.get("2").toString());

                                if(vehiculo.getFk_linea()!=0)
                                    infoAutomotor.setLinea(vehiculo.getFk_linea()+"");

                                infoAutomotor.setMarcaAutomotorMigrado(null);
                                if(caracteristicas.get("324")!=null)
                                    infoAutomotor.setModalidadServicio(caracteristicas.get("324").toString());
                                
                                infoAutomotor.setNivelServicio("0");

                                if(vehiculo.getDocumento_importacion()!=null){//validar acta anteriormente
                                    infoAutomotor.setNumeroActa(vehiculo.getDocumento_importacion());
                                    infoAutomotor.setOrigenRegistro("1");
                                    if(vehiculo.getTipo_doc_importacion()!=0){
                                        if(vehiculo.getTipo_doc_importacion()==1){
                                            infoAutomotor.setTipoActaImportacionORemate("ACTA REMATE O ADJUDICACION");
                                        }else{
                                            infoAutomotor.setTipoActaImportacionORemate("IMPORTACION");
                                        }
                                    }
                                    if(vehiculo.getFecha_importacion()!=null){
                                        java.util.GregorianCalendar fc = new java.util.GregorianCalendar();
                                        fc.setTime(new java.sql.Date(vehiculo.getFecha_importacion().getTime()));
                                        javax.xml.datatype.XMLGregorianCalendar fechafc = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fc);
                                        infoAutomotor.setFechaDeclaracion(fechafc);
                                    }
                                }
                                if(especificaciones.get("9")!=null)
                                    infoAutomotor.setNumeroEjes(Integer.parseInt(especificaciones.get("9").toString()));

                                infoAutomotor.setNumeroFichaTecnica(null);

                                if(especificaciones.get("8")!=null)
                                    infoAutomotor.setNumeroPuertas(especificaciones.get("8").toString());

                                infoAutomotor.setNumeroRegrabacionChasis(null);
                                infoAutomotor.setNumeroRegrabacionMotor(null);
                                infoAutomotor.setNumeroRegrabacionSerie(null);

                                if(especificaciones.get("13")!=null)
                                    infoAutomotor.setPesoBruto(especificaciones.get("13").toString());
                                    
                                if(especificaciones.get("12")!=null)
                                    infoAutomotor.setPotencia(especificaciones.get("12").toString());
                                
                                infoAutomotor.setPaisOrigen("90");
                                
                                infoAutomotor.setSeguridadEstado("N");

                                javax.xml.namespace.QName name_SA = new javax.xml.namespace.QName("subpartidaArancelaria");
                                java.lang.Class<String> declaredType_SA = String.class;
                                java.lang.Class scope_SA = javax.xml.bind.JAXBElement.GlobalScope.class;
                                javax.xml.bind.JAXBElement<String> jax_SA = new javax.xml.bind.JAXBElement<String>(name_SA,declaredType_SA,scope_SA,null);
                                infoAutomotor.setSubpartidaArancelaria(jax_SA);
                                
                                infoAutomotor.setRegrabacionPlaqueta(null);

                                infoAutomotor.setTipoMotor("0");

                                if(vehiculo.getFk_linea()!=0){
                                     Linea linea = modelo.getLinea(vehiculo.getFk_linea());
                                     sincAutomotor.setMarca(linea.getFk_marca()+"");
                                }

                                if(vehiculo.getModelo()!=0){
                                    sincAutomotor.setModelo(vehiculo.getModelo()+"");
                                    infoAutomotor.setAnoFabricacion((int)vehiculo.getModelo());
                                }

                                sincAutomotor.setInformacion(infoAutomotor);

                                if(vehiculo.getServicio()!=0)
                                    sincAutomotor.setTipoServicio(vehiculo.getServicio()+"");

                                if(caracteristicas.get("75")!=null){
                                    com.heinsohn.runt.general.consultas.CombustiblesDTO combustible = new com.heinsohn.runt.general.consultas.CombustiblesDTO();
                                    combustible.setTipoCombustible(caracteristicas.get("75").toString());
                                    if(vehiculo.getFecha_matricula()!=null){
                                        java.util.GregorianCalendar fc = new java.util.GregorianCalendar();
                                        fc.setTime(new java.sql.Date(vehiculo.getFecha_matricula().getTime()));
                                        javax.xml.datatype.XMLGregorianCalendar fechafc = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fc);
                                        combustible.setFechaInicio(fechafc);
                                    }
                                    combustible.setEstado("ACTIVO");
                                    sincAutomotor.getCombustibles().add(combustible);
                                }

                                java.util.List  listapropietario=modelo.crear_Lista_Propietarios(vehiculo.getId_vehiculo());
                                for(int l=0;l<listapropietario.size();l++){
                                    Propietario propietario = (Propietario)listapropietario.get(l);
                                    com.heinsohn.runt.general.sincronizacion.SincronizarDatosPropietarioDTO sincPropietario = new com.heinsohn.runt.general.sincronizacion.SincronizarDatosPropietarioDTO();
                                    Persona personaProp = modelo.consultarPersona(propietario.getFk_persona());
                                    if(propietario.getProIndiviso()!=null)
                                        sincPropietario.setProindiviso(propietario.getProIndiviso());
                                    if(propietario.getPorcentaje()!=0)
                                        sincPropietario.setPorcentajePropiedad((double)propietario.getPorcentaje());
                                    if(personaProp.getTipo_documento()==2){
                                        com.heinsohn.runt.general.sincronizacion.PropietarioPersonaJuridicaDTO personaJuridica = new com.heinsohn.runt.general.sincronizacion.PropietarioPersonaJuridicaDTO();
                                        Empresa empresa = modelo.consultarEmpresa(personaProp.getTipo_documento(), personaProp.getDocumento());
                                        if(empresa!=null){
                                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacionProp = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                            String nombreTipo = modelo.consultarParametro((int)personaProp.getTipo_documento(),5).getNombreCorto();
                                            identificacionProp.setTipoDocumento(nombreTipo);
                                            identificacionProp.setNumeroDocumento(personaProp.getDocumento());
                                            personaJuridica.setIdentificacionPersona(identificacionProp);
                                            if(empresa.getTelefono()!=null)
                                                personaJuridica.setTelefono(empresa.getTelefono());
                                            if(empresa.getRazon_social()!=null)
                                                personaJuridica.setRazonSocial(empresa.getRazon_social());
                                            if(empresa.getEmail()!=null)
                                                personaJuridica.setCorreoElectronico(empresa.getEmail());
                                            Representante representante = modelo.consultarRepresentante(empresa.getFk_representante());
                                            if(representante!=null){
                                                Persona personaRep=modelo.consultarPersona(representante.getFk_persona());
                                                identificacionProp = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                                nombreTipo = modelo.consultarParametro((int)personaRep.getTipo_documento(),5).getNombreCorto();
                                                identificacionProp.setTipoDocumento(nombreTipo);
                                                identificacionProp.setNumeroDocumento(personaRep.getDocumento());
                                                if(personaRep.getNombre_1()!=null)
                                                    personaJuridica.setPrimerNombreRepresentante(personaRep.getNombre_1());
                                                if(personaRep.getNombre_2()!=null)
                                                    personaJuridica.setSegundoNombreRepresentante(personaRep.getNombre_2());
                                                if(personaRep.getApellido_1()!=null)
                                                    personaJuridica.setPrimerApellidoRepresentante(personaRep.getApellido_1());
                                                if(personaRep.getApellido_2()!=null)
                                                    personaJuridica.setSegundoApellidoRepresentante(personaRep.getApellido_2());
                                                personaJuridica.setIdentificacionRepresentante(identificacionProp);
                                                //personaJuridica.setDireccion("calle 50");
                                            }
                                            javax.xml.namespace.QName name_PJ = new javax.xml.namespace.QName("http://sincronizacion.general.runt.heinsohn.com","personaJuridica");
                                            java.lang.Class<com.heinsohn.runt.general.sincronizacion.PropietarioPersonaJuridicaDTO> declaredType_PJ = com.heinsohn.runt.general.sincronizacion.PropietarioPersonaJuridicaDTO.class;
                                            java.lang.Class scope_PJ = javax.xml.bind.JAXBElement.GlobalScope.class;
                                            javax.xml.bind.JAXBElement<com.heinsohn.runt.general.sincronizacion.PropietarioPersonaJuridicaDTO> jax_PJ = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.sincronizacion.PropietarioPersonaJuridicaDTO>(name_PJ,declaredType_PJ,scope_PJ,personaJuridica);
                                            sincPropietario.setPersonaJuridica(jax_PJ);
                                            sincPropietario.setPersonaNatural(null);
                                        }
                                    }else{
                                        com.heinsohn.runt.general.personas.PersonaNaturalDTO personaNatural = new com.heinsohn.runt.general.personas.PersonaNaturalDTO();
                                        com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacionProp = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                        String nombreTipo = modelo.consultarParametro((int)personaProp.getTipo_documento(),5).getNombreCorto();
                                        identificacionProp.setTipoDocumento(nombreTipo);
                                        identificacionProp.setNumeroDocumento(personaProp.getDocumento());

                                        javax.xml.namespace.QName name_DP = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com","identificacion");
                                        java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DP = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                        java.lang.Class scope_DP = javax.xml.bind.JAXBElement.GlobalScope.class;
                                        javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DP = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DP,declaredType_DP,scope_DP,identificacionProp);
                                        personaNatural.setIdentificacion(jax_DP);
                                        if(personaProp.getNombre_1()!=null);
                                            personaNatural.setPrimerNombrePersona(personaProp.getNombre_1());
                                        if(personaProp.getNombre_2()!=null);
                                            personaNatural.setSegundoNombrePersona(personaProp.getNombre_2());
                                        if(personaProp.getApellido_1()!=null)
                                            personaNatural.setPrimerApellidoPersona(personaProp.getApellido_1());
                                        if(personaProp.getApellido_2()!=null)
                                            personaNatural.setSegundoApellidoPersona(personaProp.getApellido_2());
                                        personaNatural.setEstadoPersona("ACTIVA");
                                        if(personaProp.getGrupo_sanguineo()!=null&&personaProp.getRh()!=null)
                                            personaNatural.setGrupoSanguineoPersona(personaProp.getGrupo_sanguineo()+personaProp.getRh());
                                        else
                                            personaNatural.setGrupoSanguineoPersona("O+");
                                        personaNatural.setTipoPersona("PERSONA NATURAL");

                                        personaNatural.setFechaVencimiento(null);
                                        personaNatural.setSexoPersona(personaProp.getSexo()!=null?personaProp.getSexo():"M");
                                        if(personaProp.getEmail()!=null)
                                            personaNatural.setEmailPersona(personaProp.getEmail());
                                        if(personaProp.getFecha_exp()!=null){
                                            java.util.GregorianCalendar fexp = new java.util.GregorianCalendar();
                                            fexp.setTime(new java.sql.Date(personaProp.getFecha_exp().getTime()));
                                            javax.xml.datatype.XMLGregorianCalendar fechaFex = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fexp);
                                            personaNatural.setFechaExpedicionDocumento(fechaFex);
                                        }
                                        if(personaProp.getFecha_nac()!=null){
                                            java.util.GregorianCalendar fexp = new java.util.GregorianCalendar();
                                            fexp.setTime(new java.sql.Date(personaProp.getFecha_nac().getTime()));
                                            javax.xml.datatype.XMLGregorianCalendar fechaFex = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fexp);
                                            personaNatural.setFechaNacimientoPersona(fechaFex);
                                        }
                                        if(personaProp.getCelular()!=null)
                                            personaNatural.setCelularPersona(personaProp.getCelular());

                                        java.util.List listaD = modelo.listado_direcciones_persona(personaProp.getId_persona());
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
                                                        dir_municipio.setIdMunicipio(Integer.parseInt(divipo.getCodigo())+"");
                                                        direcciones.setMunicipio(dir_municipio);
                                                    }
                                                }
                                                personaNatural.getDirecciones().add(direcciones);
                                            }
                                        }


                                        javax.xml.namespace.QName name_PN = new javax.xml.namespace.QName("http://sincronizacion.general.runt.heinsohn.com","personaNatural");
                                        java.lang.Class<com.heinsohn.runt.general.personas.PersonaNaturalDTO> declaredType_PN = com.heinsohn.runt.general.personas.PersonaNaturalDTO.class;
                                        java.lang.Class scope_PN = javax.xml.bind.JAXBElement.GlobalScope.class;
                                        javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.PersonaNaturalDTO> jax_PN = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.PersonaNaturalDTO>(name_PN,declaredType_PN,scope_PN,personaNatural);
                                        sincPropietario.setPersonaNatural(jax_PN);

                                        javax.xml.namespace.QName name_PJ = new javax.xml.namespace.QName("http://sincronizacion.general.runt.heinsohn.com","personaJuridica");
                                        java.lang.Class<com.heinsohn.runt.general.sincronizacion.PropietarioPersonaJuridicaDTO> declaredType_PJ = com.heinsohn.runt.general.sincronizacion.PropietarioPersonaJuridicaDTO.class;
                                        java.lang.Class scope_PJ = javax.xml.bind.JAXBElement.GlobalScope.class;
                                        javax.xml.bind.JAXBElement<com.heinsohn.runt.general.sincronizacion.PropietarioPersonaJuridicaDTO> jax_PJ = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.sincronizacion.PropietarioPersonaJuridicaDTO>(name_PJ,declaredType_PJ,scope_PJ,null);
                                        sincPropietario.setPersonaJuridica(jax_PJ);
                                    }

                                    if(propietario.getTipoPropiedad()!=null)
                                        sincPropietario.setIdTipoPropiedad(propietario.getTipoPropiedad());

                                    if(propietario.getFecha_inicio()!=null){
                                        java.util.GregorianCalendar fi = new java.util.GregorianCalendar();
                                        fi.setTime(new java.sql.Date(propietario.getFecha_inicio().getTime()));
                                        javax.xml.datatype.XMLGregorianCalendar fechaFi = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fi);
                                        sincPropietario.setFechaInicioPropiedad(fechaFi);
                                    }
                                    if(propietario.getFecha_final()!=null){
                                        
                                        java.util.GregorianCalendar ff = new java.util.GregorianCalendar();
                                        ff.setTime(new java.sql.Date(propietario.getFecha_final().getTime()));
                                        javax.xml.datatype.XMLGregorianCalendar fechaFf = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(ff);
                                        sincPropietario.setFechaFinPropiedad(fechaFf);
                                        sincPropietario.setEstado("INACTIVA");
                                        //sincAutomotor.getPropietarios().add(sincPropietario);
                                    }else{
                                        sincPropietario.setEstado("ACTIVA");
                                        sincAutomotor.getPropietarios().add(sincPropietario);
                                    }

                                }

                                Alerta alerta = modelo.consultarAlerta(id_vehiculo);
                                if(alerta!=null){
                                    if(alerta.getFk_persona()!=0){
                                        Persona personaAlerta = modelo.consultarPersona(alerta.getFk_persona());
                                        if(personaAlerta!=null){
                                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacionAlerta = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                            com.heinsohn.runt.general.consultas.PrendaAutomotorDTO prendaAutomotor = new com.heinsohn.runt.general.consultas.PrendaAutomotorDTO();

                                            String nombreTipo = modelo.consultarParametro((int)personaAlerta.getTipo_documento(),5).getNombreCorto();
                                            identificacionAlerta.setTipoDocumento(nombreTipo);
                                            identificacionAlerta.setNumeroDocumento(personaAlerta.getDocumento());

                                            javax.xml.namespace.QName name_ID = new javax.xml.namespace.QName("http://consultas.general.runt.heinsohn.com","acreedorPrendario");
                                            java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_ID = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                            java.lang.Class scope_ID = javax.xml.bind.JAXBElement.GlobalScope.class;
                                            javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_ID = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_ID,declaredType_ID,scope_ID,identificacionAlerta);
                                            prendaAutomotor.setAcreedorPrendario(jax_ID);

                                            if(personaAlerta.getTipo_documento()==2){
                                                prendaAutomotor.setNombreRazonSocialAcreedor(personaAlerta.getNombre_1()+" "+personaAlerta.getApellido_1());
                                            }else{
                                                String nombreC = personaAlerta.getNombre_1()+" "+(personaAlerta.getNombre_2()!=null?personaAlerta.getNombre_2()+" ":"")+personaAlerta.getApellido_1()+(personaAlerta.getApellido_2()!=null?personaAlerta.getApellido_2():"");
                                                prendaAutomotor.setNombreRazonSocialAcreedor(nombreC);
                                            }

                                            if(alerta.getFecha_ini()!=null){
                                                java.util.GregorianCalendar f_ini_alerta = new java.util.GregorianCalendar();
                                                f_ini_alerta.setTime(new java.sql.Date(alerta.getFecha_ini().getTime()));
                                                javax.xml.datatype.XMLGregorianCalendar fechaIa = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(f_ini_alerta);
                                                prendaAutomotor.setFechaInscripcion(fechaIa);
                                                prendaAutomotor.setFechaRegistro(fechaIa);
                                            }

                                            if(alerta.getFecha_fin()!=null){
                                                java.util.GregorianCalendar f_ini_alerta = new java.util.GregorianCalendar();
                                                f_ini_alerta.setTime(new java.sql.Date(alerta.getFecha_ini().getTime()));
                                                javax.xml.datatype.XMLGregorianCalendar fechaIa = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(f_ini_alerta);
                                                prendaAutomotor.setFechaLevantamiento(fechaIa);
                                                prendaAutomotor.setEstadoPrenda("LEVANTADA");
                                            }else{
                                                prendaAutomotor.setEstadoPrenda("INSCRITA");
                                            }

                                            java.util.GregorianCalendar f_mod = new java.util.GregorianCalendar();
                                            f_mod.setTime(new java.sql.Date(new java.util.Date().getTime()));
                                            javax.xml.datatype.XMLGregorianCalendar fechaMod = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(f_mod);
                                            prendaAutomotor.setFechaModificacion(fechaMod);

                                            prendaAutomotor.setGrado("1");
                                            String tipoAlerta = modelo.consultarParametroName(4, alerta.getTipo());
                                            if(tipoAlerta!=null)
                                                prendaAutomotor.setTipoAlerta(tipoAlerta);

                                            sincAutomotor.getPrendas().add(prendaAutomotor);
                                        }
                                   }else{
                                        alertaValida = false;
                                   }
                               }     

                               if(alertaValida){
                                   java.util.List listaE = modelo.consultarEmbargos(vehiculo.getId_vehiculo());
                                   for(int e=0;e<listaE.size();e++){
                                       Embargo embargo = (Embargo)listaE.get(e);
                                       if(embargo.getFecha_levantamiento()==null){
                                           Persona personaDemandante = modelo.consultarPersona(embargo.getFk_persona());
                                           if(personaDemandante!=null){

                                               com.heinsohn.runt.general.consultas.MedidaCautelarAutomotorDTO embargoAutomotor = new com.heinsohn.runt.general.consultas.MedidaCautelarAutomotorDTO();
                                               com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacionDemandante = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();

                                               String nombreTipo = modelo.consultarParametro((int)personaDemandante.getTipo_documento(),5).getNombreCorto();
                                               identificacionDemandante.setNumeroDocumento(personaDemandante.getDocumento());

                                               javax.xml.namespace.QName name_ID = new javax.xml.namespace.QName("http://consultas.general.runt.heinsohn.com","demandante");
                                               java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_ID = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                               java.lang.Class scope_ID = javax.xml.bind.JAXBElement.GlobalScope.class;
                                               javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_ID = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_ID,declaredType_ID,scope_ID,identificacionDemandante);
                                               embargoAutomotor.setDemandante(jax_ID);

                                               if(personaDemandante.getTipo_documento()==2){
                                                    Empresa empresa = modelo.consultarEmpresa(personaDemandante.getTipo_documento(), personaDemandante.getDocumento());
                                                    if(empresa!=null)
                                                        embargoAutomotor.setNombreRazonSocialDemandante(empresa.getRazon_social());
                                               }else{
                                                    String nombreC = personaDemandante.getNombre_1()+" "+(personaDemandante.getNombre_2()!=null?personaDemandante.getNombre_2()+" ":"")+personaDemandante.getApellido_1()+(personaDemandante.getApellido_2()!=null?personaDemandante.getApellido_2():"");
                                                    embargoAutomotor.setNombreRazonSocialDemandante(nombreC);
                                               }

                                               for(int l=0;l<listapropietario.size();l++){
                                                   Propietario propietario = (Propietario)listapropietario.get(l);
                                                   if(propietario.getFecha_final()==null){
                                                       com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacionDemandado = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                                       Persona personaDemandada = modelo.consultarPersona(embargo.getFk_persona());
                                                       if(personaDemandada!=null){
                                                           nombreTipo = modelo.consultarParametro((int)personaDemandada.getTipo_documento(),5).getNombreCorto();
                                                           identificacionDemandado.setTipoDocumento(nombreTipo);
                                                           identificacionDemandado.setNumeroDocumento(personaDemandada.getDocumento());

                                                           name_ID = new javax.xml.namespace.QName("http://consultas.general.runt.heinsohn.com","demandado");
                                                           jax_ID = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_ID,declaredType_ID,scope_ID,identificacionDemandado);
                                                           embargoAutomotor.setDemandado(jax_ID);

                                                           if(personaDemandada.getTipo_documento()==2){
                                                                Empresa empresa = modelo.consultarEmpresa(personaDemandada.getTipo_documento(), personaDemandada.getDocumento());
                                                                if(empresa!=null)
                                                                    embargoAutomotor.setNombreRazonSocialDemandado(empresa.getRazon_social());
                                                           }else{
                                                                String nombreC = personaDemandante.getNombre_1()+" "+(personaDemandante.getNombre_2()!=null?personaDemandante.getNombre_2()+" ":"")+personaDemandante.getApellido_1()+(personaDemandante.getApellido_2()!=null?personaDemandante.getApellido_2():"");
                                                                embargoAutomotor.setNombreRazonSocialDemandado(nombreC);
                                                           }
                                                           break;
                                                       }
                                                   }
                                              }

                                              if(embargo.getOficio()!=null){
                                                  embargoAutomotor.setNumeroDocumentoProcesoJuridico(embargo.getOficio());
                                                  //pendiente campo numero de radicacion
                                                  embargoAutomotor.setNumeroMedidaCautelar(embargo.getOficio());
                                              }

                                              if(embargo.getProceso()!=0){
                                                  embargoAutomotor.setProcesoMedidaCautelar(embargo.getProceso()+"");
                                              }

                                              if(embargo.getTipo()!=0){
                                                  embargoAutomotor.setTipo(embargo.getTipo()+"");
                                              }

                                              if(embargo.getFecha_oficio()!=null){
                                                  java.util.GregorianCalendar f_oficio = new java.util.GregorianCalendar();
                                                  f_oficio.setTime(new java.sql.Date(embargo.getFecha_oficio().getTime()));
                                                  javax.xml.datatype.XMLGregorianCalendar fechaO = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(f_oficio);
                                                  embargoAutomotor.setFechaExpedicionMedidaCautelar(fechaO);
                                              }

                                              if(embargo.getFecha_levantamiento()!=null){
                                                  java.util.GregorianCalendar f_lev = new java.util.GregorianCalendar();
                                                  f_lev.setTime(new java.sql.Date(embargo.getFecha_levantamiento().getTime()));
                                                  javax.xml.datatype.XMLGregorianCalendar fechaL = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(f_lev);
                                                  embargoAutomotor.setFechaLevantamientoMedida(fechaL);
                                                  embargoAutomotor.setEstadoMedidaCautelar("LEVANTADA");
                                              }else{
                                                  embargoAutomotor.setEstadoMedidaCautelar("INSCRITA");
                                              }

                                              Oficina_Juridica oficinaJ = modelo.consultarOficinaJuridica(embargo.getFk_oficina());
                                              if(oficinaJ!=null){
                                                  if(oficinaJ.getNumero()!=null){
                                                      embargoAutomotor.setJurisdiccion(oficinaJ.getNumero());
                                                  }
                                              }

                                              sincAutomotor.getMedidasCautelares().add(embargoAutomotor);

                                          }
                                      }
                                  }

                                com.heinsohn.runt.general.sincronizacion.FiltroConsultaModificarAutomotorDTO filtro = new com.heinsohn.runt.general.sincronizacion.FiltroConsultaModificarAutomotorDTO();

                                filtro.setNumeroPlaca(automotor.getNumeroPlaca());

                                if(sincAutomotor.getMarca()!=null)
                                    filtro.setMarca(sincAutomotor.getMarca());

                                if(sincAutomotor.getInformacion()!=null)
                                    if(sincAutomotor.getInformacion().getLinea()!=null)
                                        filtro.setLinea(sincAutomotor.getInformacion().getLinea());

                                if(automotor.getNumeroMotor()!=null)
                                    filtro.setNumeroMotor(automotor.getNumeroMotor());

                                sincAutomotor.setFiltroConsultaModificarAutomotor(filtro);

                                sincAutomotor.setNumeroActoAdministrativoTutela(null);

                                 com.heinsohn.runt.general.identificaciones.StatusDTO status = sincronizar.actualizarDatosAutomotor(sincAutomotor);
                                 if(status!=null){
                                     Sincronizacion sincronizacion = new Sincronizacion();
                                     sincronizacion.setFk_vehiculo(vehiculo.getId_vehiculo());
                                     sincronizacion.setTipo(1);
                                     sincronizacion.setFecha(new java.sql.Timestamp(new java.util.Date().getTime()));
                                     Usuario usuario = (Usuario)session.getAttribute("usuario");
                                     sincronizacion.setFk_usuario(usuario.getId_usuario());
                                     if(status.getStatusCode().equals("1")){
                                         sincronizacion.setEstado(1);
                                         sincronizacion.setResultado(status.getStatusDesc());
                                         resultado = "La actualizacion del vehiculo fue "+status.getStatusDesc();
                                     }else{
                                         sincronizacion.setEstado(2);
                                         sincronizacion.setResultado(status.getStatusDesc());
                                         resultado = status.getStatusDesc();
                                     }
                                     modelo.adicionarSincronizacion(sincronizacion);
                                     modelo.getCon().commit();
                                 }else{
                                     resultado = "No se pudo acceder al servicio, intente nuevamente";
                                 }
                              }else{
                                    resultado = "Las prendas inscritas no poseen un numero de documento asociado";
                              }
                          }
                            
                    }catch(Exception exc){
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
					<table width="80%" border="0" align="center">
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
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>