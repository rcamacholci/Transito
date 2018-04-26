/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Civitrans
 */
import java.io.*;
import java.sql.*;
public class tiquete_simit implements Serializable {
    private long id_tiquete,fk_persona,fk_vehiculo,fk_taquilla,fk_usuario,fk_banco;
    private String numero_factura;
    private int estado,tipo_pago,estado_preliquidacion;
    private Date fecha,fecha_referencia;
    private float valor_total_descuento,valor_total_iva,valor_total;
    private String descripcion,referencia;
    private Timestamp fecha_proceso;

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getEstado_preliquidacion() {
        return estado_preliquidacion;
    }

    public void setEstado_preliquidacion(int estado_preliquidacion) {
        this.estado_preliquidacion = estado_preliquidacion;
    }



    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Timestamp getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Timestamp fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    }

    public long getFk_taquilla() {
        return fk_taquilla;
    }

    public void setFk_taquilla(long fk_taquilla){
        this.fk_taquilla = fk_taquilla;
    }

    public long getFk_vehiculo() {
        return fk_vehiculo;
    }

    public void setFk_vehiculo(long fk_vehiculo) {
        this.fk_vehiculo = fk_vehiculo;
    }

    public long getId_tiquete() {
        return id_tiquete;
    }

    public void setId_tiquete(long id_tiquete) {
        this.id_tiquete = id_tiquete;
    }

    public String getNumero_factura() {
        return numero_factura;
    }

    public void setNumero_factura(String numero_factura) {
        this.numero_factura = numero_factura;
    }

    public int getTipo_pago() {
        return tipo_pago;
    }

    public void setTipo_pago(int tipo_pago) {
        this.tipo_pago = tipo_pago;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public float getValor_total() {
        return valor_total;
    }

    public void setValor_total(float valor_total) {
        this.valor_total = valor_total;
    }

    public float getValor_total_descuento() {
        return valor_total_descuento;
    }

    public void setValor_total_descuento(float valor_total_descuento) {
        this.valor_total_descuento = valor_total_descuento;
    }

    public float getValor_total_iva() {
        return valor_total_iva;
    }

    public void setValor_total_iva(float valor_total_iva) {
        this.valor_total_iva = valor_total_iva;
    }

    public Date getFecha_referencia() {
        return fecha_referencia;
    }

    public void setFecha_referencia(Date fecha_referencia) {
        this.fecha_referencia = fecha_referencia;
    }

    public long getFk_banco() {
        return fk_banco;
    }

    public void setFk_banco(long fk_banco) {
        this.fk_banco = fk_banco;
    }

    public String getReferencia() {
        return referencia;
    }

    public void setReferencia(String referencia) {
        this.referencia = referencia;
    }

    public static tiquete_simit load(ResultSet rs)throws SQLException{
        tiquete_simit tiquete= new tiquete_simit();
        tiquete.setId_tiquete(rs.getLong(1));
        tiquete.setNumero_factura(rs.getString(2));
        tiquete.setFecha(rs.getDate(3));
        tiquete.setValor_total_descuento(rs.getFloat(4));
        tiquete.setValor_total_iva(rs.getFloat(5));
        tiquete.setValor_total(rs.getFloat(6));
        tiquete.setEstado(rs.getInt(7));
        tiquete.setDescripcion(rs.getString(8));
        tiquete.setFecha_proceso(rs.getTimestamp(9));
        tiquete.setFk_persona(rs.getLong(10));
        tiquete.setFk_vehiculo(rs.getLong(11));
        tiquete.setFk_taquilla(rs.getLong(12));
        tiquete.setFk_usuario(rs.getLong(13));
        tiquete.setTipo_pago(rs.getInt(14));
        tiquete.setReferencia(rs.getString(15));
        tiquete.setFecha_referencia(rs.getDate(16));
        tiquete.setFk_banco(rs.getLong(17));
        tiquete.setEstado_preliquidacion(rs.getInt(18));
        return tiquete;
    }

}
