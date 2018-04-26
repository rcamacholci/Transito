/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.Timestamp;

/**
 *
 * @author Administrador
 */
public class Saldo_Favor {

    private long id_saldo_favor;
    private String numero;
    private long fk_persona;
    private int tipo;
    private float valor;
    private String referencia;
    private int estado;
    private java.sql.Date fecha;
    private java.sql.Timestamp fecha_proceso;
    private long fk_usuario;
    private String resolucion;
    private java.sql.Date fecha_resolucion;
    private java.sql.Timestamp fecha_devolucion;
    private long fk_usuario_devolucion;
    private String observacion;

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

    public Timestamp getFecha_devolucion() {
        return fecha_devolucion;
    }

    public void setFecha_devolucion(Timestamp fecha_devolucion) {
        this.fecha_devolucion = fecha_devolucion;
    }

    public Timestamp getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Timestamp fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public Date getFecha_resolucion() {
        return fecha_resolucion;
    }

    public void setFecha_resolucion(Date fecha_resolucion) {
        this.fecha_resolucion = fecha_resolucion;
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

    public long getFk_usuario_devolucion() {
        return fk_usuario_devolucion;
    }

    public void setFk_usuario_devolucion(long fk_usuario_devolucion) {
        this.fk_usuario_devolucion = fk_usuario_devolucion;
    }

    public long getId_saldo_favor() {
        return id_saldo_favor;
    }

    public void setId_saldo_favor(long id_saldo_favor) {
        this.id_saldo_favor = id_saldo_favor;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public String getReferencia() {
        return referencia;
    }

    public void setReferencia(String referencia) {
        this.referencia = referencia;
    }

    public String getResolucion() {
        return resolucion;
    }

    public void setResolucion(String resolucion) {
        this.resolucion = resolucion;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public static Saldo_Favor load(ResultSet rs)throws java.sql.SQLException{
        Saldo_Favor saldoFavor = new Saldo_Favor();
        saldoFavor.setId_saldo_favor(rs.getLong(1));
        saldoFavor.setNumero(rs.getString(2));
        saldoFavor.setFk_persona(rs.getLong(3));
        saldoFavor.setTipo(rs.getInt(4));
        saldoFavor.setValor(rs.getFloat(5));
        saldoFavor.setReferencia(rs.getString(6));
        saldoFavor.setEstado(rs.getInt(7));
        saldoFavor.setFecha(rs.getDate(8));
        saldoFavor.setFecha_proceso(rs.getTimestamp(9));
        saldoFavor.setFk_usuario(rs.getLong(10));
        saldoFavor.setResolucion(rs.getString(11));
        saldoFavor.setFecha_resolucion(rs.getDate(12));
        saldoFavor.setFecha_devolucion(rs.getTimestamp(13));
        saldoFavor.setFk_usuario_devolucion(rs.getLong(14));
        saldoFavor.setObservacion(rs.getString(15));
        return saldoFavor;
    }
}
