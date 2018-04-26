/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;


/**
 *
 * @author Javier
 */
import java.io.*;
import java.sql.*;
public class pagos_simit implements Serializable{
    private long id_pago,fk_sede,fk_taquilla,fk_tiquete,fk_vehiculo,fk_persona,fk_usuario,fk_banco;
    private String numero_tipo_pago,observacion;
    private float valor_descuento,valor_iva,valor_total;
    private String numero_factura;
    private int tipo_pago,estado;
    private Date fecha,fecha_tipo_pago;


    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getFk_taquilla() {
        return fk_taquilla;
    }

    public void setFk_taquilla(long fk_taquilla) {
        this.fk_taquilla = fk_taquilla;
    }

    public long getFk_tiquete() {
        return fk_tiquete;
    }

    public void setFk_tiquete(long fk_tiquete) {
        this.fk_tiquete = fk_tiquete;
    }

    public long getId_pago() {
        return id_pago;
    }

    public void setId_pago(long id_pago) {
        this.id_pago = id_pago;
    }

    public String getNumero_factura() {
        return numero_factura;
    }

    public void setNumero_factura(String numero_factura) {
        this.numero_factura = numero_factura;
    }

    public String getNumero_tipo_pago() {
        return numero_tipo_pago;
    }

    public void setNumero_tipo_pago(String numero_tipo_pago) {
        this.numero_tipo_pago = numero_tipo_pago;
    }

    public int getTipo_pago() {
        return tipo_pago;
    }

    public void setTipo_pago(int tipo_pago) {
        this.tipo_pago = tipo_pago;
    }

    public float getValor_descuento() {
        return valor_descuento;
    }

    public void setValor_descuento(float valor_descuento) {
        this.valor_descuento = valor_descuento;
    }

    public float getValor_iva() {
        return valor_iva;
    }

    public void setValor_iva(float valor_iva) {
        this.valor_iva = valor_iva;
    }

    public float getValor_total() {
        return valor_total;
    }

    public void setValor_total(float valor_total) {
        this.valor_total = valor_total;
    }

    public Date getFecha_tipo_pago() {
        return fecha_tipo_pago;
    }

    public void setFecha_tipo_pago(Date fecha_tipo_pago) {
        this.fecha_tipo_pago = fecha_tipo_pago;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public long getFk_banco() {
        return fk_banco;
    }

    public void setFk_banco(long fk_banco) {
        this.fk_banco = fk_banco;
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

    public long getFk_vehiculo() {
        return fk_vehiculo;
    }

    public void setFk_vehiculo(long fk_vehiculo) {
        this.fk_vehiculo = fk_vehiculo;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public static pagos_simit load(ResultSet rs)throws SQLException{
        pagos_simit pago= new pagos_simit();

        pago.setId_pago(rs.getLong(1));
        pago.setNumero_factura(rs.getString(2));
        pago.setValor_descuento(rs.getFloat(3));
        pago.setValor_iva(rs.getFloat(4));
        pago.setValor_total(rs.getFloat(5));
        pago.setTipo_pago(rs.getInt(6));
        pago.setNumero_tipo_pago(rs.getString(7));
        pago.setFk_sede(rs.getLong(8));
        pago.setFk_taquilla(rs.getLong(9));
        pago.setFk_tiquete(rs.getLong(10));
        pago.setFecha(rs.getDate(11));
        pago.setFecha_tipo_pago(rs.getDate(12));
        pago.setEstado(rs.getInt(13));
        pago.setFk_vehiculo(rs.getLong(14));
        pago.setFk_persona(rs.getLong(15));
        pago.setFk_usuario(rs.getLong(16));
        pago.setFk_banco(rs.getLong(17));
        pago.setObservacion(rs.getString(18));
        return pago;



    }

}
