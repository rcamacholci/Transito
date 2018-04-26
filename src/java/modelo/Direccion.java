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
public class Direccion implements Serializable{
    
    
private int id_direccion,ubicacion,estado;
private String descripcion,telefono,fax;

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
private long fk_persona,fk_divipo;
private Date fecha;

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

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public long getFk_divipo() {
        return fk_divipo;
    }

    public void setFk_divipo(long fk_divipo) {
        this.fk_divipo = fk_divipo;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    }

    public int getId_direccion() {
        return id_direccion;
    }

    public void setId_direccion(int id_direccion) {
        this.id_direccion = id_direccion;
    }

    public int getUbicacion() {
        return ubicacion;
    }

    public void setUbicacion(int ubicacion) {
        this.ubicacion = ubicacion;
    }

   public static Direccion load(ResultSet rs)throws SQLException{ 
       
       Direccion direccion= new Direccion();
       direccion.setId_direccion(rs.getInt(1));
       direccion.setDescripcion(rs.getString(2));
       direccion.setUbicacion(rs.getInt(3));
       direccion.setFecha(rs.getDate(4));
       direccion.setEstado(rs.getInt(5));
       direccion.setFk_persona(rs.getLong(6));
       direccion.setFk_divipo(rs.getLong(7));
       direccion.setTelefono(rs.getString(8));
       
       return direccion;
   }    
        
        
}

