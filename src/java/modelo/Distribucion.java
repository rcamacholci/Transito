/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.Timestamp;

/**
 *
 * @author Civitrans
 */
public class Distribucion {
    private long id_distribucion,fk_sede,fk_entidad_distribucion,fk_concepto_distribucion,fk_pago;
    private double valor_base,valor;
    private java.sql.Timestamp fecha_proceso;

    public Timestamp getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Timestamp fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public long getFk_concepto_distribucion() {
        return fk_concepto_distribucion;
    }

    public void setFk_concepto_distribucion(long fk_concepto_distribucion) {
        this.fk_concepto_distribucion = fk_concepto_distribucion;
    }

    public long getFk_entidad_distribucion() {
        return fk_entidad_distribucion;
    }

    public void setFk_entidad_distribucion(long fk_entidad_distribucion) {
        this.fk_entidad_distribucion = fk_entidad_distribucion;
    }

    public long getFk_pago() {
        return fk_pago;
    }

    public void setFk_pago(long fk_pago) {
        this.fk_pago = fk_pago;
    }

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getId_distribucion() {
        return id_distribucion;
    }

    public void setId_distribucion(long id_distribucion) {
        this.id_distribucion = id_distribucion;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }

    public double getValor_base() {
        return valor_base;
    }

    public void setValor_base(double valor_base) {
        this.valor_base = valor_base;
    }
    
    public static Distribucion load(java.sql.ResultSet rs)throws java.sql.SQLException{
        Distribucion distribucion = new Distribucion();
        distribucion.setId_distribucion(rs.getLong(1));
        distribucion.setFk_sede(rs.getLong(2));
        distribucion.setFk_entidad_distribucion(rs.getLong(3));
        distribucion.setFk_concepto_distribucion(rs.getLong(4));
        distribucion.setFk_pago(rs.getLong(5));
        distribucion.setValor_base(rs.getDouble(6));
        distribucion.setValor(rs.getDouble(7));
        distribucion.setFecha_proceso(rs.getTimestamp(8));
        return distribucion;
    }
}
