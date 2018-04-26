package webservices.liquidacion;

import com.heinsohn.runt.general.identificaciones.*;
import com.heinsohn.runt.general.personas.*;
import com.heinsohn.runt.general.solicitudes.*;
import com.heinsohn.runt.liquidacion.client.*;
import com.heinsohn.runt.liquidacion.client.types.*;
import java.util.GregorianCalendar;
import javax.xml.bind.JAXBElement;
import javax.xml.datatype.XMLGregorianCalendar;
import javax.xml.namespace.QName;

/**
 *
 * @author Civitrans
 */
public class LiquidacionServicesClient {

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

    public LiquidacionOutDTO registrarLiquidacion(String placa, String identificadorAT, String nombreAT, String clasificacion, java.sql.Date fecha_liquidacion, boolean generaPDF, String id_persona, String tipoDocumento, String numeroDocumento, String numeroLiquidacion, String tipoLiquidacion, double valorOT, java.util.List<String[]> tramites, int cantidad, String multiL, String usuario, String pass) {

        try { // Call Web Service Operation
            LiquidacionService_Service service = new LiquidacionService_Service();
            LiquidacionService port = service.getLiquidacionServiceSoapHttpPort();

            // TODO initialize WS operation arguments here
            RegistrarLiquidacionElement parameters = new RegistrarLiquidacionElement();

            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t, declaredType_t, scope_t, tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);
            parameters.setHeader(header);

            RegistrarLiquidacionInDTO registrar_liquidacion_in = new RegistrarLiquidacionInDTO();

            registrar_liquidacion_in.setNumeroLiquidacionOT(numeroLiquidacion);

            registrar_liquidacion_in.setValorOT(valorOT);

            registrar_liquidacion_in.setCantidad(cantidad);
            registrar_liquidacion_in.setMultiliquidacion(multiL);

            IdentificacionPersonaDTO identificacion_persona = new IdentificacionPersonaDTO();
            identificacion_persona.setIdPersona(id_persona);
            identificacion_persona.setTipoDocumento(tipoDocumento);
            identificacion_persona.setNumeroDocumento(numeroDocumento);

            registrar_liquidacion_in.setPersonaUtilizaLiquidacion(identificacion_persona);
            registrar_liquidacion_in.setPlacaUtilizaLiquidacion(placa);

            QName name_ip = new QName("http://solicitudes.general.runt.heinsohn.com", "idSolictante");
            Class<IdentificacionPersonaDTO> declaredType_ip = IdentificacionPersonaDTO.class;
            Class scope_ip = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<IdentificacionPersonaDTO> jaxb_identificacionPersona = new JAXBElement(name_ip, declaredType_ip, scope_ip, identificacion_persona);
            registrar_liquidacion_in.setIdSolictante(jaxb_identificacionPersona);

            registrar_liquidacion_in.setClasificacion(clasificacion);

            AutoridadTransitoDTO autoridad_transito = new AutoridadTransitoDTO();
            autoridad_transito.setIdentificador(identificadorAT);
            autoridad_transito.setNombreAutoridadTransito(nombreAT);

            QName name_at = new QName("http://solicitudes.general.runt.heinsohn.com", "autoridadTransito");
            Class<AutoridadTransitoDTO> declaredType_at = AutoridadTransitoDTO.class;
            Class scope_at = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<AutoridadTransitoDTO> jaxb_autoridadTransito = new JAXBElement(name_at, declaredType_at, scope_at, autoridad_transito);

            registrar_liquidacion_in.setAutoridadTransito(jaxb_autoridadTransito);

            GregorianCalendar gc = new GregorianCalendar();
            gc.setTime(fecha_liquidacion);
            XMLGregorianCalendar fecha_registro = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gc);
            registrar_liquidacion_in.setFechaRegistro(fecha_registro);

            QName name_b = new QName("generaReciboPDF");
            Class<Boolean> declaredType_b = Boolean.class;
            Class scope_b = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<Boolean> jaxb_b = new JAXBElement(name_b, declaredType_b, scope_b, generaPDF);
            registrar_liquidacion_in.setGeneraReciboPDF(jaxb_b);
            
            QName name_s = new QName("tipoLiquidacion");
            Class<String> declaredType_s = String.class;
            Class scope_s = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_s = new JAXBElement(name_s, declaredType_s, scope_s, tipoLiquidacion);
            registrar_liquidacion_in.setTipoLiquidacion(jaxb_s);

            for (int i = 0; i < tramites.size(); i++) {
                TramiteLiquidacionDTO tramite = new TramiteLiquidacionDTO();
                String[] dupla = tramites.get(i);
                tramite.setCodigoTipoTramite(dupla[0]);
                tramite.setIdTarifaAplicada(dupla[1]);
                registrar_liquidacion_in.getTramites().add(tramite);
            }

