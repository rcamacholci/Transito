/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Jefrey
 */
public class Historial_descuento_concepto {

    private long id_hist_desc_conc, fk_conf_descuento, fk_usuario;
    private java.sql.Date fecha_proceso;

    public Date getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Date fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public long getFk_conf_descuento() {
        return fk_conf_descuento;
    }

    public void setFk_conf_descuento(long fk_conf_descuento) {
        this.fk_conf_descuento = fk_conf_descuento;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getId_hist_desc_conc() {
        return id_hist_desc_conc;
    }

    public void setId_hist_desc_conc(long id_hist_desc_conc) {
        this.id_hist_desc_conc = id_hist_desc_conc;
    }


    protected static Historial_descuento_concepto load(ResultSet rst)throws SQLException{
        Historial_descuento_concepto historial_descuento_concepto = new Historial_descuento_concepto() ;

        historial_descuento_concepto.setId_hist_desc_conc(rst.getLong(1)) ;
        historial_descuento_concepto.setFk_conf_descuento(rst.getLong(2)) ;
        historial_descuento_concepto.setFk_usuario(rst.getLong(3)) ;
        historial_descuento_concepto.setFecha_proceso(rst.getDate(4)) ;

        return historial_descuento_concepto ;
    }

}
