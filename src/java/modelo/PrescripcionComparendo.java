/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.*;
/**
 *
 * @author Administrador
 */
public class PrescripcionComparendo {

    private long id_prescripcioncomarendo,fk_persona, estado;
    private Date fecha_resolucion, fecha_comparendo;
    private String  numero_resolucion, numero_comparendo;
    private Timestamp fecha_proceso;

    public long getEstado() {
        return estado;
    }

    public void setEstado(long estado) {
        this.estado = estado;
    }

    public Date getFecha_comparendo() {
        return fecha_comparendo;
    }

    public void setFecha_comparendo(Date fecha_comparendo) {
        this.fecha_comparendo = fecha_comparendo;
    }

    public Timestamp getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Timestamp fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public Date getFecha_resolucion() {
        return fecha_resolucion;
    }

    public void setFecha_resolucion(Date fecha_resolucion) {
        this.fecha_resolucion = fecha_resolucion;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    }

    public long getId_prescripcioncomarendo() {
        return id_prescripcioncomarendo;
    }

    public void setId_prescripcioncomarendo(long id_prescripcioncomarendo) {
        this.id_prescripcioncomarendo = id_prescripcioncomarendo;
    }

    public String getNumero_comparendo() {
        return numero_comparendo;
    }

    public void setNumero_comparendo(String numero_comparendo) {
        this.numero_comparendo = numero_comparendo;
    }

    public String getNumero_resolucion() {
        return numero_resolucion;
    }

    public void setNumero_resolucion(String numero_resolucion) {
        this.numero_resolucion = numero_resolucion;
    }


     public static PrescripcionComparendo load(java.sql.ResultSet rs)throws java.sql.SQLException{
        PrescripcionComparendo PrescripcionComp = new PrescripcionComparendo();
        PrescripcionComp.setId_prescripcioncomarendo(rs.getLong(1));
        PrescripcionComp.setFecha_comparendo(rs.getDate(2));
        PrescripcionComp.setFecha_proceso(rs.getTimestamp(3));
        PrescripcionComp.setFecha_resolucion(rs.getDate(4));
        PrescripcionComp.setFk_persona(rs.getLong(5));
        PrescripcionComp.setNumero_comparendo(rs.getString(6));
        PrescripcionComp.setNumero_resolucion(rs.getString(7));
        PrescripcionComp.setEstado(rs.getLong(8));

        return PrescripcionComp;
    }
}
