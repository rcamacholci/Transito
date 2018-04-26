package webservices.common;

import com.heinsohn.runt.common.client.*;
import com.heinsohn.runt.general.consultas.*;
import com.heinsohn.runt.general.identificaciones.*;
import javax.xml.bind.JAXBElement;
import javax.xml.namespace.QName;
/**
 *
 * @author Civitrans
 */
public class CommonServicesClient {
    
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

    public ConsultarTemplateHuellaDigitalOutDTO consultarTemplateHuellaDigital(String tipoDocumento,String numeroDocumento){
        try { // Call Web Service Operation
            CommonService_Service service = new CommonService_Service();
            CommonService port = service.getCommonServiceSOAP();

            modelo.Model.userHandler = "";
            modelo.Model.passUserHandler = "";

            // TODO initialize WS operation arguments here
            CommonHeaderDTO header = new CommonHeaderDTO();
            ConsultarTemplateHuellaDigitalInDTO in = new ConsultarTemplateHuellaDigitalInDTO();

            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);

            IdentificacionPersonaDTO persona = new IdentificacionPersonaDTO();
            persona.setTipoDocumento(tipoDocumento);
            persona.setNumeroDocumento(numeroDocumento);

            javax.xml.namespace.QName name_PS = new javax.xml.namespace.QName("http://consultas.general.runt.heinsohn.com","persona");
            java.lang.Class<IdentificacionPersonaDTO> declaredType_PS = IdentificacionPersonaDTO.class;
            java.lang.Class scope_PS = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<IdentificacionPersonaDTO> jax_PS = new JAXBElement<IdentificacionPersonaDTO>(name_PS,declaredType_PS,scope_PS,persona);
            in.setPersona(jax_PS);
            // TODO process result here

            ConsultarTemplateHuellaDigitalOutDTO result = port.consultarTemplateHuellaDigital(header, in);
            return result;
        } catch (Exception ex) {
            //ex.printStackTrace();
            return null;
        }
        // TODO handle custom exceptions here aqui estan todos los servcios del ws common
    }

     public ConsultarTokenValidacionBiometricaOutDTO consultarParametroValidacionBiometrica(String tipoDocumento,String numeroDocumento,String tipoPersona){
     
             try { // Call Web Service Operation
                CommonService_Service service = new CommonService_Service();
                CommonService port = service.getCommonServiceSOAP();

                // TODO initialize WS operation arguments here
                CommonHeaderDTO header = new CommonHeaderDTO();
                ConsultarTokenValidacionBiometricaInDTO in = new ConsultarTokenValidacionBiometricaInDTO();

                QName name_t = new QName("tokenHuellaDigital");
                Class<String> declaredType_t = String.class;
                Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
                JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
                header.setTokenHuellaDigital(jaxb_t);
                header.setUsuario(user);

                IdentificacionPersonaDTO persona = new IdentificacionPersonaDTO();
                persona.setIdPersona(null);
                persona.setTipoDocumento(tipoDocumento);
                persona.setNumeroDocumento(numeroDocumento);
                
                in.setPersona(persona);
                if(tipoPersona.equals("1")){
                    in.setTipoFuncionario("WS_FUNCIONARIO");
                }else{
                    if(tipoPersona.equals("2")){
                        in.setTipoFuncionario("WS_CIUDADANO");
                    }
                }
              
                ConsultarParametroValidacionBiometricaRequest parameters = new ConsultarParametroValidacionBiometricaRequest();
                parameters.setHeader(header);
                parameters.getTokenAutorizacion().add(in);
      // TODO process result here
                 com.heinsohn.runt.common.client.ConsultarParametroValidacionBiometricaResponse result =  port.consultarParametroValidacionBiometrica(parameters);
               
                 //System.out.println("Result = "+result.getParametroValidacionBiometrica().getStatus().getStatusDesc());
                 return  result.getParametroValidacionBiometrica();
             } catch (Exception ex) {
                 System.out.println("Error :");
                // System.out.println("Error : "+result.getParametroValidacionBiometrica().getStatus().getStatusDesc());
                ex.printStackTrace();
                 
                  return null;
                    
                 // TODO handle custom exceptions here
             }
     }


     public ConsultarTemplateHuellaDigitalOutDTO consultarTemplateHuellaDigitalUsuario(String tipoDocumento,String numeroDocumento){

         try {

            com.heinsohn.runt.common.client.CommonService_Service service = new com.heinsohn.runt.common.client.CommonService_Service();
            com.heinsohn.runt.common.client.CommonService port = service.getCommonServiceSOAP();
            // TODO initialize WS operation arguments here

            com.heinsohn.runt.general.identificaciones.CommonHeaderDTO hdr = new com.heinsohn.runt.general.identificaciones.CommonHeaderDTO();
            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
            hdr.setTokenHuellaDigital(jaxb_t);
            hdr.setUsuario(user);

            java.lang.String loginUsuario = numeroDocumento;
            // TODO process result here
            com.heinsohn.runt.general.consultas.ConsultarTemplateHuellaDigitalOutDTO result = port.consultarTemplateHuellaDigitalUsuario(hdr, loginUsuario);
            return result;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
            // TODO handle custom exceptions here
        }

    }

    public VerificarEstadoDTO verificarEstadoWS(){
     try { // Call Web Service Operation
         com.heinsohn.runt.common.client.CommonService_Service service = new com.heinsohn.runt.common.client.CommonService_Service();
         com.heinsohn.runt.common.client.CommonService port = service.getCommonServiceSOAP();
         // TODO initialize WS operation arguments here
         com.heinsohn.runt.general.identificaciones.CommonHeaderDTO header = new com.heinsohn.runt.general.identificaciones.CommonHeaderDTO();
         QName name_t = new QName("tokenHuellaDigital");
         Class<String> declaredType_t = String.class;
         Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
         JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
         header.setTokenHuellaDigital(jaxb_t);
         header.setUsuario(user);
         // TODO process result here
         com.heinsohn.runt.general.identificaciones.VerificarEstadoDTO result = port.verificarEstadoWS(header);
         return result;
     } catch (Exception ex) {
         ex.printStackTrace();
         return null;
     }
         // TODO handle custom exceptions here
     }

      public PrevalidarTokenBiometricoOutDTO prevalidarTokenBiometrico(String tipoDocumento,String numeroDocumento,String tipoPersona,String trama){

          try { // Call Web Service Operation
              com.heinsohn.runt.common.client.CommonService_Service service = new com.heinsohn.runt.common.client.CommonService_Service();
              com.heinsohn.runt.common.client.CommonService port = service.getCommonServiceSOAP();
              // TODO initialize WS operation arguments here

              com.heinsohn.runt.general.identificaciones.CommonHeaderDTO header = new com.heinsohn.runt.general.identificaciones.CommonHeaderDTO();
              QName name_t = new QName("tokenHuellaDigital");
              Class<String> declaredType_t = String.class;
              Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
              JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
              header.setTokenHuellaDigital(jaxb_t);
              header.setUsuario(user);

              com.heinsohn.runt.general.consultas.PrevalidarTokenBiometricoInDTO in = new com.heinsohn.runt.general.consultas.PrevalidarTokenBiometricoInDTO();

               IdentificacionPersonaDTO persona = new IdentificacionPersonaDTO();
                
                persona.setTipoDocumento(tipoDocumento);
                persona.setNumeroDocumento(numeroDocumento);
                in.setPersona(persona);
                if(tipoPersona.equals("1")){
                    in.setTipoFuncionario("WS_FUNCIONARIO");
                }else{
                    if(tipoPersona.equals("2")){
                        in.setTipoFuncionario("WS_CIUDADANO");
                    }
                }
                in.setTrama(trama);
                in.setUserName(user);

              com.heinsohn.runt.common.client.PrevalidarTokenBiometricoRequest parameters = new com.heinsohn.runt.common.client.PrevalidarTokenBiometricoRequest();
              parameters.setHeader(header);
              parameters.getPersona().add(in);
              com.heinsohn.runt.common.client.PrevalidarTokenBiometricoResponse result = port.prevalidarTokenBiometrico(parameters);
              System.out.println("Result = "+result.getParametroValidacionBiometrica().getStatus().getStatusDesc());
              return result.getParametroValidacionBiometrica();
          } catch (Exception ex) {
              return null;
              // TODO handle custom exceptions here
          }
 
     }

