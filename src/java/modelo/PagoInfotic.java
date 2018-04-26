/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
/**
 *
 * @author Desarrollo
 */
public class PagoInfotic {
    protected String Placa;
    protected String Factura;
    protected Date fecha;
    protected  long valor;
    protected long ValoraCartera;
    protected long banco;
    protected String tipo_factura;
    protected String min_referencia;
    protected String max_referencia;

    public String getPlaca() {
        return Placa;
    }

    public void setPlaca(String Placa) {
        this.Placa = Placa;
    }

    public String getFactura() {
        return Factura;
    }

    public void setFactura(String Factura) {
        this.Factura = Factura;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public long getValor() {
        return valor;
    }

    public void setValor(long valor) {
        this.valor = valor;
    }

    public long getValoraCartera() {
        return ValoraCartera;
    }

    public void setValoraCartera(long ValoraCartera) {
        this.ValoraCartera = ValoraCartera;
    }

    public long getBanco() {
        return banco;
    }

    public void setBanco(long banco) {
        this.banco = banco;
    }

    public String getTipo_factura() {
        return tipo_factura;
    }

    public void setTipo_factura(String tipo_factura) {
        this.tipo_factura = tipo_factura;
    }

    public String getMin_referencia() {
        return min_referencia;
    }

    public void setMin_referencia(String min_referencia) {
        this.min_referencia = min_referencia;
    }

    public String getMax_referencia() {
        return max_referencia;
    }

    public void setMax_referencia(String max_referencia) {
        this.max_referencia = max_referencia;
    }
    
    public static  PagoInfotic load(ResultSet rs) throws SQLException{
    PagoInfotic pi = new PagoInfotic();
    pi.setPlaca(rs.getString(1));
    pi.setFactura(rs.getString(2));
    pi.setFecha(rs.getDate(3));
    pi.setValor(rs.getLong(4));
    pi.setValoraCartera(rs.getLong(5));
    pi.setBanco(rs.getLong(6));
    pi.setTipo_factura(rs.getString(7));
    pi.setMin_referencia(rs.getString(8));
    pi.setMax_referencia(rs.getString(9));
    return pi;
    }
}
