/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;

/**
 *
 * @author Administrador
 */
public class Liquidacion_Cia {

    private long id_liquidacion_cia;
    private String numero;
    private int estado;
    private float valor;
    private long fk_comparendo;
    private long fk_persona;
    private long fk_usuario;
    private String referencia;
    private Date fecha;
    private java.sql.Timestamp fecha_proceso;
    private long fk_sede;
    private Date fecha_pago;

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Timestamp getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Timestamp fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public long getFk_comparendo() {
        return fk_comparendo;
    }

    public void setFk_comparendo(long fk_comparendo) {
        this.fk_comparendo = fk_comparendo;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
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

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getId_liquidacion_cia() {
        return id_liquidacion_cia;
    }

    public void setId_liquidacion_cia(long id_liquidacion_cia) {
        this.id_liquidacion_cia = id_liquidacion_cia;
    }

    public Date getFecha_pago() {
        return fecha_pago;
    }

    public void setFecha_pago(Date fecha_pago) {
        this.fecha_pago = fecha_pago;
    }

    public static Liquidacion_Cia load(java.sql.ResultSet rs) throws SQLException{
        Liquidacion_Cia liquidacionCia = new Liquidacion_Cia();
        liquidacionCia.setId_liquidacion_cia(rs.getLong(1));
        liquidacionCia.setNumero(rs.getString(2));
        liquidacionCia.setValor(rs.getFloat(3));
        liquidacionCia.setFk_comparendo(rs.getLong(4));
        liquidacionCia.setFk_persona(rs.getLong(5));
        liquidacionCia.setFecha_proceso(rs.getTimestamp(6));
        liquidacionCia.setFecha(rs.getDate(7));
        liquidacionCia.setFk_usuario(rs.getLong(8));
        liquidacionCia.setReferencia(rs.getString(9));
        liquidacionCia.setFk_sede(rs.getLong(10));
        liquidacionCia.setEstado(rs.getInt(11));
        liquidacionCia.setFecha_pago(rs.getDate(12));
        return liquidacionCia;
    }
}
