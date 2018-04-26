package webservices.consultas;

import com.heinsohn.runt.consultasgeneralesrunt.*;
import com.heinsohn.runt.consultasgeneralesrunt.types.*;
import com.heinsohn.runt.general.consultas.*;
import com.heinsohn.runt.general.identificaciones.*;
import javax.xml.bind.JAXBElement;
import javax.xml.namespace.QName;

/**
 *
 * @author Civitrans
 */
public class ServicioConsultaRUNTClient {

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

    public AseguradoraOutDTO consultarDatosAseguradora(String tipoDocumento, String numeroDocumento, String numeroRegistro) {

        try { // Call Web Service Operation
            ServicioConsultaRUNT_Service service = new ServicioConsultaRUNT_Service();
            ServicioConsultaRUNT port = service.getServicioConsultaRUNTSoapHttpPort();

            // TODO initialize WS operation arguments here
            ConsultarDatosAseguradoraElement parameters = new ConsultarDatosAseguradoraElement();

            //Cabecera del Mensaje
            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t, declaredType_t, scope_t, tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);
            parameters.setHeader(header);

            IdentificadorAseguradoraDTO identificador_aseguradora = new IdentificadorAseguradoraDTO();
            identificador_aseguradora.setNumeroRegistroAseguradora(numeroRegistro);

            IdentificacionPersonaDTO identificacion_persona = new IdentificacionPersonaDTO();

            identificacion_persona.setTipoDocumento(tipoDocumento);
            identificacion_persona.setNumeroDocumento(numeroDocumento);
            identificador_aseguradora.setIdPersonaJuridicaAseguradora(identificacion_persona);

            parameters.setIdentificadorAseguradora(identificador_aseguradora);

            ConsultarDatosAseguradoraResponseElement result = port.consultarDatosAseguradora(parameters);
            AseguradoraOutDTO aseguradoraOut = result.getResult();

            return aseguradoraOut;

        } catch (Exception ex) {
            //     ex.printStackTrace();
            return null;
        }

    }

    public AutomotorOutDTO consultarDatosAutomotor(String placa, String motor, String chasis, String serie, String vin, String usuario, String pass) {

        try { // Call Web Service Operation
            ServicioConsultaRUNT_Service service = new ServicioConsultaRUNT_Service();
            ServicioConsultaRUNT port = service.getServicioConsultaRUNTSoapHttpPort();
            // TODO initialize WS operation arguments here
            ConsultarDatosAutomotorElement parameters = new ConsultarDatosAutomotorElement();

            //Cabecera del Mensaje
            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t, declaredType_t, scope_t, tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);
            parameters.setHeader(header);

            IdentificacionAutomotorDTO identificador_automotor = new IdentificacionAutomotorDTO();
            identificador_automotor.setNumeroPlaca(placa);
            identificador_automotor.setNumeroChasis(chasis);
            identificador_automotor.setNumeroSerie(serie);
            identificador_automotor.setNumeroMotor(motor);
            identificador_automotor.setNumeroVIN(vin);
            parameters.setIdentificacionAutomotor(identificador_automotor);
            // TODO process result here
            modelo.Model.userHandler = usuario;
            modelo.Model.passUserHandler = pass;
            ConsultarDatosAutomotorResponseElement result = port.consultarDatosAutomotor(parameters);
            AutomotorOutDTO automotorOut = result.getResult();

            return automotorOut;

        } catch (Exception ex) {
            //     ex.printStackTrace();
            return null;
        }

    }

    public ConductorOutDTO consultarDatosConductor(String tipoDocumento, String numeroDocumento, String numeroLicencia) {

        try { // Call Web Service Operation
            ServicioConsultaRUNT_Service service = new ServicioConsultaRUNT_Service();
            ServicioConsultaRUNT port = service.getServicioConsultaRUNTSoapHttpPort();
            // TODO initialize WS operation arguments here
            ConsultarDatosConductorElement parameters = new ConsultarDatosConductorElement();

            //Cabecera del Mensaje
            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t, declaredType_t, scope_t, tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);
            parameters.setHeader(header);

            ConsultarDatosConductorInDTO consulta_datosConductor = new ConsultarDatosConductorInDTO();
            //consulta_datosConductor.setNumeroLicenciaConduccion(numeroLicencia);

            IdentificacionPersonaDTO identificacion_persona = new IdentificacionPersonaDTO();
            identificacion_persona.setTipoDocumento(tipoDocumento);
            identificacion_persona.setNumeroDocumento(numeroDocumento);

            QName name = new QName("http://consultas.general.runt.heinsohn.com", "conductor");
            Class<IdentificacionPersonaDTO> declaredType = IdentificacionPersonaDTO.class;
            Class scope = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<IdentificacionPersonaDTO> jaxb_identificacionPersona = new JAXBElement(name, declaredType, scope, identificacion_persona);
            consulta_datosConductor.setConductor(jaxb_identificacionPersona);

            parameters.setConsultarDatosConductorInDTO(consulta_datosConductor);

            ConsultarDatosConductorResponseElement result = port.consultarDatosConductor(parameters);
            ConductorOutDTO conductorOut = result.getResult();
            return conductorOut;

        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }

    }

    public PersonaJuridicaOutDTO consultarDatosPersonaJuridica(String tipoDocumento, String numeroDocumento) {

        try { // Call Web Service Operation
            ServicioConsultaRUNT_Service service = new ServicioConsultaRUNT_Service();
            ServicioConsultaRUNT port = service.getServicioConsultaRUNTSoapHttpPort();
            // TODO initialize WS operation arguments here
            ConsultarDatosPersonaJuridicaElement parameters = new ConsultarDatosPersonaJuridicaElement();

            //Cabecera del Mensaje
            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t, declaredType_t, scope_t, tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);
            parameters.setHeader(header);

            IdentificacionPersonaDTO identificacion_persona = new IdentificacionPersonaDTO();
            identificacion_persona.setTipoDocumento(tipoDocumento);
            identificacion_persona.setNumeroDocumento(numeroDocumento);
            parameters.setIdentificacionPersonaDTO(identificacion_persona);
            // TODO process result here
            ConsultarDatosPersonaJuridicaResponseElement result = port.consultarDatosPersonaJuridica(parameters);
            PersonaJuridicaOutDTO persona_juridica_out = result.getResult();

            return persona_juridica_out;

        } catch (Exception ex) {
            //      ex.printStackTrace();
            return null;
        }

    }

    public PersonaJuridicaOutDTO consultarDatosPersonaJuridicaByID(String id) {

        try { // Call Web Service Operation
            ServicioConsultaRUNT_Service service = new ServicioConsultaRUNT_Service();
            ServicioConsultaRUNT port = service.getServicioConsultaRUNTSoapHttpPort();
            // TODO initialize WS operation arguments here
            ConsultarDatosPersonaJuridicaElement parameters = new ConsultarDatosPersonaJuridicaElement();

            //Cabecera del Mensaje
            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t, declaredType_t, scope_t, tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);
            parameters.setHeader(header);

            IdentificacionPersonaDTO identificacion_persona = new IdentificacionPersonaDTO();
            identificacion_persona.setIdPersona(id);
            parameters.setIdentificacionPersonaDTO(identificacion_persona);
            // TODO process result here
            ConsultarDatosPersonaJuridicaResponseElement result = port.consultarDatosPersonaJuridica(parameters);
            PersonaJuridicaOutDTO persona_juridica_out = result.getResult();

            return persona_juridica_out;

        } catch (Exception ex) {
            //      ex.printStackTrace();
            return null;
        }

    }

    public PersonaNaturalOutDTO consultarDatosPersonaNatural(String tipoDocumento, String numeroDocumento) {

        try { // Call Web Service Operation

            ServicioConsultaRUNT_Service service = new ServicioConsultaRUNT_Service();
            ServicioConsultaRUNT port = service.getServicioConsultaRUNTSoapHttpPort();
            // TODO initialize WS operation arguments here
            ConsultarDatosPersonaNaturalElement parameters = new ConsultarDatosPersonaNaturalElement();
            //Cabecera del Mensaje
            CommonHeaderDTO header = new CommonHeaderDTO();
            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t, declaredType_t, scope_t, tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);
            parameters.setHeader(header);

            IdentificacionPersonaDTO identificacion_persona = new IdentificacionPersonaDTO();
            identificacion_persona.setTipoDocumento(tipoDocumento);
            identificacion_persona.setNumeroDocumento(numeroDocumento);
            parameters.setIdentificacionPersona(identificacion_persona);

            ConsultarDatosPersonaNaturalResponseElement result = port.consultarDatosPersonaNatural(parameters);
            PersonaNaturalOutDTO persona_natural_out = result.getResult();
            return persona_natural_out;

        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }

    }

    public PersonaNaturalOutDTO consultarDatosPersonaNaturalByID(String id) {

        try { // Call Web Service Operation

            ServicioConsultaRUNT_Service service = new ServicioConsultaRUNT_Service();
            ServicioConsultaRUNT port = service.getServicioConsultaRUNTSoapHttpPort();
            // TODO initialize WS operation arguments here
            ConsultarDatosPersonaNaturalElement parameters = new ConsultarDatosPersonaNaturalElement();

            //Cabecera del Mensaje
            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t, declaredType_t, scope_t, tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);
            parameters.setHeader(header);

            IdentificacionPersonaDTO identificacion_persona = new IdentificacionPersonaDTO();
            identificacion_persona.setIdPersona(id);
            parameters.setIdentificacionPersona(identificacion_persona);

            ConsultarDatosPersonaNaturalResponseElement result = port.consultarDatosPersonaNatural(parameters);
            PersonaNaturalOutDTO persona_natural_out = result.getResult();
            return persona_natural_out;

        } catch (Exception ex) {
            //ex.printStackTrace();
            return null;
        }

    }

    public PolizaSeguroOutDTO consultarDatosPoliza(String placa, String motor, String chasis, String serie, String vin, String numeroPoliza) {

        try { // Call Web Service Operation
            ServicioConsultaRUNT_Service service = new ServicioConsultaRUNT_Service();
            ServicioConsultaRUNT port = service.getServicioConsultaRUNTSoapHttpPort();
            // TODO initialize WS operation arguments here
            ConsultarDatosPolizaElement parameters = new ConsultarDatosPolizaElement();

            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t, declaredType_t, scope_t, tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);
            parameters.setHeader(header);

            ConsultarDatosPolizaInDTO datos_poliza = new ConsultarDatosPolizaInDTO();
            //identificacion_persona.setIdPersona("");
            IdentificacionAutomotorDTO identificacion_automotor = new IdentificacionAutomotorDTO();
            identificacion_automotor.setNumeroChasis(chasis);
            identificacion_automotor.setNumeroMotor(motor);
            identificacion_automotor.setNumeroPlaca(placa);
            identificacion_automotor.setNumeroSerie(serie);
            identificacion_automotor.setNumeroVIN(vin);

            QName name = new QName("http://consultas.general.runt.heinsohn.com", "automotor");
            Class<IdentificacionAutomotorDTO> declaredType = IdentificacionAutomotorDTO.class;
            Class scope = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<IdentificacionAutomotorDTO> jaxb_identificacionAutomotor = new JAXBElement(name, declaredType, scope, identificacion_automotor);
            datos_poliza.setAutomotor(jaxb_identificacionAutomotor);

            datos_poliza.setNumeroPolizaSeguro(numeroPoliza);

            parameters.setConsultarDatosPoliza(datos_poliza);

            ConsultarDatosPolizaResponseElement result = port.consultarDatosPoliza(parameters);
            PolizaSeguroOutDTO poliza_seguro_out = result.getResult();

            return poliza_seguro_out;

        } catch (Exception ex) {
            //ex.printStackTrace();
            return null;
        }

    }

    public LicenciaTransitoOutDTO consultarLicenciaTransito(String placa, String motor, String chasis, String serie, String vin, String numeroLicencia) {

        try { // Call Web Service Operation
            ServicioConsultaRUNT_Service service = new ServicioConsultaRUNT_Service();
            ServicioConsultaRUNT port = service.getServicioConsultaRUNTSoapHttpPort();
            // TODO initialize WS operation arguments here
            ConsultarLicenciaTransitoElement parameters = new ConsultarLicenciaTransitoElement();

            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t, declaredType_t, scope_t, tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);
            parameters.setHeader(header);

            IdentificacionAutomotorDTO identificacion_automotor = new IdentificacionAutomotorDTO();
            identificacion_automotor.setNumeroChasis(chasis);
            identificacion_automotor.setNumeroMotor(motor);
            identificacion_automotor.setNumeroPlaca(placa);
            identificacion_automotor.setNumeroSerie(serie);
            identificacion_automotor.setNumeroVIN(vin);
            parameters.setIdentificacionAutomotor(identificacion_automotor);

            parameters.setNumeroLicenciaTransito(numeroLicencia);
            // TODO process result here
            ConsultarLicenciaTransitoResponseElement result = port.consultarLicenciaTransito(parameters);
            LicenciaTransitoOutDTO licencia_transito_out = result.getResult();

            return licencia_transito_out;

        } catch (Exception ex) {
            //         ex.printStackTrace();
            return null;
        }

    }

    public DetalleAutomotorOutDTO consultarVehiculosMCSV(IdentificacionAutomotorDTO identificacionAutomotor, String usuario, String pass) {
        try { // Call Web Service Operation
            ServicioConsultaRUNT_Service service = new ServicioConsultaRUNT_Service();
            ServicioConsultaRUNT port = service.getServicioConsultaRUNTSoapHttpPort();
            // TODO initialize WS operation arguments here
            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t, declaredType_t, scope_t, tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);
            modelo.Model.userHandler = usuario;
            modelo.Model.passUserHandler = pass;
            DetalleAutomotorOutDTO result = port.consultarAutomotoresPorSerieMotorChasisVIN(header, identificacionAutomotor);
            return result;
        } catch (Exception ex) {
            //      ex.printStackTrace();
            return null;
        }
    }

    public StatusDTO verificarEstadoWS() {

        try { // Call Web Service Operation
            ServicioConsultaRUNT_Service service = new ServicioConsultaRUNT_Service();
            ServicioConsultaRUNT port = service.getServicioConsultaRUNTSoapHttpPort();
            // TODO initialize WS operation arguments here
            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t, declaredType_t, scope_t, tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);
            // TODO process result here
            StatusDTO result = port.verificarEstadoWS(header);

            return result;
        } catch (Exception ex) {
            //       ex.printStackTrace();
            return null;
        }

    }

    public ConsultaRegistroGarantiasPreRegistradasOutDTO consultarPrendasPreRegistrada(String placa) {
        try {
            ServicioConsultaRUNT_Service service = new ServicioConsultaRUNT_Service();
            ServicioConsultaRUNT port = service.getServicioConsultaRUNTSoapHttpPort();

            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t, declaredType_t, scope_t, tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);

            ConsultaRegistroGarantiasPreRegistradasInDTO preRegistrada = new ConsultaRegistroGarantiasPreRegistradasInDTO();
            preRegistrada.setNumeroPlaca(placa);

            return port.consultarRegistroGarantiasPreRegistradas(header, preRegistrada);

        } catch (Exception e) {
            System.out.println("Error en ConsultaRegistroGarantiasPreRegistradasOutDTO \n " + e);
            e.printStackTrace();
        }
        return null;
    }//End Main 

}
