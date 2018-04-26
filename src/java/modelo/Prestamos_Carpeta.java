package modelo;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author SISTEMAS
 */
import java.io.*;
import java.sql.*;
public class Prestamos_Carpeta implements Serializable {
    private long id_prestamo, fk_carpeta, fk_usuario;
    private int estado, motivo, tramite;
    private  String observacion;
    private Date fecha_prestamo,fecha_entrega,fecha_solicitud;

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Date getFecha_entrega() {
        return fecha_entrega;
    }

    public void setFecha_entrega(Date fecha_entrega) {
        this.fecha_entrega = fecha_entrega;
    }

     public Date getFecha_solicitud() {
        return fecha_solicitud;
    }

    public void setFecha_solicitud(Date fecha_solicitud) {
        this.fecha_solicitud = fecha_solicitud;
    }

    public Date getFecha_prestamo() {
        return fecha_prestamo;
    }

    public void setFecha_prestamo(Date fecha_prestamo) {
        this.fecha_prestamo = fecha_prestamo;
    }

    public long getFk_carpeta() {
        return fk_carpeta;
    }

    public void setFk_carpeta(long fk_carpeta) {
        this.fk_carpeta = fk_carpeta;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getId_prestamo() {
        return id_prestamo;
    }

    public void setId_prestamo(long id_prestamo) {
        this.id_prestamo = id_prestamo;
    }

    public int getMotivo() {
        return motivo;
    }

    public void setMotivo(int motivo) {
        this.motivo = motivo;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public int getTramite() {
        return tramite;
    }

    public void setTramite(int tramite) {
        this.tramite = tramite;
    }

     public static Prestamos_Carpeta load(ResultSet rs)throws SQLException{
           Prestamos_Carpeta prestamo =new Prestamos_Carpeta();
           prestamo.setId_prestamo(rs.getLong(1));
           prestamo.setFk_carpeta(rs.getLong(2));
           prestamo.setFecha_prestamo(rs.getDate(3));
           prestamo.setFecha_entrega(rs.getDate(4));
           prestamo.setEstado(rs.getInt(5));
           prestamo.setFk_usuario(rs.getLong(6));
           prestamo.setMotivo(rs.getInt(7));
           prestamo.setTramite(rs.getInt(8));
           prestamo.setObservacion(rs.getString(9));
           prestamo.setFecha_solicitud(rs.getDate(10));
           return prestamo;
   }


}
