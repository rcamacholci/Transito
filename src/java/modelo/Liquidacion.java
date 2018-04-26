/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Civitrans
 */
public class Liquidacion implements java.io.Serializable{
    private long id_liquidacion;
    private int tipo;
    private int fk_concepto;
    private String referencia;
    private float valor;
    private int cantidad;
    private float total;

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public int getFk_concepto() {
        return fk_concepto;
    }

    public void setFk_concepto(int fk_concepto) {
        this.fk_concepto = fk_concepto;
    }

    public long getId_liquidacion() {
        return id_liquidacion;
    }

    public void setId_liquidacion(long id_liquidacion) {
        this.id_liquidacion = id_liquidacion;
    }

    public String getReferencia() {
        return referencia;
    }

    public void setReferencia(String referencia) {
        this.referencia = referencia;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }
    
}
