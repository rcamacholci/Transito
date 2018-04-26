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
public class Linea_Remolques implements Serializable{


    private long id_linea_rem ;
    private String nombre ;
    private long fk_marca ;

    public long getFk_marca() {
        return fk_marca;
    }

    public void setFk_marca(long fk_marca) {
        this.fk_marca = fk_marca;
    }

    public long getId_linea_rem() {
        return id_linea_rem;
    }

    public void setId_linea_rem(long id_linea_rem) {
        this.id_linea_rem = id_linea_rem;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }



    protected static Linea_Remolques load(ResultSet rst) throws SQLException {

        Linea_Remolques l = new Linea_Remolques();

        l.setId_linea_rem(rst.getLong(1)) ;
        l.setNombre(rst.getString(2)) ;
        l.setFk_marca(rst.getLong(3)) ;
        return l  ;
    }
}
