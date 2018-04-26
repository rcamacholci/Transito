/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;
import java.io.* ;
import java.sql.* ;

/**
 *
 * @author Project
 */
public class Aseguradora implements Serializable{
    
    private long id_aseguradora ;
    private long fk_persona ;
    private Date fecha_ini ;
    private Date fecha_fin ;

    public long getId_aseguradora() {
        return id_aseguradora;
    }

    public void setId_aseguradora(long id_aseguradora) {
        this.id_aseguradora = id_aseguradora;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    
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
    
    protected static Aseguradora load(ResultSet rst)throws SQLException {
        
        Aseguradora aseguradora = new Aseguradora () ;
        
        aseguradora.setId_aseguradora(rst.getLong(1)) ;
        aseguradora.setFk_persona(rst.getLong(2)) ;
        
        return aseguradora ;
        
    }

   
}
