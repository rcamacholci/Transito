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
public class Consecutivo implements Serializable{
private long id_consecutivo;
private long fk_sede;
private int numero,tipo,vigencia;

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getId_consecutivo() {
        return id_consecutivo;
    }

    public void setId_consecutivo(long id_consecutivo) {
        this.id_consecutivo = id_consecutivo;
    }

    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    public int getVigencia() {
        return vigencia;
    }

    public void setVigencia(int vigencia) {
        this.vigencia = vigencia;
    } 
    public static Consecutivo load(ResultSet rs)throws SQLException{
        Consecutivo consecutivo = new Consecutivo();
        consecutivo.setId_consecutivo(rs.getLong(1));
        consecutivo.setFk_sede(rs.getLong(2));
        consecutivo.setNumero(rs.getInt(3));
        consecutivo.setTipo(rs.getInt(4));
        consecutivo.setVigencia(rs.getInt(5));
        return consecutivo;
    }
}
