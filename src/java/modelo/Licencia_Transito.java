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
public class Licencia_Transito implements Serializable{
    
    private long id_licenciaTransito,fk_radicacion,fk_vehiculo,fk_sede,fk_usuario;
    private String numero,numero_sustrato;
    private Date fecha_expedicion,fecha_impresion;
    private int estado;

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

    public long getFk_radicacion() {
        return fk_radicacion;
    }

    public void setFk_radicacion(long fk_radicacion) {
        this.fk_radicacion = fk_radicacion;
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

    public long getId_licenciaTransito() {
        return id_licenciaTransito;
    }

    public void setId_licenciaTransito(long id_licenciaTransito) {
        this.id_licenciaTransito = id_licenciaTransito;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getNumero_sustrato() {
        return numero_sustrato;
    }

    public void setNumero_sustrato(String numero_sustrato) {
        this.numero_sustrato = numero_sustrato;
    }


    public static Licencia_Transito load(ResultSet rs)throws SQLException{
        
        Licencia_Transito licencia_transito=new Licencia_Transito();
        licencia_transito.setId_licenciaTransito(rs.getLong(1));
        licencia_transito.setFk_radicacion(rs.getLong(2));
        licencia_transito.setFk_vehiculo(rs.getLong(3));
        licencia_transito.setNumero(rs.getString(4));
        licencia_transito.setFecha_expedicion(rs.getDate(5));
        licencia_transito.setFecha_impresion(rs.getDate(6));
        licencia_transito.setEstado(rs.getInt(7));
        licencia_transito.setFk_sede(rs.getLong(8));
        licencia_transito.setNumero_sustrato(rs.getString(9));
        licencia_transito.setFk_usuario(rs.getLong(10));
        return licencia_transito;
    } 

}
