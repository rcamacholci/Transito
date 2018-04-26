/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package webservices.sincronizacion;

import com.heinsohn.runt.general.consultas.*;
import com.heinsohn.runt.sinc.client.*;
import com.heinsohn.runt.general.identificaciones.*;
import com.heinsohn.runt.general.sincronizacion.*;
import javax.xml.bind.JAXBElement;
import javax.xml.namespace.QName;
/**
 *
 * @author Civitrans
 */
public class SincronizacionServiceClient {

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

    public StatusDTO actualizarDatosAutomotor(SincronizarAutomotorDTO in){

        try { // Call Web Service Operation
            SincronizacionService_Service service = new SincronizacionService_Service();
            SincronizacionService port = service.getSincronizacionServiceSOAP();
            // TODO initialize WS operation arguments here
            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);

            // TODO process result here
            StatusDTO result = port.actualizarDatosAutomotor(header, in);
            return result;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public StatusDTO actualizarConductor(ConductorDTO in){

        try { // Call Web Service Operation
            SincronizacionService_Service service = new SincronizacionService_Service();
            SincronizacionService port = service.getSincronizacionServiceSOAP();
            // TODO initialize WS operation arguments here
            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);

            // TODO process result here
            com.heinsohn.runt.general.identificaciones.StatusDTO result = port.actualizarDatosConductor(header, in);
            return result;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }

    }

    public StatusDTO verificarEstadoWS(){

        try { // Call Web Service Operation
            SincronizacionService_Service service = new SincronizacionService_Service();
            SincronizacionService port = service.getSincronizacionServiceSOAP();
            // TODO initialize WS operation arguments here
            CommonHeaderDTO header = new CommonHeaderDTO();// TODO process result here
            com.heinsohn.runt.general.identificaciones.StatusDTO result = port.verificarEstadoWS(header);
            return result;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }

    }

}