            parameters.setLiquidacion(registrar_liquidacion_in);
            modelo.Model.userHandler = usuario;
            modelo.Model.passUserHandler = pass;
            RegistrarLiquidacionResponseElement result = port.registrarLiquidacion(parameters);
            LiquidacionOutDTO liquidacion_out = result.getResult();

            return liquidacion_out;

        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }

    }

    public LiquidacionOutDTO consultarDatosLiquidacion(String numero_liquidacion) {

        try { // Call Web Service Operation
            LiquidacionService_Service service = new LiquidacionService_Service();
            LiquidacionService port = service.getLiquidacionServiceSoapHttpPort();
            // TODO initialize WS operation arguments here
            ConsultarDatosLiquidacionElement parameters = new ConsultarDatosLiquidacionElement();

            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t, declaredType_t, scope_t, tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);

            header.setUsuario(user);
            parameters.setHeader(header);

            ConsultaLiquidacionINDTO consulta_liquidacion_in = new ConsultaLiquidacionINDTO();
            consulta_liquidacion_in.setNumeroLiquidacion(numero_liquidacion);
            parameters.setConsultaLiquidacionInDTO(consulta_liquidacion_in);
            // TODO process result here
            ConsultarDatosLiquidacionResponseElement result = port.consultarDatosLiquidacion(parameters);
            LiquidacionOutDTO liquidacion_out = result.getResult();

            return liquidacion_out;

        } catch (Exception ex) {
            //ex.printStackTrace();
            return null;
        }

    }

    public StatusDTO verificarEstadoWS() {

        try { // Call Web Service Operation
            LiquidacionService_Service service = new LiquidacionService_Service();
            LiquidacionService port = service.getLiquidacionServiceSoapHttpPort();
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
            //ex.printStackTrace();
            return null;
        }

    }

    public LiquidacionProcesoTransversalOutDTO registrarLiquidacionProcesoTransversal(String identificadorAT, String nombreAT, int cantidad, String tipoConcepto, String id_persona,String tipoDocumento,String numeroDocumento,String usuario,String pass) {
        
        try{
        LiquidacionService_Service service = new LiquidacionService_Service();
        LiquidacionService port = service.getLiquidacionServiceSoapHttpPort();
        RegistrarLiquidacionProcesoTransversalElement parameters = new RegistrarLiquidacionProcesoTransversalElement();
        
        CommonHeaderDTO header = new CommonHeaderDTO();

        QName name_t = new QName("tokenHuellaDigital");
        Class<String> declaredType_t = String.class;
        Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
        JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
        header.setTokenHuellaDigital(jaxb_t);
        header.setUsuario(user);
        parameters.setHeader(header);
        
        RegistrarLiquidacionProcesoTransversalInDTO registrar_in = new RegistrarLiquidacionProcesoTransversalInDTO();
        
        AutoridadTransitoDTO autoridad_transito = new AutoridadTransitoDTO();
        autoridad_transito.setIdentificador(identificadorAT);
        autoridad_transito.setNombreAutoridadTransito(nombreAT);

        QName name_at = new QName("http://solicitudes.general.runt.heinsohn.com","autoridadTransito");
        Class<AutoridadTransitoDTO> declaredType_at = AutoridadTransitoDTO.class;
        Class scope_at = javax.xml.bind.JAXBElement.GlobalScope.class;
        JAXBElement<AutoridadTransitoDTO> jaxb_autoridadTransito = new JAXBElement(name_at,declaredType_at,scope_at,autoridad_transito);
        
        registrar_in.setAutoridadTransito(jaxb_autoridadTransito);
        registrar_in.setCantidad(cantidad);
        
        IdentificacionPersonaDTO identificacion_persona = new IdentificacionPersonaDTO();
        identificacion_persona.setIdPersona("1");
        identificacion_persona.setTipoDocumento(tipoDocumento);
        identificacion_persona.setNumeroDocumento(numeroDocumento);
            
        QName name_ip = new QName("http://solicitudes.general.runt.heinsohn.com","solicitante");
        Class<IdentificacionPersonaDTO> declaredType_ip = IdentificacionPersonaDTO.class;
        Class scope_ip = javax.xml.bind.JAXBElement.GlobalScope.class;
        JAXBElement<IdentificacionPersonaDTO> jaxb_identificacionPersona = new JAXBElement(name_ip,declaredType_ip,scope_ip,identificacion_persona);
        
        registrar_in.setSolicitante(jaxb_identificacionPersona);
        registrar_in.setTipoConcepto(tipoConcepto);
        parameters.setLiquidacion(registrar_in);
        
        modelo.Model.userHandler = usuario;
        modelo.Model.passUserHandler = pass;
        RegistrarLiquidacionProcesoTransversalResponseElement result = port.registrarLiquidacionProcesoTransversal(parameters);
        LiquidacionProcesoTransversalOutDTO liquidacionOutDTO = result.getResult();

        return liquidacionOutDTO;
        
        }catch(Exception ex){
            ex.printStackTrace();
        }
        return null;
    }

}
