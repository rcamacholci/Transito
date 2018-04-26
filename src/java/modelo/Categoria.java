package modelo;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Javier
 */
import java.io.*;
import java.sql.*;
public class Categoria implements Serializable{
    private long id_categoria;
    private String codigo,id_anterior,descripcion,clase;
    private int estado;
    private Date fecha_ini,fecha_fin;

    public String getClase() {
        return clase;
    }

    public void setClase(String clase) {
        this.clase = clase;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
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

    public String getId_anterior() {
        return id_anterior;
    }

    public void setId_anterior(String id_anterior) {
        this.id_anterior = id_anterior;
    }

    public long getId_categoria() {
        return id_categoria;
    }

    public void setId_categoria(long id_categoria) {
        this.id_categoria = id_categoria;
    }
    public static Categoria load(ResultSet rs)throws SQLException{
        Categoria categoria = new Categoria();
        categoria.setId_categoria(rs.getLong(1));
        categoria.setCodigo(rs.getString(2));
        categoria.setId_anterior(rs.getString(3));
        categoria.setDescripcion(rs.getString(4));
        categoria.setEstado(rs.getInt(5));
        categoria.setEstado(rs.getInt(6));
        categoria.setFecha_ini(rs.getDate(7));
        categoria.setFecha_fin(rs.getDate(8));
        
        return categoria;
      
    }
}
