/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Javier
 */

import java.sql.*;
public class Radicacion {
private long id_radicacion ,fk_persona,fk_sede,fk_usuario;
private int estado;
private String numero,observaciones;
private java.sql.Date fecha;

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public java.sql.Date getFecha() {
        return fecha;
    }

    public void setFecha(java.sql.Date fecha) {
        this.fecha = fecha;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    }

    public long getId_radicacion() {
        return id_radicacion;
    }

    public void setId_radicacion(long id_radicacion) {
        this.id_radicacion = id_radicacion;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public static Radicacion load(ResultSet rs)throws SQLException{
        Radicacion radicacion = new Radicacion();
        radicacion.setId_radicacion(rs.getLong(1));
        radicacion.setNumero(rs.getString(2)); 
        radicacion.setFk_persona(rs.getLong(3));
        radicacion.setFk_sede(rs.getLong(4));
        radicacion.setFk_usuario(rs.getLong(5));
        radicacion.setEstado(rs.getInt(6));
        radicacion.setObservaciones(rs.getString(7));
        radicacion.setFecha(rs.getDate(8));
        return radicacion;
    }

}
