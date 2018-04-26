/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;
import java.util.* ;
import java.sql.* ;
import java.io.*; 
import java.sql.Date ;
public class Licencia_Conduccion implements java.io.Serializable {
	
    private long idLicenciaConduccion;
    private long fk_sede;
    private long fk_persona;
    private String numeroLicencia;
    private long fk_tramite;
    private String categoria;
    private int estadoLicencia;
    private String estadoImpresion;
    private String certificadoAptitudFisica;
    private String certificadoCentroEnsenanza;
    private String numeroSustrato;
    private String numeroResolucion;
    private String motivoCancelacion;
    private long fk_usuario;
    private Date fechaVencimiento;
    private java.sql.Timestamp  fechaRegistro;
    private long fk_radicacionLicencia;

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getCertificadoAptitudFisica() {
        return certificadoAptitudFisica;
    }

    public void setCertificadoAptitudFisica(String certificadoAptitudFisica) {
        this.certificadoAptitudFisica = certificadoAptitudFisica;
    }

    public String getCertificadoCentroEnsenanza() {
        return certificadoCentroEnsenanza;
    }

    public void setCertificadoCentroEnsenanza(String certificadoCentroEnsenanza) {
        this.certificadoCentroEnsenanza = certificadoCentroEnsenanza;
    }

    public String getEstadoImpresion() {
        return estadoImpresion;
    }

    public void setEstadoImpresion(String estadoImpresion) {
        this.estadoImpresion = estadoImpresion;
    }

    public int getEstadoLicencia() {
        return estadoLicencia;
    }

    public void setEstadoLicencia(int estadoLicencia) {
        this.estadoLicencia = estadoLicencia;
    }

    public Timestamp getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Timestamp fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public Date getFechaVencimiento() {
        return fechaVencimiento;
    }

    public void setFechaVencimiento(Date fechaVencimiento) {
        this.fechaVencimiento = fechaVencimiento;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    }

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getFk_tramite() {
        return fk_tramite;
    }

    public void setFk_tramite(long fk_tramite) {
        this.fk_tramite = fk_tramite;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getIdLicenciaConduccion() {
        return idLicenciaConduccion;
    }

    public void setIdLicenciaConduccion(long idLicenciaConduccion) {
        this.idLicenciaConduccion = idLicenciaConduccion;
    }

    public String getMotivoCancelacion() {
        return motivoCancelacion;
    }

    public void setMotivoCancelacion(String motivoCancelacion) {
        this.motivoCancelacion = motivoCancelacion;
    }

    public String getNumeroLicencia() {
        return numeroLicencia;
    }

    public void setNumeroLicencia(String numeroLicencia) {
        this.numeroLicencia = numeroLicencia;
    }

    public String getNumeroResolucion() {
        return numeroResolucion;
    }

    public void setNumeroResolucion(String numeroResolucion) {
        this.numeroResolucion = numeroResolucion;
    }

    public String getNumeroSustrato() {
        return numeroSustrato;
    }

    public void setNumeroSustrato(String numeroSustrato) {
        this.numeroSustrato = numeroSustrato;
    }

    public long getFk_radicacionLicencia() {
        return fk_radicacionLicencia;
    }

    public void setFk_radicacionLicencia(long fk_radicacion_licencia) {
        this.fk_radicacionLicencia = fk_radicacion_licencia;
    }
    
    public static Licencia_Conduccion load(ResultSet rs)throws SQLException{
        Licencia_Conduccion licenciaConduccion = new Licencia_Conduccion();
        licenciaConduccion.setIdLicenciaConduccion(rs.getLong(1));
        licenciaConduccion.setFk_sede(rs.getLong(2));
        licenciaConduccion.setFk_persona(rs.getLong(3));
        licenciaConduccion.setNumeroLicencia(rs.getString(4));
        licenciaConduccion.setFk_tramite(rs.getLong(5));
        licenciaConduccion.setCategoria(rs.getString(6));
        licenciaConduccion.setEstadoLicencia(rs.getInt(7));
        licenciaConduccion.setEstadoImpresion(rs.getString(8));
        licenciaConduccion.setCertificadoAptitudFisica(rs.getString(9));
        licenciaConduccion.setCertificadoCentroEnsenanza(rs.getString(10));
        licenciaConduccion.setNumeroSustrato(rs.getString(11));
        licenciaConduccion.setNumeroResolucion(rs.getString(12));
        licenciaConduccion.setMotivoCancelacion(rs.getString(13));
        licenciaConduccion.setFk_usuario(rs.getLong(14));
        licenciaConduccion.setFechaVencimiento(rs.getDate(15));
        licenciaConduccion.setFechaRegistro(rs.getTimestamp(16));
        licenciaConduccion.setFk_radicacionLicencia(rs.getLong(17));
        return licenciaConduccion;
    }
	
}

