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
public class Marcas_Remolques implements Serializable{

    private long id_marca_rem ;
    private long codigo ;
    private String nombre ;

    public long getCodigo() {
        return codigo;
    }

    public void setCodigo(long codigo) {
        this.codigo = codigo;
    }

    public long getId_marca_rem() {
        return id_marca_rem;
    }

    public void setId_marca_rem(long id_marca_rem) {
        this.id_marca_rem = id_marca_rem;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }  

    protected static Marcas_Remolques load (ResultSet rst)throws SQLException{

        Marcas_Remolques m = new Marcas_Remolques() ;
        m.setId_marca_rem(rst.getLong(1)) ;
        m.setCodigo(rst.getLong(2)) ;
        m.setNombre(rst.getString(3)) ;
        return m ;

    }

}
