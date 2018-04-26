/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.Timestamp;

/**
 *
 * @author Administrador
 */
public class DigitalCarpeta {

    private long idDigitalCarpeta;
    private long fk_vehiculo;
    private String nombre;
    private String direccion;
    private String observacion;
    private java.sql.Timestamp fecha_ingreso;
    private java.sql.Timestamp fecha_modificacion;

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public Timestamp getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(Timestamp fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }

    public Timestamp getFecha_modificacion() {
        return fecha_modificacion;
    }

    public void setFecha_modificacion(Timestamp fecha_modificacion) {
        this.fecha_modificacion = fecha_modificacion;
    }

    public long getFk_vehiculo() {
        return fk_vehiculo;
    }

    public void setFk_vehiculo(long fk_vehiculo) {
        this.fk_vehiculo = fk_vehiculo;
    }

    public long getIdDigitalCarpeta() {
        return idDigitalCarpeta;
    }

    public void setIdDigitalCarpeta(long idDigitalCarpeta) {
        this.idDigitalCarpeta = idDigitalCarpeta;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public static DigitalCarpeta load(java.sql.ResultSet rs)throws java.sql.SQLException{
        DigitalCarpeta digitalCarpeta = new DigitalCarpeta();
        digitalCarpeta.setIdDigitalCarpeta(rs.getLong(1));
        digitalCarpeta.setFk_vehiculo(rs.getLong(2));
        digitalCarpeta.setNombre(rs.getString(3));
        digitalCarpeta.setDireccion(rs.getString(4));
        digitalCarpeta.setObservacion(rs.getString(5));
        digitalCarpeta.setFecha_ingreso(rs.getTimestamp(6));
        digitalCarpeta.setFecha_modificacion(rs.getTimestamp(7));
        return digitalCarpeta;
    }
}
