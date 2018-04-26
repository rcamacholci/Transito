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
public class Citacion_Comparendo {

    private long idCitacionComparendo;
    private int numero;
    private java.sql.Timestamp fechaCitacion;
    private java.sql.Timestamp fechaProceso;
    private long fkPersona;
    private long fkComparendo;
    private long fkLiquidacionCia;
    private int estado;
    private long fkUsuario;
    private long fkHorarioCurso;

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Timestamp getFechaCitacion() {
        return fechaCitacion;
    }

    public void setFechaCitacion(Timestamp fechaCitacion) {
        this.fechaCitacion = fechaCitacion;
    }

    public Timestamp getFechaProceso() {
        return fechaProceso;
    }

    public void setFechaProceso(Timestamp fechaProceso) {
        this.fechaProceso = fechaProceso;
    }

    public long getFkComparendo() {
        return fkComparendo;
    }

    public void setFkComparendo(long fkComparendo) {
        this.fkComparendo = fkComparendo;
    }

    public long getFkLiquidacionCia() {
        return fkLiquidacionCia;
    }

    public void setFkLiquidacionCia(long fkLiquidacionCia) {
        this.fkLiquidacionCia = fkLiquidacionCia;
    }

    public long getFkPersona() {
        return fkPersona;
    }

    public void setFkPersona(long fkPersona) {
        this.fkPersona = fkPersona;
    }

    public long getFkUsuario() {
        return fkUsuario;
    }

    public void setFkUsuario(long fkUsuario) {
        this.fkUsuario = fkUsuario;
    }

    public long getIdCitacionComparendo() {
        return idCitacionComparendo;
    }

    public void setIdCitacionComparendo(long idCitacionComparendo) {
        this.idCitacionComparendo = idCitacionComparendo;
    }

    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    public long getFkHorarioCurso() {
        return fkHorarioCurso;
    }

    public void setFkHorarioCurso(long fkHorarioCurso) {
        this.fkHorarioCurso = fkHorarioCurso;
    }

    public static Citacion_Comparendo load(ResultSet rs)throws SQLException{
        Citacion_Comparendo citacion = new Citacion_Comparendo();
        citacion.setIdCitacionComparendo(rs.getLong(1));
        citacion.setNumero(rs.getInt(2));
        citacion.setFechaCitacion(rs.getTimestamp(3));
        citacion.setFkPersona(rs.getLong(4));
        citacion.setFkComparendo(rs.getLong(5));
        citacion.setFkLiquidacionCia(rs.getLong(6));
        citacion.setEstado(rs.getInt(7));
        citacion.setFkUsuario(rs.getLong(8));
        citacion.setFechaProceso(rs.getTimestamp(9));
        citacion.setFkHorarioCurso(rs.getLong(10));
        return citacion;
    }
}
