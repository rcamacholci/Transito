/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.Timestamp;

/**
 *
 * @author Administrador
 */
public class Sincronizacion {

    private long id_sincronizacion;
    private int tipo;
    private long fk_vehiculo;
    private long fk_persona;
    private String resultado;
    private java.sql.Timestamp fecha;
    private int estado;
    private long fk_usuario;

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Timestamp getFecha() {
        return fecha;
    }

    public void setFecha(Timestamp fecha) {
        this.fecha = fecha;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getFk_vehiculo() {
        return fk_vehiculo;
    }

    public void setFk_vehiculo(long fk_vehiculo) {
        this.fk_vehiculo = fk_vehiculo;
    }

    public long getId_sincronizacion() {
        return id_sincronizacion;
    }

    public void setId_sincronizacion(long id_sincronizacion) {
        this.id_sincronizacion = id_sincronizacion;
    }

    public String getResultado() {
        return resultado;
    }

    public void setResultado(String resultado) {
        this.resultado = resultado;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    public static Sincronizacion load(java.sql.ResultSet rs)throws Exception{
        Sincronizacion sincronizacion = new Sincronizacion();
        sincronizacion.setId_sincronizacion(rs.getLong(1));
        sincronizacion.setTipo(rs.getInt(2));
        sincronizacion.setFk_vehiculo(rs.getLong(3));
        sincronizacion.setFk_persona(rs.getLong(4));
        sincronizacion.setResultado(rs.getString(5));
        sincronizacion.setFecha(rs.getTimestamp(6));
        sincronizacion.setEstado(rs.getInt(7));
        sincronizacion.setFk_usuario(rs.getLong(8));
        return sincronizacion;
    }
}
