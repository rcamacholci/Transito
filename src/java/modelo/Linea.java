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
public class Linea implements Serializable{

    
    private long id_linea ;
    private String nombre ;
    private long fk_marca ;

    public long getId_linea() {
        return id_linea;
    }

    public void setId_linea(long id_linea) {
        this.id_linea = id_linea;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public long getFk_marca() {
        return fk_marca;
    }

    public void setFk_marca(long fk_marca) {
        this.fk_marca = fk_marca;
    }
        
        
    protected static Linea load(ResultSet rst) throws SQLException {
        
        Linea l = new Linea() ;
       
        l.setId_linea(rst.getLong(1)) ;
        l.setNombre(rst.getString(2)) ;
        l.setFk_marca(rst.getLong(3)) ;
        return l  ;
    }
}
