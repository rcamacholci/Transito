/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author DESARROLLO
 */
public class BSP  implements Serializable{
    private String  referencia,placa, tipo_documento, direccion, telefono, documento, nombres, apellido_1,apellido_2,ciudad ;
    private long  periodo,V2004,V2005,V2006,V2007,V2008,V2009,V2010,V2011,EXT04,EXT05,EXT06;

    public long getEXT04() {
        return EXT04;
    }

    public void setEXT04(long EXT04) {
        this.EXT04 = EXT04;
    }

    public long getEXT05() {
        return EXT05;
    }

    public void setEXT05(long EXT05) {
        this.EXT05 = EXT05;
    }

    public long getEXT06() {
        return EXT06;
    }

    public void setEXT06(long EXT06) {
        this.EXT06 = EXT06;
    }

    public long getV2004() {
        return V2004;
    }

    public void setV2004(long V2004) {
        this.V2004 = V2004;
    }

    public long getV2005() {
        return V2005;
    }

    public void setV2005(long V2005) {
        this.V2005 = V2005;
    }

    public long getV2006() {
        return V2006;
    }

    public void setV2006(long V2006) {
        this.V2006 = V2006;
    }

    public long getV2007() {
        return V2007;
    }

    public void setV2007(long V2007) {
        this.V2007 = V2007;
    }

    public long getV2008() {
        return V2008;
    }

    public void setV2008(long V2008) {
        this.V2008 = V2008;
    }

    public long getV2009() {
        return V2009;
    }

    public void setV2009(long V2009) {
        this.V2009 = V2009;
    }

    public long getV2010() {
        return V2010;
    }

    public void setV2010(long V2010) {
        this.V2010 = V2010;
    }

    public long getV2011() {
        return V2011;
    }

    public void setV2011(long V2011) {
        this.V2011 = V2011;
    }

    public String getApellido_1() {
        return apellido_1;
    }

    public void setApellido_1(String apellido_1) {
        this.apellido_1 = apellido_1;
    }

    public String getApellido_2() {
        return apellido_2;
    }

    public void setApellido_2(String apellido_2) {
        this.apellido_2 = apellido_2;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getDocumento() {
        return documento;
    }

    public void setDocumento(String documento) {
        this.documento = documento;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public long getPeriodo() {
        return periodo;
    }

    public void setPeriodo(long periodo) {
        this.periodo = periodo;
    }

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    public String getReferencia() {
        return referencia;
    }

    public void setReferencia(String referencia) {
        this.referencia = referencia;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getTipo_documento() {
        return tipo_documento;
    }

    public void setTipo_documento(String tipo_documento) {
        this.tipo_documento = tipo_documento;
    }


    public static BSP load(ResultSet rs)throws SQLException{

        BSP bsp= new BSP();

        bsp.setReferencia(rs.getString(1));
        bsp.setPlaca(rs.getString(2));
        bsp.setTipo_documento(rs.getString(3));
        bsp.setDocumento(rs.getString(4));
        bsp.setNombres(rs.getString(5));
        bsp.setApellido_1(rs.getString(6));
        bsp.setApellido_2(rs.getString(7));
        bsp.setDireccion(rs.getString(8));
        bsp.setCiudad(rs.getString(9));
        bsp.setTelefono(rs.getString(10));
        bsp.setPeriodo(rs.getLong(11));
        bsp.setV2004(rs.getLong(12));
        bsp.setV2005(rs.getLong(13));
        bsp.setV2006(rs.getLong(14));
        bsp.setV2007(rs.getLong(15));
        bsp.setV2008(rs.getLong(16));
        bsp.setV2009(rs.getLong(17));
        bsp.setV2010(rs.getLong(18));
        bsp.setV2011(rs.getLong(19));
        bsp.setEXT04(rs.getLong(20));
        bsp.setEXT05(rs.getLong(21));
        bsp.setEXT06(rs.getLong(22));
        return bsp;

    }

    
}
