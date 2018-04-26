/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Desarrollo
 */
public class Detalles2 {
private String tipo,vigencia,concepto,valor;

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getVigencia() {
        return vigencia;
    }

    public void setVigencia(String vigencia) {
        this.vigencia = vigencia;
    }
    public String getConcepto() {
        return concepto;
    }

    public void setConcepto(String concepto) {
        this.concepto = concepto;
    }
    public String getValor() {
        return valor;
    }

    public void setValor(String valor) {
        this.valor = valor;
    }

        public static Detalles2 load(ResultSet rs)throws SQLException{
        Detalles2 d2= new Detalles2();
            d2.setTipo(rs.getString(1));
            d2.setVigencia(rs.getString(2));
            d2.setConcepto(rs.getString(3));
            d2.setValor(rs.getString(4));
        return d2;

    }


}
