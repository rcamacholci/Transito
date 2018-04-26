/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

/**
 *
 * @author Administrador
 */
public class Resolucion_Comparendo {

    private long id_resolucion;
    private String numero;
    private Date fecha;
    private int tipo;
    private float valor;
    private int estado;
    private long fk_usuario;
    private Timestamp fecha_proceso;
    private String observacion;
    private long fk_comparendo;

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Timestamp getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Timestamp fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public long getFk_comparendo() {
        return fk_comparendo;
    }

    public void setFk_comparendo(long fk_comparendo) {
        this.fk_comparendo = fk_comparendo;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getId_resolucion() {
        return id_resolucion;
    }

    public void setId_resolucion(long id_resolucion) {
        this.id_resolucion = id_resolucion;
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

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }

    public static Resolucion_Comparendo load(ResultSet rs)throws SQLException{
        Resolucion_Comparendo resolucionComparendo = new Resolucion_Comparendo();
        resolucionComparendo.setId_resolucion(rs.getLong(1));
        resolucionComparendo.setNumero(rs.getString(2));
        resolucionComparendo.setFecha(rs.getDate(3));
        resolucionComparendo.setTipo(rs.getInt(4));
        resolucionComparendo.setValor(rs.getFloat(5));
        resolucionComparendo.setEstado(rs.getInt(6));
        resolucionComparendo.setFk_usuario(rs.getLong(7));
        resolucionComparendo.setFecha_proceso(rs.getTimestamp(8));
        resolucionComparendo.setObservacion(rs.getString(9));
        resolucionComparendo.setFk_comparendo(rs.getLong(10));
        return resolucionComparendo;
    }
}
