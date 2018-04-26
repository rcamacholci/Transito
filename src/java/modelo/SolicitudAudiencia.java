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
public class SolicitudAudiencia {
    
    private long idSolicitudAudiencia ;
    private long fkProcesoComparendo;
    private long fkComparendo ;
    private Timestamp fechaRadicacion;
    private int estado ;
    private String numeroRadicacion ;
    private String observacion ;
    private long fkUsuario;
    private long fkSede ;

    /**
     * @return the idSolicitudAudiencia
     */
    public long getIdSolicitudAudiencia() {
        return idSolicitudAudiencia;
    }

    /**
     * @param idSolicitudAudiencia the idSolicitudAudiencia to set
     */
    public void setIdSolicitudAudiencia(long idSolicitudAudiencia) {
        this.idSolicitudAudiencia = idSolicitudAudiencia;
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
     * @param fkComparendo the fkProcesoComparendo to set
     */
    public void setFkComparendo(long fkComparendo) {
        this.fkComparendo = fkComparendo;
    }


    /**
     * @return the fecha
     */
    public Timestamp getFechaRadicacion() {
        return fechaRadicacion;
    }

    /**
     * @param fecha the fecha to set
     */
    public void setFechaRadicacion(Timestamp fecha) {
        this.fechaRadicacion = fecha;
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
     * @return the estado
     */
    public String getNumeroRadicacion() {
        return numeroRadicacion;
    }

    /**
     * @param estado the estado to set
     */
    public void setNumeroRadicacion(String numeroRadicacion) {
        this.numeroRadicacion = numeroRadicacion;
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
    
    
    public static SolicitudAudiencia load( ResultSet rst ) throws SQLException{
        
        SolicitudAudiencia s = new SolicitudAudiencia() ;
        
        s.setIdSolicitudAudiencia(rst.getLong(1));
        s.setFkProcesoComparendo(rst.getLong(2));
        s.setFkComparendo(rst.getLong(3));
        s.setFechaRadicacion(rst.getTimestamp(4));
        s.setNumeroRadicacion(rst.getString(5)) ;
        s.setEstado(rst.getInt(6));
        s.setObservacion(rst.getString(7));
        s.setFkUsuario(rst.getLong(8));
        s.setFkSede(rst.getLong(9));
        
        return s ;
        
    }
    
}

