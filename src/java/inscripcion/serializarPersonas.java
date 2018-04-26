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
 * @(#)serializarPersonas.java
 *
 *
 * @author
 * @version 1.00 2010/12/29
 */
import java.io.*;
import modelo.Biometrico;
import modelo.Direccion;
import modelo.Model;
import modelo.Persona;

public class serializarPersonas {

    public serializarPersonas(Model model,int inicio,int fin)throws Exception {

        File f = new File(inicio+"-"+fin+".data");
        FileOutputStream fos = new FileOutputStream(f);
        ObjectOutputStream oos = new ObjectOutputStream(fos);
        for(int i=inicio;i<=fin;i++){
                Inscripcion inscripcion = new Inscripcion();
                Persona persona = model.consultarPersona(i);
                Direccion direccion = model.consultarDireccion(i);
                Biometrico biometrico = model.consultarBiometrico(i);
                if(persona!=null&&direccion!=null&&biometrico!=null){
                   inscripcion.setId_inscripcion(persona.getId_persona());
                   inscripcion.setFecha_nac(persona.getFecha_nac());
                   inscripcion.setGrupo_sanguineo(persona.getGrupo_sanguineo());
                   inscripcion.setRh(persona.getRh());
                   inscripcion.setSexo(persona.getSexo());
                   inscripcion.setNombre_1(persona.getNombre_1());
                   inscripcion.setNombre_2(persona.getNombre_2());
                   inscripcion.setApellido_1(persona.getApellido_1());
                   inscripcion.setApellido_2(persona.getApellido_2());
                   inscripcion.setTipo_documento(persona.getTipo_documento());
                   inscripcion.setDocumento(persona.getDocumento());
                   inscripcion.setFk_divipo(persona.getFk_divipo());
                   inscripcion.setEmail(persona.getEmail());
                   inscripcion.setCelular(persona.getCelular());
                   inscripcion.setFk_lugar_nacimiento(persona.getFk_lugar_nacimiento());
                   inscripcion.setFecha_exp(persona.getFecha_exp());
                   inscripcion.setFecha_reg(persona.getFecha_reg());
                   inscripcion.setDescripcion(direccion.getDescripcion());
                   inscripcion.setUbicacion(direccion.getUbicacion());
                   inscripcion.setFecha(direccion.getFecha());
                   inscripcion.setEstado(direccion.getEstado());
                   inscripcion.setFk_divipo_direccion(direccion.getFk_divipo());
                   inscripcion.setTelefono(direccion.getTelefono());
                   inscripcion.setBidimensional(biometrico.getBidimensional());
                   inscripcion.setFirma(biometrico.getFirma());
                   inscripcion.setFoto(biometrico.getFoto());
                   inscripcion.setDedo1(biometrico.getDedo1());
                   inscripcion.setDedo2(biometrico.getDedo2());
                   inscripcion.setHuella1(biometrico.getHuella1());
                   inscripcion.setHuella2(biometrico.getHuella2());
                   inscripcion.setTemplate(biometrico.getTemplate());
                   inscripcion.setMotivoRechazo(biometrico.getMotivoRechazo());
                   oos.writeObject(inscripcion);

                }
        }
        oos.close();
        fos.close();

    }

}