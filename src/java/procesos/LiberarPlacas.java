/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package procesos;

import java.sql.SQLException;
import modelo.Model;
import modelo.Parametro;
import modelo.Persona;
import modelo.Preasignacion;
import modelo.Usuario;
import modelo.Vehiculo;
import modelo.Venal;

/**
 *
 * @author JgCarreno
 */
public class LiberarPlacas {

    private String message;

    public boolean LiberarPlacas(Model modelo, Usuario usuario) throws Exception {
        try {
            Parametro parametro = null;
            java.util.List lista = modelo.listarPreasignaciones();
            for (int i = 0; i < lista.size(); i++) {
                modelo.getCon().setAutoCommit(false);
                Preasignacion preasignacion = (Preasignacion) lista.get(i);
                Vehiculo vehiculo = modelo.consultarVehiculo(preasignacion.getPlaca().toUpperCase());

                java.util.Date fechaActual = (new java.util.Date());
                long dif = fechaActual.getTime() - preasignacion.getFecha().getTime();
                long dias = (dif / 86400000L);
                if (dias > 60) {
                    if (vehiculo == null) {

                        Venal venal = modelo.consultar_Venal(preasignacion.getPlaca(), 3);
                        if (venal == null) {
                            venal = modelo.consultar_Venal(preasignacion.getPlaca(), 5);
                        }
                        if (venal != null) {
                            modelo.actualizarEstadoVenal(venal.getId_venal(), 1, usuario.getId_usuario());
                            modelo.actualizarPreasignacion(preasignacion.getId_preasignacion(),2);
                        }

                    } else {// not null
                        Venal venal = modelo.consultar_Venal(preasignacion.getPlaca(), 3);
                        if (venal == null) {
                            venal = modelo.consultar_Venal(preasignacion.getPlaca(), 5);
                        }
                        if (venal != null) {
                            modelo.actualizarEstadoVenal(venal.getId_venal(), 1, usuario.getId_usuario());
                            if (preasignacion.getEstado() == 1) {
                                modelo.actualizarPreasignacion(preasignacion.getId_preasignacion(), 2);
                            }

                        } else {
                            venal = modelo.consultar_Venal(preasignacion.getPlaca(), 2);
                            if (venal != null) {
                                if (preasignacion.getEstado() == 1) {
                                    modelo.actualizarPreasignacion(preasignacion.getId_preasignacion(), 2);
                                }
                            }
                        }
                    }
                }
            }
            modelo.getCon().commit();
            setMessage("Se han liberado las Placas Correctamente");
        } catch (Exception e) {
            modelo.getCon().rollback();
            setMessage(e.getMessage());
        }

        return false;
    }

    /**
     * @return the message
     */
    public String getMessage() {
        return message;
    }

    /**
     * @param message the message to set
     */
    public void setMessage(String message) {
        this.message = message;
    }

}
