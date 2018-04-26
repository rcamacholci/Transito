/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.SQLException;

/**
 *
 * @author Administrador
 */
public class Nota_Concepto {

    private long id_notaConcepto;
    private long fk_nota_credito;
    private long fk_concepto;
    private float valor;

    public long getFk_concepto() {
        return fk_concepto;
    }

    public void setFk_concepto(long fk_concepto) {
        this.fk_concepto = fk_concepto;
    }

    public long getFk_nota_credito() {
        return fk_nota_credito;
    }

    public void setFk_nota_credito(long fk_nota_credito) {
        this.fk_nota_credito = fk_nota_credito;
    }

    public long getId_notaConcepto() {
        return id_notaConcepto;
    }

    public void setId_notaConcepto(long id_notaConcepto) {
        this.id_notaConcepto = id_notaConcepto;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }

    public static Nota_Concepto load(java.sql.ResultSet rs)throws SQLException{
        Nota_Concepto notaConcepto = new Nota_Concepto();
        notaConcepto.setId_notaConcepto(rs.getLong(1));
        notaConcepto.setFk_nota_credito(rs.getLong(2));
        notaConcepto.setFk_concepto(rs.getLong(3));
        notaConcepto.setValor(rs.getFloat(4));
        return notaConcepto;
    }
}
