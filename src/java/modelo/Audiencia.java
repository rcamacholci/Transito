/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

/**
 *
 * @author ZEE
 */
public class Audiencia {

    private long idAudiencia;
    private long fkProcesoComparendo;
    private long fkComparendo;
    private Timestamp fecha;
    private int estado;
    private int asistencia;
    private String observacion;
    private long fkUsuario;
    private long fkSede;

    /**
     * @return the idAudiencia
     */
    public long getIdAudiencia() {
        return idAudiencia;
    }

    /**
     * @param idAudiencia the idAudiencia to set
     */
    public void setIdAudiencia(long idAudiencia) {
        this.idAudiencia = idAudiencia;
    }

    /**
     * @return the fkProcesoComparendo
     */
    public long getFkProcesoComparendo() {
        return fkProcesoComparendo;
    }

    /**
     * @param fkProcesoComparendo the fkProcesoComparendo to set
     */
    public void setFkProcesoComparendo(long fkProcesoComparendo) {
        this.fkProcesoComparendo = fkProcesoComparendo;
    }

    /**
     * @return the fkProcesoComparendo
     */
    public long getFkComparendo() {
        return fkComparendo;
    }

    /**
     * @param fkProcesoComparendo the fkProcesoComparendo to set
     */
    public void setFkComparendo(long fkComparendo) {
        this.fkComparendo = fkComparendo;
    }

    /**
     * @return the fecha
     */
    public Timestamp getFecha() {
        return fecha;
    }

    /**
     * @param fecha the fecha to set
     */
    public void setFecha(Timestamp fecha) {
        this.fecha = fecha;
    }

    /**
     * @return the estado
     */
    public int getEstado() {
        return estado;
    }

    /**
     * @param estado the estado to set
     */
    public void setEstado(int estado) {
        this.estado = estado;
    }

    /**
     * @return the asistencia
     */
    public int getAsistencia() {
        return asistencia;
    }

    /**
     * @param asistencia the asistencia to set
     */
    public void setAsistencia(int asistencia) {
        this.asistencia = asistencia;
    }

    /**
     * @return the observacion
     */
    public String getObservacion() {
        return observacion;
    }

    /**
     * @param observacion the observacion to set
     */
    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    /**
     * @return the fkUsuario
     */
    public long getFkUsuario() {
        return fkUsuario;
    }

    /**
     * @param fkUsuario the fkUsuario to set
     */
    public void setFkUsuario(long fkUsuario) {
        this.fkUsuario = fkUsuario;
    }

    /**
     * @return the fkSede
     */
    public long getFkSede() {
        return fkSede;
    }

    /**
     * @param fkSede the fkSede to set
     */
    public void setFkSede(long fkSede) {
        this.fkSede = fkSede;
    }

    public static Audiencia load(ResultSet rst) throws SQLException {
        Audiencia audiencia = new Audiencia();

        audiencia.setIdAudiencia(rst.getLong(1));
        audiencia.setFkProcesoComparendo(rst.getLong(2));
        audiencia.setFkComparendo(rst.getLong(3));
        audiencia.setFecha(rst.getTimestamp(4));
        audiencia.setEstado(rst.getInt(5));
        audiencia.setAsistencia(rst.getInt(6));
        audiencia.setObservacion(rst.getString(7));
        audiencia.setFkUsuario(rst.getLong(8));
        audiencia.setFkSede(rst.getLong(9));

        return audiencia;
    }
}
