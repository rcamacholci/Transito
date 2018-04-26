/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;
//import oracle.sql.TIMESTAMP;

/**
 *
 * @author Administrador
 */
public class Financiacion_Anulada {

 private long ID_ANULADA ,FK_USUARIO,FK_FINANCIACION;
 private int ESTADO;
 private java.sql.Timestamp FECHA_PROCESO;
 private String OBSERVACION ;

    public int getESTADO() {
        return ESTADO;
    }

    public void setESTADO(int ESTADO) {
        this.ESTADO = ESTADO;
    }

    public java.sql.Timestamp getFECHA_PROCESO() {
        return FECHA_PROCESO;
    }

    public void setFECHA_PROCESO(java.sql.Timestamp FECHA_PROCESO) {
        this.FECHA_PROCESO = FECHA_PROCESO;
    }

    public long getFK_USUARIO() {
        return FK_USUARIO;
    }

    public void setFK_USUARIO(long FK_USUARIO) {
        this.FK_USUARIO = FK_USUARIO;
    }

    public long getID_ANULADA() {
        return ID_ANULADA;
    }

    public void setID_ANULADA(long ID_ANULADA) {
        this.ID_ANULADA = ID_ANULADA;
    }

    public String getOBSERVACION() {
        return OBSERVACION;
    }

    public void setOBSERVACION(String OBSERVACION) {
        this.OBSERVACION = OBSERVACION;
    }

    public long getFK_FINANCIACION() {
        return FK_FINANCIACION;
    }

    public void setFK_FINANCIACION(long FK_FINANCIACION) {
        this.FK_FINANCIACION = FK_FINANCIACION;
    }



    public static Financiacion_Anulada load(ResultSet rs)throws SQLException{
        Financiacion_Anulada financiacion = new Financiacion_Anulada();

        financiacion.setID_ANULADA(rs.getLong(1));
        financiacion.setFK_USUARIO(rs.getLong(2));
        financiacion.setFECHA_PROCESO(rs.getTimestamp(3));
        financiacion.setESTADO(rs.getInt(4));
        financiacion.setOBSERVACION(rs.getString(5));
        financiacion.setFK_FINANCIACION(rs.getLong(6));
        return financiacion;

    }


}
