/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.*;

/**
 *
 * @author Flia. Aguas Macias
 */
public class Empresa {
    private long id_empresa;
    private long fk_divipo;
    private java.util.Date fecha_exp;
    private String razon_social;
    private String sigla;
    private String tipo_entidad;
    private String tipo_sociedad;
    private String prestador_servicio;
    private String email;
    private String telefono;
    private String celular;
    private String capital_pagado;
    private String patrimonio_liquido;
    private String nro_certificado;
    private long fk_representante;
    private String nit;
    private long tipo_documento;

    public long getFk_representante() {
        return fk_representante;
    }

    public void setFk_representante(long fk_representante) {
        this.fk_representante = fk_representante;
    }

    public String getNit() {
        return nit;
    }

    public void setNit(String nit) {
        this.nit = nit;
    }

    public long getTipo_documento() {
        return tipo_documento;
    }

    public void setTipo_documento(long tipo_documento) {
        this.tipo_documento = tipo_documento;
    }

    public String getCapital_pagado() {
        return capital_pagado;
    }

    public void setCapital_pagado(String capital_pagado) {
        this.capital_pagado = capital_pagado;
    }

    public String getCelular() {
        return celular;
    }

    public void setCelular(String celular) {
        this.celular = celular;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public java.util.Date getFecha_exp() {
        return fecha_exp;
    }

    public void setFecha_exp(java.util.Date fecha_exp) {
        this.fecha_exp = fecha_exp;
    }

    public long getFk_divipo() {
        return fk_divipo;
    }

    public void setFk_divipo(long fk_divipo) {
        this.fk_divipo = fk_divipo;
    }

    public long getId_empresa() {
        return id_empresa;
    }

    public void setId_empresa(long id_empresa) {
        this.id_empresa = id_empresa;
    }

    public String getNro_certificado() {
        return nro_certificado;
    }

    public void setNro_certificado(String nro_certificado) {
        this.nro_certificado = nro_certificado;
    }

    public String getPatrimonio_liquido() {
        return patrimonio_liquido;
    }

    public void setPatrimonio_liquido(String patrimonio_liquido) {
        this.patrimonio_liquido = patrimonio_liquido;
    }

    public String getPrestador_servicio() {
        return prestador_servicio;
    }

    public void setPrestador_servicio(String prestador_servicio) {
        this.prestador_servicio = prestador_servicio;
    }

    public String getRazon_social() {
        return razon_social;
    }

    public void setRazon_social(String razon_social) {
        this.razon_social = razon_social;
    }

    public String getSigla() {
        return sigla;
    }

    public void setSigla(String sigla) {
        this.sigla = sigla;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getTipo_entidad() {
        return tipo_entidad;
    }

    public void setTipo_entidad(String tipo_entidad) {
        this.tipo_entidad = tipo_entidad;
    }

    public String getTipo_sociedad() {
        return tipo_sociedad;
    }

    public void setTipo_sociedad(String tipo_sociedad) {
        this.tipo_sociedad = tipo_sociedad;
    }

    public static Empresa load(ResultSet rs)throws SQLException{
           Empresa empresa =new Empresa();
           empresa.setId_empresa(rs.getLong(1));
           empresa.setFk_divipo(rs.getLong(2));
           empresa.setFecha_exp(rs.getDate(3));
           empresa.setRazon_social(rs.getString(4));
           empresa.setSigla(rs.getString(5));
           empresa.setTipo_entidad(rs.getString(6));
           empresa.setTipo_sociedad(rs.getString(7));
           empresa.setPrestador_servicio(rs.getString(8));
           empresa.setEmail(rs.getString(9));
           empresa.setTelefono(rs.getString(10));
           empresa.setCelular(rs.getString(11));
           empresa.setCapital_pagado(rs.getString(12));
           empresa.setPatrimonio_liquido(rs.getString(13));
           empresa.setNro_certificado(rs.getString(14));
           empresa.setFk_representante(rs.getLong(15));
           empresa.setNit(rs.getString(16));
           empresa.setTipo_documento(rs.getLong(17));

           return empresa;
   }
}
