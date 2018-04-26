/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.io.Serializable;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

/**
 *
 * @author Administrador
 */
public class Inscripciones implements Serializable{
private long  ID_INSCRIPCION,FK_USUARIO,FK_PERSONA;
private int ESTADO;
private java.sql.Timestamp FECHA_REGISTRO;

    public int getESTADO() {
        return ESTADO;
    }

    public void setESTADO(int ESTADO) {
        this.ESTADO = ESTADO;
    }

    public Timestamp getFECHA_REGISTRO() {
        return FECHA_REGISTRO;
    }

    public void setFECHA_REGISTRO(Timestamp FECHA_REGISTRO) {
        this.FECHA_REGISTRO = FECHA_REGISTRO;
    }

    public long getFK_PERSONA() {
        return FK_PERSONA;
    }

    public void setFK_PERSONA(long FK_PERSONA) {
        this.FK_PERSONA = FK_PERSONA;
    }

    public long getFK_USUARIO() {
        return FK_USUARIO;
    }

    public void setFK_USUARIO(long FK_USUARIO) {
        this.FK_USUARIO = FK_USUARIO;
    }

    public long getID_INSCRIPCION() {
        return ID_INSCRIPCION;
    }

    public void setID_INSCRIPCION(long ID_INSCRIPCION) {
        this.ID_INSCRIPCION = ID_INSCRIPCION;
    }

    public static Inscripciones load(ResultSet rs)throws SQLException{
        Inscripciones inscp = new Inscripciones();

        inscp.setID_INSCRIPCION(rs.getLong(1));
        inscp.setFECHA_REGISTRO(rs.getTimestamp(2));
        inscp.setFK_USUARIO(rs.getLong(3));
        inscp.setESTADO(rs.getInt(4));
        inscp.setFK_PERSONA(rs.getLong(5));
        return inscp;

    }




}
