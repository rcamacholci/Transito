/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * Author  : Jorge Lopez
 */

package modelo;

import java.sql.Timestamp;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Jorge Lopez
 */
public class Financiacion {
    private long id_financiacion;
    private long fk_usuario;
    private Date fecha;
    private String numero;
    private float valor;
    private int cuotas;
    private float cuota_inicial;
    private int periodo_gracia;
    private int estado;
    private Timestamp fecha_proceso;
    private String observacion;
    private long fk_vehiculo;
    private long fk_tipo_financiacion;
    private long fk_persona;
    private long fk_sede;

    public float getCuota_inicial() {
        return cuota_inicial;
    }

    public void setCuota_inicial(float cuota_inicial) {
        this.cuota_inicial = cuota_inicial;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }

    public int getCuotas() {
        return cuotas;
    }

    public void setCuotas(int cuotas) {
        this.cuotas = cuotas;
    }

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

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getFk_tipo_financiacion() {
        return fk_tipo_financiacion;
    }

    public void setFk_tipo_financiacion(long fk_tipo_financiacion) {
        this.fk_tipo_financiacion = fk_tipo_financiacion;
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

    public void setFk_vehiculo(long fk_vehiculol) {
        this.fk_vehiculo = fk_vehiculol;
    }

    public long getId_financiacion() {
        return id_financiacion;
    }

    public void setId_financiacion(long id_financiacion) {
        this.id_financiacion = id_financiacion;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public int getPeriodo_gracia() {
        return periodo_gracia;
    }

    public void setPeriodo_gracia(int periodo_gracia) {
        this.periodo_gracia = periodo_gracia;
    }

    public static Financiacion load(ResultSet rs)throws SQLException{
        Financiacion financiacion = new Financiacion();
        financiacion.setId_financiacion(rs.getLong(1));
        financiacion.setFk_usuario(rs.getLong(2));
        financiacion.setFecha(rs.getDate(3));
        financiacion.setNumero(rs.getString(4));
        financiacion.setValor(rs.getFloat(5));
        financiacion.setCuotas(rs.getInt(6));
        financiacion.setCuota_inicial(rs.getFloat(7));
        financiacion.setPeriodo_gracia(rs.getInt(8));
        financiacion.setEstado(rs.getInt(9));
        financiacion.setFecha_proceso(rs.getTimestamp(10));
        financiacion.setObservacion(rs.getString(11));
        financiacion.setFk_vehiculo(rs.getLong(12));
        financiacion.setFk_tipo_financiacion(rs.getLong(13));
        financiacion.setFk_persona(rs.getLong(14));
        financiacion.setFk_sede(rs.getLong(15));
        return financiacion;
        

    }

}

