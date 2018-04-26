package webservices.radicacion;

import com.heinsohn.runt.general.identificaciones.*;
import com.heinsohn.runt.general.personas.*;
import com.heinsohn.runt.autorizador.*;
import com.heinsohn.runt.general.solicitudes.*;
import com.heinsohn.runt.general.tramite.*;
import com.heinsohn.runt.registroinformacion.client.RegistrarInformacionService_Service;
import javax.xml.bind.JAXBElement;
import java.util.GregorianCalendar;
import java.util.List;
import javax.xml.datatype.XMLGregorianCalendar;
import javax.xml.namespace.QName;
import modelo.Propietario;
/**
 *
 * @author Civitrans
 */
public class RadicacionServicesClient {
    
    private IdentificacionAutomotorDTO automotor = new IdentificacionAutomotorDTO();
    private AutoridadTransitoDTO autoridad = new AutoridadTransitoDTO();
    private IdentificacionPersonaDTO apoderado = new IdentificacionPersonaDTO();
    private IdentificacionPersonaDTO solicitante = new IdentificacionPersonaDTO();
    private String tokenHuellaDigital = null;
    private String user = null;

    public void setTokenHuellaDigital(String tokenHuellaDigital) {
        this.tokenHuellaDigital = tokenHuellaDigital;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getTokenHuellaDigital() {
        return tokenHuellaDigital;
    }

    public String getUser() {
        return user;
    }

    public RadicarSolicitudOutDTO radicarSolicitud(IdentificacionAutomotorDTO automotor,String identificadorAT,String nombreAT,String tipoDocumento,String numeroDocumento,String tipoApoderado,String numeroApoderado, String autLimitacion,String descAutorizacion,String tipoSolicitud,String numeroLiquidacion,String registroSolicitud,boolean solTutela,java.util.List<TramiteBasicoDTO> tramites,java.util.List<LiquidacionInDTO> liquidaciones,java.util.List<InformacionBiometricaCiudadanoDTO> biometrico,java.util.List<RechazoOTDTO> rechazos,String usuario,String pass,PropietarioDTO propietario){

        try { // Call Web Service Operation
            RadicacionService_Service service = new RadicacionService_Service();
            RadicacionService port = service.getRadicacionServiceSoapHttpPort(); 
            // TODO initialize WS operation arguments here
            RadicarSolicitudElement parameters = new RadicarSolicitudElement();

            CommonHeaderDTO common = new CommonHeaderDTO();


            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
            common.setTokenHuellaDigital(jaxb_t);
            common.setUsuario(user);
            parameters.setHeader(common);

            RadicarSolicitudInDTO radicacion_in = new RadicarSolicitudInDTO();

            this.automotor = automotor;
            javax.xml.namespace.QName name_IA = new javax.xml.namespace.QName("http://solicitudes.general.runt.heinsohn.com","automotor");
            java.lang.Class<IdentificacionAutomotorDTO> declaredType_IA = IdentificacionAutomotorDTO.class;
            java.lang.Class scope_IA = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<IdentificacionAutomotorDTO> jax_IA = new JAXBElement<IdentificacionAutomotorDTO>(name_IA,declaredType_IA,scope_IA,automotor);
            radicacion_in.setAutomotor(jax_IA);

            autoridad.setIdentificador(identificadorAT);
            autoridad.setNombreAutoridadTransito(nombreAT);
                

            javax.xml.namespace.QName name_AT = new javax.xml.namespace.QName("http://solicitudes.general.runt.heinsohn.com","autoridadTransito");
            java.lang.Class<AutoridadTransitoDTO> declaredType_AT = AutoridadTransitoDTO.class;
            java.lang.Class scope_AT = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<AutoridadTransitoDTO> jax_AT = new JAXBElement<AutoridadTransitoDTO>(name_AT,declaredType_AT,scope_AT,autoridad);
            radicacion_in.setAutoridadTransito(jax_AT);

             System.out.println("TIPO DOC A : "+tipoApoderado);
             System.out.println("DOC A : "+numeroApoderado);
            if(numeroApoderado!=null){
               
                apoderado.setTipoDocumento(tipoApoderado);
                apoderado.setNumeroDocumento(numeroApoderado);

                javax.xml.namespace.QName name_PA = new javax.xml.namespace.QName("http://solicitudes.general.runt.heinsohn.com","datosApoderado");
                java.lang.Class<IdentificacionPersonaDTO> declaredType_PA = IdentificacionPersonaDTO.class;
                java.lang.Class scope_PA = javax.xml.bind.JAXBElement.GlobalScope.class;
                JAXBElement<IdentificacionPersonaDTO> jax_PA = new JAXBElement<IdentificacionPersonaDTO>(name_PA,declaredType_PA,scope_PA,apoderado);
                radicacion_in.setDatosApoderado(jax_PA);               
                
            }

            solicitante.setTipoDocumento(tipoDocumento);
            solicitante.setNumeroDocumento(numeroDocumento);
            System.out.println("TIPO DOC S : "+tipoApoderado);
            System.out.println("DOC S : "+numeroApoderado);

            javax.xml.namespace.QName name_PS = new javax.xml.namespace.QName("http://solicitudes.general.runt.heinsohn.com","solicitante");
            java.lang.Class<IdentificacionPersonaDTO> declaredType_PS = IdentificacionPersonaDTO.class;
            java.lang.Class scope_PS = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<IdentificacionPersonaDTO> jax_PS = new JAXBElement<IdentificacionPersonaDTO>(name_PS,declaredType_PS,scope_PS,solicitante);
            radicacion_in.setSolicitante(jax_PS);

            radicacion_in.setAutorizacionLimitacion("S");
            radicacion_in.setDescripcionAutorizacion(descAutorizacion);
            radicacion_in.setNombreTipoSolicitud(tipoSolicitud);
            radicacion_in.setNumeroLiquidacionOT(numeroLiquidacion);
            radicacion_in.setRegistroSolicitud(registroSolicitud);
        //    radicacion_in.setSolicitudTutela(solTutela);
            radicacion_in.setTutelaOActoAdministrativo("N");
            radicacion_in.setValidacionRequisitos("N");
            
             
            for(int i=0;i<tramites.size();i++){
                radicacion_in.getTramites().add(tramites.get(i));
            }

            for(int i=0;i<liquidaciones.size();i++){
                radicacion_in.getLiquidaciones().add(liquidaciones.get(i));
            }

            for(int i=0;i<biometrico.size();i++){
                radicacion_in.getInformacionBiometricaSolicitud().add(biometrico.get(i));
            }

            //radicacion_in.setDatosApoderado(jax_PS);

            for(int i=0;i<rechazos.size();i++){
                radicacion_in.getRechazosOT().add(rechazos.get(i));
            }
            if(propietario!=null)
                radicacion_in.getDatosPropietarios().add(propietario);
            
            
            
           
            parameters.setSolicitudDTO(radicacion_in);
            // TODO process result here
            modelo.Model.userHandler = usuario;
            modelo.Model.passUserHandler = pass;
            RadicarSolicitudResponseElement result = port.radicarSolicitud(parameters);

            RadicarSolicitudOutDTO radicacion_out = result.getResult();
            return radicacion_out;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }


    }

    public ConsultaResultadoSolicitudOUTDTO consultaResultadosSolicitudServicio(String numeroSolicitud,String usuario,String pass){

        try { // Call Web Service Operation
            RadicacionService_Service service = new RadicacionService_Service();
            RadicacionService port = service.getRadicacionServiceSoapHttpPort();
            // TODO initialize WS operation arguments here
            ConsultaResultadoSolicitudServicioElement parameters = new ConsultaResultadoSolicitudServicioElement();

            CommonHeaderDTO common = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
            common.setTokenHuellaDigital(jaxb_t);
            common.setUsuario(user);
            parameters.setHeader(common);
            // TODO process result here
            ConsultaResultadoSolicitudInDTO resultado_servicio_in = new ConsultaResultadoSolicitudInDTO();
            resultado_servicio_in.setIdSolicitud(numeroSolicitud);

            parameters.setConsultaResultado(resultado_servicio_in);
            modelo.Model.userHandler = usuario;
            modelo.Model.passUserHandler = pass;

            ConsultaResultadoSolicitudServicioResponseElement result = port.consultaResultadoSolicitudServicio(parameters);
            ConsultaResultadoSolicitudOUTDTO resultado_servicio_out = result.getResult();
            return resultado_servicio_out;
        } catch (Exception ex) {
            System.out.println("Error al Aprobar Licencias de Conducciòn "+ex.getMessage()); ex.printStackTrace();
            return null;
        }

    }

    public InformacionEntregaResultadoOutDTO registrarInformacionEntregaResultado(String identificadorAT,String nombreAT,java.sql.Date fecha_entrega,String id_solicitud,String tipo_entrega){

        try { // Call Web Service Operation
            RadicacionService_Service service = new RadicacionService_Service();
            RadicacionService port = service.getRadicacionServiceSoapHttpPort();
            // TODO initialize WS operation arguments here
            RegistrarInformacionEntregaResultadoElement parameters = new RegistrarInformacionEntregaResultadoElement();

            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);
            parameters.setHeader(header);

            InformacionEntregaResultadoInDTO entregaResultado_in = new InformacionEntregaResultadoInDTO();

            AutoridadTransitoDTO autoridad_transito = new AutoridadTransitoDTO();
            autoridad_transito.setIdentificador(identificadorAT);
            autoridad_transito.setNombreAutoridadTransito(nombreAT);

            QName name_at = new QName("http://solicitudes.general.runt.heinsohn.com","autoridad");
            Class<AutoridadTransitoDTO> declaredType_at = AutoridadTransitoDTO.class;
            Class scope_at = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<AutoridadTransitoDTO> jaxb_autoridadTransito = new JAXBElement(name_at,declaredType_at,scope_at,autoridad_transito);
            entregaResultado_in.setAutoridad(jaxb_autoridadTransito);

            GregorianCalendar gc = new GregorianCalendar();
            gc.setTime(fecha_entrega);
            XMLGregorianCalendar fecha_registro = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gc);
            entregaResultado_in.setFechaEntrega(fecha_registro);

            entregaResultado_in.setIdSolicitud(id_solicitud);
            entregaResultado_in.setTipoEntrega(tipo_entrega);

            parameters.setRegistrarInformacionEntregaIn(entregaResultado_in);
            // TODO process result here
            RegistrarInformacionEntregaResultadoResponseElement result = port.registrarInformacionEntregaResultado(parameters);
            InformacionEntregaResultadoOutDTO entregaResultado_out = result.getResult();
            return entregaResultado_out;
        } catch (Exception ex) {
      //      ex.printStackTrace();
            return null;
        }

    }

    public InscribirPersonaOutDTO inscribirPersonaNatural(String tipoDoc,String numeroDoc,String nombre1,String nombre2,String apellido1,String apellido2,String sexo,String rh,java.sql.Date fexpedicion,java.sql.Date fnacimiento,String municipioNac,String celular,String email,java.util.List<DireccionDTO> direcciones,java.util.List<MotivoRechazoHuellaDTO> rechazos,String trama, String noLiquidacion){

        try { // Call Web Service Operation
            RadicacionService_Service service = new RadicacionService_Service();
            RadicacionService port = service.getRadicacionServiceSoapHttpPort();
            // TODO initialize WS operation arguments here
            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);

            InscribirPersonaNaturalInDTO in = new InscribirPersonaNaturalInDTO();

            IdentificacionPersonaDTO identificacion = new IdentificacionPersonaDTO();
            identificacion.setIdPersona(null);
            identificacion.setTipoDocumento(tipoDoc);
            identificacion.setNumeroDocumento(numeroDoc);

        //Implementacion del JAXBElement PersonaApoderada PA
            javax.xml.namespace.QName name_PN = new javax.xml.namespace.QName("http://solicitudes.general.runt.heinsohn.com","identificacion");
            java.lang.Class<IdentificacionPersonaDTO> declaredType_PN = IdentificacionPersonaDTO.class;
            java.lang.Class scope_PN = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<IdentificacionPersonaDTO> jaxb_PN = new JAXBElement<IdentificacionPersonaDTO>(name_PN,declaredType_PN,scope_PN,identificacion);
            in.setIdentificacion(jaxb_PN);

            in.setPrimerNombrePersona(nombre1);
            in.setSegundoNombrePersona(nombre2);
            in.setPrimerApellidoPersona(apellido1);
            in.setSegundoApellidoPersona(apellido2);
            in.setSexoPersona(sexo);
            in.setGrupoSanguineoPersona(rh);

            if(fexpedicion!=null){
                GregorianCalendar gc_fed = new GregorianCalendar();
                gc_fed.setTime(fexpedicion);
                XMLGregorianCalendar fecha_expedicion = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gc_fed);
                in.setFechaExpedicionDocumento(fecha_expedicion);
            }

            if(fnacimiento!=null){
                GregorianCalendar gc_fnp = new GregorianCalendar();
                gc_fnp.setTime(fnacimiento);
                XMLGregorianCalendar fecha_nacimiento = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gc_fnp);
                in.setFechaNacimientoPersona(fecha_nacimiento);
            }

            if(tipoDoc.equals("P")||tipoDoc.equals("E")){
                in.setCiudadNacimientoExtranjera("50");
            }else{
                if(municipioNac!=null){
                    IdentificadorGeografiaDTO lugarNacimiento = new IdentificadorGeografiaDTO();
                    lugarNacimiento.setIdMunicipio(municipioNac);
                    javax.xml.namespace.QName name_LN = new javax.xml.namespace.QName("http://solicitudes.general.runt.heinsohn.com","lugarNacimientoPersona");
                    java.lang.Class<IdentificadorGeografiaDTO> declaredType_LN = IdentificadorGeografiaDTO.class;
                    java.lang.Class scope_LN = javax.xml.bind.JAXBElement.GlobalScope.class;
                    JAXBElement<IdentificadorGeografiaDTO> jaxb_LN = new JAXBElement<IdentificadorGeografiaDTO>(name_LN,declaredType_LN,scope_LN,lugarNacimiento);
                    in.setLugarNacimientoPersona(jaxb_LN);
                }
            }

            in.setCelularPersona(celular); 
            in.setEmailPersona(email);
            in.setTramaEnrolamiento(trama);  
            LiquidacionInDTO liquidacion_in = new LiquidacionInDTO();
            //liquidacion_in.setNumeroLiquidacion(noLiquidacion);
            liquidacion_in.setNumeroLiquidacion("");
            java.util.List<LiquidacionInDTO> listLiquidacion = new java.util.LinkedList<LiquidacionInDTO>();
            listLiquidacion.add(liquidacion_in);

            in.getLiquidacionInscripcion().add(liquidacion_in);
     //       in.setTemplateHuellaDactilar(template);
      //      in.setCodigoBidimensionalCC(bidimensional);
      //      in.setFirmaDigitalizada(firma);
      //      in.setFoto(foto);

            for(int i=0;i<direcciones.size();i++){
               in.getDirecciones().add(direcciones.get(i));
            }

