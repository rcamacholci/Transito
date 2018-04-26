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
public class Audiencias implements Serializable {
   private long id_Audiencia,fk_comparendo,fk_agente,estado,fk_usuario,fk_inspector;
   private java.sql.Date fecha;
   private String hora;

    public long getId_Audiencia() {
        return id_Audiencia;
    }

    public void setId_Audiencia(long id_Audiencia) {
        this.id_Audiencia = id_Audiencia;
    }

    public long getFk_comparendo() {
        return fk_comparendo;
    }

    public void SetFk_comparendo(long fk_comparendo) {
        this.fk_comparendo = fk_comparendo;
    }

    public long getFk_agente() {
        return fk_agente;
    }

    public void SetFk_agente(long fk_agente) {
        this.fk_agente = fk_agente;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void SetFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getFk_inspector() {
        return fk_inspector;
    }

    public void SetFk_inspector(long fk_inspector) {
        this.fk_inspector = fk_inspector;
    }

    public String getHora() {
        return hora;
    }

    public void SetHora(String hora) {
        this.hora = hora;
    }


    public long getEstado() {
        return estado;
    }

    public void SetEstado(long estado) {
        this.estado = estado;
    }



    public java.sql.Date getFecha() {
        return fecha;
    }

    public void setFecha(java.sql.Date impreso) {
        this.fecha = impreso;
    }




    public static Audiencias load(ResultSet rs)throws SQLException{

        Audiencias aud = new Audiencias();
            aud.setId_Audiencia(rs.getLong(1));
            aud.SetFk_comparendo(rs.getLong(2));
            aud.SetFk_agente(rs.getLong(3));
            aud.setFecha(rs.getDate(4));
            aud.SetHora(rs.getString(5));
            aud.SetEstado(rs.getLong(6));
            aud.SetFk_inspector(rs.getLong(7));
            aud.SetFk_usuario(rs.getLong(8));
            
        return aud;
    }
}
