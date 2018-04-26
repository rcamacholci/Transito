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
public class Respuesta_Solicitud implements Serializable {

    private long id_oficioRespuesta,fk_usuario,fk_solicitud_Oficio;
    private int estado;
    private String num_oficioRespuesta,oficio_comercial;
    private Date fecha_oficioRespuesta;
    private Timestamp fecha_proceso;

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public String getOficio_comercial() {
        return oficio_comercial;
    }

    public void setOficio_comercial(String oficio_comercial) {
        this.oficio_comercial = oficio_comercial;
    }

    public Date getFecha_oficioRespuesta() {
        return fecha_oficioRespuesta;
    }

    public void setFecha_oficioRespuesta(Date fecha_oficioRespuesta) {
        this.fecha_oficioRespuesta = fecha_oficioRespuesta;
    }

    public Timestamp getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Timestamp fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public long getFk_solicitud_Oficio() {
        return fk_solicitud_Oficio;
    }

    public void setFk_solicitud_Oficio(long fk_solicitud_Oficio) {
        this.fk_solicitud_Oficio = fk_solicitud_Oficio;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getId_oficioRespuesta() {
        return id_oficioRespuesta;
    }

    public void setId_oficioRespuesta(long id_oficioRespuesta) {
        this.id_oficioRespuesta = id_oficioRespuesta;
    }

    public String getNum_oficioRespuesta() {
        return num_oficioRespuesta;
    }

    public void setNum_oficioRespuesta(String num_oficioRespuesta) {
        this.num_oficioRespuesta = num_oficioRespuesta;
    }

   public static Respuesta_Solicitud load(java.sql.ResultSet rs)throws Exception{
        Respuesta_Solicitud RespuestaO = new Respuesta_Solicitud();
        RespuestaO.setId_oficioRespuesta(rs.getLong(1));
        RespuestaO.setNum_oficioRespuesta(rs.getString(2));
        RespuestaO.setFecha_oficioRespuesta(rs.getDate(3));
        RespuestaO.setFk_solicitud_Oficio(rs.getLong(4));
        RespuestaO.setFecha_proceso(rs.getTimestamp(5));
        RespuestaO.setEstado(rs.getInt(6));
        RespuestaO.setFk_usuario(rs.getLong(7));
        RespuestaO.setOficio_comercial(rs.getString(8));
        return RespuestaO;
    }


}
