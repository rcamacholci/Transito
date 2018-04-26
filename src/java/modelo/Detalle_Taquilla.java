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
public class Detalle_Taquilla implements Serializable{

    private long id_detalle_taquilla;
    private long fk_taquilla;
    private long fk_banco;
    private float valor;

    public long getFk_banco() {
        return fk_banco;
    }

    public void setFk_banco(long fk_banco) {
        this.fk_banco = fk_banco;
    }

    public long getFk_taquilla() {
        return fk_taquilla;
    }

    public void setFk_taquilla(long fk_taquilla) {
        this.fk_taquilla = fk_taquilla;
    }

    public long getId_detalle_taquilla() {
        return id_detalle_taquilla;
    }

    public void setId_detalle_taquilla(long id_detalle_taquilla) {
        this.id_detalle_taquilla = id_detalle_taquilla;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }
    
    public static Detalle_Taquilla load (ResultSet rs)throws SQLException{
        Detalle_Taquilla detalle_taquilla= new Detalle_Taquilla();
        detalle_taquilla.setId_detalle_taquilla(rs.getLong(1));
        detalle_taquilla.setFk_taquilla(rs.getLong(2));
        detalle_taquilla.setFk_banco(rs.getLong(3));
        detalle_taquilla.setValor(rs.getFloat(4));
        return detalle_taquilla;
    
    }
}