//            for(int i=0;i<huellas.size();i++){
//               in.getImagenHuellaDedos().add(huellas.get(i));
//            }

            InscribirPersonaOutDTO result = port.inscribirPersonaNatural(header, in);
            return result;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }

    }

   public InscribirPersonaOutDTO inscribirPersonaJuridica(String tipoDoc,String numeroDoc, String digitoV,String razonSocial,String sigla,String tipoSociedad,String tipoEntidad,String prestadorServicio,double capitalPagado,double patrimonio,String celular,String email,String certificado,String tipoDocR,String numeroDocR,String estadoR,java.sql.Date fechaInicioR,java.sql.Date fechaVigenciaR,String tipoContrato,DireccionDTO direccion, List<SucursalDTO> listSucursales, long noregistromercantil, java.sql.Date fechaVenceRegistroM, String noLiquidacion){

        try { // Call Web Service Operation
            RadicacionService_Service service = new RadicacionService_Service();
            RadicacionService port = service.getRadicacionServiceSoapHttpPort();
            // TODO initialize WS operation arguments here
            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);

            InscribirPersonaJuridicaInDTO in = new InscribirPersonaJuridicaInDTO();

            IdentificacionPersonaDTO identificacion = new IdentificacionPersonaDTO();
            identificacion.setTipoDocumento(tipoDoc);
            identificacion.setNumeroDocumento(numeroDoc);
            
            javax.xml.namespace.QName name_PJ = new javax.xml.namespace.QName("http://solicitudes.general.runt.heinsohn.com","identificacion");
            java.lang.Class<IdentificacionPersonaDTO> declaredType_PJ = IdentificacionPersonaDTO.class;
            java.lang.Class scope_PJ = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<IdentificacionPersonaDTO> jaxb_PJ = new JAXBElement<IdentificacionPersonaDTO>(name_PJ,declaredType_PJ,scope_PJ,identificacion);
            in.setIdentificacion(jaxb_PJ);

            in.setDigitoVerificacion(digitoV);
            in.setRazonSocial(razonSocial);
            in.setEmail(email);
            in.setCelular(celular);
            in.setTipoSociedad(tipoSociedad);
            in.setTipoEntidad(tipoEntidad);
            in.setPrestadorServicios(prestadorServicio);
            in.setNumeroCertificadoExistenciaRepresentacion(certificado);
            in.setSigla(sigla);
            in.setCapitalPagado(capitalPagado);
            in.setPatrimonioLiquido(patrimonio);
            in.setNroRegistroMercantil(noregistromercantil);

            GregorianCalendar gc_fvre = new GregorianCalendar();
            gc_fvre.setTime(fechaVenceRegistroM);
            XMLGregorianCalendar fecha_venceRegistroM = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gc_fvre);
            in.setFechaVencRegistroMercantil(fecha_venceRegistroM);

            RepresentanteLegalDTO representante_legal = new RepresentanteLegalDTO();

            IdentificacionPersonaDTO identificacion_representante = new IdentificacionPersonaDTO();
            identificacion_representante.setTipoDocumento(tipoDocR);
            identificacion_representante.setNumeroDocumento(numeroDocR);
            representante_legal.setIdentificacion(identificacion_representante);
            representante_legal.setEstadoRepresentacionLegal(estadoR);

            GregorianCalendar gc_fir = new GregorianCalendar();
            gc_fir.setTime(fechaInicioR);
            XMLGregorianCalendar fecha_inicioR = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gc_fir);
            representante_legal.setFechaInicioRepresentacion(fecha_inicioR);

            GregorianCalendar gc_fvr = new GregorianCalendar();
            gc_fvr.setTime(fechaVigenciaR);
            XMLGregorianCalendar fecha_vigenciaR = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gc_fvr);
            representante_legal.setFechaVigenciaRepresentacion(fecha_vigenciaR);

            representante_legal.setTipoContrato(tipoContrato);

            in.getRepresentanteLegal().add(representante_legal);

            javax.xml.namespace.QName name_PD = new javax.xml.namespace.QName("http://solicitudes.general.runt.heinsohn.com","direccion");
            java.lang.Class<DireccionDTO> declaredType_PD = DireccionDTO.class;
            java.lang.Class scope_PD = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<DireccionDTO> jaxb_PD = new JAXBElement<DireccionDTO>(name_PD,declaredType_PD,scope_PD,direccion);
            in.setDireccion(jaxb_PD);
            in.getSucursales().add(listSucursales.get(1));
            
            LiquidacionInDTO liquidacion_in = new LiquidacionInDTO();
            //liquidacion_in.setNumeroLiquidacion(noLiquidacion);
            liquidacion_in.setNumeroLiquidacion("");
            in.getLiquidacionInscripcion().add(liquidacion_in);

            InscribirPersonaOutDTO result = port.inscribirPersonaJuridica(header, in);
            return result;

        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public StatusDTO verificarEstadoWS(){

        try { // Call Web Service Operation
            RadicacionService_Service service = new RadicacionService_Service();
            RadicacionService port = service.getRadicacionServiceSoapHttpPort();
            // TODO initialize WS operation arguments here
            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);
            // TODO process result here
            StatusDTO result = port.verificarEstadoWS(header);
            return result;
        } catch (Exception ex) {
        //    ex.printStackTrace();
            return null;
        }

    }

    public RegistrarAutorizacionSinHuellaOutDTO registrarAutorizacionRadicacionHuella(String tipoDoc, String numeroDoc, String entidadCertifica, int motivoNoHuella, int registroNacional, String[] tramites) {

        try {

            RadicacionService_Service service = new RadicacionService_Service();
            RadicacionService port = service.getRadicacionServiceSoapHttpPort();

            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t, declaredType_t, scope_t, tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);

            RegistrarAutorizacionSinHuellaInDTO in = new RegistrarAutorizacionSinHuellaInDTO();
            IdentificacionPersonaDTO identificacion = new IdentificacionPersonaDTO();
            identificacion.setTipoDocumento(tipoDoc);
            identificacion.setNumeroDocumento(numeroDoc);

            javax.xml.namespace.QName name_PJ = new javax.xml.namespace.QName("http://solicitudes.general.runt.heinsohn.com", "identificacion");
            java.lang.Class<IdentificacionPersonaDTO> declaredType_PJ = IdentificacionPersonaDTO.class;
            java.lang.Class scope_PJ = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<IdentificacionPersonaDTO> jaxb_PJ = new JAXBElement<IdentificacionPersonaDTO>(name_PJ, declaredType_PJ, scope_PJ, identificacion);
            
            in.setIdentificacion(jaxb_PJ);
            in.setMotivoNoHuella(motivoNoHuella);
            in.setRegistroNacional(registroNacional);

            for (int i = 0; i < tramites.length; i++) {
                in.getTipoTramite().add(Integer.parseInt(tramites[i]));
            }
            
            in.setEntidadCertifica(entidadCertifica);

            return port.registrarAutorizacionRadicacionHuella(header, in);

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return null;

    }

    public AprobarRevisionDocumentalOutDTO  aprobacionRevisionDocumentalSolicitud(String solicitud){

        try { // Call Web Service Operation
            com.heinsohn.runt.autorizador.RadicacionService_Service service = new com.heinsohn.runt.autorizador.RadicacionService_Service();
            com.heinsohn.runt.autorizador.RadicacionService port = service.getRadicacionServiceSoapHttpPort();
            // TODO initialize WS operation arguments here
                 // TODO initialize WS operation arguments here
            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);

            AprobarRevisionDocumentalInDTO in = new AprobarRevisionDocumentalInDTO();
            in.setIdSolicitud(solicitud);
            in.setResultadoRevision("SI");

            com.heinsohn.runt.autorizador.AprobarRevisionDocumentalSolicitudElement parameters = new com.heinsohn.runt.autorizador.AprobarRevisionDocumentalSolicitudElement();
            parameters.setAprobarRevisionDocumentalInDTO(in);
            parameters.setHeader(header);
            // TODO process result here
            com.heinsohn.runt.autorizador.AprobarRevisionDocumentalSolicitudResponseElement result = port.aprobarRevisionDocumentalSolicitud(parameters);
            System.out.println("Result = "+result);
            return result.getResult();
        } catch (Exception ex) {
            return null;
            // TODO handle custom exceptions here
        }

            // TODO initialize WS operation arguments here


    }

}
