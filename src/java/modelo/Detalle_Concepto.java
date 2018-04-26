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
public class Detalle_Concepto implements Serializable {
    private long id_detalle_conceptos,fk_concepto_cartera,fk_concepto_detalle,fk_sede;
    private float porcentaje,valor;
    private Date fecha_ini,fecha_fin;
    private int tipo;

    public Date getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public Date getFecha_ini() {
        return fecha_ini;
    }

    public void setFecha_ini(Date fecha_ini) {
        this.fecha_ini = fecha_ini;
    }

    public long getFk_concepto_cartera() {
        return fk_concepto_cartera;
    }

    public void setFk_concepto_cartera(long fk_concepto_cartera) {
        this.fk_concepto_cartera = fk_concepto_cartera;
    }

    public long getFk_concepto_detalle() {
        return fk_concepto_detalle;
    }

    public void setFk_concepto_detalle(long fk_concepto_detalle) {
        this.fk_concepto_detalle = fk_concepto_detalle;
    }

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getId_detalle_conceptos() {
        return id_detalle_conceptos;
    }

    public void setId_detalle_conceptos(long id_detalle_conceptos) {
        this.id_detalle_conceptos = id_detalle_conceptos;
    }

    public float getPorcentaje() {
        return porcentaje;
    }

    public void setPorcentaje(float porcentaje) {
        this.porcentaje = porcentaje;
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
    
    public static Detalle_Concepto load (ResultSet rs)throws SQLException{
            
            Detalle_Concepto detalle= new Detalle_Concepto();
            
            detalle.setId_detalle_conceptos(rs.getLong(1));
            detalle.setFk_concepto_cartera(rs.getLong(2));
            detalle.setFk_concepto_detalle(rs.getLong(3));
            detalle.setFk_sede(rs.getLong(4));
            detalle.setPorcentaje(rs.getFloat(5));
            detalle.setValor(rs.getFloat(6));
            detalle.setFecha_ini(rs.getDate(7));
            detalle.setFecha_fin(rs.getDate(8));
            detalle.setTipo(rs.getInt(9));
            
            
            return detalle;
            
    }
    
    

}
