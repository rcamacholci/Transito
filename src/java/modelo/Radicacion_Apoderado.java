/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.Date;

/**
 *
 * @author Civitrans
 */
public class Radicacion_Apoderado implements java.io.Serializable{
    private long id_radicacion_apoderado;
    private long fk_formulario;
    private long fk_propietario;
    private long fk_apoderado;
    private java.sql.Date fecha_inicio;
    private java.sql.Date fecha_fin;

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

    public long getFk_apoderado() {
        return fk_apoderado;
    }

    public void setFk_apoderado(long fk_apoderado) {
        this.fk_apoderado = fk_apoderado;
    }

    public long getFk_formulario() {
        return fk_formulario;
    }

    public void setFk_formulario(long fk_formulario) {
        this.fk_formulario = fk_formulario;
    }

    public long getFk_propietario() {
        return fk_propietario;
    }

    public void setFk_propietario(long fk_propietario) {
        this.fk_propietario = fk_propietario;
    }

    public long getId_radicacion_apoderado() {
        return id_radicacion_apoderado;
    }

    public void setId_radicacion_apoderado(long id_radicacion_apoderado) {
        this.id_radicacion_apoderado = id_radicacion_apoderado;
    }

    public static Radicacion_Apoderado load(java.sql.ResultSet rs) throws java.sql.SQLException{
        Radicacion_Apoderado radicacion_apoderado = new Radicacion_Apoderado();
        radicacion_apoderado.setId_radicacion_apoderado(rs.getLong(1));
        radicacion_apoderado.setFk_formulario(rs.getLong(2));
        radicacion_apoderado.setFk_propietario(rs.getLong(3));
        radicacion_apoderado.setFk_apoderado(rs.getLong(4));
        radicacion_apoderado.setFecha_inicio(rs.getDate(5));
        radicacion_apoderado.setFecha_fin(rs.getDate(6));
        return radicacion_apoderado;
    }
}
