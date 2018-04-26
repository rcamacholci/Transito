/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package inscripcion;

/**
 *
 * @author Administrador
 */
/**
 * @(#)deserializarPersonas.java
 *
 *
 * @author
 * @version 1.00 2010/12/29
 */
import java.io.*;
import modelo.Biometrico;
import modelo.Model;
import modelo.Direccion;
import modelo.Persona;

public class deserializarPersonas {

    public deserializarPersonas(Model model,String name,String noLiquidacion) throws Exception{
        File f = new File(name);
        FileInputStream fis = new FileInputStream(f);
        ObjectInputStream ois = new ObjectInputStream(fis);
        Inscripcion inscripcion = null;
        while((inscripcion=(Inscripcion)ois.readObject())!=null){
           Persona persona = new Persona();
           Direccion direccion = new Direccion();
           Biometrico biometrico = new Biometrico();

           persona.setFecha_nac(inscripcion.getFecha_nac());
           persona.setGrupo_sanguineo(inscripcion.getGrupo_sanguineo());
           persona.setRh(inscripcion.getRh());
           persona.setSexo(inscripcion.getSexo());
           persona.setNombre_1(inscripcion.getNombre_1());
           persona.setNombre_2(inscripcion.getNombre_2());
           persona.setApellido_1(inscripcion.getApellido_1());
           persona.setApellido_2(inscripcion.getApellido_2());
           persona.setTipo_documento(inscripcion.getTipo_documento());
           persona.setDocumento(inscripcion.getDocumento());
           persona.setFk_divipo(inscripcion.getFk_divipo());
           persona.setEmail(inscripcion.getEmail());
           persona.setCelular(inscripcion.getCelular());
           persona.setFk_lugar_nacimiento(inscripcion.getFk_lugar_nacimiento());
           persona.setFecha_exp(inscripcion.getFecha_exp());
           persona.setFecha_reg(inscripcion.getFecha_reg());

           direccion.setDescripcion(inscripcion.getDescripcion().replaceAll("N°", "#"));
           direccion.setUbicacion(inscripcion.getUbicacion());
           direccion.setFecha(inscripcion.getFecha());
           direccion.setEstado(inscripcion.getEstado());
           direccion.setFk_divipo(inscripcion.getFk_divipo_direccion());
           direccion.setTelefono(inscripcion.getTelefono());

           biometrico.setBidimensional(inscripcion.getBidimensional());
           biometrico.setFirma(inscripcion.getFirma());
           biometrico.setFoto(inscripcion.getFoto());
           biometrico.setDedo1(inscripcion.getDedo1());
           biometrico.setDedo2(inscripcion.getDedo2());
           biometrico.setHuella1(inscripcion.getHuella1());
           biometrico.setHuella2(inscripcion.getHuella2());
           biometrico.setTemplate(inscripcion.getTemplate());
           biometrico.setMotivoRechazo(inscripcion.getMotivoRechazo());

           Persona anteriorP = model.consultarPersona(persona.getTipo_documento(),persona.getDocumento());
           if(anteriorP==null){
               long idPersona = model.adicionarPersona(persona);
               if(idPersona!=0){
                   persona.setId_persona(idPersona);
                   direccion.setFk_persona(idPersona);
                   model.adicionarDireccion(direccion);

                   biometrico.setId_persona(idPersona);
                   model.actualizarBiometrico(biometrico);

                   inscripcion.registrarPersonaRunt registro = new inscripcion.registrarPersonaRunt(model);
                   System.out.println("registrando nueva persona "+persona.getId_persona()+" - "+persona.getDocumento());
                   registro.inscribirPersona(persona.getTipo_documento(), persona.getDocumento(),noLiquidacion);
               }
           }else{
               model.actualizarPersona(persona, anteriorP.getId_persona());
               direccion.setFk_persona(anteriorP.getId_persona());
               model.actualizarDireccion(direccion);

               biometrico.setId_persona(anteriorP.getId_persona());
               model.actualizarBiometrico(biometrico);

               inscripcion.registrarPersonaRunt registro = new inscripcion.registrarPersonaRunt(model);
               System.out.println("registrando vieja persona "+anteriorP.getId_persona()+" - "+persona.getDocumento());
               registro.inscribirPersona(persona.getTipo_documento(), persona.getDocumento(),noLiquidacion);
           }
        }
        ois.close();
        fis.close();
    }

}