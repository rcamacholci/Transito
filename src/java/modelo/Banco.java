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
public class Banco implements Serializable {
private long id_banco;
private String nombre;
private String codigo;
private Date fecha_ini,fecha_fin;

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public Date getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public Date getFecha_ini() {
        return fecha_ini;
    }

    public void setFecha_ini(Date fecha_ini) {
        this.fecha_ini = fecha_ini;
    }

    public long getId_banco() {
        return id_banco;
    }

    public void setId_banco(long id_banco) {
        this.id_banco = id_banco;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public static Banco load(ResultSet rs)throws SQLException{
        Banco banco = new Banco();
        
        banco.setId_banco(rs.getLong(1));
        banco.setNombre(rs.getString(2));
        banco.setCodigo(rs.getString(3));
        banco.setFecha_ini(rs.getDate(4));
        banco.setFecha_fin(rs.getDate(5));
        return banco;
    }
}
