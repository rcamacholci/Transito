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
public class Control_Rango implements Serializable {
    
private long id_control_rango,fk_rango;
private int clase,servicio;

    public int getClase() {
        return clase;
    }

    public void setClase(int clase) {
        this.clase = clase;
    }

    public long getFk_rango() {
        return fk_rango;
    }

    public void setFk_rango(long fk_rango) {
        this.fk_rango = fk_rango;
    }

    public long getId_control_rango() {
        return id_control_rango;
    }

    public void setId_control_rango(long id_control_rango) {
        this.id_control_rango = id_control_rango;
    }

    public int getServicio() {
        return servicio;
    }

    public void setServicio(int servicio) {
        this.servicio = servicio;
    }
 public static Control_Rango load(ResultSet rs)throws SQLException{
     
     Control_Rango control= new Control_Rango();
     
     control.setId_control_rango(rs.getLong(1));
     control.setFk_rango(rs.getLong(2));
     control.setClase(rs.getInt(3));
     control.setServicio(rs.getInt(4));
     
     return control;
 }
}
