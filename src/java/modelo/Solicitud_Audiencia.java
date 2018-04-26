/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author acer
 */
import java.io.*;
import java.sql.*;
import java.*;
public class Solicitud_Audiencia {
    private long id_solicitud,fk_comparendo,fk_persona,fk_usuario,estado;
    private String consecutivo,radicacion;
    private Date fecha;
    public long getId_solicitud() {
        return id_solicitud;
    }

    public void setId_solicitud(long id_solicitud) {
        this.id_solicitud = id_solicitud;
    }

    public long getFk_comaprendo() {
        return fk_comparendo;
    }

    public void setFk_comaprendo(long fk_comparendo) {
        this.fk_comparendo = fk_comparendo;
    }

    public long getFk_persoan() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    }
    public long getFk_ususario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_ususario) {
        this.fk_usuario = fk_ususario;
    }

    public String getConsecutivo() {
        return consecutivo;
    }

    public void setConsecutivo(String consecutivo) {
        this.consecutivo = consecutivo;
    }

    public String getRadicacion() {
        return radicacion;
    }

    public void setRadicacion(String radicacion) {
        this.radicacion = radicacion;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date Fecha) {
        this.fecha =Fecha;
    }

    public void setEstado(long fk_persona) {
        this.estado = fk_persona;
    }
    public long getEstado() {
        return estado;
    }
   public static Solicitud_Audiencia load(ResultSet rs)throws SQLException{
        Solicitud_Audiencia rango= new Solicitud_Audiencia();
            rango.setId_solicitud(rs.getLong(1));
            rango.setConsecutivo(rs.getString(2));
            rango.setFk_comaprendo(rs.getLong(3));
            rango.setRadicacion(rs.getString(4));
            rango.setFk_usuario(rs.getLong(5));
            rango.setFk_persona(rs.getLong(6));
            rango.setFecha(rs.getDate(7));
            rango.setEstado(rs.getLong(8));
        return rango;
    }
}
