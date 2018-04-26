/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;
import java.io.*;
import java.sql.*;

/**

/**
 *
 * @author Administrador
 */

public class Empresa_Vinculadora implements Serializable {
  private long id_empresa_vinculadora, fk_vehiculo, fk_persona;
  private Date  fecha_inicio,fecha_fin;
  private String observacion;

    public Date getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public Date getFecha_inicio() {
        return fecha_inicio;
    }

    public void setFecha_inicio(Date fecha_inicio) {
        this.fecha_inicio = fecha_inicio;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    }

    public long getFk_vehiculo() {
        return fk_vehiculo;
    }

    public void setFk_vehiculo(long fk_vehiculo) {
        this.fk_vehiculo = fk_vehiculo;
    }

    public long getId_empresa_vinculadora() {
        return id_empresa_vinculadora;
    }

    public void setId_empresa_vinculadora(long id_empresa_vinculadora) {
        this.id_empresa_vinculadora = id_empresa_vinculadora;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

     public static Empresa_Vinculadora load(ResultSet rs)throws SQLException{
           Empresa_Vinculadora empresaV =new Empresa_Vinculadora();
           empresaV.setId_empresa_vinculadora(rs.getLong(1));
           empresaV.setFk_persona(rs.getLong(2));
           empresaV.setFk_vehiculo(rs.getLong(3));
           empresaV.setFecha_inicio(rs.getDate(4));
           empresaV.setFecha_fin(rs.getDate(5));
           empresaV.setObservacion(rs.getString(6));
           return empresaV;
}

}
