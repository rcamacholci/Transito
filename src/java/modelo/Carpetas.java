/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.io.*;
import java.sql.*;

/**
 *
 * @author SISTEMAS
 */
public class Carpetas implements Serializable {

  private long id_carpeta,fk_vehiculo;
  private String observacion;
  private int folios,fk_sede,estado;

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public int getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(int fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getFk_vehiculo() {
        return fk_vehiculo;
    }

    public void setFk_vehiculo(long fk_vehiculo) {
        this.fk_vehiculo = fk_vehiculo;
    }

    public int getFolios() {
        return folios;
    }

    public void setFolios(int folios) {
        this.folios = folios;
    }

    public long getId_carpeta() {
        return id_carpeta;
    }

    public void setId_carpeta(long id_carpeta) {
        this.id_carpeta = id_carpeta;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

   public static Carpetas load(ResultSet rs)throws SQLException{
           Carpetas carpeta =new Carpetas();
           carpeta.setId_carpeta(rs.getLong(1));
           carpeta.setFk_vehiculo(rs.getLong(2));
           carpeta.setEstado(rs.getInt(3));
           carpeta.setFolios(rs.getInt(4));
           carpeta.setFk_sede(rs.getInt(5));
           carpeta.setObservacion(rs.getString(6));
           return carpeta;
   }

}
