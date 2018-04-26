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
public class Caja implements Serializable{

    private long id_caja,fk_sede;
    private String nombre;
    private Timestamp fecha_inicio,fecha_fin;

    public Timestamp getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Timestamp fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public Timestamp getFecha_inicio() {
        return fecha_inicio;
    }

    public void setFecha_inicio(Timestamp fecha_inicio) {
        this.fecha_inicio = fecha_inicio;
    }

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getId_caja() {
        return id_caja;
    }

    public void setId_caja(long id_caja) {
        this.id_caja = id_caja;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public static Caja load (ResultSet rs)throws SQLException{
          Caja caja = new Caja();
          
          caja.setId_caja(rs.getLong(1));
          caja.setNombre(rs.getString(2));
          caja.setFk_sede(rs.getLong(3));
          caja.setFecha_inicio(rs.getTimestamp(4));
          caja.setFecha_fin(rs.getTimestamp(5));
          
          return caja;
            
        }
    
    
}
