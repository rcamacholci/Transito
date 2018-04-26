/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

/**
 *
 * @author WALTER E
 */
public class PreLiquidacion implements java.io.Serializable{
    
    private long id_preliquidacion ;
    private long fk_pago ;
    private long fk_Taquilla ;
    private Timestamp fecha_proceso ;
    private double valor_factura ;
    private long fk_sede ;
    private long fk_usuario ;

    public Timestamp getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Timestamp fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public long getFk_Taquilla() {
        return fk_Taquilla;
    }

    public void setFk_Taquilla(long fk_Taquilla) {
        this.fk_Taquilla = fk_Taquilla;
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

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getId_preliquidacion() {
        return id_preliquidacion;
    }

    public void setId_preliquidacion(long id_preliquidacion) {
        this.id_preliquidacion = id_preliquidacion;
    }

    public double getValor_factura() {
        return valor_factura;
    }

    public void setValor_factura(double valor_factura) {
        this.valor_factura = valor_factura;
    }

    public static PreLiquidacion load( ResultSet rst) throws SQLException{
        
        PreLiquidacion pl = new PreLiquidacion() ;
        
        pl.setId_preliquidacion(rst.getLong(1));
        pl.setFk_pago(rst.getLong(2));
        pl.setValor_factura(rst.getLong(3));
        pl.setFk_Taquilla(rst.getLong(4));
        pl.setFk_sede(rst.getLong(5));
        pl.setFk_usuario(rst.getInt(6));
        pl.setFecha_proceso(rst.getTimestamp(7));
        
        return pl ;
    }
    
}
