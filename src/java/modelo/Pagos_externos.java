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
public class Pagos_externos implements Serializable {
    private long id_agente;
    private long tipo,ok;
    private String Referencia;
    private Date fecha_pago,fecha_proceso;

    public String getReferencia() {
        return Referencia;
    }

    public void setReferencia(String Referencia) {
        this.Referencia = Referencia;
    }
    public long getid_Pago_e() {
        return id_agente;
    }

    public void setid_Pago_e(long id_agente) {
        this.id_agente = id_agente;
    }

    public long getFk_vehiculo() {
        return ok;
    }

    public void setFk_vehiculo(long placa) {
        this.ok = placa;
    }

    public long getAplico(){
        return tipo;
    }

    public void setAplico(long tipo) {
        this.tipo = tipo;
    }

        public Date getFecha_inicio() {
        return fecha_pago;
    }

    public void setFecha_inicio(Date fecha_inicio) {
        this.fecha_pago = fecha_inicio;
    }

    public Date getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Date fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }



    public static Pagos_externos load(ResultSet rs)throws SQLException{
        Pagos_externos agente = new Pagos_externos();
        agente.setid_Pago_e(rs.getLong(1));
        agente.setReferencia(rs.getString(2));
        agente.setFk_vehiculo(rs.getLong(3));
        agente.setAplico(rs.getLong(4));
        agente.setFecha_inicio(rs.getDate(5));
        agente.setFecha_proceso(rs.getDate(6));
        return agente;
    }

}

