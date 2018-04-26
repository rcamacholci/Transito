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
public class Radicacion_RNMA {
    
    private long id_radicacion_rnma;
    private long fk_formulario;
    private int orden_ejecucion;
    private String nomb_tipo_registro;
    private String factura;
    private Date fecha_factura;
    private String valor_factura;
    private int rodaje;
    private int tipo_cabina;
    private String partida_arancelaria;
    private String identificacion_gps;
    private long empresa_habilitacion;
    private int tipo_documento_soporte;
    private String documento_soporte;
    private Date fecha_soporte;
    private String entidad_exp_soporte;
    private int tipodoc_vendedor;
    private String no_documento_vendedor;

    public Radicacion_RNMA() {
    }

    public Radicacion_RNMA(long id_radicacion_rnma, long fk_formulario, int orden_ejecucion, String nomb_tipo_registro, String factura, Date fecha_factura, String valor_factura, int rodaje, int tipo_cabina, String partida_arancelaria, String identificacion_gps, long empresa_habilitacion, int tipo_documento_soporte, String documento_soporte, Date fecha_soporte, String entidad_exp_soporte, int tipodoc_vendedor, String no_documento_vendedor) {
        this.id_radicacion_rnma = id_radicacion_rnma;
        this.fk_formulario = fk_formulario;
        this.orden_ejecucion = orden_ejecucion;
        this.nomb_tipo_registro = nomb_tipo_registro;
        this.factura = factura;
        this.fecha_factura = fecha_factura;
        this.valor_factura = valor_factura;
        this.rodaje = rodaje;
        this.tipo_cabina = tipo_cabina;
        this.partida_arancelaria = partida_arancelaria;
        this.identificacion_gps = identificacion_gps;
        this.empresa_habilitacion = empresa_habilitacion;
        this.tipo_documento_soporte = tipo_documento_soporte;
        this.documento_soporte = documento_soporte;
        this.fecha_soporte = fecha_soporte;
        this.entidad_exp_soporte = entidad_exp_soporte;
        this.tipodoc_vendedor = tipodoc_vendedor;
        this.no_documento_vendedor = no_documento_vendedor;
    }

    public long getId_radicacion_rnma() {
        return id_radicacion_rnma;
    }

    public void setId_radicacion_rnma(long id_radicacion_rnma) {
        this.id_radicacion_rnma = id_radicacion_rnma;
    }

    public long getFk_formulario() {
        return fk_formulario;
    }

    public void setFk_formulario(long fk_formulario) {
        this.fk_formulario = fk_formulario;
    }

    public int getOrden_ejecucion() {
        return orden_ejecucion;
    }

    public void setOrden_ejecucion(int orden_ejecucion) {
        this.orden_ejecucion = orden_ejecucion;
    }

    public String getNomb_tipo_registro() {
        return nomb_tipo_registro;
    }

    public void setNomb_tipo_registro(String nomb_tipo_registro) {
        this.nomb_tipo_registro = nomb_tipo_registro;
    }

    public String getFactura() {
        return factura;
    }

    public void setFactura(String factura) {
        this.factura = factura;
    }

    public Date getFecha_factura() {
        return fecha_factura;
    }

    public void setFecha_factura(Date fecha_factura) {
        this.fecha_factura = fecha_factura;
    }

    public String getValor_factura() {
        return valor_factura;
    }

    public void setValor_factura(String valor_factura) {
        this.valor_factura = valor_factura;
    }

    public int getRodaje() {
        return rodaje;
    }

    public void setRodaje(int rodaje) {
        this.rodaje = rodaje;
    }

    public int getTipo_cabina() {
        return tipo_cabina;
    }

    public void setTipo_cabina(int tipo_cabina) {
        this.tipo_cabina = tipo_cabina;
    }

    public String getPartida_arancelaria() {
        return partida_arancelaria;
    }

    public void setPartida_arancelaria(String partida_arancelaria) {
        this.partida_arancelaria = partida_arancelaria;
    }

    public String getIdentificacion_gps() {
        return identificacion_gps;
    }

    public void setIdentificacion_gps(String identificacion_gps) {
        this.identificacion_gps = identificacion_gps;
    }

    public long getEmpresa_habilitacion() {
        return empresa_habilitacion;
    }

    public void setEmpresa_habilitacion(long empresa_habilitacion) {
        this.empresa_habilitacion = empresa_habilitacion;
    }

    public int getTipo_documento_soporte() {
        return tipo_documento_soporte;
    }

    public void setTipo_documento_soporte(int tipo_documento_soporte) {
        this.tipo_documento_soporte = tipo_documento_soporte;
    }

    public String getDocumento_soporte() {
        return documento_soporte;
    }

    public void setDocumento_soporte(String documento_soporte) {
        this.documento_soporte = documento_soporte;
    }

    public Date getFecha_soporte() {
        return fecha_soporte;
    }

    public void setFecha_soporte(Date fecha_soporte) {
        this.fecha_soporte = fecha_soporte;
    }

    public String getEntidad_exp_soporte() {
        return entidad_exp_soporte;
    }

    public void setEntidad_exp_soporte(String entidad_exp_soporte) {
        this.entidad_exp_soporte = entidad_exp_soporte;
    }

    public int getTipodoc_vendedor() {
        return tipodoc_vendedor;
    }

    public void setTipodoc_vendedor(int tipodoc_vendedor) {
        this.tipodoc_vendedor = tipodoc_vendedor;
    }

    public String getNo_documento_vendedor() {
        return no_documento_vendedor;
    }

    public void setNo_documento_vendedor(String no_documento_vendedor) {
        this.no_documento_vendedor = no_documento_vendedor;
    }

    protected static Radicacion_RNMA load(ResultSet rs)throws SQLException{
        Radicacion_RNMA radicacion = new Radicacion_RNMA();
        
        radicacion.setId_radicacion_rnma(rs.getLong(1));
        radicacion.setFk_formulario(rs.getLong(2)); 
        radicacion.setOrden_ejecucion(rs.getInt(3));
        radicacion.setNomb_tipo_registro(rs.getString(4));
        radicacion.setFactura(rs.getString(5));
        radicacion.setFecha_factura(rs.getDate(6));
        radicacion.setValor_factura(rs.getString(7));
        radicacion.setRodaje(rs.getInt(8));
        radicacion.setTipo_cabina(rs.getInt(9));
        radicacion.setPartida_arancelaria(rs.getString(10)); 
        radicacion.setIdentificacion_gps(rs.getString(11));
        radicacion.setEmpresa_habilitacion(rs.getLong(12));
        radicacion.setTipo_documento_soporte(rs.getInt(13));
        radicacion.setDocumento_soporte(rs.getString(14));
        radicacion.setFecha_soporte(rs.getDate(15));
        radicacion.setEntidad_exp_soporte(rs.getString(16));
        radicacion.setTipodoc_vendedor(rs.getInt(17));
        radicacion.setNo_documento_vendedor(rs.getString(18));
        
        return radicacion;
    }
            
}
