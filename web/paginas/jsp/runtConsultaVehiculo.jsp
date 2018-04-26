<%@ page import="modelo.* " %>
<%
    Model model = (Model) session.getAttribute("model");
        
    try {

        Usuario usuario = (Usuario) session.getAttribute("usuario");
        webservices.consultas.ServicioConsultaRUNTClient consultaService = new webservices.consultas.ServicioConsultaRUNTClient();
        consultaService.setTokenHuellaDigital(Model.userToken);
        consultaService.setUser(Model.userHandler);

        model.getCon().setAutoCommit(false);
        java.util.List<String> listaPlacas = model.obtenerRangoPlacas();
        for (String placa : listaPlacas) {
            com.heinsohn.runt.general.consultas.AutomotorOutDTO automotor = consultaService.consultarDatosAutomotor(placa.toUpperCase(), null, null, null, null);
            if (automotor != null) {
                if (automotor.getStatus() != null) {
                    if (automotor.getStatus().getStatusCode().equals("1")) {

                        // model.getCon().setAutoCommit(false) ;
                        com.heinsohn.runt.general.consultas.InformacionAutomotorDTO inf = automotor.getAutomotor().getValue().getInformacion().getValue();

                        java.util.List<com.heinsohn.runt.general.personas.PropietarioDTO> listProp = automotor.getAutomotor().getValue().getPropietarios();
                        java.util.List<com.heinsohn.runt.general.consultas.PrendaAutomotorDTO> listPrendas = automotor.getAutomotor().getValue().getPrendas();
                        java.util.List<com.heinsohn.runt.general.consultas.CombustiblesDTO> listCom = automotor.getAutomotor().getValue().getCombustibles();
                        //java.util.List listProp = automotor.getAutomotor().getValue().getRevisionTecnoMecanica() ;

                        //System.out.println("Estado : "+ automotor.getAutomotor().getValue().getInformacion().getValue().getEstado());
                        VehiculoRunt v = new VehiculoRunt();

                        v.setPlaca(placa);
                        v.setClase(automotor.getAutomotor().getValue().getClase());
                        v.setCilindraje(automotor.getAutomotor().getValue().getCilindraje());
                        v.setMarca(automotor.getAutomotor().getValue().getMarca());
                        v.setModelo(automotor.getAutomotor().getValue().getModelo());
                        v.setTipo_servicio(automotor.getAutomotor().getValue().getTipoServicio());
                        v.setTipo_vehiculo(automotor.getAutomotor().getValue().getTipoVehiculo());
                        v.setAntiguo_clasico(automotor.getAutomotor().getValue().getInformacion().getValue().getAntiguoClasico());
                        v.setCapacidad_carga(automotor.getAutomotor().getValue().getInformacion().getValue().getCapacidadCarga());
                        v.setColor(automotor.getAutomotor().getValue().getInformacion().getValue().getColor());
                        v.setDeclaracion_simplificada("");
                        v.setEnseñanza(automotor.getAutomotor().getValue().getInformacion().getValue().getEsEnsenanza());
                        v.setImportado(automotor.getAutomotor().getValue().getInformacion().getValue().getEsImportado());
                        v.setEs_reposicion(automotor.getAutomotor().getValue().getInformacion().getValue().getEsReposicion());
                        v.setBlindado(automotor.getAutomotor().getValue().getInformacion().getValue().getEstaBlindado());
                        v.setRepotenciado(automotor.getAutomotor().getValue().getInformacion().getValue().getEstaRepotenciado());
                        v.setEstado(automotor.getAutomotor().getValue().getInformacion().getValue().getEstado());
                        v.setGrupo(automotor.getAutomotor().getValue().getInformacion().getValue().getGrupo());
                        v.setId_carroceria(automotor.getAutomotor().getValue().getInformacion().getValue().getIdCarrocerria());
                        v.setLinea(automotor.getAutomotor().getValue().getInformacion().getValue().getLinea());
                        v.setMarca_automotor_migrado(automotor.getAutomotor().getValue().getInformacion().getValue().getMarcaAutomotorMigrado());
                        v.setModalidad_servicio(automotor.getAutomotor().getValue().getInformacion().getValue().getModalidadServicio());
                        v.setMotivo_cancelacion(automotor.getAutomotor().getValue().getInformacion().getValue().getMotivoCancelacion());
                        v.setNivel_blindaje(automotor.getAutomotor().getValue().getInformacion().getValue().getNivelBlindaje());
                        v.setNivel_servicio(automotor.getAutomotor().getValue().getInformacion().getValue().getNivelServicio());
                        v.setNumero_acta(automotor.getAutomotor().getValue().getInformacion().getValue().getNumeroActa());
                        v.setNumero_ficha_tecnica(automotor.getAutomotor().getValue().getInformacion().getValue().getNumeroFichaTecnica());
                        v.setNumero_licencia_vigente(automotor.getAutomotor().getValue().getInformacion().getValue().getNumeroLicenciaVigente());
                        v.setNumero_plaqueta(automotor.getAutomotor().getValue().getInformacion().getValue().getNumeroPlaqueta());
                        v.setNumero_puertas(automotor.getAutomotor().getValue().getInformacion().getValue().getNumeroPuertas());
                        v.setNumero_regrabacion_chasis(automotor.getAutomotor().getValue().getInformacion().getValue().getNumeroRegrabacionChasis());
                        v.setNumero_regrabacion_motor(automotor.getAutomotor().getValue().getInformacion().getValue().getNumeroRegrabacionMotor());
                        v.setNumero_regrabacion_serie(automotor.getAutomotor().getValue().getInformacion().getValue().getNumeroRegrabacionSerie());
                        v.setOrigen_registro(automotor.getAutomotor().getValue().getInformacion().getValue().getOrigenRegistro());
                        v.setPais_origen(automotor.getAutomotor().getValue().getInformacion().getValue().getPaisOrigen());
                        v.setPeso_bruto(automotor.getAutomotor().getValue().getInformacion().getValue().getPesoBruto());
                        v.setPotencia(automotor.getAutomotor().getValue().getInformacion().getValue().getPotencia());
                        v.setRegrabacion_plaqueta(automotor.getAutomotor().getValue().getInformacion().getValue().getRegrabacionPlaqueta());
                        v.setTipo_acta_importacion_remate(automotor.getAutomotor().getValue().getInformacion().getValue().getTipoActaImportacionORemate());
                        v.setTipo_motor(automotor.getAutomotor().getValue().getInformacion().getValue().getTipoMotor());
                        v.setAno_fabricacion(automotor.getAutomotor().getValue().getInformacion().getValue().getAnoFabricacion() + "");
                        v.setCapacidad_pasajeros(automotor.getAutomotor().getValue().getInformacion().getValue().getCapacidadPasajeros() + "");
                        v.setNumero_ejes(automotor.getAutomotor().getValue().getInformacion().getValue().getNumeroEjes() + "");

                        if (inf.getFechaCancelacion() != null) {
                            v.setFecha_cancelacion(
                            new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.sql.Date(inf.getFechaCancelacion().getYear()-1900,
                                                                                                  inf.getFechaCancelacion().getMonth()-1,
                                                                                                  inf.getFechaCancelacion().getDay())));
                        } else {
                            v.setFecha_cancelacion("");
                        }

                        if (inf.getFechaDeclaracion() != null) {
                             v.setFecha_declaracion(
                            new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.sql.Date(inf.getFechaDeclaracion().getYear()-1900,
                                                                                                  inf.getFechaDeclaracion().getMonth()-1,
                                                                                                  inf.getFechaDeclaracion().getDay())));
                        } else {
                            v.setFecha_declaracion("");
                        }

                        if (inf.getFechaExpedicionLicencia() != null) {
                             v.setFecha_expedicion_licencia(
                            new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.sql.Date(inf.getFechaExpedicionLicencia().getYear()-1900,
                                                                                                  inf.getFechaExpedicionLicencia().getMonth()-1,
                                                                                                  inf.getFechaExpedicionLicencia().getDay())));
                        } else {
                            v.setFecha_expedicion_licencia("");
                        }

                        if (inf.getFechaRegistro() != null) {
                             v.setFecha_registro(
                            new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.sql.Date(inf.getFechaRegistro().getYear()-1900,
                                                                                                  inf.getFechaRegistro().getMonth()-1,
                                                                                                  inf.getFechaRegistro().getDay())));
                        } else {
                            v.setFecha_registro("");
                        }


                        //Se adiciona el VehiculoRunt.
                        String added = model.addVehiculoRunt(v);
                        System.out.println("PLACA    " + placa + "   " + added);

                        // Se adicionan los datos de propietarios.
                        if (listProp != null && listProp.size() > 0) {
                            for (com.heinsohn.runt.general.personas.PropietarioDTO propietario : listProp) {
                                javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> persona = propietario.getPersona();
                                model.addPropietarioDTO(propietario, persona.getValue().getTipoDocumento(), persona.getValue().getIdPersona(), placa);
                            }
                        }

                        // Se adicionan los datos de prendas.
                        if (listPrendas != null && listPrendas.size() > 0) {
                            for (com.heinsohn.runt.general.consultas.PrendaAutomotorDTO prenda : listPrendas) {
                                javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO> persona = prenda.getAcreedorPrendario();
                                model.addPrendaDTO(prenda, persona.getValue().getIdPersona(), persona.getValue().getNumeroDocumento(), placa);
                            }
                        }

                        // Se adicionan los datos de combustibles.
                        if (listCom != null && listCom.size() > 0) {
                            com.heinsohn.runt.general.consultas.CombustiblesDTO combustible = listCom.get(0);
                            model.addCombustibleDTO(combustible, placa);
                        }

                        model.getCon().commit();


                    } else {
                        System.out.println("DEsc Status " + automotor.getStatus().getStatusDesc());
                    }
                } else {
                    System.out.println("Estatus == " + null);
                }
            } else {
                System.out.println("Automotor es null");
            }
        }
        
    } catch (Exception ecx) {
        ecx.printStackTrace();
        model.getCon().rollback();
    }%>
