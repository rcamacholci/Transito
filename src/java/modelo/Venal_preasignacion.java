/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author administrador
 */
public class Venal_preasignacion {

    private long id_venal_preasignacion, fk_venal, fk_usuario;
    private java.sql.Date fecha, fecha_proceso, fecha_ini, fecha_fin;

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Date getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Date fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getFk_venal() {
        return fk_venal;
    }

    public void setFk_venal(long fk_venal) {
        this.fk_venal = fk_venal;
    }

    public long getId_venal_preasignacion() {
        return id_venal_preasignacion;
    }

    public void setId_venal_preasignacion(long id_venal_preasignacion) {
        this.id_venal_preasignacion = id_venal_preasignacion;
    }

    public Date getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public Date getFecha_ini() {
        return fecha_ini;
    }

    public void setFecha_ini(Date fecha_ini) {
        this.fecha_ini = fecha_ini;
    }



    public static Venal_preasignacion load(ResultSet rs)throws SQLException{
          Venal_preasignacion venal = new Venal_preasignacion();
          venal.setId_venal_preasignacion(rs.getLong(1));
          venal.setFk_venal(rs.getLong(2));
          venal.setFk_usuario(rs.getLong(3));
          venal.setFecha(rs.getDate(4));
          venal.setFecha_proceso(rs.getDate(5));
          venal.setFecha_ini(rs.getDate(6));
          venal.setFecha_fin(rs.getDate(7));
          return venal;
  }

}
