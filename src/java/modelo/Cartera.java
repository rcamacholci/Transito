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
public class Cartera implements Serializable {
    private long id_cartera,fk_pago,fk_persona,fk_vehiculo,fk_concepto,fk_usuario,fk_sede,periodo;
    private int tipo,estado_vigencia,estado_cartera;
    private  String referencia;
    private Date fecha_creacion,fecha_ingreso,fecha_saldo,fecha_estado,fecha_estado_vigencia;
    private double valor,saldo;

    public int getEstado_cartera() {
        return estado_cartera;
    }

    public long getPeriodo() {
        return periodo;
    }

    public void setPeriodo(long periodo) {
        this.periodo = periodo;
    }

    public void setEstado_cartera(int estado_cartera) {
        this.estado_cartera = estado_cartera;
    }

    public int getEstado_vigencia() {
        return estado_vigencia;
    }

    public void setEstado_vigencia(int estado_vigencia) {
        this.estado_vigencia = estado_vigencia;
    }

    public Date getFecha_creacion() {
        return fecha_creacion;
    }

    public void setFecha_creacion(Date fecha_creacion) {
        this.fecha_creacion = fecha_creacion;
    }

    public Date getFecha_estado() {
        return fecha_estado;
    }

    public void setFecha_estado(Date fecha_estado) {
        this.fecha_estado = fecha_estado;
    }

    public Date getFecha_estado_vigencia() {
        return fecha_estado_vigencia;
    }

    public void setFecha_estado_vigencia(Date fecha_estado_vigencia) {
        this.fecha_estado_vigencia = fecha_estado_vigencia;
    }

    public Date getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(Date fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }

    public Date getFecha_saldo() {
        return fecha_saldo;
    }

    public void setFecha_saldo(Date fecha_saldo) {
        this.fecha_saldo = fecha_saldo;
    }

    public long getFk_concepto() {
        return fk_concepto;
    }

    public void setFk_concepto(long fk_concepto) {
        this.fk_concepto = fk_concepto;
    }

    public long getFk_pago() {
        return fk_pago;
    }

    public void setFk_pago(long fk_pago) {
        this.fk_pago = fk_pago;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
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

    public long getFk_vehiculo() {
        return fk_vehiculo;
    }

    public void setFk_vehiculo(long fk_vehiculo) {
        this.fk_vehiculo = fk_vehiculo;
    }

    public long getId_cartera() {
        return id_cartera;
    }

    public void setId_cartera(long id_cartera) {
        this.id_cartera = id_cartera;
    }

    public String getReferencia() {
        return referencia;
    }

    public void setReferencia(String referencia) {
        this.referencia = referencia;
    }

    public double getSaldo() {
        return saldo;
    }

    public void setSaldo(double saldo) {
        this.saldo = saldo;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }
    
    public static Cartera Load(ResultSet rs)throws SQLException{
        Cartera cartera = new Cartera();
        cartera.setId_cartera(rs.getLong(1));
        cartera.setFk_pago(rs.getLong(2));
        cartera.setFk_persona(rs.getLong(3));
        cartera.setFk_vehiculo(rs.getLong(4));
        cartera.setFk_sede(rs.getLong(5));
        cartera.setTipo(rs.getInt(6));
        cartera.setReferencia(rs.getString(7));
        cartera.setFecha_creacion(rs.getDate(8));
        cartera.setFecha_ingreso(rs.getDate(9));
        cartera.setValor(rs.getDouble(10));
        cartera.setSaldo(rs.getDouble(11));
        cartera.setFecha_saldo(rs.getDate(12));
        cartera.setEstado_cartera(rs.getInt(13));
        cartera.setFecha_estado(rs.getDate(14));
        cartera.setEstado_vigencia(rs.getInt(15));
        cartera.setFecha_estado_vigencia(rs.getDate(16));
        cartera.setFk_usuario(rs.getLong(17));
        cartera.setFk_concepto(rs.getLong(18));
        cartera.setPeriodo(rs.getLong(19));
        
        return cartera;
        
        
    }
    

}

