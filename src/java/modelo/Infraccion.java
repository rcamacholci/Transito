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
public class Infraccion implements Serializable{
private long id_infraccion,fk_ley,fk_sede;
private int tipo,salarios_minimos;
private String descripcion,numero,fk_codigo_transito;
private Date fecha_ini,fecha_fin;

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
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

    public String getFk_codigo_transito() {
        return fk_codigo_transito;
    }

    public void setFk_codigo_transito(String fk_codigo_transito) {
        this.fk_codigo_transito = fk_codigo_transito;
    }

    public long getFk_ley() {
        return fk_ley;
    }

    public void setFk_ley(long fk_ley) {
        this.fk_ley = fk_ley;
    }

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getId_infraccion() {
        return id_infraccion;
    }

    public void setId_infraccion(long id_infraccion) {
        this.id_infraccion = id_infraccion;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public int getSalarios_minimos() {
        return salarios_minimos;
    }

    public void setSalarios_minimos(int salarios_minimos) {
        this.salarios_minimos = salarios_minimos;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }
    public static Infraccion load(ResultSet rs)throws SQLException{
        Infraccion infraccion=new  Infraccion();
        infraccion.setId_infraccion(rs.getLong(1));
        infraccion.setFk_ley(rs.getLong(2));
        infraccion.setFk_codigo_transito(rs.getString(3));
        infraccion.setNumero(rs.getString(4));
        infraccion.setTipo(rs.getInt(5));
        infraccion.setFk_sede(rs.getLong(6));
        infraccion.setSalarios_minimos(rs.getInt(7));
        infraccion.setDescripcion(rs.getString(8));
        infraccion.setFecha_ini(rs.getDate(9));
        infraccion.setFecha_fin(rs.getDate(10));
        
        return infraccion;
        
    } 
            

    
}
