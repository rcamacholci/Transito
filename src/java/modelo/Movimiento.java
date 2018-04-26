/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

/**
 * @version 0.1
 * @author Jorge lopez
 * Created on : 24-feb-2010, 14:50:07
 *
 */
public class Movimiento {
    private long id_movimiento;
    private long fk_vehiculo;
    private int tipo_movimiento;
    private long fk_sede;
    private String numero_licencia;
    private Timestamp fecha_movimiento;
    private String numero_guia;
    private String responsable_envio;    
    private Timestamp fecha_envio;
    private int estado_envio;
    private long fk_usuario_movimiento;
    private long fk_usuario_envio;
    private int estado;

    public int getEstado_envio() {
        return estado_envio;
    }

    public void setEstado_envio(int estado_envio) {
        this.estado_envio = estado_envio;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Timestamp getFecha_envio() {
        return fecha_envio;
    }

    public void setFecha_envio(Timestamp fecha_envio) {
        this.fecha_envio = fecha_envio;
    }

    public Timestamp getFecha_movimiento() {
        return fecha_movimiento;
    }

    public void setFecha_movimiento(Timestamp fecha_movimiento) {
        this.fecha_movimiento = fecha_movimiento;
    }

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getFk_vehiculo() {
        return fk_vehiculo;
    }

    public void setFk_vehiculo(long fk_vehiculo) {
        this.fk_vehiculo = fk_vehiculo;
    }

    public long getId_movimiento() {
        return id_movimiento;
    }

    public void setId_movimiento(long id_movimiento) {
        this.id_movimiento = id_movimiento;
    }
    
    public String getNumero_guia() {
        return numero_guia;
    }

    public void setNumero_guia(String numero_guia) {
        this.numero_guia = numero_guia;
    }

    public String getResponsable_envio() {
        return responsable_envio;
    }

    public void setResponsable_envio(String responsable_envio) {
        this.responsable_envio = responsable_envio;
    }

    public String getNumero_licencia() {
        return numero_licencia;
    }

    public void setNumero_licencia(String numero_licencia) {
        this.numero_licencia = numero_licencia;
    }

    public int getTipo_movimiento() {
        return tipo_movimiento;
    }

    public void setTipo_movimiento(int tipo_movimiento) {
        this.tipo_movimiento = tipo_movimiento;
    }

    public long getFk_usuario_envio() {
        return fk_usuario_envio;
    }

    public void setFk_usuario_envio(long fk_usuario_envio) {
        this.fk_usuario_envio = fk_usuario_envio;
    }

    public long getFk_usuario_movimiento() {
        return fk_usuario_movimiento;
    }

    public void setFk_usuario_movimiento(long fk_usuario_movimiento) {
        this.fk_usuario_movimiento = fk_usuario_movimiento;
    }

    protected static Movimiento load (ResultSet rst)throws SQLException{
        Movimiento m = new Movimiento() ;
        m.setId_movimiento(rst.getLong(1)) ;
        m.setFk_vehiculo(rst.getLong(2)) ;
        m.setTipo_movimiento(rst.getInt(3)) ;
        m.setFk_sede(rst.getLong(4));
        m.setNumero_licencia(rst.getString(5));
        m.setFecha_movimiento(rst.getTimestamp(6));
        m.setNumero_guia(rst.getString(7));
        m.setResponsable_envio(rst.getString(8));        
        m.setFecha_envio(rst.getTimestamp(9));
        m.setEstado_envio(rst.getInt(10));
        m.setFk_usuario_movimiento(rst.getLong(11));
        m.setFk_usuario_envio(rst.getLong(12));
        m.setEstado(rst.getInt(13));
        return m ;
    }

}
