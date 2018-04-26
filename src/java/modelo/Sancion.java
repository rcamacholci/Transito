/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author acer
 */
import java.io.*;
import java.sql.*;
public class Sancion implements Serializable {
   private long id_sancion,fk_comparendo,fk_agente,fk_persona,impreso;
   private Timestamp c_fecha ,fecha_sancion;
   private String numero;

    public long getId_sancion() {
        return id_sancion;
    }

    public void setId_sancion(long id_sancion) {
        this.id_sancion = id_sancion;
    }

    public long getFk_comparendo() {
        return fk_comparendo;
    }

    public void SetFk_comparendo(long fk_comparendo) {
        this.fk_comparendo = fk_comparendo;
    }

    public long getFk_agente() {
        return fk_agente;
    }

    public void SetFk_agente(long fk_agente) {
        this.fk_agente = fk_agente;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void SetFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    }

    public Timestamp getC_Fecha() {
        return c_fecha;
    }

    public void setC_Fecha(Timestamp fecha) {
        this.c_fecha = fecha;
    }
    
    public Timestamp getFecha_sancion() {
        return fecha_sancion;
    }

    public void setFecha_sancion(Timestamp fecha) {
        this.fecha_sancion = fecha;
    }


    public long getImpreso() {
        return impreso;
    }

    public void setImpreso(long impreso) {
        this.impreso =impreso;
    }


    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }


    public static Sancion load(ResultSet rs)throws SQLException{

        Sancion sancion = new Sancion();
            sancion.setId_sancion(rs.getLong(1));
            sancion.SetFk_comparendo(rs.getLong(2));
            sancion.SetFk_agente(rs.getLong(3));
            sancion.SetFk_persona(rs.getLong(4));
            sancion.setC_Fecha(rs.getTimestamp(6));
            sancion.setFecha_sancion(rs.getTimestamp(7));
            sancion.setImpreso(rs.getLong(5));
            sancion.setNumero(rs.getString(8));
        return sancion;
    }
}
