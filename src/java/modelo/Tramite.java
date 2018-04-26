package modelo;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Civitrans
 */
import java.io.*;
import java.sql.*;

public class Tramite implements Serializable {

    private long id_tramite;
    private String nombre,  descripcion,  abreviatura;
    private int clase_tramite,  gra_codigo, peso;

    public String getAbreviatura() {
        return abreviatura;
    }

    public void setAbreviatura(String abreviatura) {
        this.abreviatura = abreviatura;
    }

    public int getClase_tramite() {
        return clase_tramite;
    }

    public void setClase_tramite(int clase_tramite) {
        this.clase_tramite = clase_tramite;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getGra_codigo() {
        return gra_codigo;
    }

    public void setGra_codigo(int gra_codigo) {
        this.gra_codigo = gra_codigo;
    }

    public long getId_tramite() {
        return id_tramite;
    }

    public void setId_tramite(long id_tramite) {
        this.id_tramite = id_tramite;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getPeso() {
        return peso;
    }

    public void setPeso(int peso) {
        this.peso = peso;
    }

    public static Tramite load(ResultSet rs) throws SQLException {
        Tramite tramite = new Tramite();
        tramite.setId_tramite(rs.getLong(1));
        tramite.setNombre(rs.getString(2));
        tramite.setClase_tramite(rs.getInt(3));
        tramite.setDescripcion(rs.getString(4));
        tramite.setAbreviatura(rs.getString(5));
        tramite.setGra_codigo(rs.getInt(6));
        tramite.setPeso(rs.getInt(7));
        return tramite;
    }
}

