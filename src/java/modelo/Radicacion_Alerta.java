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
public class Radicacion_Alerta implements Serializable {
    private long id_radicacion_alerta,fk_formulario,fk_persona;
    private int alerta;
    private String observaciones;

    public int getAlerta() {
        return alerta;
    }

    public void setAlerta(int alerta) {
        this.alerta = alerta;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_emp_alerta) {
        this.fk_persona = fk_emp_alerta;
    }

    public long getFk_formulario() {
        return fk_formulario;
    }

    public void setFk_formulario(long fk_formulario) {
        this.fk_formulario = fk_formulario;
    }

    public long getId_radicacion_alerta() {
        return id_radicacion_alerta;
    }

    public void setId_radicacion_alerta(long id_radicacion_alerta) {
        this.id_radicacion_alerta = id_radicacion_alerta;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }
    
    public static Radicacion_Alerta load(ResultSet rs)throws SQLException{
        Radicacion_Alerta radicacion= new Radicacion_Alerta();
        
        radicacion.setId_radicacion_alerta(rs.getLong(1));
        radicacion.setFk_formulario(rs.getLong(2));
        radicacion.setFk_persona(rs.getLong(3));
        radicacion.setAlerta(rs.getInt(4));
        radicacion.setObservaciones(rs.getString(5));
        
        return radicacion;
    }
    

}
