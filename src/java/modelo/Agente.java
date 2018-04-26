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
public class Agente implements Serializable {
    private long id_agente;
    private int tipo,placa;
    private Date fecha_inicio,fecha_fin,fecha_proceso;
    private String nombre;

    public Date getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public Date getFecha_inicio() {
        return fecha_inicio;
    }

    public void setFecha_inicio(Date fecha_inicio) {
        this.fecha_inicio = fecha_inicio;
    }

    public Date getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Date fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    
    public long getId_agente() {
        return id_agente;
    }

    public void setId_agente(long id_agente) {
        this.id_agente = id_agente;
    }

    public int getPlaca() {
        return placa;
    }

    public void setPlaca(int placa) {
        this.placa = placa;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }
    public static Agente load(ResultSet rs)throws SQLException{
        Agente agente = new Agente();
        agente.setId_agente(rs.getLong(1));
        agente.setNombre(rs.getString(2));
        agente.setTipo(rs.getInt(3));
        agente.setPlaca(rs.getInt(4));
        agente.setFecha_inicio(rs.getDate(5));
        agente.setFecha_fin(rs.getDate(6));
        agente.setFecha_proceso(rs.getDate(7));
        return agente;
    }
    
}