public ConsultarTokenEnrolamientoBiometricoOutDTO consultarParametroEnrolamientoBiometrico(String tipoDocumento,String numeroDocumento,String biograficos,String foto,String huellas,String firma){

    try { // Call Web Service Operation
        com.heinsohn.runt.common.client.CommonService_Service service = new com.heinsohn.runt.common.client.CommonService_Service();
        com.heinsohn.runt.common.client.CommonService port = service.getCommonServiceSOAP();
        // TODO initialize WS operation arguments here

        com.heinsohn.runt.general.identificaciones.CommonHeaderDTO header = new com.heinsohn.runt.general.identificaciones.CommonHeaderDTO();
        QName name_t = new QName("tokenHuellaDigital");
        Class<String> declaredType_t = String.class;
        Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
        JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
        header.setTokenHuellaDigital(jaxb_t);
        header.setUsuario(user);

        com.heinsohn.runt.general.consultas.ConsultarTokenEnrolamientoBiometricoInDTO in = new com.heinsohn.runt.general.consultas.ConsultarTokenEnrolamientoBiometricoInDTO();
        com.heinsohn.runt.general.consultas.ConsultarTokenEnrolamientoBiometricoOutDTO out = new com.heinsohn.runt.general.consultas.ConsultarTokenEnrolamientoBiometricoOutDTO();
       
        IdentificacionPersonaDTO persona = new IdentificacionPersonaDTO();

        persona.setTipoDocumento(tipoDocumento);
        persona.setNumeroDocumento(numeroDocumento);
        in.setPersona(persona);
        in.setCapturarBiograficos(biograficos);
        in.setCapturarFirmaDigitalizada(firma);
        in.setCapturarFoto(foto);
        in.setCapturarHuellas(huellas);
        in.setTipoFuncionario("WS_CIUDADANO");

        com.heinsohn.runt.common.client.ConsultarParametroEnrolamientoBiometricoRequest parameters = new com.heinsohn.runt.common.client.ConsultarParametroEnrolamientoBiometricoRequest();
        // TODO process result here

        parameters.setHeader(header);
        parameters.setTokenEnrolamiento(in);
        com.heinsohn.runt.common.client.ConsultarParametroEnrolamientoBiometricoResponse result = port.consultarParametroEnrolamientoBiometrico(parameters);
        System.out.println("Result = "+result);
        return result.getParametroEnrolamientoBiometria();
    } catch (Exception ex) {
        return null;
        // TODO handle custom exceptions here
    }


}



}
