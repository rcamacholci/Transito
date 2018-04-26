/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

/**
 *
 * @author Administrador
 */
public class Motivos_sinhuella {

    private long motivo, fk_tramite;
    private int estado;
    private Date fecha_ini, fecha_fin, fecha_proceso;

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Date getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public Date getFecha_ini() {
        return fecha_ini;
    }

    public void setFecha_ini(Date fecha_ini) {
        this.fecha_ini = fecha_ini;
    }

    public Date getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Date fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public long getFk_tramite() {
        return fk_tramite;
    }

    public void setFk_tramite(long fk_tramite) {
        this.fk_tramite = fk_tramite;
    }

    public long getMotivo() {
        return motivo;
    }

    public void setMotivo(long motivo) {
        this.motivo = motivo;
    }

    protected static Motivos_sinhuella load(ResultSet rs)throws SQLException{
        Motivos_sinhuella motivo= new Motivos_sinhuella();

        motivo.setMotivo(rs.getLong(1));
        motivo.setFk_tramite(rs.getLong(2));
        motivo.setFecha_ini(rs.getDate(3));
        motivo.setFecha_fin(rs.getDate(4));
        motivo.setEstado(rs.getInt(5));
        motivo.setFecha_proceso(rs.getDate(6));

        return motivo;

    }

}
