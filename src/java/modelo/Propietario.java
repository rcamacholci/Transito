/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.Date;
import java.io.* ;
/**
 *
 * @author Civitrans
 */
public class Propietario implements Serializable {
    private long id_propietario;
    private long fk_persona;
    private long fk_vehiculo;
    private Date fecha_inicio;
    private Date fecha_final;
    private int porcentaje;
    private String tipoPropiedad;
    private String proIndiviso;
    private long fk_usuario;
    

    public Date getFecha_final() {
        return fecha_final;
    }

    public void setFecha_final(Date fecha_final) {
        this.fecha_final = fecha_final;
    }

    public Date getFecha_inicio() {
        return fecha_inicio;
    }

    public void setFecha_inicio(Date fecha_inicio) {
        this.fecha_inicio = fecha_inicio;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    }

    public long getFk_vehiculo() {
        return fk_vehiculo;
    }

    public void setFk_vehiculo(long fk_vehiculo) {
        this.fk_vehiculo = fk_vehiculo;
    }

    public long getId_propietario() {
        return id_propietario;
    }

    public void setId_propietario(long id_propietario) {
        this.id_propietario = id_propietario;
    }

    public int getPorcentaje() {
        return porcentaje;
    }

    public void setPorcentaje(int porcentaje) {
        this.porcentaje = porcentaje;
    }

    public String getProIndiviso() {
        return proIndiviso;
    }

    public void setProIndiviso(String proIndiviso) {
        this.proIndiviso = proIndiviso;
    }

    public String getTipoPropiedad() {
        return tipoPropiedad;
    }

    public void setTipoPropiedad(String tipoPropiedad) {
        this.tipoPropiedad = tipoPropiedad;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }



    public static Propietario load(java.sql.ResultSet rs)throws java.sql.SQLException{
        Propietario propietario = new Propietario();
        propietario.setId_propietario(rs.getLong(1));
        propietario.setPorcentaje(rs.getInt(2));
        propietario.setFecha_inicio(rs.getDate(3));
        propietario.setFecha_final(rs.getDate(4));
        propietario.setFk_persona(rs.getLong(5));
        propietario.setFk_vehiculo(rs.getLong(6));
        propietario.setTipoPropiedad(rs.getString(7));
        propietario.setProIndiviso(rs.getString(8));
        propietario.setFk_usuario(rs.getLong(9));
        
        return propietario;
    }
     
    
}
