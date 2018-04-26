/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package webservices.registrar;

import com.heinsohn.runt.general.identificaciones.*;
import com.heinsohn.runt.general.registroinformacion.*;
import com.heinsohn.runt.registroinformacion.client.*;
import javax.xml.bind.JAXBElement;
import javax.xml.namespace.QName;
/**
 *
 * @author WALTER AGUAS MACIAS
 */
public class RegistrarInformacionServiceClient {

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

    public StatusDTO registrarActadeImportacionDetalleVehiculo(java.sql.Date fechaL,java.sql.Date fechaM,String numero_PersonaImport,String tipoDoc_PersonaImport,String Num_Manifiesto,String Num_Levante,String pais,String tipo_Registro,InformacionVehiculoActaImportacionDTO info_Vehiculo,String usuario,String pass){
    try { // Call Web Service Operation
        RegistrarInformacionService_Service service = new RegistrarInformacionService_Service();
        com.heinsohn.runt.registroinformacion.client.RegistrarInformacionService port = service.getRegistrarInformacionServiceSOAP();
        // TODO initialize WS operation arguments here
        CommonHeaderDTO header = new CommonHeaderDTO();
        QName name_t = new QName("tokenHuellaDigital");
        Class<String> declaredType_t = String.class;
        Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
        JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
        header.setTokenHuellaDigital(jaxb_t);
        header.setUsuario(user);
        RegistrarActaImportacionDetalleVehiculoInDTO in = new RegistrarActaImportacionDetalleVehiculoInDTO();
        InformacionGeneralActaImportacionDTO importacion = new InformacionGeneralActaImportacionDTO();
        if(fechaL!=null){
        java.util.GregorianCalendar fl = new java.util.GregorianCalendar();
        fl.setTime(new java.sql.Date(fechaL.getTime()));
        javax.xml.datatype.XMLGregorianCalendar fechaLe = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fl);
        importacion.setFechaLevante(fechaLe);
        }
        if(fechaM!=null){
        java.util.GregorianCalendar fm = new java.util.GregorianCalendar();
        fm.setTime(new java.sql.Date(fechaM.getTime()));
        javax.xml.datatype.XMLGregorianCalendar fechaMI = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fm);
        importacion.setFechaManifiestoImportacionDeclaracionAduana(fechaMI);
        }

        IdentificacionPersonaDTO importador = new IdentificacionPersonaDTO();
        if(numero_PersonaImport!=null)
        importador.setNumeroDocumento(numero_PersonaImport);
        if(tipoDoc_PersonaImport!=null)
        importador.setTipoDocumento(tipoDoc_PersonaImport);

        importacion.setImportador(importador);

        if(Num_Manifiesto!=null)
        importacion.setNumeroActaManifiestoImportacionDeclaracionAduana(Num_Manifiesto);

        if(Num_Levante!=null)
        importacion.setNumeroLevante(Num_Levante);

        QName name_po = new QName("paisOrigen");
        Class<String> declaredType_po = String.class;
        Class scope_po = javax.xml.bind.JAXBElement.GlobalScope.class;
        JAXBElement<String> jaxb_po = new JAXBElement(name_po,declaredType_po,scope_po,pais);
        importacion.setPaisOrigen(jaxb_po);

        if(tipo_Registro!=null)
            importacion.setTipoRegistro(tipo_Registro);

        in.setInformacionGeneralActaImportacion(importacion);
        in.setInformacionVehiculoActaImportacion(info_Vehiculo);
         modelo.Model.userHandler = usuario;
         modelo.Model.passUserHandler = pass;

