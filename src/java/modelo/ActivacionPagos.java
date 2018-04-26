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
public class ActivacionPagos {

    private long id_activacion_pago, fk_pago, fk_usuario;
    private Date fecha_proceso;
    private String observacion;

    public Date getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Date fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public long getFk_pago() {
        return fk_pago;
    }

    public void setFk_pago(long fk_pago) {
        this.fk_pago = fk_pago;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getId_activacion_pago() {
        return id_activacion_pago;
    }

    public void setId_activacion_pago(long id_activacion_pago) {
        this.id_activacion_pago = id_activacion_pago;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public static ActivacionPagos load(ResultSet rst) throws SQLException {
        ActivacionPagos actPagos = new ActivacionPagos();

        actPagos.setId_activacion_pago(rst.getLong(1));
        actPagos.setFk_pago(rst.getLong(2));
        actPagos.setFk_usuario(rst.getLong(3));
        actPagos.setFecha_proceso(rst.getDate(4));
        actPagos.setObservacion(rst.getString(5));
        
        return actPagos;
    }

}
