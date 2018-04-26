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
public class Detalle_Cartera implements Serializable {
    
    private long id_detalle_cartera,fk_cartera,fk_concepto,fk_usuario,fk_pago;
    private String referencia;
    private Date fecha;
    private Timestamp fecha_sistema;
    private int estado;
    private float valor;

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

    public Timestamp getFecha_sistema() {
        return fecha_sistema;
    }

    public void setFecha_sistema(Timestamp fecha_sistema) {
        this.fecha_sistema = fecha_sistema;
    }

    public long getFk_cartera() {
        return fk_cartera;
    }

    public void setFk_cartera(long fk_cartera) {
        this.fk_cartera = fk_cartera;
    }

    public long getFk_concepto() {
        return fk_concepto;
    }

    public void setFk_concepto(long fk_concepto) {
        this.fk_concepto = fk_concepto;
    }

    public long getFk_pago() {
        return fk_pago;
    }

    public void setFk_pago(long fk_pago) {
        this.fk_pago = fk_pago;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getId_detalle_cartera() {
        return id_detalle_cartera;
    }

    public void setId_detalle_cartera(long id_detalle_cartera) {
        this.id_detalle_cartera = id_detalle_cartera;
    }

    public String getReferencia() {
        return referencia;
    }

    public void setReferencia(String referencia) {
        this.referencia = referencia;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }
    public static Detalle_Cartera load(ResultSet rs)throws SQLException{
        
        Detalle_Cartera detalle= new Detalle_Cartera();
        
        detalle.setId_detalle_cartera(rs.getLong(1));
        detalle.setFk_cartera(rs.getLong(2));
        detalle.setFk_concepto(rs.getLong(3));
        detalle.setReferencia(rs.getString(4));
        detalle.setFecha(rs.getDate(5));
        detalle.setFecha_sistema(rs.getTimestamp(6));
        detalle.setFk_usuario(rs.getLong(7));
        detalle.setEstado(rs.getInt(8));
        detalle.setValor(rs.getFloat(9));
        detalle.setFk_pago(rs.getLong(10));
        
        return detalle;
        
    }
    

}
