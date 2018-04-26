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
public class Taquilla implements Serializable{

    private long id_taquilla,fk_sede,fk_caja,fk_usuario;
    private Timestamp fecha_ini,fecha_fin;
    private float valor_nota_debito,valor_taquilla;
    private int estado ;

    public Timestamp getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Timestamp fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public Timestamp getFecha_ini() {
        return fecha_ini;
    }

    public void setFecha_ini(Timestamp fecha_ini) {
        this.fecha_ini = fecha_ini;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }
    public int getEstado() {
        return estado;
    }

    public long getFk_caja() {
        return fk_caja;
    }

    public void setFk_caja(long fk_caja) {
        this.fk_caja = fk_caja;
    }

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getId_taquilla() {
        return id_taquilla;
    }

    public void setId_taquilla(long id_taquilla) {
        this.id_taquilla = id_taquilla;
    }

    public float getValor_nota_debito() {
        return valor_nota_debito;
    }

    public void setValor_nota_debito(float valor_nota_debito) {
        this.valor_nota_debito = valor_nota_debito;
    }

    public float getValor_taquilla() {
        return valor_taquilla;
    }

    public void setValor_taquilla(float valor_taquilla) {
        this.valor_taquilla = valor_taquilla;
    }
    
    public static Taquilla load (ResultSet rs)throws SQLException{
        Taquilla taquilla= new Taquilla();
        
        taquilla.setId_taquilla(rs.getLong(1));
        taquilla.setValor_nota_debito(rs.getFloat(2));
        taquilla.setValor_taquilla(rs.getFloat(3));
        taquilla.setEstado(rs.getInt(4));
        taquilla.setFk_sede(rs.getLong(5));
        taquilla.setFk_caja(rs.getLong(6));
        taquilla.setFk_usuario(rs.getLong(7));
        taquilla.setFecha_ini(rs.getTimestamp(8));
        taquilla.setFecha_fin(rs.getTimestamp(9));
        return taquilla;
    
    }
}
