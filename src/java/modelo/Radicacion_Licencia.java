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
public class Radicacion_Licencia {
private long id_radicacion_licencia ,fk_persona,fk_sede,fk_usuario;
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

    public long getId_radicacion_licencia() {
        return id_radicacion_licencia;
    }

    public void setId_radicacion_licencia(long id_radicacion_licencia) {
        this.id_radicacion_licencia = id_radicacion_licencia;
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

    public static Radicacion_Licencia load(ResultSet rs)throws SQLException{
        Radicacion_Licencia radicacionLicencia = new Radicacion_Licencia();
        radicacionLicencia.setId_radicacion_licencia(rs.getLong(1));
        radicacionLicencia.setNumero(rs.getString(2));
        radicacionLicencia.setFk_persona(rs.getLong(3));
        radicacionLicencia.setFk_sede(rs.getLong(4));
        radicacionLicencia.setFk_usuario(rs.getLong(5));
        radicacionLicencia.setEstado(rs.getInt(6));
        radicacionLicencia.setObservaciones(rs.getString(7));
        radicacionLicencia.setFecha(rs.getDate(8));
        return radicacionLicencia;
    }

}
