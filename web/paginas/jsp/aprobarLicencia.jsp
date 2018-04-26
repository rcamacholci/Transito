
<%@ page  import = "modelo.*" import = "java.util.*" import = "java.sql.*" %>
<%
     Model model = null;
     try{
         boolean procesoTramiteRunt = false;
         String mensajeTramiteRunt = "";
         model = (Model) session.getAttribute("model");
         modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
         UsuarioRunt userRunt = model.consultarUsuarioRunt(usuario.getId_usuario());
         model.getCon().setAutoCommit(false);
         Radicacion_Licencia radicacionLicencia = model.consultar_RadicacionLicencia(Long.parseLong(request.getParameter("radicacionl")));
         if(radicacionLicencia!=null){
           if(request.getParameter("del")!=null){
                if(request.getParameter("del").equals("0")){
                    radicacionLicencia.setEstado(8);
                    model.actualizarEstadoRadicacionLicencia(radicacionLicencia.getId_radicacion_licencia(), 8);
                    model.getCon().commit();
                }
           }
	   if(request.getParameter("ren")!=null){
                if(request.getParameter("ren").equals("1")){
                    radicacionLicencia.setEstado(9);
                }
           }
           if(radicacionLicencia.getEstado()==1){
                com.heinsohn.runt.general.solicitudes.RadicarSolicitudOutDTO radicarSolicitudOut = null;
                webservices.radicacion.RadicacionServicesClient radicacionService = new webservices.radicacion.RadicacionServicesClient();
                radicacionService.setTokenHuellaDigital("");
                radicacionService.setUser(userRunt.getCodigo());
                 Model.userHandler = userRunt.getCodigo();
                 Model.passUserHandler = userRunt.getPassword();

              if(session.getAttribute("token2")!=null){
                radicacionService.setTokenHuellaDigital(session.getAttribute("token2").toString());

                java.util.List<com.heinsohn.runt.general.solicitudes.LiquidacionInDTO> liquidaciones = new java.util.LinkedList<com.heinsohn.runt.general.solicitudes.LiquidacionInDTO>();
                java.util.List<com.heinsohn.runt.general.tramite.TramiteBasicoDTO> tramites = new java.util.LinkedList<com.heinsohn.runt.general.tramite.TramiteBasicoDTO>();
                java.util.List<com.heinsohn.runt.general.identificaciones.InformacionBiometricaCiudadanoDTO> biometricos = new java.util.LinkedList<com.heinsohn.runt.general.identificaciones.InformacionBiometricaCiudadanoDTO>();
                java.util.List<com.heinsohn.runt.general.solicitudes.RechazoOTDTO> rechazos = new java.util.LinkedList<com.heinsohn.runt.general.solicitudes.RechazoOTDTO>();
                com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO automotor = null;

                String identificadorAT = "8634001";
                String nombreAT = "SABANAGRANDE - ATLANTICO(DPTAL)";
                String autLimitacion = "N";
                String descAutorizacion = "";
                String tipoSolicitud = "SOLICITUD_TRAMITES";
                String numeroLiquidacion = "";
                boolean solTutela = false;

                Persona solicitante = model.consultarPersona(radicacionLicencia.getFk_persona());
                String tipoDocumento = model.consultarParametro((int)solicitante.getTipo_documento(),5).getNombreCorto();
                String numeroDocumento = solicitante.getDocumento();
                String registroSolicitud = String.valueOf("2");
                
                com.heinsohn.runt.general.identificaciones.InformacionBiometricaCiudadanoDTO biometrico = new com.heinsohn.runt.general.identificaciones.InformacionBiometricaCiudadanoDTO();
                com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacionP = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                identificacionP.setTipoDocumento(tipoDocumento);
                identificacionP.setNumeroDocumento(solicitante.getDocumento());
                biometrico.setPersona(identificacionP);

                String template = "";
                if(session.getAttribute("tokenSolicitante")!=null){
                 template = session.getAttribute("tokenSolicitante").toString();


               // if(request.getParameter("huellaT").equals("1")){
                    javax.xml.namespace.QName name_t = new javax.xml.namespace.QName("http://personas.general.runt.heinsohn.com","tokenHuellaDigital");
                    Class<String> declaredType_t = String.class;
                    Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
                    javax.xml.bind.JAXBElement<String> jaxb_t = new javax.xml.bind.JAXBElement(name_t,declaredType_t,scope_t,template);
                    biometrico.setTokenHuellaDigital(jaxb_t);
                    biometricos.add(biometrico);
             //  }



                String imagen ="";
                if(session.getAttribute("fotoSolicitante")!=null){
                    imagen = session.getAttribute("fotoSolicitante").toString();
                    long codigoTramiteRunt = 0;

                    Formulario_Licencia formularioLicencia = (Formulario_Licencia)model.consultarFormularioLicencia(radicacionLicencia.getId_radicacion_licencia());
                    
                    if(formularioLicencia.getRunt2().equals(formularioLicencia.getRunt())){
                        com.heinsohn.runt.general.solicitudes.LiquidacionInDTO liquidacion = new com.heinsohn.runt.general.solicitudes.LiquidacionInDTO();
                        liquidacion.setNumeroLiquidacion(formularioLicencia.getRunt());
                        liquidaciones.add(liquidacion);
                    }else{
                        com.heinsohn.runt.general.solicitudes.LiquidacionInDTO liquidacion = new com.heinsohn.runt.general.solicitudes.LiquidacionInDTO();
                        liquidacion.setNumeroLiquidacion(formularioLicencia.getRunt());
                        liquidaciones.add(liquidacion);
                        com.heinsohn.runt.general.solicitudes.LiquidacionInDTO liquidacion2 = new com.heinsohn.runt.general.solicitudes.LiquidacionInDTO();
                        liquidacion2.setNumeroLiquidacion(formularioLicencia.getRunt2());
                        liquidaciones.add(liquidacion2);                    
                    }



                    Pago pago = model.consultarPago(formularioLicencia.getFk_pago());
                    if(pago!=null)
                        numeroLiquidacion = pago.getNumero_factura();
                    numeroLiquidacion = "";

                    String nFactura = model.obtenerPosiblePagoTRANSITO(formularioLicencia.getFk_persona(), formularioLicencia.getFk_tramite());
                    if(nFactura.length()==0){
                        nFactura = model.consultarPagoReclamo(2,formularioLicencia.getFk_persona()+"", formularioLicencia.getFk_tramite());
                        nFactura = nFactura!=null?nFactura:"";
                    }
                    if(nFactura.length()>0){

                        switch((int)formularioLicencia.getFk_tramite()){
                            //Tramite de Expedicion de Licencia de Conduccion Vehiculos
                            case 28:
                                    com.heinsohn.runt.general.tramite.rnc.TramiteExpedicionLicenciaConduccionDTO tramiteExpedicionLicencia = new com.heinsohn.runt.general.tramite.rnc.TramiteExpedicionLicenciaConduccionDTO();
                                     com.heinsohn.runt.general.identificaciones.CategoriaDTO categoria= new com.heinsohn.runt.general.identificaciones.CategoriaDTO();
                                    codigoTramiteRunt = model.consultarTramiteRUNT(formularioLicencia.getFk_tramite());
                                    tramiteExpedicionLicencia.setCodigoTipoTramite(codigoTramiteRunt+"");
                                    tramiteExpedicionLicencia.setConvalidacion("N");
                                    tramiteExpedicionLicencia.setEstadoTramite("SOLICITADO");
                                    tramiteExpedicionLicencia.setOrdenEjecucion(0);
                                    categoria.setCategoria(formularioLicencia.getCategoria());
                                    tramiteExpedicionLicencia.getCategoria().add(categoria);
                                   // tramiteExpedicionLicencia.setIdCategoria(formularioLicencia.getCategoria());
                                    tramiteExpedicionLicencia.setFotoPersona(imagen);
                                    tramites.add(tramiteExpedicionLicencia);
                                    break;
                                    //Tramite de Expedicion de Licencia de Conduccion Motos
                            case 29:
                                    tramiteExpedicionLicencia = new com.heinsohn.runt.general.tramite.rnc.TramiteExpedicionLicenciaConduccionDTO();
                                    com.heinsohn.runt.general.identificaciones.CategoriaDTO categoriaV = new com.heinsohn.runt.general.identificaciones.CategoriaDTO();
                                    codigoTramiteRunt = model.consultarTramiteRUNT(formularioLicencia.getFk_tramite());
                                    tramiteExpedicionLicencia.setCodigoTipoTramite(codigoTramiteRunt+"");
                                    tramiteExpedicionLicencia.setConvalidacion("N");
                                    tramiteExpedicionLicencia.setEstadoTramite("SOLICITADO");
                                    tramiteExpedicionLicencia.setOrdenEjecucion(0);
                                    categoriaV.setCategoria(formularioLicencia.getCategoria());
                                    tramiteExpedicionLicencia.getCategoria().add(categoriaV);
                                    //tramiteExpedicionLicencia.setIdCategoria(formularioLicencia.getCategoria());
                                    tramiteExpedicionLicencia.setFotoPersona(imagen);
                                    tramites.add(tramiteExpedicionLicencia);
                                    break;
                                     //Tramite de Refrendacion de Licencia de Conduccion
                            case 30:
                                    com.heinsohn.runt.general.tramite.rnc.TramiteRefrendacionLicenciaConduccionDTO tramiteRefrendacionLicencia = new com.heinsohn.runt.general.tramite.rnc.TramiteRefrendacionLicenciaConduccionDTO();
                                    com.heinsohn.runt.general.identificaciones.CategoriaDTO categoriaRef = new com.heinsohn.runt.general.identificaciones.CategoriaDTO();
                                    codigoTramiteRunt = model.consultarTramiteRUNT(formularioLicencia.getFk_tramite());
                                    tramiteRefrendacionLicencia.setCodigoTipoTramite(codigoTramiteRunt+"");
                                    tramiteRefrendacionLicencia.setEstadoTramite("SOLICITADO");
                                    tramiteRefrendacionLicencia.setOrdenEjecucion(0);
                                    categoriaRef.setCategoria(formularioLicencia.getCategoria());
                                    tramiteRefrendacionLicencia.getCategoria().add(categoriaRef);
                                    //tramiteRefrendacionLicencia.setIdCategoria(formularioLicencia.getCategoria());
                                    tramiteRefrendacionLicencia.setFotoPersona(imagen);
                                    tramites.add(tramiteRefrendacionLicencia);
                                    break;
                            //Tramite de Recategorizacion Hacia Arriba de Licencia de Conduccion
                            case 31:
                                    com.heinsohn.runt.general.tramite.rnc.TramiteRecategorizacionLicenciaConduccionDTO tramiteRecategorizacionALicencia = new com.heinsohn.runt.general.tramite.rnc.TramiteRecategorizacionLicenciaConduccionDTO();
                                    com.heinsohn.runt.general.tramite.rnc.RecategorizacionDTO recatego = new com.heinsohn.runt.general.tramite.rnc.RecategorizacionDTO();
                                    com.heinsohn.runt.general.identificaciones.CategoriaDTO categoriaN = new com.heinsohn.runt.general.identificaciones.CategoriaDTO();
                                    com.heinsohn.runt.general.identificaciones.CategoriaDTO categoriaAn  = new com.heinsohn.runt.general.identificaciones.CategoriaDTO();
                                    codigoTramiteRunt = model.consultarTramiteRUNT(formularioLicencia.getFk_tramite());
                                    tramiteRecategorizacionALicencia.setCodigoTipoTramite(codigoTramiteRunt+"");
                                    tramiteRecategorizacionALicencia.setEstadoTramite("SOLICITADO");
                                    tramiteRecategorizacionALicencia.setOrdenEjecucion(0);
                                    recatego.setNumeroLicencia(formularioLicencia.getLicencia_anterior());
                                    categoriaN.setCategoria(formularioLicencia.getCategoria());
                                    recatego.setCategoriaNueva(categoriaN);
                                    categoriaAn.setCategoria(formularioLicencia.getCategoria_anterior()); 
                                    recatego.setCategoria(categoriaAn);
                                    tramiteRecategorizacionALicencia.getRecategorizacion().add(recatego);
                                    tramiteRecategorizacionALicencia.setFotoPersona(imagen);
                                    tramites.add(tramiteRecategorizacionALicencia);
                                    break;
                             //Tramite de Recategorizacion Hacia Abajo de Licencia de Conduccion
                            case 34:
                                    com.heinsohn.runt.general.tramite.rnc.TramiteRecategorizacionLicenciaConduccionDTO tramiteRecategorizacionBLicencia = new com.heinsohn.runt.general.tramite.rnc.TramiteRecategorizacionLicenciaConduccionDTO();
                                    com.heinsohn.runt.general.tramite.rnc.RecategorizacionDTO recateg = new com.heinsohn.runt.general.tramite.rnc.RecategorizacionDTO();
                                    com.heinsohn.runt.general.identificaciones.CategoriaDTO categoriaNueva = new com.heinsohn.runt.general.identificaciones.CategoriaDTO();
                                    com.heinsohn.runt.general.identificaciones.CategoriaDTO categoriaAn2  = new com.heinsohn.runt.general.identificaciones.CategoriaDTO();
                                    codigoTramiteRunt = model.consultarTramiteRUNT(formularioLicencia.getFk_tramite());
                                    tramiteRecategorizacionBLicencia.setCodigoTipoTramite(codigoTramiteRunt+"");
                                    tramiteRecategorizacionBLicencia.setEstadoTramite("SOLICITADO");
                                    tramiteRecategorizacionBLicencia.setOrdenEjecucion(0);
                                    recateg.setNumeroLicencia(formularioLicencia.getLicencia_anterior());
                                    categoriaNueva.setCategoria(formularioLicencia.getCategoria());
                                    recateg.setCategoriaNueva(categoriaNueva);
                                    categoriaAn2.setCategoria(formularioLicencia.getCategoria_anterior());
                                    recateg.setCategoria(categoriaAn2);
                                    
                                    tramiteRecategorizacionBLicencia.getRecategorizacion().add(recateg);
                                    tramiteRecategorizacionBLicencia.setFotoPersona(imagen);
                                    tramites.add(tramiteRecategorizacionBLicencia);
                                    break;
                            //Tramite de Duplicado Licencia de Conduccion
                            case 35:
                                    com.heinsohn.runt.general.tramite.rnc.TramiteDuplicadoLicenciaConduccionDTO tramiteDuplicadoLicencia = new com.heinsohn.runt.general.tramite.rnc.TramiteDuplicadoLicenciaConduccionDTO();
                                    com.heinsohn.runt.general.identificaciones.CategoriaDTO cat = new com.heinsohn.runt.general.identificaciones.CategoriaDTO();
                                    codigoTramiteRunt = model.consultarTramiteRUNT(formularioLicencia.getFk_tramite());
                                    tramiteDuplicadoLicencia.setCodigoTipoTramite(codigoTramiteRunt+"");
                                    tramiteDuplicadoLicencia.setEstadoTramite("SOLICITADO");
                                    tramiteDuplicadoLicencia.setOrdenEjecucion(0);
                                    cat.setCategoria(formularioLicencia.getCategoria());
                                    tramiteDuplicadoLicencia.getCategoria().add(cat);
                                    tramiteDuplicadoLicencia.setIdCategoria(formularioLicencia.getCategoria());
                                    tramiteDuplicadoLicencia.setFotoPersona(imagen);
                                    tramites.add(tramiteDuplicadoLicencia);
                                    break;
                       }
                       radicarSolicitudOut = radicacionService.radicarSolicitud(automotor, identificadorAT, nombreAT, tipoDocumento, numeroDocumento, null, null, autLimitacion, descAutorizacion, tipoSolicitud, numeroLiquidacion, registroSolicitud, solTutela, tramites,liquidaciones,biometricos,rechazos,userRunt.getCodigo(),userRunt.getPassword(),null);
                       if(radicarSolicitudOut!=null){
                           if(radicarSolicitudOut.getStatus()!=null){
                               mensajeTramiteRunt = radicarSolicitudOut.getStatus().getStatusDesc();
                               if(radicarSolicitudOut.getStatus().getStatusCode().equals("1")){
                                   model.registrarSolicitudRUNT(radicarSolicitudOut, radicacionLicencia.getId_radicacion_licencia(),2);
                                   session.setAttribute("respuesta", radicarSolicitudOut);
                                   procesoTramiteRunt = true;
                                   mensajeTramiteRunt = radicarSolicitudOut.getStatus().getStatusDesc();
                               }else{
                                   mensajeTramiteRunt = radicarSolicitudOut.getStatus().getStatusDesc();
                                   procesoTramiteRunt = false;
                               }
                           }else{
                               mensajeTramiteRunt = "No fue posible realizar la solicitud, intente nuevamente";
                               procesoTramiteRunt = false;
                           }
                       }else{
                           mensajeTramiteRunt = "No fue posible realizar la solicitud, intente nuevamente";
                           procesoTramiteRunt = false;
                       }
                   }else{
                        mensajeTramiteRunt = "El pago asociado no se encuentra habilitado";
                        procesoTramiteRunt = false;
                   }
               }else{
                   mensajeTramiteRunt = "No fue posible obtener la foto del solicitante";
                   procesoTramiteRunt = false;
               }
                }else{
                 mensajeTramiteRunt = "No fue posible obtener las Huellasn del solicitante";
                 procesoTramiteRunt = false;
                }

               }else{
                 mensajeTramiteRunt = "No fue posible obtener las Huellasn del Funcionario, Vuelva Autenticarse";
                 procesoTramiteRunt = false;
                }

               if(procesoTramiteRunt){
                    model.actualizarObservacionRadicacionLicencia(radicacionLicencia.getId_radicacion_licencia(),mensajeTramiteRunt);
                    model.actualizarEstadoRadicacionLicencia(radicacionLicencia.getId_radicacion_licencia(),3);
                    model.getCon().commit();
               }else{
                    model.getCon().rollback();
               } %>
               <jsp:forward page="radicarLicencia.jsp">
                   <jsp:param name="radicacionl" value="<%=radicacionLicencia.getId_radicacion_licencia()%>" />
                   <jsp:param name="msg" value="<%=mensajeTramiteRunt%>" />
                </jsp:forward>
             <%  }
             if(radicacionLicencia.getEstado()==3){
                com.heinsohn.runt.general.solicitudes.ConsultaResultadoSolicitudOUTDTO consultaResultado = null;
                webservices.radicacion.RadicacionServicesClient radicacionService = new webservices.radicacion.RadicacionServicesClient();
                radicacionService.setTokenHuellaDigital("");
                radicacionService.setUser(userRunt.getCodigo());
                 Model.userHandler = userRunt.getCodigo();
                 Model.passUserHandler = userRunt.getPassword();
                 String  mensajeRespuesta = "";
                 if(session.getAttribute("token2")!=null){
                    radicacionService.setTokenHuellaDigital(session.getAttribute("token2").toString());

               
                String numeroSolicitud = model.consultarSolicitudRadicacionRUNT(radicacionLicencia.getId_radicacion_licencia(),2);
                if(numeroSolicitud!=null){
                    consultaResultado = radicacionService.consultaResultadosSolicitudServicio(numeroSolicitud,userRunt.getCodigo(),userRunt.getPassword());
                    if(consultaResultado!=null){
                        if(consultaResultado.getStatus()!=null){
                            if(consultaResultado.getStatus().getStatusCode().equals("1")){
                                javax.xml.bind.JAXBElement<com.heinsohn.runt.general.solicitudes.RegistroSolicitudDTO> jax_registroSolicitud = consultaResultado.getSolicitud();
                                com.heinsohn.runt.general.solicitudes.RegistroSolicitudDTO registroSolicitud = jax_registroSolicitud.getValue();
                                session.setAttribute("solicitudl",registroSolicitud);
                                if(registroSolicitud!=null){
                                    if(!registroSolicitud.getEstadoSolicitud().equals("APROBADA")){
                                        String resultadoSol = "";
                                        for(int i=0;i<registroSolicitud.getRechazosOT().size();i++){
                                            com.heinsohn.runt.general.solicitudes.RechazoOTDTO rechazo = (com.heinsohn.runt.general.solicitudes.RechazoOTDTO)registroSolicitud.getRechazosOT().get(i);
                                            resultadoSol += rechazo.getDescripcionRechazo()+", ";
                                        }
                                        model.actualizarObservacionRadicacionLicencia(radicacionLicencia.getId_radicacion_licencia(),resultadoSol);
                                        model.getCon().commit();
                                    }
                                    mensajeRespuesta = "Tramite radicado exitosamente..";
                                     %>
                                    <jsp:forward page="resultadoLicencia.jsp">
                                       <jsp:param name="radicacionl" value="<%=radicacionLicencia.getId_radicacion_licencia()%>" />
                                       <jsp:param name="msg" value="<%=mensajeRespuesta%>" />
                                    </jsp:forward>
                         <%     }
                            }else{
                                mensajeRespuesta = "RUNT: "+consultaResultado.getStatus().getStatusDesc();
                            }
                        }else{
                             mensajeTramiteRunt = "No fue posible realizar la consulta de la solicitud, intente nuevamente - Sin resultados de Estado";
                        }
                    }else{
                         mensajeTramiteRunt = "No fue posible realizar la consulta de la solicitud, intente nuevamente - Sin servicio con Runt";
                    }
                }else{
                    mensajeRespuesta = "Numero de solicitud asociada no existe en civitrans";
                }
                }else{
                mensajeRespuesta = "Token vencido o Invalido, Favor vuelva autenticarse";
                }
                mensajeRespuesta = mensajeRespuesta.replace((char)13, ' ').replace((char)10, ' ').replace((char)9, ' '); %>
                <jsp:forward page="radicarLicencia.jsp">
                   <jsp:param name="radicacionl" value="<%=radicacionLicencia.getId_radicacion_licencia()%>" />
                   <jsp:param name="msg" value="<%=mensajeRespuesta%>" />
                </jsp:forward>
         <%  }
             if(radicacionLicencia.getEstado()==4){
                 model.actualizarNumeroSustrato(radicacionLicencia.getId_radicacion_licencia(), request.getParameter("sustrato"), 2);
                 model.actualizarEstadoRadicacionLicencia(radicacionLicencia.getId_radicacion_licencia(),5);
                 model.getCon().commit(); %>
               <jsp:forward page="registrarPersona.jsp">
                   <jsp:param name="radicacionl" value="<%=radicacionLicencia.getId_radicacion_licencia()%>" />
                </jsp:forward>
        <%  }
	    if(radicacionLicencia.getEstado()==8){
                String mensajeRespuesta = "Radicacion ha sido anulada.."; %>
                <jsp:forward page="radicarLicencia.jsp">
                   <jsp:param name="radicacionl" value="<%=radicacionLicencia.getId_radicacion_licencia()%>" />
                   <jsp:param name="msg" value="<%=mensajeRespuesta%>" />
                </jsp:forward>
         <%  }
	     if(radicacionLicencia.getEstado()==9){
                     model.actualizarEstadoRadicacionLicencia(radicacionLicencia.getId_radicacion_licencia(), 1);
                     model.getCon().commit();
                     String mensajeRespuesta = "Radicacion ha sido renovada";%>
                     <jsp:forward page="radicarLicencia.jsp">
                       <jsp:param name="radicacionl" value="<%=radicacionLicencia.getId_radicacion_licencia()%>" />
                       <jsp:param name="msg" value="<%=mensajeRespuesta%>" />
                    </jsp:forward>
         <%  }
        }
    }catch(Exception excw){
        excw.printStackTrace();
        model.getCon().rollback();
        String mensajeRespuesta = "Civitrans : "+excw.getMessage(); %>
        <jsp:forward page="radicarLicencia.jsp">
           <jsp:param name="radicacionl" value="<%=request.getParameter(\"radicacionl\")%>" />
           <jsp:param name="msg" value="<%=mensajeRespuesta%>" />
        </jsp:forward>
<%  }  %>
