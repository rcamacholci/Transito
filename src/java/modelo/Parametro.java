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
public class Parametro implements Serializable {
    
    private String nombre ;
    private String nombreCorto ;
    private long id_parametro ;
    private long fk_grupo ;
    private long codigo ;

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getNombreCorto() {
        return nombreCorto;
    }

    public void setNombreCorto(String nombreCorto) {
        this.nombreCorto = nombreCorto;
    }

    public long getId_parametro() {
        return id_parametro;
    }

    public void setId_parametro(long id_parametro) {
        this.id_parametro = id_parametro;
    }

    public long getFk_grupo() {
        return fk_grupo;
    }

    public void setFk_grupo(long fk_grupo) {
        this.fk_grupo = fk_grupo;
    }

    public long getCodigo() {
        return codigo;
    }

    public void setCodigo(long codigo) {
        this.codigo = codigo;
    }
    
    protected static Parametro load(ResultSet rst) throws SQLException {
        
        Parametro parametro = new Parametro() ;
        
        parametro.setId_parametro(rst.getLong(1)) ;
        parametro.setNombre(rst.getString(2)) ;
        parametro.setNombreCorto(rst.getString(3));
        parametro.setCodigo(rst.getLong(4));
        parametro.setFk_grupo(rst.getLong(5)) ;
        
        return parametro ;
        
        
    }
    
    
}



