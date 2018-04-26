/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.Timestamp;
import java.sql.Date;

/**
 *
 * @author Administrador
 */
public class Nota_Credito {

    private long id_nota_credito;
    private String numero;
    private int estado;
    private float valor;
    private long fk_registro;
    private long fk_persona;
    private long fk_usuario;
    private String referencia;
    private Date fecha;
    private java.sql.Timestamp fecha_proceso;
    private long fk_sede;
    private int tipo;

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Timestamp getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Timestamp fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public long getFk_registro() {
        return fk_registro;
    }

    public void setFk_registro(long fk_registro) {
        this.fk_registro = fk_registro;
    }

    public long getId_nota_credito() {
        return id_nota_credito;
    }

    public void setId_nota_credito(long id_nota_credito) {
        this.id_nota_credito = id_nota_credito;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public String getReferencia() {
        return referencia;
    }

    public void setReferencia(String referencia) {
        this.referencia = referencia;
    }

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    public static Nota_Credito load(java.sql.ResultSet rs) throws Exception{
        Nota_Credito notaCredito = new Nota_Credito();
        notaCredito.setId_nota_credito(rs.getLong(1));
        notaCredito.setNumero(rs.getString(2));
        notaCredito.setEstado(rs.getInt(3));
        notaCredito.setValor(rs.getFloat(4));
        notaCredito.setFk_registro(rs.getLong(5));
        notaCredito.setFecha_proceso(rs.getTimestamp(6));
        notaCredito.setFecha(rs.getDate(7));
        notaCredito.setFk_persona(rs.getLong(8));
        notaCredito.setFk_usuario(rs.getLong(9));
        notaCredito.setReferencia(rs.getString(10));
        notaCredito.setFk_sede(rs.getLong(11));
        notaCredito.setTipo(rs.getInt(12));
        return notaCredito;
    }
}
