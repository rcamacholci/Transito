/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author Flia. Aguas Macias
 */
public class Embargo {
    private long id_embargo,fk_persona,fk_usuario,fk_oficina,fk_vehiculo,fk_sede,fk_divipo;
    //tipo grupo 41
    private int tipo,proceso;
    private java.sql.Date fecha_oficio,fecha_levantamiento,fecha_radicacion;
    private java.sql.Timestamp fecha_proceso;
    private String observaciones,oficio,nro_levantamiento,demandante,nro_radicacion;

    public Date getFecha_levantamiento() {
        return fecha_levantamiento;
    }

    public void setFecha_levantamiento(Date fecha_levantamiento) {
        this.fecha_levantamiento = fecha_levantamiento;
    }
     public Date getFecha_radicacion() {
        return fecha_radicacion;
    }

    public void setFecha_radicacion(Date fecha_radicacion) {
        this.fecha_radicacion = fecha_radicacion;
    }


    public Date getFecha_oficio() {
        return fecha_oficio;
    }

    public void setFecha_oficio(Date fecha_oficio) {
        this.fecha_oficio = fecha_oficio;
    }

    public Timestamp getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Timestamp fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public long getFk_oficina() {
        return fk_oficina;
    }

    public void setFk_oficina(long fk_oficina) {
        this.fk_oficina = fk_oficina;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
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

    public long getFk_vehiculo() {
        return fk_vehiculo;
    }

    public void setFk_vehiculo(long fk_vehiculo) {
        this.fk_vehiculo = fk_vehiculo;
    }

    public long getId_embargo() {
        return id_embargo;
    }

    public void setId_embargo(long id_embargo) {
        this.id_embargo = id_embargo;
    }

    public String getNro_levantamiento() {
        return nro_levantamiento;
    }

    public void setNro_levantamiento(String nro_levantamiento) {
        this.nro_levantamiento = nro_levantamiento;
    }

    public String getNro_radicacion() {
        return nro_radicacion;
    }

    public void setNro_radicacion(String nro_radicacion) {
        this.nro_radicacion = nro_radicacion;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public String getOficio() {
        return oficio;
    }

    public void setOficio(String oficio) {
        this.oficio = oficio;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    public int getProceso() {
        return proceso;
    }

    public void setProceso(int proceso) {
        this.proceso = proceso;
    }

    public long getFk_divipo() {
        return fk_divipo;
    }

    public void setFk_divipo(long fk_divipo) {
        this.fk_divipo = fk_divipo;
    }

    public String getDemandante() {
        return demandante;
    }

    public void setDemandante(String demandante) {
        this.demandante = demandante;
    }
    
    public static Embargo load(java.sql.ResultSet rs)throws java.sql.SQLException{
        Embargo embargo = new Embargo();
        embargo.setId_embargo(rs.getLong(1));
        embargo.setFk_persona(rs.getLong(2));
        embargo.setFk_usuario(rs.getLong(3));
        embargo.setProceso(rs.getInt(4));
        embargo.setTipo(rs.getInt(5));
        embargo.setFecha_oficio(rs.getDate(6));
        embargo.setOficio(rs.getString(7));
        embargo.setNro_levantamiento(rs.getString(8));
        embargo.setFecha_levantamiento(rs.getDate(9));
        embargo.setObservaciones(rs.getString(10));
        embargo.setFecha_proceso(rs.getTimestamp(11));
        embargo.setFk_oficina(rs.getLong(12));
        embargo.setFk_vehiculo(rs.getLong(13));
        embargo.setFk_sede(rs.getLong(14));
        embargo.setFk_divipo(rs.getLong(15));
        embargo.setDemandante(rs.getString(16));
        embargo.setNro_radicacion(rs.getString(17));
        embargo.setFecha_radicacion(rs.getDate(18));
        return embargo;
    }
}

