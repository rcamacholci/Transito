/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author jjpadillag
 */
public class PagoOnline {
    private long id_pago_Online;
    private int estado;
    private float valor;
    private long fk_persona;
    private long fk_usuario;
    private String referencia;
    private Date fecha;
    private java.sql.Timestamp fecha_proceso;
    private long fk_vehiculo;
    private long fk_pago;

    public long getId_pago_Online() {
        return id_pago_Online;
    }

    public void setId_pago_Online(long id_pago_Online) {
        this.id_pago_Online = id_pago_Online;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
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

    public String getReferencia() {
        return referencia;
    }

    public void setReferencia(String referencia) {
        this.referencia = referencia;
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

    public long getFk_vehiculo() {
        return fk_vehiculo;
    }

    public void setFk_vehiculo(long fk_vehiculo) {
        this.fk_vehiculo = fk_vehiculo;
    }

    public long getFk_pago() {
        return fk_pago;
    }

    public void setFk_pago(long fk_pago) {
        this.fk_pago = fk_pago;
    }

    public static PagoOnline load(java.sql.ResultSet rs) throws Exception{
        PagoOnline pagoOnline = new PagoOnline();
        pagoOnline.setId_pago_Online(rs.getLong(1));
        pagoOnline.setFk_vehiculo(rs.getLong(2));
        pagoOnline.setFk_persona(rs.getLong(3));
        pagoOnline.setFk_pago(rs.getLong(4));
        pagoOnline.setReferencia(rs.getString(5));
        pagoOnline.setValor(rs.getFloat(6));
        pagoOnline.setFecha(rs.getDate(7));
        pagoOnline.setEstado(rs.getInt(8));
        pagoOnline.setFk_usuario(rs.getLong(9));
        pagoOnline.setFecha_proceso(rs.getTimestamp(10));

        return pagoOnline;
    }
}
