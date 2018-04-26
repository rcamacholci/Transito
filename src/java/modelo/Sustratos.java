/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Administrador
 */
import java.io.*;
import java.sql.*;
public class Sustratos implements Serializable{
    private long id_sustrato,fk_rango_sustrato, fk_usuario, fk_radicacion;
    private int estado;
    private  String numero,venal,observacion;
    private Timestamp fecha_utilizacion;

    public Timestamp getFecha_utilizacion() {
        return fecha_utilizacion;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
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

    public long getFk_rango_sustrato() {
        return fk_rango_sustrato;
    }

    public void setFk_rango_sustrato(long fk_rango_sustrato) {
        this.fk_rango_sustrato = fk_rango_sustrato;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getId_sustrato() {
        return id_sustrato;
    }

    public void setId_sustrato(long id_sustrato) {
        this.id_sustrato = id_sustrato;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public String getVenal() {
        return venal;
    }

    public void setVenal(String venal) {
        this.venal = venal;
    }

     public static Sustratos load(ResultSet rs)throws SQLException{
           Sustratos sustrato =new Sustratos();
           sustrato.setId_sustrato(rs.getLong(1));
           sustrato.setNumero(rs.getString(2));
           sustrato.setEstado(rs.getInt(3));
           sustrato.setFk_rango_sustrato(rs.getLong(4));
           sustrato.setFecha_utilizacion(rs.getTimestamp(5));
           sustrato.setVenal(rs.getString(6));
           sustrato.setFk_usuario(rs.getLong(7));
           sustrato.setFk_radicacion(rs.getLong(8));
           sustrato.setObservacion(rs.getString(9));
           return sustrato;
   }


}
