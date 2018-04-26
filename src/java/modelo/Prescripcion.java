/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author Administrador
 */
public class Prescripcion {

    private long id_prescripcion;
    private String numero;
    private java.sql.Date fecha;
    private long fk_vehiculo;
    private long fk_persona;
    private int vigencia_inicial;
    private int vigencia_final;
    private String observaciones;
    private long fk_usuario;
    private java.sql.Timestamp fecha_proceso;
    private int estado;

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Timestamp getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Timestamp fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getFk_vehiculo() {
        return fk_vehiculo;
    }

    public void setFk_vehiculo(long fk_vehiculo) {
        this.fk_vehiculo = fk_vehiculo;
    }

    public long getId_prescripcion() {
        return id_prescripcion;
    }

    public void setId_prescripcion(long id_prescripcion) {
        this.id_prescripcion = id_prescripcion;
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

    public int getVigencia_final() {
        return vigencia_final;
    }

    public void setVigencia_final(int vigencia_final) {
        this.vigencia_final = vigencia_final;
    }

    public int getVigencia_inicial() {
        return vigencia_inicial;
    }

    public void setVigencia_inicial(int vigencia_inicial) {
        this.vigencia_inicial = vigencia_inicial;
    }

     public static Prescripcion load(java.sql.ResultSet rs)throws Exception{
        Prescripcion prescripcion = new Prescripcion();
        prescripcion.setId_prescripcion(rs.getLong(1));
        prescripcion.setNumero(rs.getString(2));
        prescripcion.setFecha(rs.getDate(3));
        prescripcion.setFk_vehiculo(rs.getLong(4));
        prescripcion.setFk_persona(rs.getLong(5));
        prescripcion.setVigencia_inicial(rs.getInt(6));
        prescripcion.setVigencia_final(rs.getInt(7));
        prescripcion.setObservaciones(rs.getString(8));
        prescripcion.setFk_usuario(rs.getLong(9));
        prescripcion.setFecha_proceso(rs.getTimestamp(10));
        prescripcion.setEstado(rs.getInt(11));
        return prescripcion;
    }

}