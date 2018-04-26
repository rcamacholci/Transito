/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;
import java.sql.* ;

/**
 *
 * @author Project
 */
public class Seguro {
    private long id_seguro ;
    private long fk_vehiculo ;
    private long fk_aseguradora ;
    private String poliza ;
    private Date fecha_ini ;
    private Date fecha_fin ;

    public long getId_seguro() {
        return id_seguro;
    }

    public void setId_seguro(long id_seguro) {
        this.id_seguro = id_seguro;
    }

    public long getFk_vehiculo() {
        return fk_vehiculo;
    }

    public void setFk_vehiculo(long fk_vehiculo) {
        this.fk_vehiculo = fk_vehiculo;
    }

    public long getFk_aseguradora() {
        return fk_aseguradora;
    }

    public void setFk_aseguradora(long fk_aseguradora) {
        this.fk_aseguradora = fk_aseguradora;
    }

    public String getPoliza() {
        return poliza;
    }

    public void setPoliza(String poliza) {
        this.poliza = poliza;
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
    
    protected static Seguro load(ResultSet rst)throws SQLException{
        Seguro seguro  = new Seguro() ;
        seguro.setId_seguro(rst.getLong(1));
        seguro.setFk_vehiculo(rst.getLong(2));
        seguro.setFk_aseguradora(rst.getLong(3)); 
        seguro.setPoliza(rst.getString(4)) ; 
        seguro.setFecha_ini(rst.getDate(5));
        seguro.setFecha_fin(rst.getDate(6));
         return seguro ;
    }
}
