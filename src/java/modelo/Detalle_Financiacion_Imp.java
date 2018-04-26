/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Javier
 */

import java.io.*;
import java.sql.*;
public class Detalle_Financiacion_Imp implements Serializable {

    private long id_det_financiacion_imp,fk_financiacion,fk_cartera;
    private Date fecha_pago;
    private Timestamp fecha_proceso;
    private int cuota,estado;
    private float valor,saldo,intereses;

    public int getCuota() {
        return cuota;
    }

    public void setCuota(int cuota) {
        this.cuota = cuota;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Date getFecha_pago() {
        return fecha_pago;
    }

    public void setFecha_pago(Date fecha_pago) {
        this.fecha_pago = fecha_pago;
    }

    public Timestamp getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Timestamp fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public long getFk_cartera() {
        return fk_cartera;
    }

    public void setFk_cartera(long fk_cartera) {
        this.fk_cartera = fk_cartera;
    }

    public long getFk_financiacion() {
        return fk_financiacion;
    }

    public void setFk_financiacion(long fk_financiacion) {
        this.fk_financiacion = fk_financiacion;
    }

    public long getId_det_financiacion_imp() {
        return id_det_financiacion_imp;
    }

    public void setId_det_financiacion_imp(long id_det_financiacion_imp) {
        this.id_det_financiacion_imp = id_det_financiacion_imp;
    }

    public float getIntereses() {
        return intereses;
    }

    public void setIntereses(float intereses) {
        this.intereses = intereses;
    }

    public float getSaldo() {
        return saldo;
    }

    public void setSaldo(float saldo) {
        this.saldo = saldo;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }

    public static Detalle_Financiacion_Imp load(ResultSet rs)throws SQLException{
        Detalle_Financiacion_Imp detalle_financiacion_imp = new Detalle_Financiacion_Imp();
        detalle_financiacion_imp.setId_det_financiacion_imp(rs.getLong(1));
        detalle_financiacion_imp.setFk_financiacion(rs.getLong(2));
        detalle_financiacion_imp.setFk_cartera(rs.getLong(3));
        detalle_financiacion_imp.setCuota(rs.getInt(4));
        detalle_financiacion_imp.setValor(rs.getFloat(5));
        detalle_financiacion_imp.setSaldo(rs.getFloat(6));
        detalle_financiacion_imp.setEstado(rs.getInt(7));
        detalle_financiacion_imp.setIntereses(rs.getFloat(8));
        detalle_financiacion_imp.setFecha_pago(rs.getDate(9));
        detalle_financiacion_imp.setFecha_proceso(rs.getTimestamp(10));
        return detalle_financiacion_imp;
    }
}
