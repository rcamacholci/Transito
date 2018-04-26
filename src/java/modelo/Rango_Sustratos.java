/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.io.Serializable;
import java.sql.*;
import java.util.Date;

/**
 *
 * @author Administrador
 */
public class Rango_Sustratos implements Serializable {
    private long id_rango_sustrato;
    private int estado,tipo;
    private String  num_inicio,num_fin;
    private Date fecha_proceso;

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Date getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Date fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public long getId_rango_sustrato() {
        return id_rango_sustrato;
    }

    public void setId_rango_sustrato(long id_rango_sustrato) {
        this.id_rango_sustrato = id_rango_sustrato;
    }

    public String getNum_fin() {
        return num_fin;
    }

    public void setNum_fin(String num_fin) {
        this.num_fin = num_fin;
    }

    public String getNum_inicio() {
        return num_inicio;
    }

    public void setNum_inicio(String num_inicio) {
        this.num_inicio = num_inicio;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

     public static Rango_Sustratos load(ResultSet rs)throws SQLException{
        Rango_Sustratos rangoS= new Rango_Sustratos();
        rangoS.setId_rango_sustrato(rs.getLong(1));
        rangoS.setTipo(rs.getInt(2));
        rangoS.setNum_inicio(rs.getString(3));
        rangoS.setNum_fin(rs.getString(4));
        rangoS.setFecha_proceso(rs.getDate(5));
        rangoS.setEstado(rs.getInt(6));
        return rangoS;
    }
}
