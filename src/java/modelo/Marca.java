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
public class Marca implements Serializable{
    
    private long id_marca ;
    private long codigo ;
    private String nombre ;
    
    public long getId_marca() {
        return id_marca;
    }

    public void setId_marca(long id_marca) {
        this.id_marca = id_marca;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public long getCodigo() {
        return codigo;
    }

    public void setCodigo(long codigo) {
        this.codigo = codigo;
    }

    protected static Marca load (ResultSet rst)throws SQLException{
        
        Marca m = new Marca() ;
        
        m.setId_marca(rst.getLong(1)) ;
        m.setCodigo(rst.getLong(2)) ;
        m.setNombre(rst.getString(3)) ;
        return m ;
         
    }

}
