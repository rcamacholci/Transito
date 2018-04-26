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
public class Patio implements Serializable{
    private long id_patio,fk_sede;
    private String direccion,telefono,nombre;
    private int tipo;
    private Date Fecha_ini,fecha_fin;

   

    public Date getFecha_ini() {
        return Fecha_ini;
    }

    public void setFecha_ini(Date Fecha_ini) {
        this.Fecha_ini = Fecha_ini;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public Date getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getId_patio() {
        return id_patio;
    }

    public void setId_patio(long id_patio) {
        this.id_patio = id_patio;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }
 public static Patio load(ResultSet rs)throws SQLException{
       Patio patio= new Patio();
       patio.setId_patio(rs.getLong(1));
       patio.setFk_sede(rs.getLong(2));
       patio.setDireccion(rs.getString(3));
       patio.setTelefono(rs.getString(4));
       patio.setTipo(rs.getInt(5));
       patio.setFecha_ini(rs.getDate(6));
       patio.setFecha_fin(rs.getDate(7));
       patio.setNombre(rs.getString(8));
     
       return patio;
       
       
 }

}
