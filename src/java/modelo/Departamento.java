/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Civitrans
 */
import java.io.*;
import java.sql.*;
/**
 *
 * @author Administrador
 */
public class Departamento implements Serializable{
    
private long  id_departamento;
private String nombre,codigo_area;
private int codigo_departamento;

    public String getCodigo_area() {
        return codigo_area;
    }

    public void setCodigo_area(String codigo_area) {
        this.codigo_area = codigo_area;
    }

    public int getCodigo_departamento() {
        return codigo_departamento;
    }

    public void setCodigo_departamento(int codigo_departamento) {
        this.codigo_departamento = codigo_departamento;
    }

    public long getId_departamento() {
        return id_departamento;
    }

    public void setId_departamento(long id_departamento) {
        this.id_departamento = id_departamento;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

  public static Departamento load(ResultSet rs)throws SQLException{
           Departamento dep =new Departamento();
         
           dep.setId_departamento(rs.getLong(1));
           dep.setNombre(rs.getString(2)+"");
           dep.setCodigo_area(rs.getString(3)+"");
           dep.setCodigo_departamento(rs.getInt(4));
           return dep;
   }
}