        // TODO process result here
        com.heinsohn.runt.general.identificaciones.StatusDTO result = port.registrarActaImportacionDetalleVehiculo(header, in);
        return result;
    } catch (Exception ex) {
        com.heinsohn.runt.general.identificaciones.StatusDTO statusDTO = new com.heinsohn.runt.general.identificaciones.StatusDTO();
        statusDTO.setStatusCode("0");
        statusDTO.setStatusDesc(ex.getMessage());
        return statusDTO;
    }
}

    public void solicitarCambioDatosPersona(String tipoDocAnterior,String documentoAnterior,String tipoDocNuevo,String documentoNuevo,java.sql.Date fechaExpedicionNuevo,String tipoCambio){

        try { // Call Web Service Operation
            com.heinsohn.runt.registroinformacion.client.RegistrarInformacionService_Service service = new com.heinsohn.runt.registroinformacion.client.RegistrarInformacionService_Service();
            com.heinsohn.runt.registroinformacion.client.RegistrarInformacionService port = service.getRegistrarInformacionServiceSOAP();
            // TODO initialize WS operation arguments here
            com.heinsohn.runt.general.identificaciones.CommonHeaderDTO header = new com.heinsohn.runt.general.identificaciones.CommonHeaderDTO();
            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);

            com.heinsohn.runt.general.registroinformacion.SolicitarCambioDocumentoDatosPersonaInDTO in = new com.heinsohn.runt.general.registroinformacion.SolicitarCambioDocumentoDatosPersonaInDTO();

            IdentificacionPersonaDTO solicitante = new IdentificacionPersonaDTO();
            solicitante.setNumeroDocumento(documentoAnterior);
            solicitante.setTipoDocumento(tipoDocAnterior);
            in.setSolicitante(solicitante);

            in.setTipoCambio(tipoCambio);
            in.setTipoIdentificacionNueva(tipoDocNuevo);
            in.setNumeroIdentificacionNueva(documentoNuevo);

            java.util.GregorianCalendar fexp = new java.util.GregorianCalendar();
            fexp.setTime(fechaExpedicionNuevo);
            javax.xml.datatype.XMLGregorianCalendar fechaExp = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fexp);
            in.setFechaExpedicionNuevoDocumento(fechaExp);
            // TODO process result here
            com.heinsohn.runt.general.identificaciones.StatusDTO result = port.solicitarCambioDocumentoDatosPersona(header, in);
            System.out.println("Result = "+result);
        } catch (Exception ex) {
            // TODO handle custom exceptions here
        }
   }
    
    public void registrarNumeroFthAutomotor(String placa,String fthChasis,String fthCarroceria){

        try { // Call Web Service Operation
            com.heinsohn.runt.registroinformacion.client.RegistrarInformacionService_Service service = new com.heinsohn.runt.registroinformacion.client.RegistrarInformacionService_Service();
            com.heinsohn.runt.registroinformacion.client.RegistrarInformacionService port = service.getRegistrarInformacionServiceSOAP();
            // TODO initialize WS operation arguments here
            com.heinsohn.runt.general.identificaciones.CommonHeaderDTO header = new com.heinsohn.runt.general.identificaciones.CommonHeaderDTO();
            QName name_t = new QName("tokenHuellaDigital");
            Class<String> declaredType_t = String.class;
            Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
            JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
            header.setTokenHuellaDigital(jaxb_t);
            header.setUsuario(user);


            com.heinsohn.runt.general.registroinformacion.RegistrarNumeroFthAutomotorInDTO in = new com.heinsohn.runt.general.registroinformacion.RegistrarNumeroFthAutomotorInDTO();

            in.setNumeroPlaca(placa);
            in.setNroFth(fthChasis);
            in.setNroFthCarroceria(fthCarroceria);

            // TODO process result here
            com.heinsohn.runt.general.identificaciones.StatusDTO result = port.registrarNumeroFthAutomotor(header, in);
            System.out.println("Result = "+result);
        } catch (Exception ex) {
            // TODO handle custom exceptions here
        }

    }



     public StatusDTO registrarCertificadoRegistroRNRYS(java.sql.Date fechaL,java.sql.Date fechaM,String numero_PersonaImport,String tipoDoc_PersonaImport,String Num_Manifiesto,String Num_Levante,IdentificacionAutomotorDTO info_Vehiculo,int modeloV,int marca,int linea,int clase,int ejes,int llantas,String carroceria,String condicionM,String origenV,String fichaT,int capacidad,String certificadoR,java.sql.Date fechaCR,String usuario,String pass){
    try { // Call Web Service Operation

        RegistrarInformacionService_Service service = new RegistrarInformacionService_Service();
        com.heinsohn.runt.registroinformacion.client.RegistrarInformacionService port = service.getRegistrarInformacionServiceSOAP();

        CommonHeaderDTO header = new CommonHeaderDTO();
        com.heinsohn.runt.general.registroinformacion.InformacionCertificadoRegistroInDTO in = new com.heinsohn.runt.general.registroinformacion.InformacionCertificadoRegistroInDTO();

        QName name_t = new QName("tokenHuellaDigital");
        Class<String> declaredType_t = String.class;
        Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
        JAXBElement<String> jaxb_t = new JAXBElement(name_t,declaredType_t,scope_t,tokenHuellaDigital);
        header.setTokenHuellaDigital(jaxb_t);
        header.setUsuario(user);
        if(fechaL!=null){
        java.util.GregorianCalendar fl = new java.util.GregorianCalendar();
        fl.setTime(new java.sql.Date(fechaL.getTime()));
        javax.xml.datatype.XMLGregorianCalendar fechaLe = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fl);
       // in.setFechaLevante(fechaLe);
        }
        if(fechaM!=null){
        java.util.GregorianCalendar fm = new java.util.GregorianCalendar();
        fm.setTime(new java.sql.Date(fechaM.getTime()));
        javax.xml.datatype.XMLGregorianCalendar fechaMI = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fm);
        //in.setFechaAceptacion(fechaMI);
        }

        in.setNumeroCertificadoRegistro(certificadoR);
        if(fechaCR!=null){
        java.util.GregorianCalendar fc = new java.util.GregorianCalendar();
        fc.setTime(new java.sql.Date(fechaCR.getTime()));
        javax.xml.datatype.XMLGregorianCalendar fechaR = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(fc);
        in.setFechaCertificadoRemolque(fechaR);
        }


        IdentificacionPersonaDTO carrocero = new IdentificacionPersonaDTO();
        if(numero_PersonaImport!=null)
        carrocero.setNumeroDocumento(numero_PersonaImport);
        if(tipoDoc_PersonaImport!=null)
        carrocero.setTipoDocumento(tipoDoc_PersonaImport);
        in.setCarrocero(carrocero);

        if(Num_Manifiesto!=null)
        in.setNumeroAceptacion(Num_Manifiesto);

        if(Num_Levante!=null)
        in.setNumeroLevante(Num_Levante);

        in.setActaImportacion(true);
        in.setModelo(modeloV);
        in.setMarcaRemolque(marca);
        in.setReferencia(linea);
        in.setIdClaseVehiculo(clase);
        in.setNumeroEjes(ejes);
        in.setNumeroLlantas(llantas);
        in.setTipoCarroceria(carroceria);
        in.setCondicionMovilidad(condicionM);
        in.setFichaTecnica(fichaT);
        in.setOrigenVehiculo(origenV);
        in.setCapacidad(capacidad);
        in.setPesoVacio(6000.0);
        



        in.setVehiculo(info_Vehiculo);
         modelo.Model.userHandler = usuario;
         modelo.Model.passUserHandler = pass;

        // TODO process result here
         com.heinsohn.runt.general.identificaciones.StatusDTO result = port.registrarCertificadoRegistroRNRYS(header, in);
           System.out.println("Result = "+result);

        return result;
    } catch (Exception ex) {
        com.heinsohn.runt.general.identificaciones.StatusDTO statusDTO = new com.heinsohn.runt.general.identificaciones.StatusDTO();
        statusDTO.setStatusCode("0");
        statusDTO.setStatusDesc(ex.getMessage());
        return statusDTO;
    }
}




}

