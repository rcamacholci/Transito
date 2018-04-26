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
public class auditoria_comparendo {
private long id_auditoria_comparendo,fk_estado,fk_comparendo,usuario,estado;
private Timestamp fecha_inicio, fecha_fin,fecha_proceso;
//private String nit,clase,codigo,nombre_corto,telefono;
    public void setId_auditoria_comparendo(long fk_organismo) {
        this.id_auditoria_comparendo = fk_organismo;
    }

    public long getId_auditoria_comparendo() {
        return id_auditoria_comparendo;
    }

    public void setFk_estado(long fk_organismo) {
        this.fk_estado = fk_organismo;
    }

    public long getFk_estado() {
        return fk_estado;
    }

    public void setUsuario(long fk_organismo) {
        this.usuario = fk_organismo;
    }

    public long getUsuario() {
        return usuario;
    }

    public void setEstado(long fk_organismo) {
        this.estado = fk_organismo;
    }

    public long getEstado() {
        return estado;
    }

    public void setFk_comparendo(long fk_organismo) {
        this.fk_comparendo = fk_organismo;
    }

    public long getFk_comaprendo() {
        return fk_comparendo;
    }


    public void setFecha_inicio(Timestamp fk_organismo) {
        this.fecha_inicio = fk_organismo;
    }

    public Timestamp getFecha_inicio(){
        return fecha_inicio;
    }

    public void setFecha_fin(Timestamp fk_organismo) {
        this.fecha_fin = fk_organismo;
    }

    public Timestamp getFecha_fin(){
        return fecha_fin;
    }

    public void setFecha_proceso(Timestamp fk_organismo) {
        this.fecha_proceso = fk_organismo;
    }

    public Timestamp getFecha_proceso(){
        return fecha_proceso;
    }
   public static auditoria_comparendo Load(ResultSet rs)throws SQLException{
       auditoria_comparendo sede=new auditoria_comparendo();
       sede.setId_auditoria_comparendo(rs.getLong(1));
       sede.setFk_comparendo(rs.getLong(2));
       sede.setFk_estado(rs.getLong(8));
       sede.setFecha_proceso(rs.getTimestamp(3));
       sede.setUsuario(rs.getLong(4));
       sede.setEstado(rs.getLong(5));
       sede.setFecha_inicio(rs.getTimestamp(6));
       sede.setFecha_fin(rs.getTimestamp(7));
       return sede;
   }
}
