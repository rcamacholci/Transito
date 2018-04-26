

package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;

public class TRAMITES_ASOCIADOS {


    int id_tramite_asociado,usuario_solicitante,fk_vehiculo;
    String nombre_tramite,referencia,fecha,observacion,estado,fecha_registro;
    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getFecha_registro() {
        return fecha_registro;
    }

    public void setFecha_registro(String fecha_registro) {
        this.fecha_registro = fecha_registro;
    }

    public int getFk_vehiculo() {
        return fk_vehiculo;
    }

    public void setFk_vehiculo(int fk_vehiculo) {
        this.fk_vehiculo = fk_vehiculo;
    }

    public int getId_tramite_asociado() {
        return id_tramite_asociado;
    }

    public void setId_tramite_asociado(int id_tramite_asociado) {
        this.id_tramite_asociado = id_tramite_asociado;
    }

    public String getNombre_tramite() {
        return nombre_tramite;
    }

    public void setNombre_tramite(String nombre_tramite) {
        this.nombre_tramite = nombre_tramite;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public String getReferencia() {
        return referencia;
    }

    public void setReferencia(String referencia) {
        this.referencia = referencia;
    }

    public int getUsuario_solicitante() {
        return usuario_solicitante;
    }

    public void setUsuario_solicitante(int usuario_solicitante) {
        this.usuario_solicitante = usuario_solicitante;
    }
    public static TRAMITES_ASOCIADOS load(ResultSet rst) throws SQLException {
        TRAMITES_ASOCIADOS tramites_asociados = new TRAMITES_ASOCIADOS();
        tramites_asociados.setNombre_tramite(rst.getString(1));
        tramites_asociados.setReferencia(rst.getString(2));
        tramites_asociados.setFecha(rst.getString(3));
        tramites_asociados.setObservacion(rst.getString(4));
        tramites_asociados.setEstado(rst.getString(5));
        tramites_asociados.setUsuario_solicitante(rst.getInt(6));
        tramites_asociados.setFecha_registro(rst.getString(7));
        tramites_asociados.setFk_vehiculo(rst.getInt(8));
        return tramites_asociados;
    }
}
