package webservices.bancos;

import com.heinsohn.runt.bancos.client.*;
import com.heinsohn.runt.bancos.client.types.*;
import com.heinsohn.runt.general.bancos.ConsultarLiquidacionesBancosInDTO;
import com.heinsohn.runt.general.identificaciones.*;
import javax.xml.bind.JAXBElement;
import javax.xml.namespace.QName;

/**
 *
 * @author Civitrans
 */
public class BancosServicesClient {

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

    public void registrarPago(){

        try { // Call Web Service Operation
            BancosService_Service service = new BancosService_Service();
            BancosService port = service.getBancosServiceSoapHttpPort();
            // TODO initialize WS operation arguments here
            RegistrarPagoElement parameters = new RegistrarPagoElement();

            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);

            parameters.setHeader(header);

            com.heinsohn.runt.general.bancos.RegistrarPagoBancosInDTO pagoBanco = new com.heinsohn.runt.general.bancos.RegistrarPagoBancosInDTO();
            parameters.setRegistrarPagoBancosIn(null);
            // TODO process result here
            RegistrarPagoResponseElement result = port.registrarPago(parameters);
        } catch (Exception ex) {
            // TODO handle custom exceptions here
        }

    }

    public StatusDTO verificarEstadoWS(){

        try { // Call Web Service Operation
            BancosService_Service service = new BancosService_Service();
            BancosService port = service.getBancosServiceSoapHttpPort();
            // TODO initialize WS operation arguments here
            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);

            header.setUsuario(user);
            StatusDTO result = port.verificarEstadoWS(header);
            return result;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }

    }

    public String consultarLiquidacionCUPL(String numeroLiquidacion){

        try { // Call Web Service Operation
            BancosService_Service service = new BancosService_Service();
            BancosService port = service.getBancosServiceSoapHttpPort();
            // TODO initialize WS operation arguments here
            ConsultarLiquidacionesBancosElement parameters = new ConsultarLiquidacionesBancosElement();

            CommonHeaderDTO header = new CommonHeaderDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);

            header.setUsuario(user);

            parameters.setHeader(header);
            ConsultarLiquidacionesBancosInDTO liquidacion = new ConsultarLiquidacionesBancosInDTO();
            liquidacion.setNumeroLiquidacionRUNT(numeroLiquidacion);
            parameters.setConsultarIn(liquidacion);
            // TODO process result here
            ConsultarLiquidacionesBancosResponseElement result = port.consultarLiquidacionesBancos(parameters);
            if(result!=null){
                if(result.getResult()!=null){
                    if(result.getResult().getStatus().getStatusCode().equals("1")){
                        return result.getResult().getLiquidacion().getValue().getEstado();
                    }else{
                        return "NO_EXISTE";
                    }
                }
            }
            return "NO_ACCESO";
        } catch (Exception ex) {
  //          ex.printStackTrace();
            return "NO_ACCESO";
        }

    }

}