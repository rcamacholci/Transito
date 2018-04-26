/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Jefrey
 */
public class Valor_conceptos_tramite {

    private long id_valor_concepto_tramite, fk_tramite, fk_concepto, fk_sede;
    private float valor;
    private java.sql.Date fecha_ini, fecha_fin, fecha_resolucion;
    private String resolucion;

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

    public Date getFecha_resolucion() {
        return fecha_resolucion;
    }

    public void setFecha_resolucion(Date fecha_resolucion) {
        this.fecha_resolucion = fecha_resolucion;
    }

    public long getFk_concepto() {
        return fk_concepto;
    }

    public void setFk_concepto(long fk_concepto) {
        this.fk_concepto = fk_concepto;
    }

    public long getFk_tramite() {
        return fk_tramite;
    }

    public void setFk_tramite(long fk_tramite) {
        this.fk_tramite = fk_tramite;
    }

    public long getId_valor_concepto_tramite() {
        return id_valor_concepto_tramite;
    }

    public void setId_valor_concepto_tramite(long id_valor_concepto_tramite) {
        this.id_valor_concepto_tramite = id_valor_concepto_tramite;
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

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

      protected static Valor_conceptos_tramite load(ResultSet rst)throws SQLException{

        Valor_conceptos_tramite valor_conceptos_tramite = new Valor_conceptos_tramite() ;

        valor_conceptos_tramite.setId_valor_concepto_tramite(rst.getLong(1)) ;
        valor_conceptos_tramite.setFk_tramite(rst.getLong(2)) ;
        valor_conceptos_tramite.setFk_concepto(rst.getLong(3)) ;
        valor_conceptos_tramite.setValor(rst.getFloat(4)) ;
        valor_conceptos_tramite.setFecha_ini(rst.getDate(5)) ;
        valor_conceptos_tramite.setFecha_fin(rst.getDate(6)) ;
        valor_conceptos_tramite.setResolucion(rst.getString(7)) ;
        valor_conceptos_tramite.setFecha_resolucion(rst.getDate(8)) ;
        valor_conceptos_tramite.setFk_sede(rst.getLong(9)) ;

        return valor_conceptos_tramite ;
    }

}
