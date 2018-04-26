
<%@page import="com.heinsohn.runt.general.consultas.GarantiasPreRegistradasWSDTO"%>
<%@page import="webservices.consultas.ServicioConsultaRUNTClient"%>
<%@page import="com.heinsohn.runt.general.consultas.ConsultaRegistroGarantiasPreRegistradasOutDTO"%>
<%@page import="com.heinsohn.runt.general.tramite.rnma.TramiteRegrabacionRNMADTO"%>
<%@page import="com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO"%>
<%@page import="com.heinsohn.runt.general.tramite.rnma.TramiteMatriculaInicialRNMADTO"%>
<%@ page  import = "modelo.*" import = "java.util.*" import = "java.sql.*" %>
<html>
    <head>
        <title></title>
        <script type="javascript">
            function aprobarL(){
            if(document.form.sustrato.value.length==13){
            document.form.submit();
            }else{
            alert("Digite numero de sustrato valido");
            }
            }
        </script>
    </head>
    <body>

    </body>
    <%
        Model model = null;
        try {
            boolean procesoTramiteRunt = false;
            String mensajeTramiteRunt = "";
            session.removeAttribute("solicitud");
            session.removeAttribute("respuesta");
            model = (Model) session.getAttribute("model");
            modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
            modelo.UsuarioRunt userRunt = model.consultarUsuarioRunt(usuario.getId_usuario());

            model.getCon().setAutoCommit(false);
            Sede sede = (Sede) session.getAttribute("sede");
            String numero = request.getParameter("radicacion");
            String fecha = request.getParameter("fecha");
            Radicacion radicacion = null;
            if (numero != null && fecha != null) {
                radicacion = model.consultarRadicacion(numero, new java.sql.Date(new java.util.Date(fecha).getTime()), sede.getId_sede());
            }
            if (radicacion != null) {
                if (request.getParameter("del") != null) {
                    if (request.getParameter("del").equals("0")) {
                        radicacion.setEstado(8);
                        model.actualizarEstadoRadicacion(radicacion.getId_radicacion(), 8);
                        model.getCon().commit();
                    }
                }
                if (request.getParameter("ren") != null) {
                    if (request.getParameter("ren").equals("1")) {
                        radicacion.setEstado(9);
                    }
                }
                if (radicacion.getEstado() == 4) {
                    radicacion.setEstado(3);
                }
                if (radicacion.getEstado() == 2) {
                    Model.userHandler = userRunt.getCodigo();
                    Model.passUserHandler = userRunt.getPassword();

                    com.heinsohn.runt.general.solicitudes.RadicarSolicitudOutDTO radicarSolicitudOut = null;
                    webservices.radicacion.RadicacionServicesClient radicacionService = new webservices.radicacion.RadicacionServicesClient();
                    com.heinsohn.runt.general.personas.PropietarioDTO propietarioRNA = new com.heinsohn.runt.general.personas.PropietarioDTO();
                    radicacionService.setTokenHuellaDigital("");
                    radicacionService.setUser(userRunt.getCodigo());
                    if (session.getAttribute("token2") != null) {
                        radicacionService.setTokenHuellaDigital(session.getAttribute("token2").toString());
                    }

                    java.util.List<com.heinsohn.runt.general.solicitudes.LiquidacionInDTO> liquidaciones = new java.util.LinkedList<com.heinsohn.runt.general.solicitudes.LiquidacionInDTO>();
                    java.util.List<com.heinsohn.runt.general.tramite.TramiteBasicoDTO> tramites = new java.util.LinkedList<com.heinsohn.runt.general.tramite.TramiteBasicoDTO>();
                    java.util.List<com.heinsohn.runt.general.identificaciones.InformacionBiometricaCiudadanoDTO> biometricos = new java.util.LinkedList<com.heinsohn.runt.general.identificaciones.InformacionBiometricaCiudadanoDTO>();
                    java.util.List<com.heinsohn.runt.general.solicitudes.RechazoOTDTO> rechazos = new java.util.LinkedList<com.heinsohn.runt.general.solicitudes.RechazoOTDTO>();
                    com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO automotor = new com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO();

                    java.util.List<String> listadoL = new java.util.LinkedList<String>();

                    String identificadorAT = "8634001";
                    String nombreAT = "SABANAGRANDE - ATLANTICO(DPTAL)";
                    String autLimitacion = "N";
                    String descAutorizacion = "";
                    String tipoSolicitud = "SOLICITUD_TRAMITES";
                    boolean solTutela = false;
                    String valorR = null;

                    String tipoDocumentoApoderado = null;
                    String numeroDocumentoApoderado = null;

                    String tipoDocumento = null;
                    String numeroDocumento = null;

                    com.heinsohn.runt.general.identificaciones.InformacionBiometricaCiudadanoDTO biometrico = new com.heinsohn.runt.general.identificaciones.InformacionBiometricaCiudadanoDTO();
                    com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacionP = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();

                    Persona solicitante = model.consultarPersona(radicacion.getFk_persona());

                    java.util.List lista = model.consultarFormularios(radicacion.getId_radicacion());
                    for (int i = 0; i < lista.size(); i++) {
                        Formulario formulario = (Formulario) lista.get(i);
                        java.util.List listaSolReal = model.consultaPropietarios(formulario.getPlaca());
                        if (listaSolReal.size() > 0) {
                            Propietario propSol = (Propietario) listaSolReal.get(0);
                            Persona perSol = model.consultarPersona(propSol.getFk_persona());
                            tipoDocumento = model.consultarParametro((int) solicitante.getTipo_documento(), 5).getNombreCorto();
                            numeroDocumento = solicitante.getDocumento();

                            if (perSol.getId_persona() != radicacion.getFk_persona()) {
                                tipoDocumentoApoderado = model.consultarParametro((int) solicitante.getTipo_documento(), 5).getNombreCorto();
                                numeroDocumentoApoderado = solicitante.getDocumento();
                                identificacionP.setTipoDocumento(tipoDocumentoApoderado);
                                identificacionP.setNumeroDocumento(numeroDocumentoApoderado);
                            } else {
                                identificacionP.setTipoDocumento(tipoDocumento);
                                identificacionP.setNumeroDocumento(numeroDocumento);
                            }
                        } else {
                            tipoDocumento = model.consultarParametro((int) solicitante.getTipo_documento(), 5).getNombreCorto();
                            numeroDocumento = solicitante.getDocumento();
                            identificacionP.setTipoDocumento(tipoDocumento);
                            identificacionP.setNumeroDocumento(numeroDocumento);
                        }
                        break;
                    }

                    String registroSolicitud = String.valueOf("1");
                    String numeroLiquidacion = "0001";///traer pago del usuario
                    //
                    biometrico.setPersona(identificacionP);

                    String template = "";
                    if (session.getAttribute("token") != null) {
                        template = session.getAttribute("token").toString();
                    }
                    javax.xml.namespace.QName name_t = new javax.xml.namespace.QName("tokenHuellaDigital");
                    Class<String> declaredType_t = String.class;
                    Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
                    javax.xml.bind.JAXBElement<String> jaxb_t = new javax.xml.bind.JAXBElement(name_t, declaredType_t, scope_t, template);
                    biometrico.setTokenHuellaDigital(jaxb_t);
                    biometricos.add(biometrico);

                    java.sql.Date fecha_actual = new java.sql.Date(new java.util.Date().getTime());

                    long codigoTramiteRunt = 0;
                    long colorRunt = 0;
                    Vehiculo vehiculo = null;
                    boolean continuar = true;
                    boolean carteraA = false;
                    boolean validacion = false;
                    for (int i = 0; i < lista.size(); i++) {
                        Formulario formulario = (Formulario) lista.get(i);

                        System.out.println("liq 23 : " + formulario.getRunt2());
                        System.out.println("liq 24 : " + formulario.getRunt());
                        if (!model.tieneCarteraActiva(formulario.getPlaca())) {

                            if (formulario.getRunt().equals(formulario.getRunt2())) {
                                if (!listadoL.contains(formulario.getRunt())) {
                                    com.heinsohn.runt.general.solicitudes.LiquidacionInDTO liquidacion = new com.heinsohn.runt.general.solicitudes.LiquidacionInDTO();
                                    liquidacion.setNumeroLiquidacion(formulario.getRunt());
                                    liquidaciones.add(liquidacion);
                                    listadoL.add(formulario.getRunt());
                                    System.out.println("okkkkkkkkkkkkkk2");

                                }

                            } else if (!listadoL.contains(formulario.getRunt()) || !listadoL.contains(formulario.getRunt2())) {
                                com.heinsohn.runt.general.solicitudes.LiquidacionInDTO liquidacion = new com.heinsohn.runt.general.solicitudes.LiquidacionInDTO();
                                liquidacion.setNumeroLiquidacion(formulario.getRunt());
                                liquidaciones.add(liquidacion);
                                listadoL.add(formulario.getRunt());
                                com.heinsohn.runt.general.solicitudes.LiquidacionInDTO liquidacion2 = new com.heinsohn.runt.general.solicitudes.LiquidacionInDTO();
                                liquidacion2.setNumeroLiquidacion(formulario.getRunt2());
                                liquidaciones.add(liquidacion2);
                                listadoL.add(formulario.getRunt2());
                                System.out.println("okkkkkkkkkkkkkk");
                            }

                            /*         if(formulario.getRunt2()!=null){
                                        System.out.println("liq 2 : "+formulario.getRunt2());
                                        com.heinsohn.runt.general.solicitudes.LiquidacionInDTO liquidacion2 = new com.heinsohn.runt.general.solicitudes.LiquidacionInDTO();
                                        liquidacion2.setNumeroLiquidacion(formulario.getRunt2());
                                        liquidaciones.add(liquidacion2);
                                    }*/
                            String nFactura = model.obtenerPosiblePagoTRANSITO(formulario.getPlaca(), formulario.getFk_tramite());
                            if (nFactura.length() == 0) {
                                nFactura = model.consultarPagoReclamo(1, formulario.getPlaca(), formulario.getFk_tramite());
                                nFactura = nFactura != null ? nFactura : "";
                            }
                            //----------------------------- prop radicacion ---------------------------

                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacionRNA = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();

                            Vehiculo vehiProp = model.consultarVehiculo(formulario.getPlaca());
                            if (vehiProp != null) {
                                Propietario prop = model.consultarPropietarioVehiculo(vehiProp.getId_vehiculo());
                                if (prop != null) {
                                    Persona persona = (Persona) model.consultarPersona(prop.getFk_persona());
                                    String tipDocProp = model.consultarParametro((int) persona.getTipo_documento(), 5).getNombreCorto();
                                    String NombreProp = persona.getNombre_1() + " " + persona.getApellido_1();
                                    identificacionRNA.setTipoDocumento(tipDocProp);
                                    identificacionRNA.setNumeroDocumento(persona.getDocumento());
                                    tipoDocumento = tipDocProp;
                                    numeroDocumento = persona.getDocumento();

                                    if (persona.getTipo_documento() == 2) {
                                        Empresa empresa = model.consultarEmpresa(2, persona.getDocumento());
                                        if (empresa != null) {
                                            Representante representante = model.consultarRepresentante(empresa.getFk_representante());
                                            if (representante != null) {
                                                Persona personaRepre = model.consultarPersona(representante.getFk_persona());
                                                String tipDocRep = model.consultarParametro((int) personaRepre.getTipo_documento(), 5).getNombreCorto();
                                                tipoDocumento = tipDocRep;
                                                numeroDocumento = personaRepre.getDocumento();
                                            } else {
                                                mensajeTramiteRunt = "Debe registrar el Representante legal en Civitrans";
                                            }
                                        }
                                    }

                                    javax.xml.namespace.QName name_DP = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "persona");
                                    java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DP = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                    java.lang.Class scope_DP = javax.xml.bind.JAXBElement.GlobalScope.class;
                                    javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DP = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DP, declaredType_DP, scope_DP, identificacionRNA);
                                    propietarioRNA.setPersona(jax_DP);
                                    propietarioRNA.setNombrePropietario(NombreProp);

                                    propietarioRNA.setIdTipoPropiedad(prop.getTipoPropiedad());
                                    propietarioRNA.setProindiviso(prop.getProIndiviso());
                                    propietarioRNA.setPorcentajePropiedad((double) prop.getPorcentaje());

                                    GregorianCalendar gp = new GregorianCalendar();
                                    gp.setTime(new java.sql.Date(new java.util.Date().getTime()));
                                    javax.xml.datatype.XMLGregorianCalendar fecha_inicio = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gp);
                                    propietarioRNA.setFechaInicioPropiedad(null);

                                    javax.xml.namespace.QName name_AP = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "apoderado");
                                    java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_AP = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                    java.lang.Class scope_AP = javax.xml.bind.JAXBElement.GlobalScope.class;
                                    javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_AP = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_AP, declaredType_AP, scope_AP, identificacionP);
                                    propietarioRNA.setApoderado(jax_AP);

                                }

                            }

                            //--------------------------------------------------------------------
                            if (nFactura.length() > 0) {
                                switch ((int) formulario.getFk_tramite()) {
                                    //Tramite de Matricula Inicial - OK
                                    case 1:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteMatriculaInicialDTO tramiteMatriculaRunt = new com.heinsohn.runt.general.tramite.rna.TramiteMatriculaInicialDTO();
                                        tramiteMatriculaRunt.setIdClaseVehiculo(formulario.getClase_vehiculo() + "");
                                        com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO empresaVende = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                        Persona concesionario = model.consultarPersona(2, formulario.getObservaciones().trim());
                                        empresaVende.setTipoDocumento(model.consultarParametro(concesionario.getTipo_documento(), 5).getNombreCorto());
                                        System.out.println(" tipo doc Empresa V : " + model.consultarParametro(concesionario.getTipo_documento(), 5).getNombreCorto());
                                        empresaVende.setNumeroDocumento(concesionario.getDocumento());
                                        System.out.println(" documento Empresa V : " + concesionario.getDocumento());
                                        tramiteMatriculaRunt.setEmpresaVende(empresaVende);

                                        Radicacion_Propietario radicacionPro = model.consultarRadicacionPropietarios(formulario.getId_formulario());
                                        if (radicacionPro != null) {
                                            tramiteMatriculaRunt.setIdTipoPropiedad(Integer.parseInt(radicacionPro.getTipoPropiedad()));
                                            Persona persona = (Persona) model.consultarPersona(radicacionPro.getFk_persona());
                                            String tipDocProp = model.consultarParametro((int) persona.getTipo_documento(), 5).getNombreCorto();
                                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO locatoriosP = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                            if (radicacionPro.getTipoPropiedad().equals("3")) {
                                                locatoriosP.setTipoDocumento(tipDocProp);
                                                locatoriosP.setNumeroDocumento(persona.getDocumento());
                                                tramiteMatriculaRunt.getLocatariosMatriculaInicial().add(locatoriosP);

                                            }
                                            //System.out.println("location : "+tramiteMatriculaRunt.getLocatariosMatriculaInicial());
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 17);
                                        if (valorR != null) {
                                            tramiteMatriculaRunt.setAntiguoClasico(valorR);
                                        }

                                        tramiteMatriculaRunt.setTipoCarroceria(formulario.getCarroceria());
                                        System.out.println("Carroceria : " + formulario.getCarroceria());

                                        valorR = model.consultarRadicacionesEspecificaciones(formulario.getId_formulario(), 2, 2);
                                        if (valorR != null) {
                                            tramiteMatriculaRunt.setCapacidadToneladas(new java.math.BigDecimal(valorR));
                                        } else {
                                            valorR = "0";
                                        }

                                        if ((formulario.getServicio() == 2 || formulario.getServicio() == 1) && Integer.parseInt(valorR) > 10000) {
                                            valorR = model.consultarRadicacionesEspecificaciones(formulario.getId_formulario(), 2, 28);
                                            if (valorR == null) {
                                                continuar = true;
                                                validacion = true;
                                                mensajeTramiteRunt = "El numero de cupo asociado no es el correcto";
                                            }
                                        }
                                        System.out.println("formulario modalidad:" + formulario.getModalidad());
                                        if (formulario.getServicio() == 2 && formulario.getModalidad() != 0) {
                                            System.out.println("modalidad : " + formulario.getModalidad());
                                            //tramiteMatriculaRunt.setIdModalidadServicio(formulario.getModalidad() + ""); 
                                            tramiteMatriculaRunt.setIdModalidadTransporte(formulario.getModalidad() + "");
                                            // Despliegue E42
                                            if (formulario.getModalidad_servicio() != 0) {
                                                tramiteMatriculaRunt.setIdModaServiVehiculo(formulario.getModalidad_servicio() + "");
                                            }
                                            if (formulario.getFk_departamento() != 0) {
                                                tramiteMatriculaRunt.setIdDepartamento((int) formulario.getFk_departamento());
                                            }
                                        }
                                        //tramiteMatriculaRunt.setIdModalidadServicio(formulario.getModalidad() + "");
                                        //System.out.println("despues de modalidad : "+formulario.getModalidad());

                                        if (formulario.getServicio() == 2) {
                                            tramiteMatriculaRunt.setRadioAccion(formulario.getNro_poliza());
                                            if (formulario.getNro_poliza().equals("3")) {
                                                if (!formulario.getArea_metropolitana().equals("0")) {
                                                    tramiteMatriculaRunt.setAreaMetropolitana(formulario.getArea_metropolitana());
                                                }
                                            }
                                            tramiteMatriculaRunt.setVehiculoReposicion("N");
                                        }

                                        Linea linea = model.getLinea(formulario.getFk_linea());
                                        tramiteMatriculaRunt.setCodigoMarca(linea.getFk_marca() + "");

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteMatriculaRunt.setCodigoTipoTramite(codigoTramiteRunt + "");

                                        tramiteMatriculaRunt.setEmpresa(null);
                                        tramiteMatriculaRunt.setEmpresaVende(null);

                                        tramiteMatriculaRunt.setEstadoTramite("SOLICITADO");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 4, 6);
                                        if (valorR != null) {
                                            GregorianCalendar gc = new GregorianCalendar();
                                            gc.setTime(new java.sql.Date(new java.util.Date(valorR).getTime()));
                                            javax.xml.datatype.XMLGregorianCalendar fechaGc = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gc);
                                            tramiteMatriculaRunt.setFechaFacturaCompraVenta(fechaGc);
                                            System.out.println("fecha factura : " + fechaGc);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 4, 2);
                                        if (valorR != null) {
                                            GregorianCalendar gc = new GregorianCalendar();
                                            gc.setTime(new java.sql.Date(new java.util.Date(valorR).getTime()));
                                            javax.xml.datatype.XMLGregorianCalendar fechaGc = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gc);
                                            tramiteMatriculaRunt.setFechaFinVigencia(fechaGc);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 4, 1);
                                        if (valorR != null) {
                                            GregorianCalendar gc = new GregorianCalendar();
                                            gc.setTime(new java.sql.Date(new java.util.Date(valorR).getTime()));
                                            javax.xml.datatype.XMLGregorianCalendar fechaGc = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gc);
                                            tramiteMatriculaRunt.setFechaInicioVigencia(fechaGc);
                                        }

                                        if (formulario.getFecha_poliza() != null) {
                                            GregorianCalendar gc = new GregorianCalendar();
                                            gc.setTime(new java.sql.Date(formulario.getFecha_poliza().getTime()));
                                            javax.xml.datatype.XMLGregorianCalendar fechaGc = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gc);
                                            tramiteMatriculaRunt.setFechaPoliza(fechaGc);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 3);
                                        if (valorR != null) {
                                            tramiteMatriculaRunt.setFichaTecnicaHomologacion(valorR);

                                            System.out.println("ficha tecnica cHASIS : " + valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 8);
                                        if (valorR != null) {
                                            tramiteMatriculaRunt.setFichaTecnicaHomologacionCarroceria(valorR);
                                            System.out.println("ficha tecnica CARROCERIA : " + valorR);
                                        }

                                        colorRunt = model.consultarRadicacionColor(formulario.getId_formulario());
                                        if (colorRunt != 0) {
                                            tramiteMatriculaRunt.setIdColor(colorRunt + "");
                                        }

                                        if (formulario.getFk_linea() != 0) {
                                            tramiteMatriculaRunt.setLineaAutomotor(formulario.getFk_linea() + "");
                                        }

                                        if (formulario.getModelo() != 0) {
                                            tramiteMatriculaRunt.setModelo(formulario.getModelo() + "");
                                        }

                                        com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO municipio = new com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO();
                                        municipio.setIdMunicipio("8001000");
                                        tramiteMatriculaRunt.setMunicipioAfiliadora(municipio);
                                        tramiteMatriculaRunt.setMunicipioVendedor(municipio);

                                        if (formulario.getDocumento_importacion() != null) {
                                            tramiteMatriculaRunt.setNumeroDeclaracionImportacion(formulario.getDocumento_importacion());
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 5);
                                        if (valorR != null) {
                                            tramiteMatriculaRunt.setNumeroFacturaCompraVenta(valorR);
                                            System.out.println("n factura : " + valorR);
                                        }

                                        if (formulario.getNro_poliza() != null) {
                                            tramiteMatriculaRunt.setNumeroPoliza(formulario.getNro_poliza());
                                        }

                                        valorR = model.consultarRadicacionesEspecificaciones(formulario.getId_formulario(), 2, 8);
                                        if (valorR != null) {
                                            tramiteMatriculaRunt.setNumeroPuertas(Integer.parseInt(valorR));
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 9);
                                        if (valorR != null) {
                                            tramiteMatriculaRunt.setObservacionAutorizacionOT(valorR);
                                        }

                                        tramiteMatriculaRunt.setOrdenEjecucion(i);

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 71);
                                        if (valorR != null) {
                                            tramiteMatriculaRunt.setRadioAccion(valorR);
                                        }

                                        //valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 43);
                                        //if(valorR!=null) tramiteMatriculaRunt.setTipoMatricula(valorR);
                                        tramiteMatriculaRunt.setTipoMatricula("PERMANENTE");

                                        //valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 46);
                                        //if(valorR!=null) tramiteMatriculaRunt.setTipoPlaca(valorR);
                                        tramiteMatriculaRunt.setTipoPlaca("NORMAL");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 53);
                                        if (valorR != null) {
                                            tramiteMatriculaRunt.setTipoRegistroVehiculo(valorR);
                                        }

                                        if (formulario.getServicio() != 0) {
                                            tramiteMatriculaRunt.setTipoServicio(formulario.getServicio() + "");
                                            if (formulario.getServicio() == 2) {
                                                tramiteMatriculaRunt.setVehiculoReposicion("N");
                                            } else {
                                                tramiteMatriculaRunt.setVehiculoReposicion("N");
                                            }
                                        }

                                        if (formulario.getSimit() != null) {
                                            tramiteMatriculaRunt.setValorFacturaCompraVenta(formulario.getSimit());
                                            System.out.println("Valor factura : " + formulario.getSimit());
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 7);
                                        if (valorR != null) {
                                            tramiteMatriculaRunt.setValorPoliza(Double.parseDouble(valorR));
                                        }

                                        //valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 3, 11);
                                        //if(valorR!=null)
                                        tramiteMatriculaRunt.setVehiculoDonado("N");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 3, 10);
                                        if (valorR != null) {
                                            tramiteMatriculaRunt.setVehiculoReposicion(valorR);
                                        }

                                        Aseguradora aseguradora = model.consultarAseguradora(formulario.getFk_aseguradora());
                                        if (aseguradora != null) {
                                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO aseguradoraRunt = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                            Persona personaAseguradora = model.consultarPersona(aseguradora.getFk_persona());
                                            aseguradoraRunt.setTipoDocumento(model.consultarParametro(personaAseguradora.getTipo_documento(), 5).getNombreCorto());
                                            aseguradoraRunt.setNumeroDocumento(personaAseguradora.getDocumento());
                                            tramiteMatriculaRunt.setAseguradora(aseguradoraRunt);
                                        }

                                        //////////////////
                                        ///////////////////
                                        java.util.List lista_propietarios = model.consultarRadicacionesPropietarios(formulario.getId_formulario());
                                        for (int j = 0; j < lista_propietarios.size(); j++) {
                                            Radicacion_Propietario radicacion_propietario = (Radicacion_Propietario) lista_propietarios.get(j);
                                            Persona persona = (Persona) model.consultarPersona(radicacion_propietario.getFk_persona());
                                            String tipDocProp = model.consultarParametro((int) persona.getTipo_documento(), 5).getNombreCorto();
                                            String NombreProp = persona.getNombre_1() + " " + persona.getApellido_1();
                                            com.heinsohn.runt.general.personas.PropietarioDTO propietarioDTO = new com.heinsohn.runt.general.personas.PropietarioDTO();

                                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacionProp = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                            identificacionProp.setTipoDocumento(tipDocProp);
                                            identificacionProp.setNumeroDocumento(persona.getDocumento());

                                            javax.xml.namespace.QName name_DP = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "persona");
                                            java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DP = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                            java.lang.Class scope_DP = javax.xml.bind.JAXBElement.GlobalScope.class;
                                            javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DP = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DP, declaredType_DP, scope_DP, identificacionProp);
                                            propietarioDTO.setPersona(jax_DP);
                                            propietarioDTO.setNombrePropietario(NombreProp);

                                            propietarioDTO.setIdTipoPropiedad(radicacion_propietario.getTipoPropiedad());
                                            propietarioDTO.setProindiviso(radicacion_propietario.getProIndiviso());

                                            propietarioDTO.setPorcentajePropiedad((double) radicacion_propietario.getPorcentaje());

                                            GregorianCalendar gp = new GregorianCalendar();
                                            gp.setTime(new java.sql.Date(new java.util.Date().getTime()));
                                            javax.xml.datatype.XMLGregorianCalendar fecha_inicio = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gp);
                                            propietarioDTO.setFechaInicioPropiedad(fecha_inicio);

                                            javax.xml.namespace.QName name_AP = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "apoderado");
                                            java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_AP = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                            java.lang.Class scope_AP = javax.xml.bind.JAXBElement.GlobalScope.class;
                                            javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_AP = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_AP, declaredType_AP, scope_AP, identificacionP);
                                            propietarioDTO.setApoderado(jax_AP);

                                            tramiteMatriculaRunt.getPropietariosMatriculaInicial().add(propietarioDTO);
                                        }

                                        valorR = "" + (model.consultarRadicacionColor(formulario.getId_formulario()));
                                        if (valorR != null) {
                                            tramiteMatriculaRunt.setIdColor(valorR);
                                        }

                                        com.heinsohn.runt.general.tramite.rna.MatriculaReposicionDTO matriculaReposicion = new com.heinsohn.runt.general.tramite.rna.MatriculaReposicionDTO();
                                        matriculaReposicion.setAutomotor(null);
                                        matriculaReposicion.setPorcentajeReposicion(0.0);
                                        tramiteMatriculaRunt.getMatriculaReposicion().add(matriculaReposicion);

                                        tramites.add(tramiteMatriculaRunt);
                                        ;
                                        break;
                                    //Tramite de Traspaso - OK
                                    case 2:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteTraspasoDTO tramiteTraspasoRunt = new com.heinsohn.runt.general.tramite.rna.TramiteTraspasoDTO();

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteTraspasoRunt.setCodigoTipoTramite(codigoTramiteRunt + "");

                                        tramiteTraspasoRunt.setEstadoTramite("SOLICITADO");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 52);
                                        if (valorR != null) {
                                            tramiteTraspasoRunt.setIdTipoTraspaso(valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 3, 46);
                                        if (valorR != null) {
                                            autLimitacion = valorR;
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 47);
                                        if (valorR != null) {
                                            descAutorizacion = valorR;
                                        }

                                        Radicacion_Propietario radicacionProT = model.consultarRadicacionPropietarios(formulario.getId_formulario());

                                        if (radicacionProT != null) {
                                            tramiteTraspasoRunt.setIdTipoPropiedad(Integer.parseInt(radicacionProT.getTipoPropiedad()));
                                            //tramiteMatriculaRunt.setLocatariosMatriculaInicial(null);
                                            Persona persona = (Persona) model.consultarPersona(radicacionProT.getFk_persona());
                                            String tipDocProp = model.consultarParametro((int) persona.getTipo_documento(), 5).getNombreCorto();
                                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO locatoriosP = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                            if (radicacionProT.getTipoPropiedad().equals("3")) {
                                                tramiteTraspasoRunt.setIdTipoLocatario(1);
                                                locatoriosP.setTipoDocumento(tipDocProp);
                                                locatoriosP.setNumeroDocumento(persona.getDocumento());
                                                tramiteTraspasoRunt.getLocatariosMatriculaInicial().add(locatoriosP);

                                            }
                                        }

                                        vehiculo = model.consultarVehiculo(formulario.getPlaca());
                                        if (vehiculo != null) {
                                            java.util.List lista_vendedores = model.crear_Lista_Propietarios(vehiculo.getId_vehiculo());
                                            for (int j = 0; j < lista_vendedores.size(); j++) {
                                                Propietario propietario = (Propietario) lista_vendedores.get(j);
                                                if (propietario.getFecha_final() == null) {
                                                    Persona persona = (Persona) model.consultarPersona(propietario.getFk_persona());
                                                    String tipDocProp = model.consultarParametro((int) persona.getTipo_documento(), 5).getNombreCorto();
                                                    propietario.getPorcentaje();

                                                    com.heinsohn.runt.general.personas.VendedorDTO vendedorDTO = new com.heinsohn.runt.general.personas.VendedorDTO();

                                                    com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                                    identificacion.setIdPersona(null);
                                                    identificacion.setTipoDocumento(tipDocProp);
                                                    identificacion.setNumeroDocumento(persona.getDocumento());

                                                    javax.xml.namespace.QName name_DC = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosVendedor");
                                                    java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DC = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                                    java.lang.Class scope_DC = javax.xml.bind.JAXBElement.GlobalScope.class;
                                                    javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DC = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DC, declaredType_DC, scope_DC, identificacion);
                                                    vendedorDTO.setDatosVendedor(jax_DC);

                                                    String tipDocApo = model.consultarParametro((int) solicitante.getTipo_documento(), 5).getNombreCorto();
                                                    identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                                    identificacion.setIdPersona(null);
                                                    identificacion.setTipoDocumento(tipDocApo);
                                                    identificacion.setNumeroDocumento(solicitante.getDocumento());
                                                    javax.xml.namespace.QName name_DA = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosApoderado");
                                                    java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DA = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                                    java.lang.Class scope_DA = javax.xml.bind.JAXBElement.GlobalScope.class;
                                                    javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DA = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DA, declaredType_DA, scope_DA, identificacion);
                                                    vendedorDTO.setDatosApoderado(jax_DA);

                                                    tramiteTraspasoRunt.getVendedoresTraspaso().add(vendedorDTO);
                                                }
                                            }
                                        } else {
                                            for (int f = 0; f < lista.size(); f++) {
                                                Formulario formMtr = (Formulario) lista.get(f);
                                                if (formMtr.getFk_tramite() == 1 || formMtr.getFk_tramite() == 4) {
                                                    lista_propietarios = model.consultarRadicacionesPropietarios(formMtr.getId_formulario());
                                                    for (int j = 0; j < lista_propietarios.size(); j++) {
                                                        Radicacion_Propietario radicacion_propietario = (Radicacion_Propietario) lista_propietarios.get(j);
                                                        Persona persona = (Persona) model.consultarPersona(radicacion_propietario.getFk_persona());
                                                        String tipDocProp = model.consultarParametro((int) persona.getTipo_documento(), 5).getNombreCorto();

                                                        com.heinsohn.runt.general.personas.VendedorDTO vendedorDTO = new com.heinsohn.runt.general.personas.VendedorDTO();

                                                        com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                                        identificacion.setIdPersona(null);
                                                        identificacion.setTipoDocumento(tipDocProp);
                                                        identificacion.setNumeroDocumento(persona.getDocumento());

                                                        javax.xml.namespace.QName name_DC = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosVendedor");
                                                        java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DC = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                                        java.lang.Class scope_DC = javax.xml.bind.JAXBElement.GlobalScope.class;
                                                        javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DC = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DC, declaredType_DC, scope_DC, identificacion);
                                                        vendedorDTO.setDatosVendedor(jax_DC);

                                                        String tipDocApo = model.consultarParametro((int) solicitante.getTipo_documento(), 5).getNombreCorto();
                                                        identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                                        identificacion.setIdPersona(null);
                                                        identificacion.setTipoDocumento(tipDocApo);
                                                        identificacion.setNumeroDocumento(solicitante.getDocumento());
                                                        javax.xml.namespace.QName name_DA = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosApoderado");
                                                        java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DA = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                                        java.lang.Class scope_DA = javax.xml.bind.JAXBElement.GlobalScope.class;
                                                        javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DA = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DA, declaredType_DA, scope_DA, identificacion);
                                                        vendedorDTO.setDatosApoderado(jax_DA);

                                                        tramiteTraspasoRunt.getVendedoresTraspaso().add(vendedorDTO);

                                                    }
                                                    break;
                                                }
                                            }
                                        }
                                        lista_propietarios = model.consultarRadicacionesPropietarios(formulario.getId_formulario());
                                        for (int j = 0; j < lista_propietarios.size(); j++) {
                                            Radicacion_Propietario radicacion_propietario = (Radicacion_Propietario) lista_propietarios.get(j);
                                            Persona persona = (Persona) model.consultarPersona(radicacion_propietario.getFk_persona());
                                            String tipDocProp = model.consultarParametro((int) persona.getTipo_documento(), 5).getNombreCorto();

                                            com.heinsohn.runt.general.personas.CompradorDTO compradorDTO = new com.heinsohn.runt.general.personas.CompradorDTO();

                                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                            identificacion.setIdPersona(null);
                                            identificacion.setTipoDocumento(tipDocProp);
                                            identificacion.setNumeroDocumento(persona.getDocumento());

                                            javax.xml.namespace.QName name_DC = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosComprador");
                                            java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DC = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                            java.lang.Class scope_DC = javax.xml.bind.JAXBElement.GlobalScope.class;
                                            javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DC = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DC, declaredType_DC, scope_DC, identificacion);
                                            compradorDTO.setDatosComprador(jax_DC);

                                            //compradorDTO.setIdTipoPropiedad("1");
                                            // compradorDTO.setProindiviso("N");
                                            java.util.List apoderados = model.consultarRadicacionesApoderados(formulario.getId_formulario(), persona.getId_persona());
                                            if (apoderados != null) {
                                                for (int k = 0; k < apoderados.size(); k++) {
                                                    Radicacion_Apoderado radicacion_apoderado = (Radicacion_Apoderado) apoderados.get(k);
                                                    Persona apoderado = model.consultarPersona(radicacion_apoderado.getFk_apoderado());
                                                    String tipDocApo = model.consultarParametro((int) apoderado.getTipo_documento(), 5).getNombreCorto();
                                                    identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                                    identificacion.setIdPersona(null);
                                                    identificacion.setTipoDocumento(tipDocApo);
                                                    identificacion.setNumeroDocumento(apoderado.getDocumento());

                                                    javax.xml.namespace.QName name_DA = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosApoderado");
                                                    java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DA = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                                    java.lang.Class scope_DA = javax.xml.bind.JAXBElement.GlobalScope.class;
                                                    javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DA = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DA, declaredType_DA, scope_DA, identificacion);
                                                    compradorDTO.setDatosApoderado(jax_DA);
                                                }
                                            }

                                            tramiteTraspasoRunt.getCompradoresTraspaso().add(compradorDTO);
                                        }

                                        tramiteTraspasoRunt.setProindiviso("N");
                                        tramiteTraspasoRunt.setOrdenEjecucion(i);
                                        tramites.add(tramiteTraspasoRunt);
                                        ;
                                        break;
                                    //Tramite de Traslado de Cuenta - OK
                                    case 3:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }
                                        com.heinsohn.runt.general.tramite.rna.TramiteTrasladoDTO tramiteTraslado = new com.heinsohn.runt.general.tramite.rna.TramiteTrasladoDTO();
                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteTraslado.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteTraslado.setEstadoTramite("SOLICITADO");

                                        Sede nuevaSede = model.consultarSede(formulario.getSede_movimiento());
                                        com.heinsohn.runt.general.personas.AutoridadTransitoDTO autoridad_transito = new com.heinsohn.runt.general.personas.AutoridadTransitoDTO();
                                        autoridad_transito.setIdentificador(nuevaSede.getCodigo());
                                        autoridad_transito.setNombreAutoridadTransito(nuevaSede.getNombre_corto());
                                        tramiteTraslado.setAutoridadTransito(autoridad_transito);
                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 3, 46);
                                        if (valorR != null) {
                                            autLimitacion = valorR;
                                        }
                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 47);
                                        if (valorR != null) {
                                            descAutorizacion = valorR;
                                        }
                                        tramiteTraslado.setOrdenEjecucion(i);
                                        tramites.add(tramiteTraslado);
                                        ;
                                        break;
                                    //Tramite de Radicacion de Cuenta - Pendiente por Revision
                                    case 4:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteRadicacionCuentaDTO tramiteRadicacionRUNT = new com.heinsohn.runt.general.tramite.rna.TramiteRadicacionCuentaDTO();

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteRadicacionRUNT.setCodigoTipoTramite(codigoTramiteRunt + "");

                                        tramiteRadicacionRUNT.setEstadoTramite("SOLICITADO");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 3, 46);
                                        if (valorR != null) {
                                            autLimitacion = valorR;
                                        }

                                        //              if(formulario.getServicio()==2){
                                        //                 com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO empresa = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                        //                empresa.setTipoDocumento("N");
                                        //               empresa.setNumeroDocumento("8905027484");
                                        //              tramiteRadicacionRUNT.setEmpresa(empresa);
                                        //         }
                                        com.heinsohn.runt.general.personas.AutoridadTransitoDTO autoridadTransito = new com.heinsohn.runt.general.personas.AutoridadTransitoDTO();
                                        autoridadTransito.setIdentificador(sede.getCodigo());
                                        autoridadTransito.setNombreAutoridadTransito("SABANAGRANDE - ATLANTICO(DPTAL)");
                                        tramiteRadicacionRUNT.setAutoridadTransito(autoridadTransito);
                                        System.out.println("CODIGO AUTORIDAD DESTINO : " + autoridadTransito.getIdentificador());
                                        System.out.println("AUTORIDAD DESTINO : " + autoridadTransito.getNombreAutoridadTransito());

                                        com.heinsohn.runt.general.personas.AutoridadTransitoDTO autoridadTransitoOrigen = new com.heinsohn.runt.general.personas.AutoridadTransitoDTO();
                                        Sede sedeTraslado = model.consultarSede(formulario.getSede_movimiento());
                                        autoridadTransitoOrigen.setIdentificador(sedeTraslado.getCodigo());
                                        autoridadTransitoOrigen.setNombreAutoridadTransito(sedeTraslado.getNombre_corto());
                                        tramiteRadicacionRUNT.setAutoridadTransitoOrigen(autoridadTransitoOrigen);
                                        System.out.println("CODIGO AUTORIDAD ORIGEN : " + autoridadTransitoOrigen.getIdentificador());
                                        System.out.println("AUTORIDAD ORIGEN : " + autoridadTransitoOrigen.getNombreAutoridadTransito());

                                        tramiteRadicacionRUNT.setOrdenEjecucion(i);
                                        tramites.add(tramiteRadicacionRUNT);
                                        ;
                                        break;
                                    //Tramite de Cambio de Color - OK
                                    case 5:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteCambioColorDTO tramiteColorRunt = new com.heinsohn.runt.general.tramite.rna.TramiteCambioColorDTO();

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteColorRunt.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteColorRunt.setEstadoTramite("SOLICITADO");

                                        colorRunt = model.consultarRadicacionColor(formulario.getId_formulario());
                                        if (colorRunt != 0) {
                                            tramiteColorRunt.setIdColor(colorRunt + "");
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 3, 46);
                                        if (valorR != null) {
                                            autLimitacion = valorR;
                                        }

                                        tramiteColorRunt.setOrdenEjecucion(i);
                                        tramites.add(tramiteColorRunt);
                                        ;
                                        break;
                                    //Tramite de Cambio de Servicio - OK
                                    case 6:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteCambioServicioDTO tramiteServicioRunt = new com.heinsohn.runt.general.tramite.rna.TramiteCambioServicioDTO();
                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteServicioRunt.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteServicioRunt.setEstadoTramite("SOLICITADO");

                                        if (formulario.getServicio() != 0) {
                                            tramiteServicioRunt.setTipoServicio(formulario.getServicio() + "");
                                        }

                                        tramiteServicioRunt.setOrdenEjecucion(i);
                                        tramites.add(tramiteServicioRunt);
                                        ;
                                        break;
                                    //Tramite de Blindaje - Pendiente por Revision
                                    case 7:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteCambioBlindajeDTO tramiteBlindajeRunt = new com.heinsohn.runt.general.tramite.rna.TramiteCambioBlindajeDTO();
                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteBlindajeRunt.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteBlindajeRunt.setEstadoTramite("SOLICITADO");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 31);
                                        if (valorR != null) {
                                            tramiteBlindajeRunt.setNivelBlindaje(valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 39);
                                        if (valorR != null) {
                                            tramiteBlindajeRunt.setClaseResolucionBlindaje(valorR);
                                        }

                                        tramiteBlindajeRunt.setOrdenEjecucion(i);
                                        tramites.add(tramiteBlindajeRunt);
                                        ;
                                        break;
                                    //Tramite de Rematricula - Pendiente por Implementar
                                    case 8:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteRematriculaDTO tramiteRematriculaRunt = new com.heinsohn.runt.general.tramite.rna.TramiteRematriculaDTO();
                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteRematriculaRunt.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteRematriculaRunt.setEstadoTramite("SOLICITADO");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 91);
                                        if (valorR != null) {
                                            tramiteRematriculaRunt.setEntidadQueReportaActa(valorR);
                                        }
                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 36);
                                        if (valorR != null) {
                                            tramiteRematriculaRunt.setNumeroActa(valorR);
                                        }
                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 37);
                                        if (valorR != null) {
                                            com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO municipioActa = new com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO();
                                            municipioActa.setIdMunicipio("8001000");
                                            tramiteRematriculaRunt.setMunicipioActa(municipioActa);
                                        }
                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 4, 38);
                                        if (valorR != null) {
                                            GregorianCalendar gc = new GregorianCalendar();
                                            gc.setTime(new java.sql.Date(new java.util.Date(valorR).getTime()));
                                            javax.xml.datatype.XMLGregorianCalendar fechaGc = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gc);
                                            tramiteRematriculaRunt.setFechaActa(fechaGc);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 7);
                                        if (valorR != null) {
                                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO personaActa = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                            personaActa.setTipoDocumento(valorR);
                                            valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 39);
                                            if (valorR != null) {
                                                personaActa.setNumeroDocumento(valorR);
                                                tramiteRematriculaRunt.setIdentificacionPersonaActa(personaActa);
                                            }
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 40);
                                        if (valorR != null) {
                                            tramiteRematriculaRunt.setNombrePersonaActa(valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 41);
                                        if (valorR != null) {
                                            com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO municipioEntrega = new com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO();
                                            municipioEntrega.setIdMunicipio("8001000");
                                            tramiteRematriculaRunt.setMunicipioEntregaVehiculoActa(municipioEntrega);
                                        }

                                        tramiteRematriculaRunt.setEntidadQueReportaActa("FISCALIA");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 4, 42);
                                        if (valorR != null) {
                                            GregorianCalendar gc = new GregorianCalendar();
                                            gc.setTime(new java.sql.Date(new java.util.Date(valorR).getTime()));
                                            javax.xml.datatype.XMLGregorianCalendar fechaGc = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gc);
                                            tramiteRematriculaRunt.setFechaEntregaActa(fechaGc);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 43);
                                        if (valorR != null) {
                                            tramiteRematriculaRunt.setNumeroPlacaActa(valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 92);
                                        if (valorR != null) {
                                            tramiteRematriculaRunt.setTipoEntregaActa(valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 44);
                                        if (valorR != null) {
                                            tramiteRematriculaRunt.setEstadoEntregaActa(valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 3, 45);
                                        if (valorR != null) {
                                            tramiteRematriculaRunt.setCambioColor(valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 1);
                                        if (valorR != null) {
                                            tramiteRematriculaRunt.setNuevoColor(valorR);
                                        }

                                        tramiteRematriculaRunt.setOrdenEjecucion(i);
                                        tramites.add(tramiteRematriculaRunt);
                                        ;
                                        break;
                                    //Tramite de Traspaso Indeterminado - Pendiente por Implementar
                                    case 9:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteTraspasoIndeterminadoDTO tramiteTraspasoIndRunt = new com.heinsohn.runt.general.tramite.rna.TramiteTraspasoIndeterminadoDTO();

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteTraspasoIndRunt.setCodigoTipoTramite(codigoTramiteRunt + "");

                                        tramiteTraspasoIndRunt.setEstadoTramite("SOLICITADO");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 4, 49);
                                        GregorianCalendar gc1 = new GregorianCalendar();
                                        gc1.setTime(new java.sql.Date(new java.util.Date("01/03/2002").getTime()));
                                        javax.xml.datatype.XMLGregorianCalendar fechaGc1 = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gc1);
                                        // tramiteTraspasoIndRunt.setFechaEnajenacion(fechaGc1);

                                        if (valorR != null) {
                                            GregorianCalendar gc = new GregorianCalendar();
                                            gc.setTime(new java.sql.Date(new java.util.Date(valorR).getTime()));
                                            javax.xml.datatype.XMLGregorianCalendar fechaGc = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gc);
                                            tramiteTraspasoIndRunt.setFechaTraspaso(fechaGc);
                                            tramiteTraspasoIndRunt.setFechaEnajenacion(fechaGc);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 52);
                                        if (valorR != null) {
                                            //tramiteTraspasoIndRunt.setTipoDocumentoTraspaso(valorR);
                                            tramiteTraspasoIndRunt.setTipoDocumentoTraspaso("DECLARACION O MANIFESTACION");
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 50);
                                        if (valorR != null) {
                                            tramiteTraspasoIndRunt.setNombreJuzgado(valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 48);
                                        if (valorR != null) {
                                            long idM = Long.parseLong(valorR.trim().substring(0, valorR.indexOf("-")));
                                            Municipio mncp = model.consultarMunicipioByCodigo(idM);
                                            if (mncp != null) {
                                                modelo.Divipo dvp = model.consultarDvipo(mncp.getDepartamento(), mncp.getCodigo());
                                                if (dvp != null) {
                                                    com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO municipioJuzgado = new com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO();
                                                    municipioJuzgado.setIdMunicipio(Integer.parseInt(dvp.getCodigo()) + "");
                                                    tramiteTraspasoIndRunt.setMunicipioJuzgado(municipioJuzgado);
                                                }
                                            }
                                        }

                                        vehiculo = model.consultarVehiculo(formulario.getPlaca());
                                        java.util.List lista_vendedores = model.crear_Lista_Propietarios(vehiculo.getId_vehiculo());
                                        for (int j = 0; j < lista_vendedores.size(); j++) {
                                            Propietario propietario = (Propietario) lista_vendedores.get(j);
                                            if (propietario.getFecha_final() == null) {
                                                Persona persona = (Persona) model.consultarPersona(propietario.getFk_persona());
                                                String tipDocProp = model.consultarParametro((int) persona.getTipo_documento(), 5).getNombreCorto();
                                                propietario.getPorcentaje();

                                                com.heinsohn.runt.general.personas.VendedorDTO vendedorDTO = new com.heinsohn.runt.general.personas.VendedorDTO();

                                                com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                                identificacion.setIdPersona(null);
                                                identificacion.setTipoDocumento(tipDocProp);
                                                identificacion.setNumeroDocumento(persona.getDocumento());

                                                javax.xml.namespace.QName name_DC = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosVendedor");
                                                java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DC = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                                java.lang.Class scope_DC = javax.xml.bind.JAXBElement.GlobalScope.class;
                                                javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DC = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DC, declaredType_DC, scope_DC, identificacion);
                                                vendedorDTO.setDatosVendedor(jax_DC);

                                                tramiteTraspasoIndRunt.getVendedoresTraspaso().add(vendedorDTO);
                                            }
                                        }

                                        lista_propietarios = model.consultarRadicacionesPropietarios(formulario.getId_formulario());
                                        for (int j = 0; j < lista_propietarios.size(); j++) {
                                            Radicacion_Propietario radicacion_propietario = (Radicacion_Propietario) lista_propietarios.get(j);
                                            Persona persona = (Persona) model.consultarPersona(radicacion_propietario.getFk_persona());
                                            String tipDocProp = model.consultarParametro((int) persona.getTipo_documento(), 5).getNombreCorto();

                                            com.heinsohn.runt.general.personas.CompradorDTO compradorDTO = new com.heinsohn.runt.general.personas.CompradorDTO();

                                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                            identificacion.setIdPersona(null);
                                            identificacion.setTipoDocumento(tipDocProp);
                                            identificacion.setNumeroDocumento(persona.getDocumento());

                                            javax.xml.namespace.QName name_DC = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosComprador");
                                            java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DC = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                            java.lang.Class scope_DC = javax.xml.bind.JAXBElement.GlobalScope.class;
                                            javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DC = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DC, declaredType_DC, scope_DC, identificacion);
                                            compradorDTO.setDatosComprador(jax_DC);

                                            // compradorDTO.setIdTipoPropiedad(radicacion_propietario.getTipoPropiedad());
                                            // compradorDTO.setProindiviso(radicacion_propietario.getProIndiviso());
                                            java.util.List apoderados = model.consultarRadicacionesApoderados(formulario.getId_formulario(), persona.getId_persona());
                                            if (apoderados != null) {
                                                for (int k = 0; k < apoderados.size(); k++) {
                                                    Radicacion_Apoderado radicacion_apoderado = (Radicacion_Apoderado) apoderados.get(k);
                                                    Persona apoderado = model.consultarPersona(radicacion_apoderado.getFk_apoderado());
                                                    String tipDocApo = model.consultarParametro((int) apoderado.getTipo_documento(), 5).getNombreCorto();
                                                    identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                                    identificacion.setIdPersona(null);
                                                    identificacion.setTipoDocumento(tipDocApo);
                                                    identificacion.setNumeroDocumento(apoderado.getDocumento());

                                                    javax.xml.namespace.QName name_DA = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosApoderado");
                                                    java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DA = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                                    java.lang.Class scope_DA = javax.xml.bind.JAXBElement.GlobalScope.class;
                                                    javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DA = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DA, declaredType_DA, scope_DA, identificacion);
                                                    compradorDTO.setDatosApoderado(jax_DA);
                                                }
                                            }

                                            tramiteTraspasoIndRunt.getDestinatarioTraspaso().add(compradorDTO);
                                        }

                                        tramiteTraspasoIndRunt.setOrdenEjecucion(i);
                                        tramites.add(tramiteTraspasoIndRunt);
                                        ;
                                        break;
                                    //Tramite de Traspaso - OK
                                    case 10:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        tramiteTraspasoRunt = new com.heinsohn.runt.general.tramite.rna.TramiteTraspasoDTO();

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteTraspasoRunt.setCodigoTipoTramite(codigoTramiteRunt + "");

                                        tramiteTraspasoRunt.setEstadoTramite("SOLICITADO");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 52);
                                        if (valorR != null) {
                                            tramiteTraspasoRunt.setIdTipoTraspaso(valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 3, 46);
                                        if (valorR != null) {
                                            autLimitacion = valorR;
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 47);
                                        if (valorR != null) {
                                            descAutorizacion = valorR;
                                        }

                                        for (int f = 0; f < lista.size(); f++) {
                                            Formulario formMtr = (Formulario) lista.get(f);
                                            if (formMtr.getFk_tramite() == 2) {
                                                lista_propietarios = model.consultarRadicacionesPropietarios(formMtr.getId_formulario());
                                                for (int j = 0; j < lista_propietarios.size(); j++) {
                                                    Radicacion_Propietario radicacion_propietario = (Radicacion_Propietario) lista_propietarios.get(j);
                                                    Persona persona = (Persona) model.consultarPersona(radicacion_propietario.getFk_persona());
                                                    String tipDocProp = model.consultarParametro((int) persona.getTipo_documento(), 5).getNombreCorto();

                                                    com.heinsohn.runt.general.personas.VendedorDTO vendedorDTO = new com.heinsohn.runt.general.personas.VendedorDTO();

                                                    com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                                    identificacion.setIdPersona(null);
                                                    identificacion.setTipoDocumento(tipDocProp);
                                                    identificacion.setNumeroDocumento(persona.getDocumento());

                                                    javax.xml.namespace.QName name_DC = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosVendedor");
                                                    java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DC = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                                    java.lang.Class scope_DC = javax.xml.bind.JAXBElement.GlobalScope.class;
                                                    javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DC = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DC, declaredType_DC, scope_DC, identificacion);
                                                    vendedorDTO.setDatosVendedor(jax_DC);

                                                    tramiteTraspasoRunt.getVendedoresTraspaso().add(vendedorDTO);
                                                }
                                                break;
                                            }
                                        }
                                        lista_propietarios = model.consultarRadicacionesPropietarios(formulario.getId_formulario());
                                        for (int j = 0; j < lista_propietarios.size(); j++) {
                                            Radicacion_Propietario radicacion_propietario = (Radicacion_Propietario) lista_propietarios.get(j);
                                            Persona persona = (Persona) model.consultarPersona(radicacion_propietario.getFk_persona());
                                            String tipDocProp = model.consultarParametro((int) persona.getTipo_documento(), 5).getNombreCorto();

                                            com.heinsohn.runt.general.personas.CompradorDTO compradorDTO = new com.heinsohn.runt.general.personas.CompradorDTO();

                                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                            identificacion.setIdPersona(null);
                                            identificacion.setTipoDocumento(tipDocProp);
                                            identificacion.setNumeroDocumento(persona.getDocumento());

                                            javax.xml.namespace.QName name_DC = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosComprador");
                                            java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DC = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                            java.lang.Class scope_DC = javax.xml.bind.JAXBElement.GlobalScope.class;
                                            javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DC = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DC, declaredType_DC, scope_DC, identificacion);
                                            compradorDTO.setDatosComprador(jax_DC);

                                            //   compradorDTO.setIdTipoPropiedad("1");
                                            //  compradorDTO.setProindiviso("N");
                                            java.util.List apoderados = model.consultarRadicacionesApoderados(formulario.getId_formulario(), persona.getId_persona());
                                            if (apoderados != null) {
                                                for (int k = 0; k < apoderados.size(); k++) {
                                                    Radicacion_Apoderado radicacion_apoderado = (Radicacion_Apoderado) apoderados.get(k);
                                                    Persona apoderado = model.consultarPersona(radicacion_apoderado.getFk_apoderado());
                                                    String tipDocApo = model.consultarParametro((int) apoderado.getTipo_documento(), 5).getNombreCorto();
                                                    identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                                    identificacion.setIdPersona(null);
                                                    identificacion.setTipoDocumento(tipDocApo);
                                                    identificacion.setNumeroDocumento(apoderado.getDocumento());

                                                    javax.xml.namespace.QName name_DA = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosApoderado");
                                                    java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DA = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                                    java.lang.Class scope_DA = javax.xml.bind.JAXBElement.GlobalScope.class;
                                                    javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DA = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DA, declaredType_DA, scope_DA, identificacion);
                                                    compradorDTO.setDatosApoderado(jax_DA);
                                                }
                                            }

                                            tramiteTraspasoRunt.getCompradoresTraspaso().add(compradorDTO);
                                        }

                                        tramiteTraspasoRunt.setOrdenEjecucion(i);
                                        tramites.add(tramiteTraspasoRunt);
                                        ;
                                        break;
                                    //Tramite de Preasignacion de Placa - Ok
                                    case 11:
                                        com.heinsohn.runt.general.tramite.rna.TramitePreasignacionDTO tramitePreasignacion = new com.heinsohn.runt.general.tramite.rna.TramitePreasignacionDTO();

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 30);
                                        if (valorR != null) {
                                            automotor.setNumeroMotor(valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 31);
                                        if (valorR != null) {
                                            automotor.setNumeroChasis(valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 32);
                                        if (valorR != null) {
                                            automotor.setNumeroSerie(valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 34);
                                        if (valorR != null) {
                                            automotor.setNumeroVIN(valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 50);
                                        if (valorR != null) {
                                            tramitePreasignacion.setTipoServicio(valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 32);
                                        if (valorR != null) {
                                            tramitePreasignacion.setIdOrigenRegistroVehiculo(valorR);
                                        }

                                        tramitePreasignacion.setEstadoTramite("SOLICITADO");

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramitePreasignacion.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramitePreasignacion.setOrdenEjecucion(i);

                                        tramites.add(tramitePreasignacion);
                                        break;
                                    //Tramite Duplicado de Licencia de Transito - Pendiente por Revision
                                    case 12:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.TramiteBasicoDTO tramiteDuplicadoLicenciaRunt = new com.heinsohn.runt.general.tramite.TramiteBasicoDTO();
                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteDuplicadoLicenciaRunt.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteDuplicadoLicenciaRunt.setEstadoTramite("SOLICITADO");

                                        tramiteDuplicadoLicenciaRunt.setOrdenEjecucion(i);
                                        tramites.add(tramiteDuplicadoLicenciaRunt);
                                        ;
                                        break;
                                    //Tramite de Inscripcion de Alerta - OK
                                    case 13:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteInscripcionPrendaDTO tramiteInscripcionRunt = new com.heinsohn.runt.general.tramite.rna.TramiteInscripcionPrendaDTO();
                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteInscripcionRunt.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteInscripcionRunt.setEstadoTramite("SOLICITADO");

                                        Radicacion_Alerta radicacionAlerta = model.consultarRadicacionAlerta(formulario.getId_formulario());
                                        String tipoAlerta = model.consultarParametroName(4, radicacionAlerta.getAlerta());
                                        System.out.println("tipo alerta : " + tipoAlerta);
                                        tramiteInscripcionRunt.setTipoAlerta(tipoAlerta);

                                        com.heinsohn.runt.general.personas.DatosNuevoAcreedorPrendarioDTO datosPrendario = new com.heinsohn.runt.general.personas.DatosNuevoAcreedorPrendarioDTO();
                                        Persona personaPrenda = model.consultarPersona(radicacionAlerta.getFk_persona());

                                        String tipoDocumentoP = model.consultarParametro((int) personaPrenda.getTipo_documento(), 5).getNombreCorto();
                                        datosPrendario.setTipoDocumento(tipoDocumentoP);
                                        datosPrendario.setNumeroDocumento(personaPrenda.getDocumento());
                                        System.out.println("nit acreedor : " + personaPrenda.getDocumento());
                                        if (personaPrenda.getApellido_1() != null) {
                                            //  datosPrendario.setPrimerApellido(personaPrenda.getApellido_1());
                                            //  datosPrendario.setPrimerApellido(null);
                                        }
                                        if (personaPrenda.getNombre_1() != null) {
                                            datosPrendario.setPrimerNombre(personaPrenda.getNombre_1());
                                        }
                                        if (personaPrenda.getApellido_2() != null) {
                                            //  datosPrendario.setSegundoApellido(personaPrenda.getApellido_2());
                                        }
                                        if (personaPrenda.getNombre_2() != null) {
                                            //  datosPrendario.setSegundoNombre(personaPrenda.getNombre_2());
                                        }
                                        datosPrendario.setTipoPersona(tipoDocumentoP.equals("N") ? "PERSONA JURIDICA" : "PERSONA NATURAL");

                                        java.util.List direccionesPrendario = model.listado_direcciones_persona(personaPrenda.getId_persona());
                                        Iterator it = direccionesPrendario.iterator();
                                        while (it.hasNext()) {
                                            Direccion direccionPrenda = (Direccion) it.next();
                                            if (direccionPrenda.getDescripcion() != null) {
                                                //      datosPrendario.setDireccion(direccionPrenda.getDescripcion());
                                            }
                                            if (direccionPrenda.getFk_divipo() != 0) {
                                                Divipo divPrenda = model.getDivipo(direccionPrenda.getFk_divipo());
                                                com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO municipioPrenda = new com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO();

                                                municipioPrenda.setIdMunicipio(Integer.parseInt(divPrenda.getCodigo()) + "");
                                                Departamento dpto = model.consultarDepartamentosById(divPrenda.getFk_departamento());
                                                datosPrendario.setCiudad(municipioPrenda);
                                                System.out.println("municipio : " + municipioPrenda.getIdMunicipio());
                                                System.out.println("departamento : " + dpto.getCodigo_departamento());
                                                //    datosPrendario.setDepartamento(""+dpto.getCodigo_departamento());
                                            }
                                            //datosPrendario.setDepartamento(null);
                                            if (direccionPrenda.getTelefono() != null) {
                                                //  datosPrendario.setTelefono(direccionPrenda.getTelefono());
                                            }
                                        }
                                        tramiteInscripcionRunt.setDatosPersonaAcreedor(datosPrendario);

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 21);
                                        if (valorR != null) {
                                            tramiteInscripcionRunt.setGradoAlerta(valorR);
                                        }

                                        /*Id prenda*/
                                        webservices.consultas.ServicioConsultaRUNTClient port = new ServicioConsultaRUNTClient();
                                        Model.userHandler = userRunt.getCodigo();
                                        Model.passUserHandler = userRunt.getPassword();
                                        port.setUser(userRunt.getCodigo());
                                        if (session.getAttribute("token2") != null) {
                                            port.setTokenHuellaDigital(session.getAttribute("token2").toString());
                                        }
                                        ConsultaRegistroGarantiasPreRegistradasOutDTO preRegistro = new ConsultaRegistroGarantiasPreRegistradasOutDTO();
                                        preRegistro = port.consultarPrendasPreRegistrada(formulario.getPlaca().toUpperCase());
                                        
                                        
                                        if (preRegistro != null) {
                                            for (GarantiasPreRegistradasWSDTO temPreRegistro : preRegistro.getAcredoresPrendarios()) {
                                                tramiteInscripcionRunt.setIdPrenda(temPreRegistro.getIdentificador());
                                                modelo.Parametro param = model.consultarParametro(personaPrenda.getTipo_documento(), 66);
                                                if (param.getNombreCorto().equals(temPreRegistro.getTipoDocumento()) && personaPrenda.getDocumento().equals(temPreRegistro.getNumeroDocumento())) {
                                                    tramiteInscripcionRunt.setIdPrenda(temPreRegistro.getIdentificador());
                                                }
                                            }
                                        } else {
                                            tramiteInscripcionRunt.setIdPrenda(null);
                                        }
                                        /**/
                                        tramiteInscripcionRunt.setOrdenEjecucion(i);
                                        tramites.add(tramiteInscripcionRunt);
                                        ;
                                        break;
                                    //Tramite Levantamiento de Alerta - OK
                                    case 14:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteLevantamientoPrendaDTO tramiteLevantamientoRunt = new com.heinsohn.runt.general.tramite.rna.TramiteLevantamientoPrendaDTO();
                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteLevantamientoRunt.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteLevantamientoRunt.setEstadoTramite("SOLICITADO");
                                        Persona personaAcreedora;
                                        vehiculo = model.consultarVehiculo(formulario.getPlaca());
                                        if (vehiculo != null) {
                                            Alerta alerta = model.consultarAlerta(vehiculo.getId_vehiculo());
                                            tipoAlerta = model.consultarParametroName(4, alerta.getTipo());//revisar parametrizacion
                                            tramiteLevantamientoRunt.setTipoAlerta(tipoAlerta);
                                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacionPA = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                            personaAcreedora = model.consultarPersona(alerta.getFk_persona());
                                            String tipoDocumentoL = model.consultarParametro((int) personaAcreedora.getTipo_documento(), 5).getNombreCorto();
                                            identificacionPA.setTipoDocumento(tipoDocumentoL);
                                            identificacionPA.setNumeroDocumento(personaAcreedora.getDocumento());
                                            tramiteLevantamientoRunt.setDatosAcreedorPrendario(identificacionPA);
                                            tramiteLevantamientoRunt.setGradoAlerta("" + alerta.getGrado());
                                        } else {
                                            Radicacion_Alerta radAlerta = model.consultarRadicacionAlerta(formulario.getId_formulario());
                                            tipoAlerta = model.consultarParametroName(4, radAlerta.getAlerta());//revisar parametrizacion
                                            tramiteLevantamientoRunt.setTipoAlerta(tipoAlerta);
                                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacionPA = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                            personaAcreedora = model.consultarPersona(radAlerta.getFk_persona());
                                            String tipoDocumentoL = model.consultarParametro((int) personaAcreedora.getTipo_documento(), 5).getNombreCorto();
                                            identificacionPA.setTipoDocumento(tipoDocumentoL);
                                            identificacionPA.setNumeroDocumento(personaAcreedora.getDocumento());
                                            tramiteLevantamientoRunt.setDatosAcreedorPrendario(identificacionPA);
                                            tramiteLevantamientoRunt.setGradoAlerta("1");
                                        }

                                        /*Id prenda*/
                                        port = new ServicioConsultaRUNTClient();
                                        Model.userHandler = userRunt.getCodigo();
                                        Model.passUserHandler = userRunt.getPassword();
                                        port.setUser(userRunt.getCodigo());
                                        if (session.getAttribute("token2") != null) {
                                            port.setTokenHuellaDigital(session.getAttribute("token2").toString());
                                        }
                                        ConsultaRegistroGarantiasPreRegistradasOutDTO preRegistro2 = new ConsultaRegistroGarantiasPreRegistradasOutDTO();
                                        preRegistro2 = port.consultarPrendasPreRegistrada(formulario.getPlaca());

                                        if (preRegistro2 != null) {
                                            for (GarantiasPreRegistradasWSDTO temPreRegistro : preRegistro2.getAcredoresPrendarios()) {
                                                modelo.Parametro param = model.consultarParametro(personaAcreedora.getTipo_documento(), 66);
                                                if (param.getNombreCorto().equals(temPreRegistro.getTipoDocumento()) && personaAcreedora.getDocumento().equals(temPreRegistro.getNumeroDocumento())) {
                                                    tramiteLevantamientoRunt.setIdPrenda(temPreRegistro.getIdentificador());
                                                }
                                            }
                                        } else {
                                            tramiteLevantamientoRunt.setIdPrenda(0L);
                                        }

                                        /**/
                                        tramiteLevantamientoRunt.setOrdenEjecucion(i);
                                        tramites.add(tramiteLevantamientoRunt);
                                        ;
                                        break;
                                    //Tramite Cancelacion de Matricula - OK
                                    case 15:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }
                                        com.heinsohn.runt.general.tramite.rna.TramiteCancelacionMatriculaDTO tramiteCancelacion = new com.heinsohn.runt.general.tramite.rna.TramiteCancelacionMatriculaDTO();
                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteCancelacion.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteCancelacion.setEstadoTramite("SOLICITADO");
                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 29);
                                        if (valorR != null) {
                                            tramiteCancelacion.setMotivoCancelacion(valorR);
                                            System.out.println("motivo : " + valorR);
                                            //    if(valorR.equals("HURTO")){

                                            valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 53);
                                            if (valorR != null) {
                                                String entidadC = valorR;
                                                javax.xml.namespace.QName name_J = new javax.xml.namespace.QName("enteJudicial");
                                                Class<String> declaredType_J = String.class;
                                                Class scope_J = javax.xml.bind.JAXBElement.GlobalScope.class;
                                                javax.xml.bind.JAXBElement<String> jaxb_J = new javax.xml.bind.JAXBElement(name_J, declaredType_J, scope_J, entidadC);
                                                tramiteCancelacion.setEnteJudicial(jaxb_J);
                                            }
                                            valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 52);
                                            if (valorR != null) {
                                                String oficioCancelacion = valorR;
                                                javax.xml.namespace.QName name_o = new javax.xml.namespace.QName("numeroOficio");
                                                Class<String> declaredType_o = String.class;
                                                Class scope_o = javax.xml.bind.JAXBElement.GlobalScope.class;
                                                javax.xml.bind.JAXBElement<String> jaxb_o = new javax.xml.bind.JAXBElement(name_o, declaredType_o, scope_o, oficioCancelacion);
                                                tramiteCancelacion.setNumeroOficio(jaxb_o);
                                            }

                                            // }
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 4, 51);

                                        if (valorR != null) {
                                            System.out.println("fecha hecho cancelacion : " + valorR);
                                            java.sql.Date fechaHe = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(valorR).getTime());
                                            GregorianCalendar fhr = new GregorianCalendar();
                                            fhr.setTime(new java.sql.Date(fechaHe.getTime()));
                                            javax.xml.datatype.XMLGregorianCalendar fechaHec = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fhr);
                                            tramiteCancelacion.setFechaHecho(fechaHec);
                                        }

                                        tramiteCancelacion.setOrdenEjecucion(i);
                                        tramiteCancelacion.setRecuperacionMotor("N");
                                        tramites.add(tramiteCancelacion);
                                        ;
                                        break;
                                    //Tramite Cambio de Placa Reflectiva - Pendiente por Revision
                                    case 16:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteCambioPlacaDTO tramiteCambioPlaca = new com.heinsohn.runt.general.tramite.rna.TramiteCambioPlacaDTO();

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteCambioPlaca.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteCambioPlaca.setEstadoTramite("SOLICITADO");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 46);
                                        if (valorR != null) {
                                            tramiteCambioPlaca.setTipoPlaca(valorR);
                                        }

                                        tramiteCambioPlaca.setOrdenEjecucion(i);

                                        tramites.add(tramiteCambioPlaca);
                                        ;
                                        break;
                                    //Tramite Cambio de Motor - OK
                                    case 17:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteCambioMotorDTO tramiteCambioMotor = new com.heinsohn.runt.general.tramite.rna.TramiteCambioMotorDTO();

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteCambioMotor.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteCambioMotor.setEstadoTramite("SOLICITADO");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 37);
                                        if (valorR != null) {
                                            tramiteCambioMotor.setTipoIngresoMotor(valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 22);
                                        if (valorR != null) {
                                            tramiteCambioMotor.setNumeroDeclaracionImportacion(valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 23);
                                        if (valorR != null) {
                                            tramiteCambioMotor.setNumeroFacturaCompraMotor(valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 4, 24);
                                        if (valorR != null) {
                                            System.out.println("fecha fact Motor : " + valorR);
                                            java.sql.Date fechaF = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(valorR).getTime());
                                            GregorianCalendar fefm = new GregorianCalendar();
                                            fefm.setTime(new java.sql.Date(fechaF.getTime()));
                                            javax.xml.datatype.XMLGregorianCalendar fechaFacturaMotor = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fefm);
                                            tramiteCambioMotor.setFechaExpedicionFacturaCompraMotor(fechaFacturaMotor);

                                        }

                                        if (formulario.getMotor() != null) {
                                            tramiteCambioMotor.setNumeroMotor(formulario.getMotor());
                                        }
                                        tramiteCambioMotor.setOrdenEjecucion(i);

                                        tramites.add(tramiteCambioMotor);
                                        ;
                                        break;
                                    //Tramite de Duplicado de Placas - OK
                                    case 18:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteDuplicadoPlacasDTO tramiteDuplicadoPlaca = new com.heinsohn.runt.general.tramite.rna.TramiteDuplicadoPlacasDTO();

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteDuplicadoPlaca.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteDuplicadoPlaca.setEstadoTramite("SOLICITADO");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 27);
                                        if (valorR != null) {
                                            System.out.println("motivo dupli : " + valorR);
                                            tramiteDuplicadoPlaca.setIdMotivoDuplicado(valorR);
                                        }

                                        tramiteDuplicadoPlaca.setCantidadPlacas(1);

                                        tramiteDuplicadoPlaca.setOrdenEjecucion(i);

                                        tramites.add(tramiteDuplicadoPlaca);
                                        ;
                                        break;
                                    //Tramite de Certificado de Tradicion - Pendiente por Implementar
                                    case 19:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteCertificadoTradicionDTO certificadoTradicion = new com.heinsohn.runt.general.tramite.rna.TramiteCertificadoTradicionDTO();

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        certificadoTradicion.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        certificadoTradicion.setEstadoTramite("SOLICITADO");

                                        certificadoTradicion.setObservacionesCertificadoTradicion(formulario.getObservaciones());

                                        certificadoTradicion.setOrdenEjecucion(i);

                                        tramites.add(certificadoTradicion);
                                        ;
                                        break;
                                    //Tramite de Cambio de Carroceria (Transformacion 1) - Pendiente por Revision
                                    case 20:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteTransformacionDTO tramiteTransformacionCarroceriaRUNT = new com.heinsohn.runt.general.tramite.rna.TramiteTransformacionDTO();

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteTransformacionCarroceriaRUNT.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteTransformacionCarroceriaRUNT.setEstadoTramite("SOLICITADO");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 8);
                                        if (valorR != null) {
                                            tramiteTransformacionCarroceriaRUNT.setNumeroFichaTecnica(valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 3, 46);
                                        if (valorR != null) {
                                            autLimitacion = valorR;
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 47);
                                        if (valorR != null) {
                                            descAutorizacion = valorR;
                                        }

                                        tramiteTransformacionCarroceriaRUNT.setIdTipoTransformacion("CAMBIO CARROCERIA");
                                        tramiteTransformacionCarroceriaRUNT.setIdTipoCarroceria(formulario.getCarroceria() + "");

                                        tramiteTransformacionCarroceriaRUNT.setOrdenEjecucion(i);

                                        tramites.add(tramiteTransformacionCarroceriaRUNT);
                                        ;
                                        break;
                                    //Tramite de Cambio de Combustible (Transformacion 2) - Pendiente por Revision
                                    case 21:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteTransformacionDTO tramiteTransformacionCombustibleRUNT = new com.heinsohn.runt.general.tramite.rna.TramiteTransformacionDTO();

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteTransformacionCombustibleRUNT.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteTransformacionCombustibleRUNT.setEstadoTramite("SOLICITADO");

                                        tramiteTransformacionCombustibleRUNT.setIdTipoTransformacion("CAMBIO COMBUSTIBLE");
                                        tramiteTransformacionCombustibleRUNT.setNombreTipoCombustible(formulario.getCombustible() + "");

                                        tramiteTransformacionCombustibleRUNT.setOrdenEjecucion(i);

                                        tramites.add(tramiteTransformacionCombustibleRUNT);
                                        ;
                                        break;
                                    //Tramite de Cambio de Conjunto (Transformacion 3) - Pendiente por Revision
                                    case 22:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteTransformacionDTO tramiteTransformacionConjuntoRUNT = new com.heinsohn.runt.general.tramite.rna.TramiteTransformacionDTO();

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteTransformacionConjuntoRUNT.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteTransformacionConjuntoRUNT.setEstadoTramite("SOLICITADO");

                                        tramiteTransformacionConjuntoRUNT.setIdTipoTransformacion("CAMBIO CONJUNTO");
                                        tramiteTransformacionConjuntoRUNT.setDescripcion(formulario.getObservaciones());
                                        tramiteTransformacionConjuntoRUNT.setModeloNuevo(formulario.getModelo() + "");

                                        tramiteTransformacionConjuntoRUNT.setOrdenEjecucion(i);

                                        tramites.add(tramiteTransformacionConjuntoRUNT);
                                        ;
                                        break;
                                    //Tramite de Repotenciacion (Transformacion 4) - Pendiente por Revision
                                    case 23:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteTransformacionDTO tramiteTransformacionRepotenciacionRUNT = new com.heinsohn.runt.general.tramite.rna.TramiteTransformacionDTO();

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteTransformacionRepotenciacionRUNT.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteTransformacionRepotenciacionRUNT.setEstadoTramite("SOLICITADO");

                                        tramiteTransformacionRepotenciacionRUNT.setIdTipoTransformacion("REPOTENCIACION");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 49);
                                        if (valorR != null) {
                                            tramiteTransformacionRepotenciacionRUNT.setTipoRepotenciacion(valorR);
                                            if (valorR.equals("1") || valorR.equals("4")) {
                                                tramiteTransformacionRepotenciacionRUNT.setNumeroMotor(formulario.getMotor());

                                                valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 22);
                                                if (valorR != null) {
                                                    tramiteTransformacionRepotenciacionRUNT.setNumeroDeclaracionImportacion(valorR);
                                                }

                                                valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 28);
                                                if (valorR != null) {
                                                    tramiteTransformacionRepotenciacionRUNT.setNumeroFactura(valorR);
                                                }

                                                valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 37);
                                                if (valorR != null) {
                                                    tramiteTransformacionRepotenciacionRUNT.setTipoIngresoMotor(valorR);
                                                }

                                                valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 93);
                                                if (valorR != null) {
                                                    tramiteTransformacionRepotenciacionRUNT.setAnotacionesTransformacion(valorR);
                                                }

                                                valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 4, 27);
                                                if (valorR != null) {
                                                    GregorianCalendar fefm = new GregorianCalendar();
                                                    fefm.setTime(new java.sql.Date(new java.util.Date(valorR).getTime()));
                                                    javax.xml.datatype.XMLGregorianCalendar fechaFacturaMotor = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fefm);
                                                    tramiteTransformacionRepotenciacionRUNT.setFechaExpedicionFactura(fechaFacturaMotor);
                                                }

                                                valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 3, 26);
                                                if (valorR != null) {
                                                    tramiteTransformacionRepotenciacionRUNT.setRealizaCambioMotor(valorR);
                                                }
                                            }
                                            if (valorR.equals("2") || valorR.equals("5")) {
                                                String valorR2 = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 93);
                                                if (valorR2 != null) {
                                                    tramiteTransformacionRepotenciacionRUNT.setAnotacionesTransformacion(valorR2);
                                                }
                                            }
                                            if (valorR.equals("3") || valorR.equals("4") || valorR.equals("5")) {
                                                tramiteTransformacionRepotenciacionRUNT.setModeloNuevo(formulario.getModelo() + "");

                                                String valorR3 = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 93);
                                                if (valorR3 != null) {
                                                    tramiteTransformacionRepotenciacionRUNT.setAnotacionesTransformacion(valorR3);
                                                }
                                            }
                                        }

                                        tramiteTransformacionRepotenciacionRUNT.setOrdenEjecucion(i);

                                        tramites.add(tramiteTransformacionRepotenciacionRUNT);
                                        ;
                                        break;
                                    //Tramite de Regrabacion de Motor - OK
                                    case 24:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteRegrabacionVehiculoDTO tramiteRegrabacionMotorRunt = new com.heinsohn.runt.general.tramite.rna.TramiteRegrabacionVehiculoDTO();

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteRegrabacionMotorRunt.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteRegrabacionMotorRunt.setEstadoTramite("SOLICITADO");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 28);
                                        if (valorR != null) {
                                            tramiteRegrabacionMotorRunt.setMotivoRegrabacion(valorR);
                                        }

                                        tramiteRegrabacionMotorRunt.setTipoRegrabacion("REGRABACION MOTOR");
                                        tramiteRegrabacionMotorRunt.setNumeroMotor(formulario.getMotor());

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 35);
                                        if (valorR != null) {
                                            tramiteRegrabacionMotorRunt.setNumeroRevisionTecnicoMecanica(valorR);
                                        }

                                        tramites.add(tramiteRegrabacionMotorRunt);
                                        ;
                                        break;
                                    //Tramite de Regrabacion de Chasis - OK
                                    case 25:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteRegrabacionVehiculoDTO tramiteRegrabacionChasisRunt = new com.heinsohn.runt.general.tramite.rna.TramiteRegrabacionVehiculoDTO();

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteRegrabacionChasisRunt.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteRegrabacionChasisRunt.setEstadoTramite("SOLICITADO");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 28);
                                        if (valorR != null) {
                                            tramiteRegrabacionChasisRunt.setMotivoRegrabacion(valorR);
                                        }

                                        tramiteRegrabacionChasisRunt.setTipoRegrabacion("REGRABACION CHASIS");
                                        tramiteRegrabacionChasisRunt.setNumeroChasis(formulario.getChasis());

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 35);
                                        if (valorR != null) {
                                            tramiteRegrabacionChasisRunt.setNumeroRevisionTecnicoMecanica(valorR);
                                        }

                                        tramites.add(tramiteRegrabacionChasisRunt);
                                        ;
                                        break;
                                    //Tramite de Regrabacion de Serie - OK
                                    case 26:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteRegrabacionVehiculoDTO tramiteRegrabacionSerieRunt = new com.heinsohn.runt.general.tramite.rna.TramiteRegrabacionVehiculoDTO();

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteRegrabacionSerieRunt.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteRegrabacionSerieRunt.setEstadoTramite("SOLICITADO");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 28);
                                        if (valorR != null) {
                                            tramiteRegrabacionSerieRunt.setMotivoRegrabacion(valorR);
                                        }

                                        tramiteRegrabacionSerieRunt.setTipoRegrabacion("REGRABACION SERIE");
                                        tramiteRegrabacionSerieRunt.setNumeroSerie(formulario.getSerie());

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 35);
                                        if (valorR != null) {
                                            tramiteRegrabacionSerieRunt.setNumeroRevisionTecnicoMecanica(valorR);
                                        }

                                        tramites.add(tramiteRegrabacionSerieRunt);
                                        ;
                                        break;
                                    //Tramite de Subrogacion de Alerta - OK
                                    case 27:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteModificacionAcreedorPrendarioDTO tramiteSubrogacionPrendaRunt = new com.heinsohn.runt.general.tramite.rna.TramiteModificacionAcreedorPrendarioDTO();
                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteSubrogacionPrendaRunt.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteSubrogacionPrendaRunt.setEstadoTramite("SOLICITADO");

                                        radicacionAlerta = model.consultarRadicacionAlerta(formulario.getId_formulario());
                                        tipoAlerta = model.consultarParametroName(4, radicacionAlerta.getAlerta());

                                        com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO antiguoAcreedor = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();

                                        vehiculo = model.consultarVehiculo(formulario.getPlaca());
                                        Alerta alertaAnterior = model.consultarAlerta(vehiculo.getId_vehiculo());
                                        Persona personaAnterior = model.consultarPersona(alertaAnterior.getFk_persona());
                                        String tipoDocAnterior = model.consultarParametro((int) personaAnterior.getTipo_documento(), 5).getNombreCorto();
                                        antiguoAcreedor.setTipoDocumento(tipoDocAnterior);
                                        antiguoAcreedor.setNumeroDocumento(personaAnterior.getDocumento());

                                        javax.xml.namespace.QName name_AA = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosAntiguoAcreedor");
                                        java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_AA = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                        java.lang.Class scope_AA = javax.xml.bind.JAXBElement.GlobalScope.class;
                                        javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_AA = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_AA, declaredType_AA, scope_AA, antiguoAcreedor);
                                        tramiteSubrogacionPrendaRunt.setDatosAntiguoAcreedor(jax_AA);

                                        datosPrendario = new com.heinsohn.runt.general.personas.DatosNuevoAcreedorPrendarioDTO();
                                        personaPrenda = model.consultarPersona(radicacionAlerta.getFk_persona());

                                        String tipoDocumentop = model.consultarParametro((int) personaPrenda.getTipo_documento(), 5).getNombreCorto();
                                        datosPrendario.setTipoDocumento(tipoDocumentop);
                                        datosPrendario.setNumeroDocumento(personaPrenda.getDocumento());
                                        if (personaPrenda.getApellido_1() != null) {
                                            datosPrendario.setPrimerApellido(personaPrenda.getApellido_1());
                                        }
                                        if (personaPrenda.getNombre_1() != null) {
                                            datosPrendario.setPrimerNombre(personaPrenda.getNombre_1());
                                        }
                                        if (personaPrenda.getApellido_2() != null) {
                                            datosPrendario.setSegundoApellido(personaPrenda.getApellido_2());
                                        }
                                        if (personaPrenda.getNombre_2() != null) {
                                            datosPrendario.setSegundoNombre(personaPrenda.getNombre_2());
                                        }
                                        datosPrendario.setTipoPersona(tipoDocumentop.equals("N") ? "PERSONA JURIDICA" : "PERSONA NATURAL");

                                        direccionesPrendario = model.listado_direcciones_persona(personaPrenda.getId_persona());
                                        it = direccionesPrendario.iterator();
                                        while (it.hasNext()) {
                                            Direccion direccionPrenda = (Direccion) it.next();
                                            if (direccionPrenda.getDescripcion() != null) {
                                                datosPrendario.setDireccion(direccionPrenda.getDescripcion());
                                            }
                                            if (direccionPrenda.getFk_divipo() != 0) {
                                                Divipo divPrenda = model.getDivipo(direccionPrenda.getFk_divipo());
                                                com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO municipioPrenda = new com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO();
                                                municipioPrenda.setIdMunicipio(Integer.parseInt(divPrenda.getCodigo()) + "");
                                                datosPrendario.setCiudad(municipioPrenda);
                                            }
                                            if (direccionPrenda.getTelefono() != null) {
                                                datosPrendario.setTelefono(direccionPrenda.getTelefono());
                                            }
                                        }

                                        javax.xml.namespace.QName name_NP = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosNuevoAcreedor");
                                        java.lang.Class<com.heinsohn.runt.general.personas.DatosNuevoAcreedorPrendarioDTO> declaredType_NP = com.heinsohn.runt.general.personas.DatosNuevoAcreedorPrendarioDTO.class;
                                        java.lang.Class scope_NP = javax.xml.bind.JAXBElement.GlobalScope.class;
                                        javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.DatosNuevoAcreedorPrendarioDTO> jax_NP = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.DatosNuevoAcreedorPrendarioDTO>(name_NP, declaredType_NP, scope_NP, datosPrendario);
                                        tramiteSubrogacionPrendaRunt.setDatosNuevoAcreedor(jax_NP);

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 21);
                                        if (valorR != null) {
                                            javax.xml.namespace.QName name_g = new javax.xml.namespace.QName("gradoAlerta");
                                            Class<String> declaredType_g = String.class;
                                            Class scope_g = javax.xml.bind.JAXBElement.GlobalScope.class;
                                            javax.xml.bind.JAXBElement<String> jaxb_g = new javax.xml.bind.JAXBElement(name_g, declaredType_g, scope_g, valorR);
                                            tramiteSubrogacionPrendaRunt.setGradoAlerta(jaxb_g);
                                        }

                                        tramiteSubrogacionPrendaRunt.setOrdenEjecucion(i);
                                        tramites.add(tramiteSubrogacionPrendaRunt);
                                        ;
                                        break;
                                    //Tramite Cancelacion de Matricula - OK
                                    case 32:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteCancelacionMatriculaDTO tramiteCancelacionRep = new com.heinsohn.runt.general.tramite.rna.TramiteCancelacionMatriculaDTO();

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteCancelacionRep.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteCancelacionRep.setEstadoTramite("SOLICITADO");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 151);
                                        if (valorR != null) {
                                            tramiteCancelacionRep.setMotivoCancelacion(valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 4, 51);

                                        if (valorR != null) {
                                            System.out.println("fecha hecho cance lrepo : " + valorR);
                                            java.sql.Date fechaHe = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(valorR).getTime());
                                            GregorianCalendar fhr = new GregorianCalendar();
                                            fhr.setTime(new java.sql.Date(fechaHe.getTime()));
                                            javax.xml.datatype.XMLGregorianCalendar fechaHec = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fhr);
                                            tramiteCancelacionRep.setFechaHecho(fechaHec);

                                        }

                                        tramiteCancelacionRep.setOrdenEjecucion(i);

                                        if (formulario.getMotor() != null) {
                                            //   tramiteCancelacionRep.setNumeroMotor(formulario.getMotor());
                                        }

                                        tramites.add(tramiteCancelacionRep);
                                        ;
                                        break;

                                    case 62: // tramite registro incii
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rnrys.TramiteMatriculaInicialRNRYSDTO tramiteMatriculaRNRYS = new com.heinsohn.runt.general.tramite.rnrys.TramiteMatriculaInicialRNRYSDTO();
                                        tramiteMatriculaRNRYS.setIdClaseVehiculo(formulario.getClase_vehiculo() + "");
                                        com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO empresaVendeRNRYS = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                        Persona concesionarioRNRYS = model.consultarPersona(2, formulario.getObservaciones());
                                        empresaVendeRNRYS.setTipoDocumento(model.consultarParametro(concesionarioRNRYS.getTipo_documento(), 5).getNombreCorto());
                                        System.out.println(" tipo doc Empresa RNRYS : " + model.consultarParametro(concesionarioRNRYS.getTipo_documento(), 5).getNombreCorto());
                                        empresaVendeRNRYS.setNumeroDocumento(concesionarioRNRYS.getDocumento());
                                        System.out.println(" documento Empresa RNRYS : " + concesionarioRNRYS.getDocumento());
                                        tramiteMatriculaRNRYS.setEmpresaVende(empresaVendeRNRYS);

                                        Radicacion_Propietario radicacionProRNRYS = model.consultarRadicacionPropietarios(formulario.getId_formulario());
                                        if (radicacionProRNRYS != null) {
                                            Persona persona = (Persona) model.consultarPersona(radicacionProRNRYS.getFk_persona());
                                            String tipDocProp = model.consultarParametro((int) persona.getTipo_documento(), 5).getNombreCorto();
                                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO locatoriosP = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                            if (radicacionProRNRYS.getTipoPropiedad().equals("3")) {
                                                locatoriosP.setTipoDocumento(tipDocProp);
                                                locatoriosP.setNumeroDocumento(persona.getDocumento());
                                                tramiteMatriculaRNRYS.getLocatariosMatriculaInicial().add(locatoriosP);

                                            }
                                        }
                                        tramiteMatriculaRNRYS.setIdTipoPropiedad(1);
                                        //System.out.println("location : "+tramiteMatriculaRunt.getLocatariosMatriculaInicial());

                                        tramiteMatriculaRNRYS.setNumeroVIN(formulario.getVin());
                                        tramiteMatriculaRNRYS.setNumeroSerie(formulario.getSerie());

                                        //  tramiteMatriculaRNRYS.setTipoCarroceria(""+formulario.getCarroceria());
                                        System.out.println("Carroceria : " + formulario.getCarroceria());

                                        tramiteMatriculaRNRYS.setCodigoMarca(formulario.getFk_marca() + "");
                                        //tramiteMatriculaRNRYS.setReferencia(""+formulario.getFk_linea());
                                        tramiteMatriculaRNRYS.setReferencia(null);

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteMatriculaRNRYS.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        tramiteMatriculaRNRYS.setEstadoTramite("SOLICITADO");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 4, 6);
                                        if (valorR != null) {
                                            GregorianCalendar gc = new GregorianCalendar();
                                            gc.setTime(new java.sql.Date(new java.util.Date(valorR).getTime()));
                                            javax.xml.datatype.XMLGregorianCalendar fechaGc = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gc);
                                            tramiteMatriculaRNRYS.setFechaFacturaCompraVenta(fechaGc);
                                            System.out.println("fecha factura : " + fechaGc);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 5);
                                        if (valorR != null) {
                                            tramiteMatriculaRNRYS.setNumeroFacturaCompraVenta(valorR);
                                            System.out.println("n factura RNRYS : " + valorR);
                                        }

                                        tramiteMatriculaRNRYS.setOrdenEjecucion(i);

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 53);
                                        if (valorR != null) {
                                            tramiteMatriculaRNRYS.setCondicionIngreso(valorR);
                                        }

                                        if (formulario.getSimit() != null) {
                                            tramiteMatriculaRNRYS.setValorFacturaCompraVenta(formulario.getSimit());
                                            System.out.println("Valor factura : " + formulario.getSimit());
                                        }

                                        java.util.List lista_propietariosRNRYS = model.consultarRadicacionesPropietarios(formulario.getId_formulario());
                                        for (int j = 0; j < lista_propietariosRNRYS.size(); j++) {
                                            Radicacion_Propietario radicacion_propietario = (Radicacion_Propietario) lista_propietariosRNRYS.get(j);
                                            Persona personaRNRYS = (Persona) model.consultarPersona(radicacion_propietario.getFk_persona());
                                            String tipDocPropRNRYS = model.consultarParametro((int) personaRNRYS.getTipo_documento(), 5).getNombreCorto();

                                            com.heinsohn.runt.general.personas.PropietarioRNRYSDTO propietarioDTO = new com.heinsohn.runt.general.personas.PropietarioRNRYSDTO();

                                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacionProp = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                            identificacionProp.setTipoDocumento(tipDocPropRNRYS);
                                            identificacionProp.setNumeroDocumento(personaRNRYS.getDocumento());

                                            javax.xml.namespace.QName name_DP = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "persona");
                                            java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DP = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                            java.lang.Class scope_DP = javax.xml.bind.JAXBElement.GlobalScope.class;
                                            javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DP = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DP, declaredType_DP, scope_DP, identificacionProp);
                                            propietarioDTO.setPersona(jax_DP);

                                            propietarioDTO.setIdTipoPropiedad(radicacion_propietario.getTipoPropiedad());
                                            propietarioDTO.setProindiviso(radicacion_propietario.getProIndiviso());

                                            propietarioDTO.setPorcentajePropiedad((double) radicacion_propietario.getPorcentaje());

                                            javax.xml.namespace.QName name_AP = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosApoderado");
                                            java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_AP = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                            java.lang.Class scope_AP = javax.xml.bind.JAXBElement.GlobalScope.class;
                                            javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_AP = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_AP, declaredType_AP, scope_AP, identificacionP);
                                            propietarioDTO.setDatosApoderado(jax_AP);

                                            tramiteMatriculaRNRYS.getPropietariosMatriculaInicial().add(propietarioDTO);
                                        }

                                        tramites.add(tramiteMatriculaRNRYS);
                                        ;
                                        break;
                                    //Tramite de Traspaso - OK
                                    case 63:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        com.heinsohn.runt.general.tramite.rna.TramiteTraspasoDTO tramiteTraspasoRuntRNRYS = new com.heinsohn.runt.general.tramite.rna.TramiteTraspasoDTO();

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteTraspasoRuntRNRYS.setCodigoTipoTramite(codigoTramiteRunt + "");

                                        tramiteTraspasoRuntRNRYS.setEstadoTramite("SOLICITADO");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 52);
                                        if (valorR != null) {
                                            tramiteTraspasoRuntRNRYS.setIdTipoTraspaso(valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 3, 46);
                                        if (valorR != null) {
                                            autLimitacion = valorR;
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 47);
                                        if (valorR != null) {
                                            descAutorizacion = valorR;
                                        }

                                        Radicacion_Propietario radicacionProTRNRYS = model.consultarRadicacionPropietarios(formulario.getId_formulario());

                                        if (radicacionProTRNRYS != null) {
                                            tramiteTraspasoRuntRNRYS.setIdTipoPropiedad(Integer.parseInt(radicacionProTRNRYS.getTipoPropiedad()));
                                            //tramiteMatriculaRunt.setLocatariosMatriculaInicial(null);
                                            Persona persona = (Persona) model.consultarPersona(radicacionProTRNRYS.getFk_persona());
                                            String tipDocProp = model.consultarParametro((int) persona.getTipo_documento(), 5).getNombreCorto();
                                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO locatoriosP = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                            if (radicacionProTRNRYS.getTipoPropiedad().equals("3")) {
                                                tramiteTraspasoRuntRNRYS.setIdTipoLocatario(1);
                                                locatoriosP.setTipoDocumento(tipDocProp);
                                                locatoriosP.setNumeroDocumento(persona.getDocumento());
                                                tramiteTraspasoRuntRNRYS.getLocatariosMatriculaInicial().add(locatoriosP);

                                            }
                                        }

                                        vehiculo = model.consultarVehiculo(formulario.getPlaca());
                                        if (vehiculo != null) {
                                            java.util.List lista_vendedoresRNRYS = model.crear_Lista_Propietarios(vehiculo.getId_vehiculo());
                                            for (int j = 0; j < lista_vendedoresRNRYS.size(); j++) {
                                                Propietario propietario = (Propietario) lista_vendedoresRNRYS.get(j);
                                                if (propietario.getFecha_final() == null) {
                                                    Persona persona = (Persona) model.consultarPersona(propietario.getFk_persona());
                                                    String tipDocProp = model.consultarParametro((int) persona.getTipo_documento(), 5).getNombreCorto();
                                                    propietario.getPorcentaje();

                                                    com.heinsohn.runt.general.personas.VendedorDTO vendedorDTO = new com.heinsohn.runt.general.personas.VendedorDTO();

                                                    com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                                    identificacion.setIdPersona(null);
                                                    identificacion.setTipoDocumento(tipDocProp);
                                                    identificacion.setNumeroDocumento(persona.getDocumento());

                                                    javax.xml.namespace.QName name_DC = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosVendedor");
                                                    java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DC = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                                    java.lang.Class scope_DC = javax.xml.bind.JAXBElement.GlobalScope.class;
                                                    javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DC = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DC, declaredType_DC, scope_DC, identificacion);
                                                    vendedorDTO.setDatosVendedor(jax_DC);

                                                    String tipDocApo = model.consultarParametro((int) solicitante.getTipo_documento(), 5).getNombreCorto();
                                                    identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                                    identificacion.setIdPersona(null);
                                                    identificacion.setTipoDocumento(tipDocApo);
                                                    identificacion.setNumeroDocumento(solicitante.getDocumento());
                                                    javax.xml.namespace.QName name_DA = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosApoderado");
                                                    java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DA = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                                    java.lang.Class scope_DA = javax.xml.bind.JAXBElement.GlobalScope.class;
                                                    javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DA = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DA, declaredType_DA, scope_DA, identificacion);
                                                    vendedorDTO.setDatosApoderado(jax_DA);

                                                    tramiteTraspasoRuntRNRYS.getVendedoresTraspaso().add(vendedorDTO);
                                                }
                                            }
                                        } else {
                                            for (int f = 0; f < lista.size(); f++) {
                                                Formulario formMtr = (Formulario) lista.get(f);
                                                if (formMtr.getFk_tramite() == 1 || formMtr.getFk_tramite() == 4) {
                                                    lista_propietarios = model.consultarRadicacionesPropietarios(formMtr.getId_formulario());
                                                    for (int j = 0; j < lista_propietarios.size(); j++) {
                                                        Radicacion_Propietario radicacion_propietario = (Radicacion_Propietario) lista_propietarios.get(j);
                                                        Persona persona = (Persona) model.consultarPersona(radicacion_propietario.getFk_persona());
                                                        String tipDocProp = model.consultarParametro((int) persona.getTipo_documento(), 5).getNombreCorto();

                                                        com.heinsohn.runt.general.personas.VendedorDTO vendedorDTO = new com.heinsohn.runt.general.personas.VendedorDTO();

                                                        com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                                        identificacion.setIdPersona(null);
                                                        identificacion.setTipoDocumento(tipDocProp);
                                                        identificacion.setNumeroDocumento(persona.getDocumento());

                                                        javax.xml.namespace.QName name_DC = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosVendedor");
                                                        java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DC = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                                        java.lang.Class scope_DC = javax.xml.bind.JAXBElement.GlobalScope.class;
                                                        javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DC = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DC, declaredType_DC, scope_DC, identificacion);
                                                        vendedorDTO.setDatosVendedor(jax_DC);

                                                        String tipDocApo = model.consultarParametro((int) solicitante.getTipo_documento(), 5).getNombreCorto();
                                                        identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                                        identificacion.setIdPersona(null);
                                                        identificacion.setTipoDocumento(tipDocApo);
                                                        identificacion.setNumeroDocumento(solicitante.getDocumento());
                                                        javax.xml.namespace.QName name_DA = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosApoderado");
                                                        java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DA = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                                        java.lang.Class scope_DA = javax.xml.bind.JAXBElement.GlobalScope.class;
                                                        javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DA = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DA, declaredType_DA, scope_DA, identificacion);
                                                        vendedorDTO.setDatosApoderado(jax_DA);

                                                        tramiteTraspasoRuntRNRYS.getVendedoresTraspaso().add(vendedorDTO);

                                                    }
                                                    break;
                                                }
                                            }
                                        }
                                        lista_propietarios = model.consultarRadicacionesPropietarios(formulario.getId_formulario());
                                        for (int j = 0; j < lista_propietarios.size(); j++) {
                                            Radicacion_Propietario radicacion_propietario = (Radicacion_Propietario) lista_propietarios.get(j);
                                            Persona persona = (Persona) model.consultarPersona(radicacion_propietario.getFk_persona());
                                            String tipDocProp = model.consultarParametro((int) persona.getTipo_documento(), 5).getNombreCorto();

                                            com.heinsohn.runt.general.personas.CompradorDTO compradorDTO = new com.heinsohn.runt.general.personas.CompradorDTO();

                                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                            identificacion.setIdPersona(null);
                                            identificacion.setTipoDocumento(tipDocProp);
                                            identificacion.setNumeroDocumento(persona.getDocumento());

                                            javax.xml.namespace.QName name_DC = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosComprador");
                                            java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DC = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                            java.lang.Class scope_DC = javax.xml.bind.JAXBElement.GlobalScope.class;
                                            javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DC = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DC, declaredType_DC, scope_DC, identificacion);
                                            compradorDTO.setDatosComprador(jax_DC);

                                            //compradorDTO.setIdTipoPropiedad("1");
                                            // compradorDTO.setProindiviso("N");
                                            java.util.List apoderados = model.consultarRadicacionesApoderados(formulario.getId_formulario(), persona.getId_persona());
                                            if (apoderados != null) {
                                                for (int k = 0; k < apoderados.size(); k++) {
                                                    Radicacion_Apoderado radicacion_apoderado = (Radicacion_Apoderado) apoderados.get(k);
                                                    Persona apoderado = model.consultarPersona(radicacion_apoderado.getFk_apoderado());
                                                    String tipDocApo = model.consultarParametro((int) apoderado.getTipo_documento(), 5).getNombreCorto();
                                                    identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                                    identificacion.setIdPersona(null);
                                                    identificacion.setTipoDocumento(tipDocApo);
                                                    identificacion.setNumeroDocumento(apoderado.getDocumento());

                                                    javax.xml.namespace.QName name_DA = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosApoderado");
                                                    java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DA = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                                    java.lang.Class scope_DA = javax.xml.bind.JAXBElement.GlobalScope.class;
                                                    javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DA = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DA, declaredType_DA, scope_DA, identificacion);
                                                    compradorDTO.setDatosApoderado(jax_DA);
                                                }
                                            }

                                            tramiteTraspasoRuntRNRYS.getCompradoresTraspaso().add(compradorDTO);
                                        }

                                        tramiteTraspasoRuntRNRYS.setProindiviso("N");
                                        tramiteTraspasoRuntRNRYS.setOrdenEjecucion(i);
                                        tramites.add(tramiteTraspasoRuntRNRYS);
                                        ;
                                        break;
                                    //Tramite de Traslado de Cuenta - OK

                                    //Radicaicon RNMA
                                    case 91:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        TramiteMatriculaInicialRNMADTO inicialRNMADTO = new TramiteMatriculaInicialRNMADTO();
                                        inicialRNMADTO.setClaseMaquinaria(formulario.getClase_vehiculo());
                                        Persona Locatario = model.consultarPersona(2, formulario.getObservaciones());

                                        Radicacion_Propietario radicacionProRnma = model.consultarRadicacionPropietarios(formulario.getId_formulario());

                                        if (radicacionProRnma != null) {
                                            Persona persona = (Persona) model.consultarPersona(radicacionProRnma.getFk_persona());
                                            String tipDocProp = model.consultarParametro((int) persona.getTipo_documento(), 5).getNombreCorto();
                                            IdentificacionPersonaDTO locatariosP = new IdentificacionPersonaDTO();
                                            if (radicacionProRnma.getTipoPropiedad().equals("3")) {
                                                locatariosP.setTipoDocumento(tipDocProp);
                                                locatariosP.setNumeroDocumento(persona.getDocumento());
                                                inicialRNMADTO.getLocatarios().add(locatariosP);
                                            }
                                        }
                                        inicialRNMADTO.setIdTipoPropiedad(1);
                                        inicialRNMADTO.setNumeroVin(formulario.getVin());
                                        inicialRNMADTO.setNumeroSerie(formulario.getSerie());
                                        inicialRNMADTO.setNumeroChasis(formulario.getChasis());
                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        inicialRNMADTO.setCodigoTipoTramite(codigoTramiteRunt + "");
                                        inicialRNMADTO.setEstadoTramite("SOLICITADO");
                                        Parametro para = model.consultarParametro(formulario.getClase_vehiculo(), 1);
                                        inicialRNMADTO.setNombreTipoRegistro("NUEVO");
                                        inicialRNMADTO.setOrdenEjecucion(i);
                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 65);
                                        inicialRNMADTO.setNroIdentificacionGPS(valorR);
                                        //inicialRNMADTO.setIdEmpresaHabilitacion((long)13);

                                        java.util.List<Radicacion_Propietario> lista_propietariosRnma = model.consultarRadicacionesPropietarios(formulario.getId_formulario());

                                        for (Radicacion_Propietario radicacion_propietario : lista_propietariosRnma) {
                                            Persona personaRNRYS = (Persona) model.consultarPersona(radicacion_propietario.getFk_persona());
                                            String tipDocPropRNRYS = model.consultarParametro((int) personaRNRYS.getTipo_documento(), 5).getNombreCorto();

                                            com.heinsohn.runt.general.personas.PropietarioRNMADTO propietarioDTO = new com.heinsohn.runt.general.personas.PropietarioRNMADTO();

                                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacionProp = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                            identificacionProp.setTipoDocumento(tipDocPropRNRYS);
                                            identificacionProp.setNumeroDocumento(personaRNRYS.getDocumento());

                                            propietarioDTO.setPersona(identificacionProp);
                                            propietarioDTO.setProvindiviso(radicacion_propietario.getProIndiviso() + "");
                                            propietarioDTO.setApoderado(identificacionP);
                                            propietarioDTO.setNroDocumentoPropietario(personaRNRYS.getDocumento());
                                            propietarioDTO.setTipoDocumentoPropietario(tipDocPropRNRYS);

                                            inicialRNMADTO.getPropietariosDTO().add(propietarioDTO);
                                        }

                                        tramites.add(inicialRNMADTO);
                                        break;
                                    //RNMA OK

                                    //traspado RNMA
                                    case 92:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        tramiteTraspasoRunt = new com.heinsohn.runt.general.tramite.rna.TramiteTraspasoDTO();

                                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                                        tramiteTraspasoRunt.setCodigoTipoTramite(codigoTramiteRunt + "");

                                        tramiteTraspasoRunt.setEstadoTramite("SOLICITADO");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 52);
                                        if (valorR != null) {
                                            tramiteTraspasoRunt.setIdTipoTraspaso(valorR);
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 3, 46);
                                        if (valorR != null) {
                                            autLimitacion = valorR;
                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 47);
                                        if (valorR != null) {
                                            descAutorizacion = valorR;
                                        }

                                        radicacionProT = model.consultarRadicacionPropietarios(formulario.getId_formulario());

                                        if (radicacionProT != null) {
                                            tramiteTraspasoRunt.setIdTipoPropiedad(Integer.parseInt(radicacionProT.getTipoPropiedad()));
                                            //tramiteMatriculaRunt.setLocatariosMatriculaInicial(null);
                                            Persona persona = (Persona) model.consultarPersona(radicacionProT.getFk_persona());
                                            String tipDocProp = model.consultarParametro((int) persona.getTipo_documento(), 5).getNombreCorto();
                                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO locatoriosP = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                            if (radicacionProT.getTipoPropiedad().equals("3")) {
                                                tramiteTraspasoRunt.setIdTipoLocatario(1);
                                                locatoriosP.setTipoDocumento(tipDocProp);
                                                locatoriosP.setNumeroDocumento(persona.getDocumento());
                                                tramiteTraspasoRunt.getLocatariosMatriculaInicial().add(locatoriosP);

                                            }
                                        }

                                        vehiculo = model.consultarVehiculo(formulario.getPlaca());
                                        if (vehiculo != null) {
                                            lista_vendedores = model.crear_Lista_Propietarios(vehiculo.getId_vehiculo());
                                            for (int j = 0; j < lista_vendedores.size(); j++) {
                                                Propietario propietario = (Propietario) lista_vendedores.get(j);
                                                if (propietario.getFecha_final() == null) {
                                                    Persona persona = (Persona) model.consultarPersona(propietario.getFk_persona());
                                                    String tipDocProp = model.consultarParametro((int) persona.getTipo_documento(), 5).getNombreCorto();
                                                    propietario.getPorcentaje();

                                                    com.heinsohn.runt.general.personas.VendedorDTO vendedorDTO = new com.heinsohn.runt.general.personas.VendedorDTO();

                                                    com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                                    identificacion.setIdPersona(null);
                                                    identificacion.setTipoDocumento(tipDocProp);
                                                    identificacion.setNumeroDocumento(persona.getDocumento());

                                                    javax.xml.namespace.QName name_DC = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosVendedor");
                                                    java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DC = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                                    java.lang.Class scope_DC = javax.xml.bind.JAXBElement.GlobalScope.class;
                                                    javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DC = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DC, declaredType_DC, scope_DC, identificacion);
                                                    vendedorDTO.setDatosVendedor(jax_DC);

                                                    String tipDocApo = model.consultarParametro((int) solicitante.getTipo_documento(), 5).getNombreCorto();
                                                    identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                                    identificacion.setIdPersona(null);
                                                    identificacion.setTipoDocumento(tipDocApo);
                                                    identificacion.setNumeroDocumento(solicitante.getDocumento());
                                                    javax.xml.namespace.QName name_DA = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosApoderado");
                                                    java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DA = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                                    java.lang.Class scope_DA = javax.xml.bind.JAXBElement.GlobalScope.class;
                                                    javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DA = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DA, declaredType_DA, scope_DA, identificacion);
                                                    vendedorDTO.setDatosApoderado(jax_DA);

                                                    tramiteTraspasoRunt.getVendedoresTraspaso().add(vendedorDTO);
                                                }
                                            }
                                        } else {
                                            for (int f = 0; f < lista.size(); f++) {
                                                Formulario formMtr = (Formulario) lista.get(f);
                                                if (formMtr.getFk_tramite() == 1 || formMtr.getFk_tramite() == 4) {
                                                    lista_propietarios = model.consultarRadicacionesPropietarios(formMtr.getId_formulario());
                                                    for (int j = 0; j < lista_propietarios.size(); j++) {
                                                        Radicacion_Propietario radicacion_propietario = (Radicacion_Propietario) lista_propietarios.get(j);
                                                        Persona persona = (Persona) model.consultarPersona(radicacion_propietario.getFk_persona());
                                                        String tipDocProp = model.consultarParametro((int) persona.getTipo_documento(), 5).getNombreCorto();

                                                        com.heinsohn.runt.general.personas.VendedorDTO vendedorDTO = new com.heinsohn.runt.general.personas.VendedorDTO();

                                                        com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                                        identificacion.setIdPersona(null);
                                                        identificacion.setTipoDocumento(tipDocProp);
                                                        identificacion.setNumeroDocumento(persona.getDocumento());

                                                        javax.xml.namespace.QName name_DC = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosVendedor");
                                                        java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DC = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                                        java.lang.Class scope_DC = javax.xml.bind.JAXBElement.GlobalScope.class;
                                                        javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DC = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DC, declaredType_DC, scope_DC, identificacion);
                                                        vendedorDTO.setDatosVendedor(jax_DC);

                                                        String tipDocApo = model.consultarParametro((int) solicitante.getTipo_documento(), 5).getNombreCorto();
                                                        identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                                        identificacion.setIdPersona(null);
                                                        identificacion.setTipoDocumento(tipDocApo);
                                                        identificacion.setNumeroDocumento(solicitante.getDocumento());
                                                        javax.xml.namespace.QName name_DA = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosApoderado");
                                                        java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DA = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                                        java.lang.Class scope_DA = javax.xml.bind.JAXBElement.GlobalScope.class;
                                                        javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DA = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DA, declaredType_DA, scope_DA, identificacion);
                                                        vendedorDTO.setDatosApoderado(jax_DA);

                                                        tramiteTraspasoRunt.getVendedoresTraspaso().add(vendedorDTO);

                                                    }
                                                    break;
                                                }
                                            }
                                        }
                                        lista_propietarios = model.consultarRadicacionesPropietarios(formulario.getId_formulario());
                                        for (int j = 0; j < lista_propietarios.size(); j++) {
                                            Radicacion_Propietario radicacion_propietario = (Radicacion_Propietario) lista_propietarios.get(j);
                                            Persona persona = (Persona) model.consultarPersona(radicacion_propietario.getFk_persona());
                                            String tipDocProp = model.consultarParametro((int) persona.getTipo_documento(), 5).getNombreCorto();

                                            com.heinsohn.runt.general.personas.CompradorDTO compradorDTO = new com.heinsohn.runt.general.personas.CompradorDTO();

                                            com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                            identificacion.setIdPersona(null);
                                            identificacion.setTipoDocumento(tipDocProp);
                                            identificacion.setNumeroDocumento(persona.getDocumento());

                                            javax.xml.namespace.QName name_DC = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosComprador");
                                            java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DC = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                            java.lang.Class scope_DC = javax.xml.bind.JAXBElement.GlobalScope.class;
                                            javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DC = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DC, declaredType_DC, scope_DC, identificacion);
                                            compradorDTO.setDatosComprador(jax_DC);

                                            //compradorDTO.setIdTipoPropiedad("1");
                                            // compradorDTO.setProindiviso("N");
                                            java.util.List apoderados = model.consultarRadicacionesApoderados(formulario.getId_formulario(), persona.getId_persona());
                                            if (apoderados != null) {
                                                for (int k = 0; k < apoderados.size(); k++) {
                                                    Radicacion_Apoderado radicacion_apoderado = (Radicacion_Apoderado) apoderados.get(k);
                                                    Persona apoderado = model.consultarPersona(radicacion_apoderado.getFk_apoderado());
                                                    String tipDocApo = model.consultarParametro((int) apoderado.getTipo_documento(), 5).getNombreCorto();
                                                    identificacion = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                                                    identificacion.setIdPersona(null);
                                                    identificacion.setTipoDocumento(tipDocApo);
                                                    identificacion.setNumeroDocumento(apoderado.getDocumento());

                                                    javax.xml.namespace.QName name_DA = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com", "datosApoderado");
                                                    java.lang.Class<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> declaredType_DA = com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO.class;
                                                    java.lang.Class scope_DA = javax.xml.bind.JAXBElement.GlobalScope.class;
                                                    javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> jax_DA = new javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO>(name_DA, declaredType_DA, scope_DA, identificacion);
                                                    compradorDTO.setDatosApoderado(jax_DA);
                                                }
                                            }

                                            tramiteTraspasoRunt.getCompradoresTraspaso().add(compradorDTO);
                                        }

                                        tramiteTraspasoRunt.setProindiviso("N");
                                        tramiteTraspasoRunt.setOrdenEjecucion(i);
                                        tramites.add(tramiteTraspasoRunt);
                                        ;
                                        break;
                                    //TRASPASo RNMA
                                    //Regrabacion RNMA
                                    case 113:
                                    case 114:
                                    case 115:
                                        if (formulario.getPlaca() != null) {
                                            automotor.setNumeroPlaca(formulario.getPlaca());
                                        }

                                        TramiteRegrabacionRNMADTO tramiteRegrabacionRNMADTO = new TramiteRegrabacionRNMADTO();
                                        tramiteRegrabacionRNMADTO.setCodigoTipoTramite("" + model.consultarTramiteRUNT((int) formulario.getFk_tramite()));
                                        tramiteRegrabacionRNMADTO.setEstadoTramite("SOLICITADO");

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 28);
                                        if (valorR != null) {
                                            tramiteRegrabacionRNMADTO.setMotivoRegrabacion(valorR);
                                        }

                                        switch ((int) formulario.getFk_tramite()) {
                                            case 113:
                                                tramiteRegrabacionRNMADTO.setTipoRegrabacion("REGRABACION MOTOR");
                                                tramiteRegrabacionRNMADTO.setNumeroMotor(formulario.getMotor());
                                                break;
                                            case 114:
                                                tramiteRegrabacionRNMADTO.setTipoRegrabacion("REGRABACION CHASIS");
                                                break;
                                            case 115:
                                                tramiteRegrabacionRNMADTO.setTipoRegrabacion("REGRABACION SERIE");
                                                tramiteRegrabacionRNMADTO.setNumeroSerie(formulario.getSerie());
                                                break;

                                        }

                                        valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 35);
                                        if (valorR != null) {
                                            tramiteRegrabacionRNMADTO.setNumeroRevisionTecnicaSijinDijin(valorR);
                                        }

                                        tramites.add(tramiteRegrabacionRNMADTO);

                                        break;
                                    //Regrabacion Rnma OK;
                                }
                            } else {
                                continuar = false;
                                carteraA = false;
                                break;
                            }
                        } else {
                            continuar = false;
                            carteraA = true;
                            break;
                        }
                    }
                    String numeroRad = request.getParameter("radicacion");
                    String fechaRad = request.getParameter("fecha");

                    if (tipoDocumentoApoderado != null) {
                        System.out.print("documento A enviado : " + tipoDocumentoApoderado + " numero doc A enviado : " + numeroDocumentoApoderado);
                    }
                    if (continuar) {
                        radicarSolicitudOut = radicacionService.radicarSolicitud(automotor, identificadorAT, nombreAT, tipoDocumento, numeroDocumento, tipoDocumentoApoderado, numeroDocumentoApoderado, autLimitacion, descAutorizacion, tipoSolicitud, numeroLiquidacion, registroSolicitud, solTutela, tramites, liquidaciones, biometricos, rechazos, userRunt.getCodigo(), userRunt.getPassword(), propietarioRNA);
                        if (radicarSolicitudOut != null) {
                            if (radicarSolicitudOut.getStatus() != null) {
                                mensajeTramiteRunt = radicarSolicitudOut.getStatus().getStatusDesc();
                                if (radicarSolicitudOut.getStatus().getStatusCode().equals("1")) {
                                    model.registrarSolicitudRUNT(radicarSolicitudOut, radicacion.getId_radicacion(), 1);
                                    session.setAttribute("respuesta", radicarSolicitudOut);
                                    procesoTramiteRunt = true;
                                    mensajeTramiteRunt = radicarSolicitudOut.getStatus().getStatusDesc();
                                } else {
                                    mensajeTramiteRunt = radicarSolicitudOut.getStatus().getStatusDesc();
                                    procesoTramiteRunt = false;
                                }
                            } else {
                                mensajeTramiteRunt = "No fue posible realizar la solicitud, intente nuevamente 1";
                                procesoTramiteRunt = false;
                            }
                        } else {
                            mensajeTramiteRunt = "No fue posible realizar la solicitud, intente nuevamente 2";
                            procesoTramiteRunt = false;
                        }
                        if (procesoTramiteRunt) {
                            model.actualizarObservacionRadicacion(radicacion.getId_radicacion(), mensajeTramiteRunt);
                            model.actualizarEstadoRadicacion(radicacion.getId_radicacion(), 3);
                            model.getCon().commit();
                        } else {
                            model.getCon().rollback();
                        }
                    } else if (validacion) {
                        procesoTramiteRunt = false;
                    } else if (carteraA) {
                        mensajeTramiteRunt = "El vehiculo posee cartera activa";
                    } else {
                        mensajeTramiteRunt = "El pago asociado no se encuentra habilitado";
                        procesoTramiteRunt = false;
                    }%>
    <jsp:forward page="formularioTramite.jsp">
        <jsp:param name="radicacion" value="<%=numeroRad%>" />
        <jsp:param name="fecha" value="<%=fechaRad%>" />
        <jsp:param name="msg" value="<%=mensajeTramiteRunt%>" />
    </jsp:forward>
    <%  }
        if (radicacion.getEstado() == 3) {
            Model.userHandler = userRunt.getCodigo();
            Model.passUserHandler = userRunt.getPassword();
            com.heinsohn.runt.general.solicitudes.ConsultaResultadoSolicitudOUTDTO consultaResultado = null;
            webservices.radicacion.RadicacionServicesClient radicacionService = new webservices.radicacion.RadicacionServicesClient();
            radicacionService.setTokenHuellaDigital("");
            radicacionService.setUser(userRunt.getCodigo());
            String mensajeRespuesta = "";
            if (session.getAttribute("token2") != null) {
                radicacionService.setTokenHuellaDigital(session.getAttribute("token2").toString());
            }
            String numeroSolicitud = model.consultarSolicitudRadicacionRUNT(radicacion.getId_radicacion(), 1);
            if (numeroSolicitud != null) {
                consultaResultado = radicacionService.consultaResultadosSolicitudServicio(numeroSolicitud, userRunt.getCodigo(), userRunt.getPassword());
                if (consultaResultado != null) {
                    if (consultaResultado.getStatus() != null) {
                        if (consultaResultado.getStatus().getStatusCode().equals("1")) {
                            javax.xml.bind.JAXBElement<com.heinsohn.runt.general.solicitudes.RegistroSolicitudDTO> jax_registroSolicitud = consultaResultado.getSolicitud();
                            com.heinsohn.runt.general.solicitudes.RegistroSolicitudDTO registroSolicitud = jax_registroSolicitud.getValue();
                            //aqui agregar resultado y estado de las solicitudes runt.
                            session.setAttribute("solicitud", registroSolicitud);
                            if (registroSolicitud != null) {
                                if (registroSolicitud.getEstadoSolicitud().equals("RECHAZADA")) {
                                    String resultadoSol = "";
                                    for (int i = 0; i < registroSolicitud.getRechazosOT().size(); i++) {
                                        com.heinsohn.runt.general.solicitudes.RechazoOTDTO rechazo = (com.heinsohn.runt.general.solicitudes.RechazoOTDTO) registroSolicitud.getRechazosOT().get(i);
                                        resultadoSol += rechazo.getDescripcionRechazo() + ", ";
                                    }
                                    model.actualizarObservacionRadicacion(radicacion.getId_radicacion(), resultadoSol);
                                    model.getCon().commit();
                                }
    %>
    <jsp:forward page="resultadoRunt.jsp">
        <jsp:param name="radicacion" value="<%=numero%>" />
        <jsp:param name="fecha" value="<%=fecha%>" />
    </jsp:forward>
    <%     }
                    } else {
                        mensajeRespuesta = "RUNT: " + consultaResultado.getStatus().getStatusDesc();
                    }
                } else {
                    mensajeTramiteRunt = "No fue posible realizar la consulta de la solicitud, intente nuevamente";
                }
            } else {
                mensajeTramiteRunt = "No fue posible realizar la consulta de la solicitud, intente nuevamente";
            }

        } else {
            mensajeRespuesta = "Numero de solicitud asociada no existe en civitrans";
        }
        mensajeRespuesta = mensajeRespuesta.replace((char) 13, ' ').replace((char) 10, ' ').replace((char) 9, ' ');
        String numeroRad = request.getParameter("radicacion");
        String fechaRad = request.getParameter("fecha");%>
    <jsp:forward page="formularioTramite.jsp">
        <jsp:param name="radicacion" value="<%=numeroRad%>" />
        <jsp:param name="fecha" value="<%=fechaRad%>" />
        <jsp:param name="msg" value="<%=mensajeRespuesta%>" />
    </jsp:forward>
    <%  }
        if (radicacion.getEstado() == 1) {
    %>
    <jsp:forward page="autenticarSolicitantes.jsp">
        <jsp:param name="radicacion" value="<%=numero%>" />
        <jsp:param name="fecha" value="<%=fecha%>" />
    </jsp:forward>
    <%  }
        if (radicacion.getEstado() == 8) {
            String mensajeRespuesta = "Radicacion ha sido anulada..";
            String numeroRad = request.getParameter("radicacion");
            String fechaRad = request.getParameter("fecha");%>
    <jsp:forward page="formularioTramite.jsp">
        <jsp:param name="radicacion" value="<%=numeroRad%>" />
        <jsp:param name="fecha" value="<%=fechaRad%>" />
        <jsp:param name="msg" value="<%=mensajeRespuesta%>" />
    </jsp:forward>
    <%  }
        if (radicacion.getEstado() == 9) {
            model.actualizarEstadoRadicacion(radicacion.getId_radicacion(), 1);
            model.getCon().commit();
            String mensajeRespuesta = "Radicacion ha sido renovada, Vuelva Autenticar Al Solicitante";
            String numeroRad = request.getParameter("radicacion");
            String fechaRad = request.getParameter("fecha");%>
    <jsp:forward page="formularioTramite.jsp">
        <jsp:param name="radicacion" value="<%=numeroRad%>" />
        <jsp:param name="fecha" value="<%=fechaRad%>" />
        <jsp:param name="msg" value="<%=mensajeRespuesta%>" />
    </jsp:forward>
    <%  }
        if (radicacion.getEstado() == 10) {
            model.actualizarEstadoRadicacion(radicacion.getId_radicacion(), 1);
            model.getCon().commit();
            String mensajeRespuesta = "Vuelva Autenticar Al Solicitante";
            String numeroRad = request.getParameter("radicacion");
            String fechaRad = request.getParameter("fecha");%>
    <jsp:forward page="formularioTramite.jsp">
        <jsp:param name="radicacion" value="<%=numeroRad%>" />
        <jsp:param name="fecha" value="<%=fechaRad%>" />
        <jsp:param name="msg" value="<%=mensajeRespuesta%>" />
    </jsp:forward>
    <%  }
        }
    } catch (Exception excw) {
        excw.printStackTrace();
        model.getCon().rollback();
        String numeroRad = request.getParameter("radicacion");
        String fechaRad = request.getParameter("fecha");
        String mensajeRespuesta = "Civitrans : Algun valor nulo ha generado una excepcion (Alertas,DatosV,etc), revise logApache " + excw.getMessage();%>
    <jsp:forward page="formularioTramite.jsp">
        <jsp:param name="radicacion" value="<%=numeroRad%>" />
        <jsp:param name="fecha" value="<%=fechaRad%>" />
        <jsp:param name="msg" value="<%=mensajeRespuesta%>" />
    </jsp:forward>
    <%  }%>
</html>
