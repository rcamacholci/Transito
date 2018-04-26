/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Jefrey
 */
public class Importacion_Temporal_RNMA {

    long id_importacionrnma;
    long fk_formulario;
    int pais_registro_maquinaria;
    String puerto_ingreso;
    String nro_aceptacion;
    String condicion_ingreso;
    String resultado_revision;
    String documento_revision;
    Date fecha_revision;
    String entidad_revision;
    Date fecha_expedicion;
    Date fecha_vencimiento;

    public Importacion_Temporal_RNMA(long id_importacionrnma, long fk_formulario, int pais_registro_maquinaria, String puerto_ingreso, String nro_aceptacion, String condicion_ingreso, String resultado_revision, String documento_revision, Date fecha_revision, String entidad_revision, Date fecha_expedicion, Date fecha_vencimiento) {
        this.id_importacionrnma = id_importacionrnma;
        this.fk_formulario = fk_formulario;
        this.pais_registro_maquinaria = pais_registro_maquinaria;
        this.puerto_ingreso = puerto_ingreso;
        this.nro_aceptacion = nro_aceptacion;
        this.condicion_ingreso = condicion_ingreso;
        this.resultado_revision = resultado_revision;
        this.documento_revision = documento_revision;
        this.fecha_revision = fecha_revision;
        this.entidad_revision = entidad_revision;
        this.fecha_expedicion = fecha_expedicion;
        this.fecha_vencimiento = fecha_vencimiento;
    }

    public long getId_importacionrnma() {
        return id_importacionrnma;
    }

    public void setId_importacionrnma(long id_importacionrnma) {
        this.id_importacionrnma = id_importacionrnma;
    }

    public long getFk_formulario() {
        return fk_formulario;
    }

    public void setFk_formulario(long fk_formulario) {
        this.fk_formulario = fk_formulario;
    }

    public int getPais_registro_maquinaria() {
        return pais_registro_maquinaria;
    }

    public void setPais_registro_maquinaria(int pais_registro_maquinaria) {
        this.pais_registro_maquinaria = pais_registro_maquinaria;
    }

    public String getPuerto_ingreso() {
        return puerto_ingreso;
    }

    public void setPuerto_ingreso(String puerto_ingreso) {
        this.puerto_ingreso = puerto_ingreso;
    }

    public String getNro_aceptacion() {
        return nro_aceptacion;
    }

    public void setNro_aceptacion(String nro_aceptacion) {
        this.nro_aceptacion = nro_aceptacion;
    }

    public String getCondicion_ingreso() {
        return condicion_ingreso;
    }

    public void setCondicion_ingreso(String condicion_ingreso) {
        this.condicion_ingreso = condicion_ingreso;
    }

    public String getResultado_revision() {
        return resultado_revision;
    }

    public void setResultado_revision(String resultado_revision) {
        this.resultado_revision = resultado_revision;
    }

    public String getDocumento_revision() {
        return documento_revision;
    }

    public void setDocumento_revision(String documento_revision) {
        this.documento_revision = documento_revision;
    }

    public Date getFecha_revision() {
        return fecha_revision;
    }

    public void setFecha_revision(Date fecha_revision) {
        this.fecha_revision = fecha_revision;
    }

    public String getEntidad_revision() {
        return entidad_revision;
    }

    public void setEntidad_revision(String entidad_revision) {
        this.entidad_revision = entidad_revision;
    }

    public Date getFecha_expedicion() {
        return fecha_expedicion;
    }

    public void setFecha_expedicion(Date fecha_expedicion) {
        this.fecha_expedicion = fecha_expedicion;
    }

    public Date getFecha_vencimiento() {
        return fecha_vencimiento;
    }

    public void setFecha_vencimiento(Date fecha_vencimiento) {
        this.fecha_vencimiento = fecha_vencimiento;
    }

    public Importacion_Temporal_RNMA() {
    }

    protected static Importacion_Temporal_RNMA load(ResultSet rs) throws SQLException {
        Importacion_Temporal_RNMA importacion = new Importacion_Temporal_RNMA();

        importacion.setId_importacionrnma(rs.getLong(1));
        importacion.setFk_formulario(rs.getLong(2));
        importacion.setPais_registro_maquinaria(rs.getInt(3));
        importacion.setPuerto_ingreso(rs.getString(4));
        importacion.setNro_aceptacion(rs.getString(5));
        importacion.setCondicion_ingreso(rs.getString(6));
        importacion.setResultado_revision(rs.getString(7));
        importacion.setDocumento_revision(rs.getString(8));
        importacion.setFecha_revision(rs.getDate(9));
        importacion.setEntidad_revision(rs.getString(10));
        importacion.setFecha_expedicion(rs.getDate(11));
        importacion.setFecha_vencimiento(rs.getDate(12));

        return importacion;
    }

}
