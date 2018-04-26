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
public class Sede_tramite_concepto {

    private long id_tramite_concepto, fk_concepto, valor, fk_sede, fk_tramite;
    private java.sql.Date fecha_ini, fecha_fin, fecha_resol;
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

    public long getId_tramite_concepto() {
        return id_tramite_concepto;
    }

    public void setId_tramite_concepto(long id_tramite_concepto) {
        this.id_tramite_concepto = id_tramite_concepto;
    }

    public String getResolucion() {
        return resolucion;
    }

    public void setResolucion(String resolucion) {
        this.resolucion = resolucion;
    }

    public long getValor() {
        return valor;
    }

    public void setValor(long valor) {
        this.valor = valor;
    }

    public static Sede_tramite_concepto load (ResultSet rs)throws SQLException{
        Sede_tramite_concepto sede_tramite_concepto = new Sede_tramite_concepto();

        sede_tramite_concepto.setId_tramite_concepto(rs.getLong(1));
        sede_tramite_concepto.setFk_concepto(rs.getLong(2));
        sede_tramite_concepto.setFecha_fin(rs.getDate(3));
        sede_tramite_concepto.setFecha_fin(rs.getDate(4));
        sede_tramite_concepto.setResolucion(rs.getString(5));
        sede_tramite_concepto.setFecha_resol(rs.getDate(6));
        sede_tramite_concepto.setValor(rs.getLong(7));
        sede_tramite_concepto.setFk_sede(rs.getLong(8));
        sede_tramite_concepto.setFk_tramite(rs.getLong(9));

        return sede_tramite_concepto;

    }

}
