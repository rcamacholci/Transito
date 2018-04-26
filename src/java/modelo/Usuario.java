/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Javier
 */

import java.sql.*;
public class Usuario {
private long id_usuario,fk_persona,fk_sede;
private String nombre,password;
private Date fechaInicio,fechaFin;

    public long getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(long id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(Date fechaFin) {
        this.fechaFin = fechaFin;
    }

    public Date getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(Date fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    }

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public static Usuario load(ResultSet rs)throws SQLException{
        Usuario usuario= new Usuario();
        usuario.setId_usuario(rs.getLong(1));
        usuario.setFk_persona(rs.getLong(2));
        usuario.setNombre(rs.getString(3));
        usuario.setPassword(rs.getString(4));
        usuario.setFechaInicio(rs.getDate(5));
        usuario.setFechaFin(rs.getDate(6));
        usuario.setFk_sede(rs.getLong(7));
        return usuario;
    }

}
