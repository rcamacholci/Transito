/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Civitrans
 */
import java.io.*;
import java.sql.*;
public class Sede  implements Serializable{
    
private long id_sede,fk_organismo;
private String nit,clase,codigo,nombre_corto,telefono;
private String email,direccion,nombre;

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

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public long getFk_organismo() {
        return fk_organismo;
    }

    public void setFk_organismo(long fk_organismo) {
        this.fk_organismo = fk_organismo;
    }

    public long getId_sede() {
        return id_sede;
    }

    public void setId_sede(long id_sede) {
        this.id_sede = id_sede;
    }

    public String getNit() {
        return nit;
    }

    public void setNit(String nit) {
        this.nit = nit;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getNombre_corto() {
        return nombre_corto;
    }

    public void setNombre_corto(String nombre_corto) {
        this.nombre_corto = nombre_corto;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

   public static Sede Load(ResultSet rs)throws SQLException{
       Sede sede=new Sede();
       sede.setId_sede(rs.getLong(1));
       sede.setNit(rs.getString(2));
       sede.setClase(rs.getString(3));
       sede.setCodigo(rs.getString(4));
       sede.setNombre_corto(rs.getString(5));
       sede.setTelefono(rs.getString(6));
       sede.setEmail(rs.getString(7));
       sede.setDireccion(rs.getString(8));
       sede.setNombre(rs.getString(9));
       sede.setFk_organismo(rs.getLong(10));
       
       return sede;
   }
        
}

