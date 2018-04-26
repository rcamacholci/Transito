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
public class Comparendo_publico implements Serializable {
private long id_com_publico,radidia_accion,Modalidad_Transporte,Transporte_pasajeros,Especial;



    public long getId_comparendo_Publico() {
        return id_com_publico;
    }

    public void setId_banco(long id_banco) {
        this.id_com_publico = id_banco;
    }

    public long getRadio_accion() {
        return radidia_accion;
    }

    public void setRadio_accion(long id_banco) {
        this.radidia_accion = id_banco;
    }

    public long getModalidad() {
        return Modalidad_Transporte;
    }

    public void setModalidad(long id_banco) {
        this.Modalidad_Transporte = id_banco;
    }

    public long getTransporte_pasajeros() {
        return Transporte_pasajeros;
    }

    public void setTransporte_pasajeros(long id_banco) {
        this.Transporte_pasajeros = id_banco;
    }

    public long getEspecial() {
        return Especial;
    }

    public void setEspecial(long id_banco) {
        this.Especial = id_banco;
    }



    public static Comparendo_publico load(ResultSet rs)throws SQLException{
        Comparendo_publico banco = new Comparendo_publico();
        banco.setId_banco(rs.getLong(1));
        banco.setRadio_accion(rs.getLong(2));
        banco.setModalidad(rs.getLong(3));
        banco.setTransporte_pasajeros(rs.getLong(4));
        banco.setEspecial(rs.getLong(5));

        return banco;
    }
}
