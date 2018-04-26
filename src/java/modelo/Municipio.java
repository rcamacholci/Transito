/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;
import java.io. *;
/**
 *
 * @author Civitrans
 */
public class Municipio  implements Serializable{
    
    private int codigo;
    private String nombre;
    private int departamento;

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public int getDepartamento() {
        return departamento;
    }

    public void setDepartamento(int departamento) {
        this.departamento = departamento;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public static Municipio load(java.sql.ResultSet rs)throws java.sql.SQLException{
        
        Municipio municipio = new Municipio();
        municipio.setCodigo(rs.getInt(1));
        municipio.setNombre(rs.getString(2));
        municipio.setDepartamento(rs.getInt(3));
        return municipio;
    }
}
