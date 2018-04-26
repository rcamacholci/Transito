/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.*;
/**
 *
 * @author Flia. Aguas Macias
 */
public class Representante {
    private long id_representante;
    private long fk_persona;
    private String tipo_contrato;
    private Date fecha_inicio_representacion;
    private String estado_representacion;
    private Date fecha_vigencia;

    public String getEstado_representacion() {
        return estado_representacion;
    }

    public void setEstado_representacion(String estado_representacion) {
        this.estado_representacion = estado_representacion;
    }

    public Date getFecha_inicio_representacion() {
        return fecha_inicio_representacion;
    }

    public void setFecha_inicio_representacion(Date fecha_inicio_representacion) {
        this.fecha_inicio_representacion = fecha_inicio_representacion;
    }

    public Date getFecha_vigencia() {
        return fecha_vigencia;
    }

    public void setFecha_vigencia(Date fecha_vigencia) {
        this.fecha_vigencia = fecha_vigencia;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    }

    public long getId_representante() {
        return id_representante;
    }

    public void setId_representante(long id_representante) {
        this.id_representante = id_representante;
    }

    public String getTipo_contrato() {
        return tipo_contrato;
    }

    public void setTipo_contrato(String tipo_contrato) {
        this.tipo_contrato = tipo_contrato;
    }

    public static Representante load(ResultSet rs)throws SQLException{
           Representante representante = new Representante();
           representante.setId_representante(rs.getLong(1));
           representante.setFk_persona(rs.getLong(2));
           representante.setTipo_contrato(rs.getString(3));
           representante.setFecha_inicio_representacion(rs.getDate(4));
           representante.setEstado_representacion(rs.getString(5));
           representante.setFecha_vigencia(rs.getDate(6));
           
           return representante;
    }
}
