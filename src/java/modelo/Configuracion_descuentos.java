/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

/**
 *
 * @author Jefrey
 */
public class Configuracion_descuentos {

    private long id_configuracion_descuentos ;
    private long fk_sede ;
    private long fk_entidad_distribucion ;
    private long fk_concepto, fk_tramite ;
    private int estado ;
    private float porcentaje ;
    private java.sql.Date fecha_ini ;
    private java.sql.Date fecha_fin , fecha_resolucion;
    private String resolucion;

    public long getId_configuracion_descuentos() {
        return id_configuracion_descuentos;
    }

    public void setId_configuracion_descuentos(long id_configuracion_descuentos) {
        this.id_configuracion_descuentos = id_configuracion_descuentos;
    }

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getFk_entidad_distribucion() {
        return fk_entidad_distribucion;
    }

    public void setFk_entidad_distribucion(long fk_entidad_distribucion) {
        this.fk_entidad_distribucion = fk_entidad_distribucion;
    }

    public long getFk_concepto() {
        return fk_concepto;
    }

    public void setFk_concepto(long fk_concepto) {
        this.fk_concepto = fk_concepto;
    }

    public float getPorcentaje() {
        return porcentaje;
    }

    public void setPorcentaje(float porcentaje) {
        this.porcentaje = porcentaje;
    }

   
    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public java.sql.Date getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(java.sql.Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public java.sql.Date getFecha_ini() {
        return fecha_ini;
    }

    public void setFecha_ini(java.sql.Date fecha_ini) {
        this.fecha_ini = fecha_ini;
    }

    public java.sql.Date getFecha_resolucion() {
        return fecha_resolucion;
    }

    public void setFecha_resolucion(java.sql.Date fecha_resolucion) {
        this.fecha_resolucion = fecha_resolucion;
    }

    public String getResolucion() {
        return resolucion;
    }

    public void setResolucion(String resolucion) {
        this.resolucion = resolucion;
    }

    public long getFk_tramite() {
        return fk_tramite;
    }

    public void setFk_tramite(long fk_tramite) {
        this.fk_tramite = fk_tramite;
    }



    protected static Configuracion_descuentos load(ResultSet rst)throws SQLException{
        Configuracion_descuentos configuracion_descuentos = new Configuracion_descuentos() ;
        configuracion_descuentos.setId_configuracion_descuentos(rst.getLong(1)) ;
        configuracion_descuentos.setFk_sede(rst.getLong(2)) ;
        configuracion_descuentos.setFk_entidad_distribucion(rst.getLong(3)) ;
        configuracion_descuentos.setFk_concepto(rst.getLong(4)) ;
        configuracion_descuentos.setPorcentaje(rst.getFloat(5)) ;
        configuracion_descuentos.setFecha_ini(rst.getDate(6)) ;
        configuracion_descuentos.setFecha_fin(rst.getDate(7)) ;
        configuracion_descuentos.setEstado(rst.getInt(8)) ;
        configuracion_descuentos.setResolucion(rst.getString(9)) ;
        configuracion_descuentos.setFecha_resolucion(rst.getDate(10)) ;
        configuracion_descuentos.setFk_tramite(rst.getLong(11)) ;

        return configuracion_descuentos ;
    }

}
