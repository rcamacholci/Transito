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
public class Recibos_excedentes {

    private long id_recibo_excedente, fk_tiquete_ant, fk_tiquete_nue, fk_usuario;
    private Date fecha_proceso;

    public Date getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Date fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public long getFk_tiquete_ant() {
        return fk_tiquete_ant;
    }

    public void setFk_tiquete_ant(long fk_tiquete_ant) {
        this.fk_tiquete_ant = fk_tiquete_ant;
    }

    public long getFk_tiquete_nue() {
        return fk_tiquete_nue;
    }

    public void setFk_tiquete_nue(long fk_tiquete_nue) {
        this.fk_tiquete_nue = fk_tiquete_nue;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getId_recibo_excedente() {
        return id_recibo_excedente;
    }

    public void setId_recibo_excedente(long id_recibo_excedente) {
        this.id_recibo_excedente = id_recibo_excedente;
    }

     public static Recibos_excedentes load(ResultSet rs)throws SQLException{

         Recibos_excedentes recibo_excedente =new Recibos_excedentes();

         recibo_excedente.setId_recibo_excedente(rs.getLong(1));
         recibo_excedente.setFk_tiquete_ant(rs.getLong(2));
         recibo_excedente.setFk_tiquete_nue(rs.getLong(3));
         recibo_excedente.setFk_usuario(rs.getLong(4));
         recibo_excedente.setFecha_proceso(rs.getDate(5));

         return recibo_excedente;
   }



}
