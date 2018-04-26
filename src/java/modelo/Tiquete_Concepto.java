/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.ResultSet;

/**
 *
 * @author Civitrans
 */
public class Tiquete_Concepto {

    private long id_tiqueteConcepto;
    private long fk_detalleTiquete;
    private long fk_concepto;
    private float valor;
    private int estado;
    private int secuencia;

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public long getFk_detalleTiquete() {
        return fk_detalleTiquete;
    }

    public void setFk_detalleTiquete(long fk_detalleTiquete) {
        this.fk_detalleTiquete = fk_detalleTiquete;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }

    public long getFk_concepto() {
        return fk_concepto;
    }

    public void setFk_concepto(long fk_concepto) {
        this.fk_concepto = fk_concepto;
    }

    public long getId_tiqueteConcepto() {
        return id_tiqueteConcepto;
    }

    public void setId_tiqueteConcepto(long id_tiqueteConcepto) {
        this.id_tiqueteConcepto = id_tiqueteConcepto;
    }

    public int getSecuencia() {
        return secuencia;
    }

    public void setSecuencia(int secuencia) {
        this.secuencia = secuencia;
    }

    public static Tiquete_Concepto load(ResultSet rs)throws Exception{
        Tiquete_Concepto tiqueteTramite = new Tiquete_Concepto();
        tiqueteTramite.setId_tiqueteConcepto(rs.getLong(1));
        tiqueteTramite.setFk_detalleTiquete(rs.getLong(2));
        tiqueteTramite.setFk_concepto(rs.getLong(3));
        tiqueteTramite.setValor(rs.getFloat(4));
        tiqueteTramite.setEstado(rs.getInt(5));
        tiqueteTramite.setSecuencia(rs.getInt(6));
        return tiqueteTramite;
    }
}
