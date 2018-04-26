/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;
import java.sql.* ;

/**
 *
 * @author Civitrans
 */
public class Configuracion_distribucion {
    private long id_configuracion_distribucion ;
    private long fk_sede ;
    private long fk_entidad_distribucion ;
    private long fk_concepto ;
    private float porcentaje ;
    private Date fecha_ini ;
    private Date fecha_fin ;

    public long getId_configuracion_distribucion() {
        return id_configuracion_distribucion;
    }

    public void setId_configuracion_distribucion(long id_configuracion_distribucion) {
        this.id_configuracion_distribucion = id_configuracion_distribucion;
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

    public Date getFecha_ini() {
        return fecha_ini;
    }

    public void setFecha_ini(Date fecha_ini) {
        this.fecha_ini = fecha_ini;
    }

    public Date getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }
    
    protected static Configuracion_distribucion load(ResultSet rst)throws SQLException{
        Configuracion_distribucion configuracion_distribucion = new Configuracion_distribucion() ;
        configuracion_distribucion.setId_configuracion_distribucion(rst.getLong(1)) ;
        configuracion_distribucion.setFk_sede(rst.getLong(2)) ;
        configuracion_distribucion.setFk_entidad_distribucion(rst.getLong(3)) ;
        configuracion_distribucion.setFk_concepto(rst.getLong(4)) ;
        configuracion_distribucion.setPorcentaje(rst.getFloat(5)) ;
        configuracion_distribucion.setFecha_ini(rst.getDate(6)) ;
        configuracion_distribucion.setFecha_fin(rst.getDate(7)) ;
        return configuracion_distribucion ;
    }
}
