/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.Date;

/**
 *
 * @author Civitrans
 */
public class Valor {
    private long id_valor;
    private long fk_concepto;
    private Date fecha_ini;
    private Date fecha_fin;
    private String resolucion;
    private Date fecha_resol;
    private float valor;
    private long fk_sede;
    private long fk_tramite;

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

    public Date getFecha_resol() {
        return fecha_resol;
    }

    public void setFecha_resol(Date fecha_resol) {
        this.fecha_resol = fecha_resol;
    }

    public long getFk_concepto() {
        return fk_concepto;
    }

    public void setFk_concepto(long fk_concepto) {
        this.fk_concepto = fk_concepto;
    }

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getFk_tramite() {
        return fk_tramite;
    }

    public void setFk_tramite(long fk_tramite) {
        this.fk_tramite = fk_tramite;
    }

    public long getId_valor() {
        return id_valor;
    }

    public void setId_valor(long id_valor) {
        this.id_valor = id_valor;
    }

    public String getResolucion() {
        return resolucion;
    }

    public void setResolucion(String resolucion) {
        this.resolucion = resolucion;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }
    
    public static Valor load(java.sql.ResultSet rs)throws java.sql.SQLException{
        Valor valor = new Valor();
        valor.setId_valor(rs.getLong(1));
        valor.setFk_concepto(rs.getLong(2));
        valor.setFecha_ini(rs.getDate(3));
        valor.setFecha_fin(rs.getDate(4));
        valor.setResolucion(rs.getString(5));
        valor.setFecha_resol(rs.getDate(6));
        valor.setValor(rs.getFloat(7));
        valor.setFk_sede(rs.getLong(8));
        valor.setFk_tramite(rs.getLong(9));
        return valor;
    }
}
