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
public class Oficio_Embargo implements Serializable {

    private long id_oficio,fk_usuario,fk_vehiculo,fk_embargo;
    private int estado,novedad;
    private String num_oficio,num_radicacion,solicitante,cargo,referencia,direccion,municipio,entidad;
    private Date fecha_oficio,fecha_radicacion;
    private Timestamp fecha_proceso;

    public long getFk_embargo() {
        return fk_embargo;
    }

    public void setFk_embargo(long fk_embargo) {
        this.fk_embargo = fk_embargo;
    }

    public int getNovedad() {
        return novedad;
    }

    public void setNovedad(int novedad) {
        this.novedad = novedad;
    }

    public long getFk_vehiculo() {
        return fk_vehiculo;
    }

    public void setFk_vehiculo(long fk_vehiculo) {
        this.fk_vehiculo = fk_vehiculo;
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

    public static Oficio_Embargo load(java.sql.ResultSet rs)throws Exception{
        Oficio_Embargo OficioE = new Oficio_Embargo();
        OficioE.setId_oficio(rs.getLong(1));
        OficioE.setNum_oficio(rs.getString(2));
        OficioE.setFecha_oficio(rs.getDate(3));
        OficioE.setNum_radicacion(rs.getString(4));
        OficioE.setFecha_radicacion(rs.getDate(5));
        OficioE.setSolicitante(rs.getString(6));
        OficioE.setCargo(rs.getString(7));
        OficioE.setReferencia(rs.getString(8));
        OficioE.setDireccion(rs.getString(9));
        OficioE.setMunicipio(rs.getString(10));
        OficioE.setFecha_proceso(rs.getTimestamp(11));
        OficioE.setEstado(rs.getInt(12));
        OficioE.setFk_usuario(rs.getLong(13));
        OficioE.setEntidad(rs.getString(14));
        OficioE.setFk_vehiculo(rs.getLong(15));
        OficioE.setFk_embargo(rs.getLong(16));
        OficioE.setNovedad(rs.getInt(17));
        return OficioE;
    }



}
