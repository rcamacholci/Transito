/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author acer
 */
import java.io.*;
import java.sql.*;
public class TipoPagos {


private Long id_usuario_tipopago,fk_usuario,fk_caja,tipo_pago,estado;

    public long getId_usuario_tipopago() {
        return id_usuario_tipopago;
    }

    public void setId_usuario_tipopago(long id_usuario_tipopago) {
        this.id_usuario_tipopago = id_usuario_tipopago;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }
    public long getFk_caja() {
        return fk_caja;
    }

    public void setFk_caja(long fk_caja) {
        this.fk_caja = fk_caja;
    }

    public long getTipo_pago() {
        return tipo_pago;
    }

    public void setTipo_pago(long tipo_pago) {
        this.tipo_pago = tipo_pago;
    }

    public long getEstado() {
        return estado;
    }

    public void setEstado(long estado) {
        this.tipo_pago = estado;
    }

     public static TipoPagos Load(ResultSet rs)throws SQLException{
       TipoPagos sede=new TipoPagos();
       sede.setId_usuario_tipopago(rs.getLong(1));
       sede.setFk_usuario(rs.getLong(2));
       sede.setFk_caja(rs.getLong(3));
       sede.setTipo_pago(rs.getLong(4));
       sede.setEstado(rs.getLong(5));
       return sede;
   }

}
