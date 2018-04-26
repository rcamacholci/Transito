/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.* ;
import java.io.* ;
/**
 *
 * @author Project
 */
public class Grupo implements Serializable {
    
    private long id_grupo ;
    private String nombre ;

    
    // Metodos analizadores y modificadores
    public long getId_grupo() {
        return id_grupo;
    }

    public void setId_grupo(long id_grupo) {
        this.id_grupo = id_grupo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    
    //Metodo para generar un grupo a partir de datos extraidos de la base de datos
    protected static Grupo load(ResultSet rst)throws SQLException {
        
        Grupo grupo = new Grupo() ;
        
        grupo.setId_grupo(rst.getLong(1)) ;
        grupo.setNombre(rst.getString(2)) ;
        
        return grupo ;
                
    }

    

}
