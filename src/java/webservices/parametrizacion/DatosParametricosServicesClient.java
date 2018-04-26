package webservices.parametrizacion;

import com.heinsohn.runt.param.client.*;
import com.heinsohn.runt.general.identificaciones.*;
import com.heinsohn.runt.general.param.*;
import javax.xml.bind.JAXBElement;
import javax.xml.namespace.QName;
/**
 *
 * @author Civitrans
 */
public class DatosParametricosServicesClient {
    
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

    public java.util.List<ParametroDTO> consultarTabla(String idTablaParametrica){

        try { // Call Web Service Operation
            DatosParametricosService_Service service = new DatosParametricosService_Service();
            DatosParametricosService port = service.getDatosParametricosServiceSOAP();
            // TODO initialize WS operation arguments here
            CommonHeaderDTO header = new CommonHeaderDTO();
            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);
            
            javax.xml.ws.Holder<com.heinsohn.runt.general.identificaciones.StatusDTO> status = new javax.xml.ws.Holder<com.heinsohn.runt.general.identificaciones.StatusDTO>();
            javax.xml.ws.Holder<com.heinsohn.runt.general.param.ParametrosOutDTO> out = new javax.xml.ws.Holder<com.heinsohn.runt.general.param.ParametrosOutDTO>();
            port.consultarTabla(header, idTablaParametrica, status, out);
            if(out!=null){
                if(out.value!=null){
                    return out.value.getParametros();
                }
            }
            return null;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public java.util.List<TablaParametricaDTO> consultarTablasParametricas(){

        try { // Call Web Service Operation
            DatosParametricosService_Service service = new DatosParametricosService_Service();
            DatosParametricosService port = service.getDatosParametricosServiceSOAP();
            // TODO initialize WS operation arguments here
            CommonHeaderDTO header = new CommonHeaderDTO();
            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);

            javax.xml.ws.Holder<com.heinsohn.runt.general.identificaciones.StatusDTO> status = new javax.xml.ws.Holder<com.heinsohn.runt.general.identificaciones.StatusDTO>();
            javax.xml.ws.Holder<com.heinsohn.runt.general.param.TablasParametricasOutDTO> out = new javax.xml.ws.Holder<com.heinsohn.runt.general.param.TablasParametricasOutDTO>();
            port.consultarTablasParametricas(header, status,out);
            if(out!=null){
                return out.value.getTablas();
            }
            return null;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

}
