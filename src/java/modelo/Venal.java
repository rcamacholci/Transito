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
public class Venal implements Serializable {
    private long id_venal,fk_rango,fk_radicacion,fk_usuario;
    private int estado;
    private String numero ;
    private Timestamp fecha_utilizacion;

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Timestamp getFecha_utilizacion() {
        return fecha_utilizacion;
    }

    public void setFecha_utilizacion(Timestamp fecha_utilizacion) {
        this.fecha_utilizacion = fecha_utilizacion;
    }

    public long getFk_radicacion() {
        return fk_radicacion;
    }

    public void setFk_radicacion(long fk_radicacion) {
        this.fk_radicacion = fk_radicacion;
    }

    public long getFk_rango() {
        return fk_rango;
    }

    public void setFk_rango(long fk_rango) {
        this.fk_rango = fk_rango;
    }

    public long getId_venal() {
        return id_venal;
    }

    public void setId_venal(long id_venal) {
        this.id_venal = id_venal;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public static Venal load(ResultSet rs)throws SQLException{
          Venal venal = new Venal();
          venal.setId_venal(rs.getLong(1));
          venal.setFk_rango(rs.getLong(2));
          venal.setFk_radicacion(rs.getLong(3));
          venal.setNumero(rs.getString(4));
          venal.setEstado(rs.getInt(5));
          venal.setFecha_utilizacion(rs.getTimestamp(6));
          venal.setFk_usuario(rs.getLong(7));
          return venal;
  }      
        
}
