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
public class Formulario_Licencia {

    private long idFormularioLicencia;
    private long fk_radicacion;
    private long fk_tramite;
    private long fk_persona;
    private long fk_pago;
    private String categoria;
    private String runt,runt2;
    private String simit;
    private java.sql.Timestamp fechaProceso;
    private String licencia_anterior;
    private String categoria_anterior;

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public Timestamp getFechaProceso() {
        return fechaProceso;
    }

    public void setFechaProceso(Timestamp fechaProceso) {
        this.fechaProceso = fechaProceso;
    }

    public long getFk_pago() {
        return fk_pago;
    }

    public void setFk_pago(long fk_pago) {
        this.fk_pago = fk_pago;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    }

    public long getFk_radicacion() {
        return fk_radicacion;
    }

    public void setFk_radicacion(long fk_radicacion) {
        this.fk_radicacion = fk_radicacion;
    }

    public long getFk_tramite() {
        return fk_tramite;
    }

    public void setFk_tramite(long fk_tramite) {
        this.fk_tramite = fk_tramite;
    }

    public long getIdFormularioLicencia() {
        return idFormularioLicencia;
    }

    public void setIdFormularioLicencia(long idFormularioLicencia) {
        this.idFormularioLicencia = idFormularioLicencia;
    }

    public String getRunt() {
        return runt;
    }

    public void setRunt(String runt) {
        this.runt = runt;
    }

    public String getRunt2() {
        return runt2;
    }

    public void setRunt2(String runt2) {
        this.runt2 = runt2;
    }



    public String getSimit() {
        return simit;
    }

    public void setSimit(String simit) {
        this.simit = simit;
    }

    public String getLicencia_anterior() {
        return licencia_anterior;
    }

    public void setLicencia_anterior(String licencia_anterior) {
        this.licencia_anterior = licencia_anterior;
    }

    public String getCategoria_anterior() {
        return categoria_anterior;
    }

    public void setCategoria_anterior(String categoria_anterior) {
        this.categoria_anterior = categoria_anterior;
    }




    public static Formulario_Licencia load(java.sql.ResultSet rs)throws java.sql.SQLException{
        Formulario_Licencia formularioLicencia = new Formulario_Licencia();
        formularioLicencia.setIdFormularioLicencia(rs.getLong(1));
        formularioLicencia.setFk_radicacion(rs.getLong(2));
        formularioLicencia.setFk_tramite(rs.getLong(3));
        formularioLicencia.setFk_persona(rs.getLong(4));
        formularioLicencia.setFk_pago(rs.getLong(5));
        formularioLicencia.setCategoria(rs.getString(6));
        formularioLicencia.setRunt(rs.getString(7));
        formularioLicencia.setSimit(rs.getString(8));
        formularioLicencia.setFechaProceso(rs.getTimestamp(9));
        formularioLicencia.setLicencia_anterior(rs.getString(10));
        formularioLicencia.setCategoria_anterior(rs.getString(11));
        formularioLicencia.setRunt2(rs.getString(12));
        return formularioLicencia;
    }

}
