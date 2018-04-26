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
public class Rango implements Serializable{
    private long id_rango,fk_sede;
    private int estado,tipo;
    private String  numero_ini,numero_fin,resolucion;
    private Date fecha_resolucion,fecha_proceso;

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Date getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Date fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public Date getFecha_resolucion() {
        return fecha_resolucion;
    }

    public void setFecha_resolucion(Date fecha_resolucion) {
        this.fecha_resolucion = fecha_resolucion;
    }

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getId_rango() {
        return id_rango;
    }

    public void setId_rango(long id_rango) {
        this.id_rango = id_rango;
    }

    public String getNumero_fin() {
        return numero_fin;
    }

    public void setNumero_fin(String numero_fin) {
        this.numero_fin = numero_fin;
    }

    public String getNumero_ini() {
        return numero_ini;
    }

    public void setNumero_ini(String numero_ini) {
        this.numero_ini = numero_ini;
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
   public static Rango load(ResultSet rs)throws SQLException{
        Rango rango= new Rango();
        rango.setId_rango(rs.getLong(1));
        rango.setFk_sede(rs.getLong(2));
        rango.setNumero_ini(rs.getString(3));
        rango.setNumero_fin(rs.getString(4));
        rango.setResolucion(rs.getString(5));
        rango.setFecha_resolucion(rs.getDate(6));
        rango.setFecha_proceso(rs.getDate(7));
        rango.setEstado(rs.getInt(8));
        rango.setTipo(rs.getInt(9));
        return rango;
        
        
        
    }
}
