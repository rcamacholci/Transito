/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package inscripcion;

import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import modelo.Base64Coder;
import modelo.Biometrico;
import modelo.Direccion;
import modelo.Divipo;
import modelo.Persona;
import modelo.Model;

/**
 *
 * @author Administrador
 */
public class registrarPersonaRunt {

    Model model = null;

    public registrarPersonaRunt(Model model){
        this.model = model;
    }

    public Persona consultarPersona(int tipoDocumento,String documento){
        Persona persona = null;
        try {
            persona = model.consultarPersona(tipoDocumento, documento);
        } catch (SQLException ex) {
            Logger.getLogger(registrarPersonaRunt.class.getName()).log(Level.SEVERE, null, ex);
        }
        return persona;
    }

    public Direccion consultarDireccion(long fkPersona){
        java.util.List lista;
        try {
            lista = model.listado_direcciones_persona(fkPersona);
            if(lista.size()>0)
                return (Direccion)lista.get(0);
        } catch (SQLException ex) {
            Logger.getLogger(registrarPersonaRunt.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public byte[] consultarBiometrico(long fkPersona,String tipo){
        try {
            return model.consultarBiometricoTipoByte(fkPersona, tipo);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public String consultarMunicipio(long fkDivipo){

        try {
            if(fkDivipo!=0){
                Divipo divipo = model.getDivipo(fkDivipo);
                if(divipo!=null)
                    return Integer.parseInt(divipo.getCodigo())+"";
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return "";
    }

    public Biometrico consultarBiometrico(long fkPersona){
        try {
            return model.consultarBiometrico(fkPersona);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public void inscribirPersona(int tipo,String documento,String noLiquidacion){

        Persona persona = consultarPersona(tipo, documento);
        if(persona!=null){
            com.heinsohn.runt.general.solicitudes.InscribirPersonaNaturalInDTO radicarSolicitudOut = null;
            webservices.radicacion.RadicacionServicesClient radicacionService = new webservices.radicacion.RadicacionServicesClient();
            radicacionService.setTokenHuellaDigital(model.userToken);
            radicacionService.setUser(model.userHandler);
            String tipoDocumento = "";
            switch(persona.getTipo_documento()){
                case 1: tipoDocumento = "C";break;
                case 3: tipoDocumento = "E";break;
                case 4: tipoDocumento = "T";break;
                case 5: tipoDocumento = "P";break;
            }
            String numeroDoc = persona.getDocumento();
            String nombre1 = persona.getNombre_1();
            String nombre2 = persona.getNombre_2();
            String apellido1 = persona.getApellido_1();
            String apellido2 = persona.getApellido_2();
            String sex = persona.getSexo();
            String tiporh = persona.getGrupo_sanguineo()+persona.getRh();
            java.sql.Date fexpedicion = persona.getFecha_exp();
            java.sql.Date fnacimiento = persona.getFecha_nac();
            String municipioNac = consultarMunicipio(persona.getFk_lugar_nacimiento());
            String cel = persona.getCelular();
            String mail = persona.getEmail();
            java.util.List<com.heinsohn.runt.general.personas.DireccionDTO> direcciones = new java.util.LinkedList<com.heinsohn.runt.general.personas.DireccionDTO>();

            Direccion direccion = consultarDireccion(persona.getId_persona());
            if(direccion!=null){
                if(direccion.getDescripcion()!=null){
                    com.heinsohn.runt.general.personas.DireccionDTO dir = new com.heinsohn.runt.general.personas.DireccionDTO();
                    dir.setDireccion(direccion.getDescripcion());
                    dir.setTipoDireccion("CASA");
                    dir.setFax(null);
                    if(direccion.getTelefono()!=null)
                        dir.setTelefono(direccion.getTelefono());
                    if(direccion.getFk_divipo()!=0){
                        com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO dir_mun = new com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO();
                        dir_mun.setIdMunicipio(consultarMunicipio(direccion.getFk_divipo()));
                        dir.setMunicipio(dir_mun);
                    }
                    direcciones.add(dir);
                }
            }

            java.util.List<com.heinsohn.runt.general.solicitudes.MotivoRechazoHuellaDTO> rechazos = new java.util.LinkedList<com.heinsohn.runt.general.solicitudes.MotivoRechazoHuellaDTO>();

            Biometrico biometrico = consultarBiometrico(persona.getId_persona());
            if(biometrico!=null){

                java.util.List<com.heinsohn.runt.general.solicitudes.ImagenHuellaDedoDTO> huellas = new java.util.LinkedList<com.heinsohn.runt.general.solicitudes.ImagenHuellaDedoDTO>();
                byte[] huella1 = consultarBiometrico(persona.getId_persona(), "HUELLA1");
                if(huella1!=null){
                    com.heinsohn.runt.general.solicitudes.ImagenHuellaDedoDTO ImagenHuella1 = new com.heinsohn.runt.general.solicitudes.ImagenHuellaDedoDTO();
                    ImagenHuella1.setTipoDedo(biometrico.getDedo1()+"");
                    byte[] imageBytes = Base64Coder.decode(new String(huella1));
                    ImagenHuella1.setFotoHuella(imageBytes);
                    huellas.add(ImagenHuella1);
                }

                byte[] huella2 = consultarBiometrico(persona.getId_persona(), "HUELLA2");
                if(huella2!=null){
                    com.heinsohn.runt.general.solicitudes.ImagenHuellaDedoDTO ImagenHuella2 = new com.heinsohn.runt.general.solicitudes.ImagenHuellaDedoDTO();
                    ImagenHuella2.setTipoDedo(biometrico.getDedo2()+"");
                    byte[] imageBytes = Base64Coder.decode(new String(huella2));
                    ImagenHuella2.setFotoHuella(imageBytes);
                    huellas.add(ImagenHuella2);
                }

                byte[] foto = consultarBiometrico(persona.getId_persona(), "FOTO");
                byte[] imageFoto = null;
//                if(foto!=null)
  //                  imageFoto = Base64Coder.decode(new String(foto));

                byte[] template = consultarBiometrico(persona.getId_persona(), "TEMPLATE");
                String imageTemplate = "";
                if(template!=null)
                    imageTemplate = new String(template);

                byte[] firma = consultarBiometrico(persona.getId_persona(), "FIRMA");
                byte[] imageFirma = null;
                if(firma!=null)
                    imageFirma = Base64Coder.decode(new String(firma));

                byte[] bidimensional = consultarBiometrico(persona.getId_persona(), "BIDIMENSIONAL");
                byte[] imageBidimensional = null;

                String trama ="";
   //             if(bidimensional!=null)
     //               imageBidimensional = Base64Coder.decode(new String(bidimensional));

                com.heinsohn.runt.general.solicitudes.InscribirPersonaOutDTO inscripcion = radicacionService.inscribirPersonaNatural(tipoDocumento, numeroDoc, nombre1, nombre2, apellido1, apellido2, sex, tiporh,fexpedicion, fnacimiento, municipioNac, cel, mail, direcciones, rechazos,trama,noLiquidacion);
                if(inscripcion!=null){
                    if(inscripcion.getStatus()!=null){
                        if(inscripcion.getStatus().getStatusCode().equals("1")){
//                            try{
//                                java.io.File fileL = new java.io.File("C:\\Civitrans\\InscripcionesRUNT\\"+persona.getId_persona()+".pdf");
//                                java.io.FileOutputStream fos = new java.io.FileOutputStream(fileL.getAbsolutePath());
//                                fos.write(inscripcion.getCertificado());
//                                fos.close();
//                            }catch(Exception fxe){
//                            }
                            System.out.println(persona.getId_persona()+" : Inscrito");
                        }else{
                            System.out.println(persona.getId_persona()+" : "+inscripcion.getStatus().getStatusDesc());
                        }
                    }else{
                        System.out.println(persona.getId_persona()+" : No hay estatus");
                    }
                }else{
                    System.out.println(persona.getId_persona()+" : No hay services");
                }
            }
        }else{
            System.out.println("Persona no existe...");
        }
    }

    public void inscribirPersona(Persona p,Direccion d, String noLiquidacion){

        if(p!=null){
            com.heinsohn.runt.general.solicitudes.InscribirPersonaNaturalInDTO radicarSolicitudOut = null;
            webservices.radicacion.RadicacionServicesClient radicacionService = new webservices.radicacion.RadicacionServicesClient();
            radicacionService.setTokenHuellaDigital(model.userToken);
            radicacionService.setUser(model.userHandler);
            String tipoDocumento = "";
            switch(p.getTipo_documento()){
                case 1: tipoDocumento = "C";break;
                case 3: tipoDocumento = "E";break;
                case 4: tipoDocumento = "T";break;
                case 5: tipoDocumento = "P";break;
            }
            String numeroDoc = p.getDocumento();
            String nombre1 = p.getNombre_1();
            String nombre2 = p.getNombre_2();
            String apellido1 = p.getApellido_1();
            String apellido2 = p.getApellido_2();
            String sex = p.getSexo();
            String tiporh = p.getGrupo_sanguineo()+p.getRh();
            java.sql.Date fexpedicion = p.getFecha_exp();
            java.sql.Date fnacimiento = p.getFecha_nac();
            String municipioNac = consultarMunicipio(p.getFk_lugar_nacimiento());
            String cel = p.getCelular();
            String mail = p.getEmail();
            java.util.List<com.heinsohn.runt.general.personas.DireccionDTO> direcciones = new java.util.LinkedList<com.heinsohn.runt.general.personas.DireccionDTO>();

            if(d!=null){
                if(d.getDescripcion()!=null){
                    com.heinsohn.runt.general.personas.DireccionDTO dir = new com.heinsohn.runt.general.personas.DireccionDTO();
                    dir.setDireccion(d.getDescripcion());
                    dir.setTipoDireccion("CASA");
                    dir.setFax(null);
                    if(d.getTelefono()!=null)
                        dir.setTelefono(d.getTelefono());
                    if(d.getFk_divipo()!=0){
                        com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO dir_mun = new com.heinsohn.runt.general.identificaciones.IdentificadorGeografiaDTO();
                        dir_mun.setIdMunicipio(consultarMunicipio(d.getFk_divipo()));
                        dir.setMunicipio(dir_mun);
                    }
                    direcciones.add(dir);
                }
            }

            java.util.List<com.heinsohn.runt.general.solicitudes.MotivoRechazoHuellaDTO> rechazos = new java.util.LinkedList<com.heinsohn.runt.general.solicitudes.MotivoRechazoHuellaDTO>();

            Biometrico biometrico = consultarBiometrico(p.getId_persona());
            if(biometrico!=null){

                java.util.List<com.heinsohn.runt.general.solicitudes.ImagenHuellaDedoDTO> huellas = new java.util.LinkedList<com.heinsohn.runt.general.solicitudes.ImagenHuellaDedoDTO>();
                byte[] huella1 = consultarBiometrico(p.getId_persona(), "HUELLA1");
                if(huella1!=null){
                    com.heinsohn.runt.general.solicitudes.ImagenHuellaDedoDTO ImagenHuella1 = new com.heinsohn.runt.general.solicitudes.ImagenHuellaDedoDTO();
                    ImagenHuella1.setTipoDedo(biometrico.getDedo1()+"");
                    byte[] imageBytes = Base64Coder.decode(new String(huella1));
                    ImagenHuella1.setFotoHuella(imageBytes);
                    huellas.add(ImagenHuella1);
                }

                byte[] huella2 = consultarBiometrico(p.getId_persona(), "HUELLA2");
                if(huella2!=null){
                    com.heinsohn.runt.general.solicitudes.ImagenHuellaDedoDTO ImagenHuella2 = new com.heinsohn.runt.general.solicitudes.ImagenHuellaDedoDTO();
                    ImagenHuella2.setTipoDedo(biometrico.getDedo2()+"");
                    byte[] imageBytes = Base64Coder.decode(new String(huella2));
                    ImagenHuella2.setFotoHuella(imageBytes);
                    huellas.add(ImagenHuella2);
                }

                byte[] foto = consultarBiometrico(p.getId_persona(), "FOTO");
                byte[] imageFoto = null;
//                if(foto!=null)
  //                  imageFoto = Base64Coder.decode(new String(foto));

                byte[] template = consultarBiometrico(p.getId_persona(), "TEMPLATE");
                String imageTemplate = "";
                if(template!=null)
                    imageTemplate = new String(template);

                byte[] firma = consultarBiometrico(p.getId_persona(), "FIRMA");
                byte[] imageFirma = null;
                if(firma!=null)
                    imageFirma = Base64Coder.decode(new String(firma));

                byte[] bidimensional = consultarBiometrico(p.getId_persona(), "BIDIMENSIONAL");
                byte[] imageBidimensional = null;
   //             if(bidimensional!=null)
     //               imageBidimensional = Base64Coder.decode(new String(bidimensional));
                String trama="";

                com.heinsohn.runt.general.solicitudes.InscribirPersonaOutDTO inscripcion = radicacionService.inscribirPersonaNatural(tipoDocumento, numeroDoc, nombre1, nombre2, apellido1, apellido2, sex, tiporh,fexpedicion, fnacimiento, municipioNac, cel, mail, direcciones, rechazos,trama,noLiquidacion);
                if(inscripcion!=null){
                    if(inscripcion.getStatus()!=null){
                        if(inscripcion.getStatus().getStatusCode().equals("1")){

                            System.out.println(p.getId_persona()+" : Inscrito");
                        }else{
                            System.out.println(p.getId_persona()+" : "+inscripcion.getStatus().getStatusDesc());
                        }
                    }else{
                        System.out.println(p.getId_persona()+" : No hay estatus");
                    }
                }else{
                    System.out.println(p.getId_persona()+" : No hay services");
                }
            }
        }else{
            System.out.println("Persona no existe...");
        }
    }
}
