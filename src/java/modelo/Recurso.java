/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Javier
 */
import java.io.*;
import java.sql.*;
public class Recurso {
    private long id_recurso;
    private String nombre,descripcion;
    private int modulo;
    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public long getId_recurso() {
        return id_recurso;
    }

    public void setId_recurso(long id_recurso) {
        this.id_recurso = id_recurso;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getModulo() {
        return modulo;
    }

    public void setModulo(int modulo) {
        this.modulo = modulo;
    }
public static Recurso load(ResultSet rs)throws SQLException{
        Recurso recurso= new Recurso();
        recurso.setId_recurso(rs.getLong(1));
        recurso.setNombre(rs.getString(2));
        recurso.setDescripcion(rs.getString(3));
        recurso.setModulo(rs.getInt(4));
  
        return recurso;
        
        
        
    }
}
