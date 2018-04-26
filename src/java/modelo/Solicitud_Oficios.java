/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.io.*;
import java.sql.*;

/**
 *
 * @author Administrador
 */
public class Solicitud_Oficios implements Serializable {

    private long id_oficio,fk_usuario,numero_interno;
    private int estado;
    private String num_oficio,num_radicacion,solicitante,cargo,referencia,direccion,municipio,entidad;
    private Date fecha_oficio,fecha_radicacion;
    private Timestamp fecha_proceso;

    public long getNumero_interno() {
        return numero_interno;
    }

    public void setNumero_interno(long numero_interno) {
        this.numero_interno = numero_interno;
    }



    public String getEntidad() {
        return entidad;
    }

    public void setEntidad(String entidad) {
        this.entidad = entidad;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public String getCargo() {
        return cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
    }

    public String getDireccion(){
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

    public Date getFecha_oficio() {
        return fecha_oficio;
    }

    public void setFecha_oficio(Date fecha_oficio) {
        this.fecha_oficio = fecha_oficio;
    }

    public Timestamp getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Timestamp fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public Date getFecha_radicacion() {
        return fecha_radicacion;
    }

    public void setFecha_radicacion(Date fecha_radicacion) {
        this.fecha_radicacion = fecha_radicacion;
    }

    public long getId_oficio() {
        return id_oficio;
    }

    public void setId_oficio(long id_oficio) {
        this.id_oficio = id_oficio;
    }

    public String getMunicipio() {
        return municipio;
    }

    public void setMunicipio(String municipio) {
        this.municipio = municipio;
    }

    public String getNum_oficio() {
        return num_oficio;
    }

    public void setNum_oficio(String num_oficio) {
        this.num_oficio = num_oficio;
    }

    public String getNum_radicacion() {
        return num_radicacion;
    }

    public void setNum_radicacion(String num_radicacion) {
        this.num_radicacion = num_radicacion;
    }

    public String getReferencia() {
        return referencia;
    }

    public void setReferencia(String referencia) {
        this.referencia = referencia;
    }

    public String getSolicitante() {
        return solicitante;
    }

    public void setSolicitante(String solicitante) {
        this.solicitante = solicitante;
    }

    public static Solicitud_Oficios load(java.sql.ResultSet rs)throws Exception{
        Solicitud_Oficios SolicitudO = new Solicitud_Oficios();
        SolicitudO.setId_oficio(rs.getLong(1));
        SolicitudO.setNum_oficio(rs.getString(2));
        SolicitudO.setFecha_oficio(rs.getDate(3));
        SolicitudO.setNum_radicacion(rs.getString(4));
        SolicitudO.setFecha_radicacion(rs.getDate(5));
        SolicitudO.setSolicitante(rs.getString(6));
        SolicitudO.setCargo(rs.getString(7));
        SolicitudO.setReferencia(rs.getString(8));
        SolicitudO.setDireccion(rs.getString(9));
        SolicitudO.setMunicipio(rs.getString(10));
        SolicitudO.setFecha_proceso(rs.getTimestamp(11));
        SolicitudO.setEstado(rs.getInt(12));
        SolicitudO.setFk_usuario(rs.getLong(13));
        SolicitudO.setEntidad(rs.getString(14));
        SolicitudO.setNumero_interno(rs.getLong(15));
        return SolicitudO;
    }



}
