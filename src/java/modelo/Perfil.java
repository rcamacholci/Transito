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
public class Perfil implements Serializable{
    private long id_perfil, fk_usuario;
    private String descripcion;

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public long getId_perfil() {
        return id_perfil;
    }

    public void setId_perfil(long id_perfil) {
        this.id_perfil = id_perfil;
    }

    public long getfk_usuario() {
        return fk_usuario;
    }

    public void setfk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }


public static Perfil load(ResultSet rs)throws SQLException{
        Perfil perfil= new Perfil();
        perfil.setId_perfil(rs.getLong(1));
        perfil.setfk_usuario(rs.getLong(2));
        perfil.setDescripcion(rs.getString(3));


        return perfil;



    }
}
