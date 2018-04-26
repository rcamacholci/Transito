/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Administrador
 */
public class ReciboExcedente {

  private long codigo, cantidad;
  private String concepto;
  private double valor;

    public long getCantidad() {
        return cantidad;
    }

    public void setCantidad(long cantidad) {
        this.cantidad = cantidad;
    }

    public long getCodigo() {
        return codigo;
    }

    public void setCodigo(long codigo) {
        this.codigo = codigo;
    }

    public String getConcepto() {
        return concepto;
    }

    public void setConcepto(String concepto) {
        this.concepto = concepto;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }

      public static ReciboExcedente load(ResultSet rs)throws SQLException{
        ReciboExcedente exc= new ReciboExcedente();

        exc.setCodigo(rs.getLong(1));
        exc.setCantidad(rs.getLong(2));
        exc.setConcepto(rs.getString(3));
        exc.setValor(rs.getDouble(4));

        return exc;

    }


}
