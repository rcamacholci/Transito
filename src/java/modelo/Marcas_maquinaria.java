/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;
import java.sql.* ;
import java.io. * ;

/**
 *
 * @author Project
 */
public class Marcas_maquinaria implements Serializable{
    
    private long codigo_marca;
    private String descripcion;

    public long getCodigo_marca() {
        return codigo_marca;
    }

    public void setCodigo_marca(long codigo_marca) {
        this.codigo_marca = codigo_marca;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    protected static Marcas_maquinaria load (ResultSet rst)throws SQLException{
        
        Marcas_maquinaria m = new Marcas_maquinaria() ;
        
        m.setCodigo_marca(rst.getLong(1)) ;
        m.setDescripcion(rst.getString(2)) ;
        
        return m ;
         
    }

}
