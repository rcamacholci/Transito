/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;
import java.io.* ;
import java.sql.*;

/**
 *
 * @author Project
 */
public class Color implements Serializable {
    
    private long id_color ;
    private String nombre ;

    public long getId_color() {
        return id_color;
    }

    public void setId_color(long id_color) {
        this.id_color = id_color;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    protected static Color load(ResultSet rst)throws SQLException{
        Color color = new Color() ;
        color.setId_color(rst.getLong(1)) ;
        color.setNombre(rst.getString(2)) ;
      
        return color ;
    }

   
}
