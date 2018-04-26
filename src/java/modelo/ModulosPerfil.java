/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Sistemas - Jefrey
 */
import java.io.*;
import java.sql.*;
public class ModulosPerfil {

    private long id_recurso;
    private String nombre;
    private String descripcion;
    private long modulo;
    private long tipo_menu;
    private String ubicacion;
    private long id_perfil_recurso;
    private long fk_perfil;
    private long fk_recurso;
    private Date fecha_inicio;
    private Date fecha_final;
    

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

     public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public long getModulo() {
        return modulo;
    }

    public void setModulo(long modulo) {
        this.modulo = modulo;
    }

     public long getTipo_menu() {
        return tipo_menu;
    }

    public void setTipo_menu(long tipo_menu) {
        this.tipo_menu = tipo_menu;
    }

     public String getUbicacion() {
        return ubicacion;
    }

    public void setUbicacion(String ubicacion) {
        this.ubicacion = ubicacion;
    }

    public long getId_perfil_recurso() {
        return id_perfil_recurso;
    }

    public void setId_perfil_recurso(long id_perfil_recurso) {
        this.id_perfil_recurso = id_perfil_recurso;
    }

    public long getFk_perfil() {
        return fk_perfil;
    }

    public void setFk_perfil(long fk_perfil) {
        this.fk_perfil = fk_perfil;
    }

    public long getFk_recurso() {
        return fk_recurso;
    }

    public void setFk_recurso(long fk_recurso) {
        this.fk_recurso = fk_recurso;
    }

    public Date getFecha_inicio() {
        return fecha_inicio;
    }

    public void setFecha_inicio(Date fecha_inicio) {
        this.fecha_inicio = fecha_inicio;
    }

     public Date getFecha_final() {
        return fecha_final;
    }

    public void setFecha_final(Date fecha_final) {
        this.fecha_final = fecha_final;
    }

    public static ModulosPerfil load(ResultSet rs)throws SQLException{
        ModulosPerfil modulosPerfil= new ModulosPerfil();

        modulosPerfil.setId_recurso(rs.getLong(1));
        modulosPerfil.setNombre(rs.getString(2));
        modulosPerfil.setDescripcion(rs.getString(3));
        modulosPerfil.setModulo(rs.getLong(4));
        modulosPerfil.setTipo_menu(rs.getLong(5));
        modulosPerfil.setUbicacion(rs.getString(6));
        modulosPerfil.setId_perfil_recurso(rs.getLong(7));
        modulosPerfil.setFk_perfil(rs.getLong(8));
        modulosPerfil.setFk_recurso(rs.getLong(9));
        modulosPerfil.setFecha_inicio(rs.getDate(10));
        modulosPerfil.setFecha_final(rs.getDate(11));

        return modulosPerfil;



    }

}
