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
public class Detalle_Tiquete {
  private long id_det_tiquete,fk_tiquete,fk_cartera,fk_concepto,fk_tramite;
  private float valor_unitario,valor_descuento,valor_iva,valor_total;
  private int cantidad,estado;

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
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

    public long getFk_tiquete() {
        return fk_tiquete;
    }

    public void setFk_tiquete(long fk_tiquete) {
        this.fk_tiquete = fk_tiquete;
    }

    public long getFk_tramite() {
        return fk_tramite;
    }

    public void setFk_tramite(long fk_tramite) {
        this.fk_tramite = fk_tramite;
    }

    public long getId_det_tiquete() {
        return id_det_tiquete;
    }

    public void setId_det_tiquete(long id_det_tiquete) {
        this.id_det_tiquete = id_det_tiquete;
    }

    public float getValor_descuento() {
        return valor_descuento;
    }

    public void setValor_descuento(float valor_descuento) {
        this.valor_descuento = valor_descuento;
    }

    public float getValor_iva() {
        return valor_iva;
    }

    public void setValor_iva(float valor_iva) {
        this.valor_iva = valor_iva;
    }

    public float getValor_total() {
        return valor_total;
    }

    public void setValor_total(float valor_total) {
        this.valor_total = valor_total;
    }

    public float getValor_unitario() {
        return valor_unitario;
    }

    public void setValor_unitario(float valor_unitario) {
        this.valor_unitario = valor_unitario;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }
  
    public static Detalle_Tiquete load(ResultSet rs)throws SQLException{
        Detalle_Tiquete tiquete= new Detalle_Tiquete();
        
        tiquete.setId_det_tiquete(rs.getLong(1));
        tiquete.setCantidad(rs.getInt(2));
        tiquete.setValor_unitario(rs.getFloat(3));
        tiquete.setValor_descuento(rs.getFloat(4));
        tiquete.setValor_iva(rs.getFloat(5));
        tiquete.setValor_total(rs.getFloat(6));
        tiquete.setFk_tiquete(rs.getLong(7));
        tiquete.setFk_cartera(rs.getLong(8));
        tiquete.setFk_concepto(rs.getLong(9));
        tiquete.setFk_tramite(rs.getLong(10));
        tiquete.setEstado(rs.getInt(11));
        return tiquete;
        
    }
}
