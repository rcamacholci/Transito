/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.*;

/**
 *
 * @author Jefrey
 */
public class Sede_concepto {

    private long id_sede_concepto, fk_sede, fk_concepto;
    private java.sql.Date fecha_inicio, fecha_fin;

    public Date getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public Date getFecha_inicio() {
        return fecha_inicio;
    }

    public void setFecha_inicio(Date fecha_inicio) {
        this.fecha_inicio = fecha_inicio;
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

    public long getId_sede_concepto() {
        return id_sede_concepto;
    }

    public void setId_sede_concepto(long id_sede_concepto) {
        this.id_sede_concepto = id_sede_concepto;
    }

     public static Sede_concepto load (ResultSet rs)throws SQLException{
        Sede_concepto sede_concepto = new Sede_concepto();

        sede_concepto.setId_sede_concepto(rs.getLong(1));
        sede_concepto.setFk_sede(rs.getLong(2));
        sede_concepto.setFk_concepto(rs.getLong(3));
        sede_concepto.setFecha_inicio(rs.getDate(4));
        sede_concepto.setFecha_fin(rs.getDate(5));
        
        return sede_concepto;

    }

}
