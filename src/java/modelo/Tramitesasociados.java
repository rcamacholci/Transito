/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Sistemas-Jefrey
 */
public class Tramitesasociados {

    private long id_tramite_asociado, usuario_solicitante, fk_vehiculo;
    private String nombre_tramite, referencia, observacion, estado;
    private Date fecha, fecha_registro;

    public long getId_tramite_asociado() {
        return id_tramite_asociado;
    }

    public void setId_tramite_asociado(long id_tramite_asociado) {
        this.id_tramite_asociado = id_tramite_asociado;
    }

    public long getUsuario_solicitante() {
        return usuario_solicitante;
    }

    public void setUsuario_solicitante(long usuario_solicitante) {
        this.usuario_solicitante = usuario_solicitante;
    }

    public long getFk_vehiculo() {
        return fk_vehiculo;
    }

    public void setFk_vehiculo(long fk_vehiculo) {
        this.fk_vehiculo = fk_vehiculo;
    }

    public String getNombre_tramite() {
        return nombre_tramite;
    }

    public void setNombre_tramite(String nombre_tramite) {
        this.nombre_tramite = nombre_tramite;
    }

    public String getReferencia() {
        return referencia;
    }

    public void setReferencia(String referencia) {
        this.referencia = referencia;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Date getFecha_registro() {
        return fecha_registro;
    }

    public void setFecha_registro(Date fecha_registro) {
        this.fecha_registro = fecha_registro;
    }

    public static Tramitesasociados load(ResultSet rs)throws SQLException{
        Tramitesasociados tramitesA= new Tramitesasociados();
        tramitesA.setId_tramite_asociado(rs.getLong(1));
        tramitesA.setNombre_tramite(rs.getString(2));
        tramitesA.setReferencia(rs.getString(3));
        tramitesA.setFecha(rs.getDate(4));
        tramitesA.setObservacion(rs.getString(5));
        tramitesA.setEstado(rs.getString(6));
        tramitesA.setUsuario_solicitante(rs.getLong(7));
        tramitesA.setFecha_registro(rs.getDate(8));
        tramitesA.setFk_vehiculo(rs.getLong(9));

        return tramitesA;
    }

}
