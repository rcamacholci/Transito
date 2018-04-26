/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;
import java.io.*;
import java.sql.*;

/**
 *
 * @author SISTEMAS
 */
public class Documento implements Serializable {
  private long id_documento, fk_vehiculo, fk_persona,fk_usuario;
  private Date  fecha_impresion,fecha_expedicion;
  private String numero,referencia,observacion,direccion;
  private int estado, tipo;

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Date getFecha_expedicion() {
        return fecha_expedicion;
    }

    public void setFecha_expedicion(Date fecha_expedicion) {
        this.fecha_expedicion = fecha_expedicion;
    }

    public Date getFecha_impresion() {
        return fecha_impresion;
    }

    public void setFecha_impresion(Date fecha_impresion) {
        this.fecha_impresion = fecha_impresion;
    }

    public long getFk_Persona() {
        return fk_persona;
    }

    public void setFk_Persona(long fk_persona) {
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

    public long getId_documento() {
        return id_documento;
    }

    public void setId_documento(long id_documento) {
        this.id_documento = id_documento;
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

    public String getReferencia() {
        return referencia;
    }

    public void setReferencia(String referencia) {
        this.referencia = referencia;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

 public static Documento load(ResultSet rs)throws SQLException{
           Documento documento =new Documento();
           documento.setId_documento(rs.getLong(1));
           documento.setNumero(rs.getString(2));
           documento.setTipo(rs.getInt(3));
           documento.setReferencia(rs.getString(4));
           documento.setFk_vehiculo(rs.getLong(5));
           documento.setFk_Persona(rs.getLong(6));
           documento.setEstado(rs.getInt(7));
           documento.setFecha_expedicion(rs.getDate(8));
           documento.setFecha_impresion(rs.getDate(9));
           documento.setObservacion(rs.getString(10));
           documento.setDireccion(rs.getString(11));
           documento.setFk_usuario(rs.getLong(12));
           return documento;
}


}
