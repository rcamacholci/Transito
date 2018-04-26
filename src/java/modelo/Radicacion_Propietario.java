/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Javier
 */
import java.io.*;
import java.sql.*;
public class Radicacion_Propietario implements Serializable {
   private long id_radicacion_propietario,fk_formulario,fk_persona;
   private float porcentaje;
   String tipoPropiedad,proIndiviso;
    public long getFk_formulario() {
        return fk_formulario;
    }

    public void setFk_formulario(long fk_formulario) {
        this.fk_formulario = fk_formulario;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    }

    public long getId_radicacion_propietario() {
        return id_radicacion_propietario;
    }

    public void setId_radicacion_propietario(long id_radicacion_propietario) {
        this.id_radicacion_propietario = id_radicacion_propietario;
    }

    public float getPorcentaje() {
        return porcentaje;
    }

    public void setPorcentaje(float porcentaje) {
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

    public static Radicacion_Propietario load (ResultSet rs)throws SQLException{
        
        Radicacion_Propietario rad_propietario =new Radicacion_Propietario();
        rad_propietario.setId_radicacion_propietario(rs.getLong(1));
        rad_propietario.setFk_formulario(rs.getLong(2));
        rad_propietario.setFk_persona(rs.getLong(3));
        rad_propietario.setPorcentaje(rs.getFloat(4));
        rad_propietario.setTipoPropiedad(rs.getString(5));
        rad_propietario.setProIndiviso(rs.getString(6));
       return rad_propietario;
    }
}
