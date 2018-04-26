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
public class DetPagoInfotic {
    protected String Placa;
    protected String Referencia;
    protected String Factura;
    protected  long valor;
    protected long valorCosta;
    protected long valorInteres;
    protected long valorExtemp;

    public String getPlaca() {
        return Placa;
    }

    public void setPlaca(String Placa) {
        this.Placa = Placa;
    }

    public String getReferencia() {
        return Referencia;
    }

    public void setReferencia(String Referencia) {
        this.Referencia = Referencia;
    }

    public String getFactura() {
        return Factura;
    }

    public void setFactura(String min_referencia) {
        this.Factura = min_referencia;
    }

    public long getValor() {
        return valor;
    }

    public void setValor(long valor) {
        this.valor = valor;
    }

    public long getValorCosta() {
        return valorCosta;
    }

    public void setValorCosta(long valorCosta) {
        this.valorCosta = valorCosta;
    }

    public long getValorInteres() {
        return valorInteres;
    }

    public void setValorInteres(long valorInteres) {
        this.valorInteres = valorInteres;
    }

    public long getValorExtemp() {
        return valorExtemp;
    }

    public void setValorExtemp(long valorExtemp) {
        this.valorExtemp = valorExtemp;
    }
    
public static DetPagoInfotic load(ResultSet rs) throws SQLException{
    DetPagoInfotic dp = new DetPagoInfotic();
    dp.setPlaca(rs.getString(1)==null?"Financiacion":rs.getString(1));
    dp.setReferencia(rs.getString(2));
    dp.setFactura(rs.getString(3));
    dp.setValor(rs.getLong(4));
    dp.setValorCosta(rs.getLong(5));
    dp.setValorInteres(rs.getLong(6));
    dp.setValorExtemp(rs.getLong(7));
    return dp;
}

}

