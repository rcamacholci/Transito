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
 * @author Administrador
 */
public class SimitPlano {

    private long idSimitPlano;
    private String consecutivo;
    private java.sql.Timestamp fechaProceso;
    private java.sql.Timestamp fechaReporte;
    private int estado;
    private long fkUsuario;

    public String getConsecutivo() {
        return consecutivo;
    }

    public void setConsecutivo(String consecutivo) {
        this.consecutivo = consecutivo;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Timestamp getFechaProceso() {
        return fechaProceso;
    }

    public void setFechaProceso(Timestamp fechaProceso) {
        this.fechaProceso = fechaProceso;
    }

    public Timestamp getFechaReporte() {
        return fechaReporte;
    }

    public void setFechaReporte(Timestamp fechaReporte) {
        this.fechaReporte = fechaReporte;
    }

    public long getIdSimitPlano() {
        return idSimitPlano;
    }

    public void setIdSimitPlano(long idSimitPlano) {
        this.idSimitPlano = idSimitPlano;
    }

    public long getFkUsuario() {
        return fkUsuario;
    }

    public void setFkUsuario(long fkUsuario) {
        this.fkUsuario = fkUsuario;
    }

    public static SimitPlano load(ResultSet rs)throws SQLException{
        SimitPlano simitPlano = new SimitPlano();
        simitPlano.setIdSimitPlano(rs.getLong(1));
        simitPlano.setConsecutivo(rs.getString(2));
        simitPlano.setFechaProceso(rs.getTimestamp(3));
        simitPlano.setFechaReporte(rs.getTimestamp(4));
        simitPlano.setEstado(rs.getInt(5));
        simitPlano.setFkUsuario(rs.getLong(6));
        return simitPlano;
    }
}
