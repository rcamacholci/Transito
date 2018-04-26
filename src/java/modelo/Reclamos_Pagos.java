/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Civitrans
 */
import java.io.*;
import java.sql.*;

public class Reclamos_Pagos implements Serializable {

private long ID_RECLAMO_PAGO,FK_PERSONA,FK_TRAMITE,FK_PAGO,FK_USUARIO;
private String NUMERO,PLACA,OBSERVACION;
private Date FECHA;
private int TIPO,ESTADO;
private Timestamp FECHA_PROCESO;

    public int getESTADO() {
        return ESTADO;
    }

    public void setESTADO(int ESTADO) {
        this.ESTADO = ESTADO;
    }

    public Date getFECHA() {
        return FECHA;
    }

    public void setFECHA(Date FECHA) {
        this.FECHA = FECHA;
    }

    public Timestamp getFECHA_PROCESO() {
        return FECHA_PROCESO;
    }

    public void setFECHA_PROCESO(Timestamp FECHA_PROCESO) {
        this.FECHA_PROCESO = FECHA_PROCESO;
    }

    public long getFK_PAGO() {
        return FK_PAGO;
    }

    public void setFK_PAGO(long FK_PAGO) {
        this.FK_PAGO = FK_PAGO;
    }

    public long getFK_PERSONA() {
        return FK_PERSONA;
    }

    public void setFK_PERSONA(long FK_PERSONA) {
        this.FK_PERSONA = FK_PERSONA;
    }

    public long getFK_TRAMITE() {
        return FK_TRAMITE;
    }

    public void setFK_TRAMITE(long FK_TRAMITE) {
        this.FK_TRAMITE = FK_TRAMITE;
    }

    public long getFK_USUARIO() {
        return FK_USUARIO;
    }

    public void setFK_USUARIO(long FK_USUARIO) {
        this.FK_USUARIO = FK_USUARIO;
    }

    public long getID_RECLAMO_PAGO() {
        return ID_RECLAMO_PAGO;
    }

    public void setID_RECLAMO_PAGO(long ID_RECLAMO_PAGO) {
        this.ID_RECLAMO_PAGO = ID_RECLAMO_PAGO;
    }

    public String getNUMERO() {
        return NUMERO;
    }

    public void setNUMERO(String NUMERO) {
        this.NUMERO = NUMERO;
    }

    public String getOBSERVACION() {
        return OBSERVACION;
    }

    public void setOBSERVACION(String OBSERVACION) {
        this.OBSERVACION = OBSERVACION;
    }

    public String getPLACA() {
        return PLACA;
    }

    public void setPLACA(String PLACA) {
        this.PLACA = PLACA;
    }

    public int getTIPO() {
        return TIPO;
    }

    public void setTIPO(int TIPO) {
        this.TIPO = TIPO;
    }


	

  public static Reclamos_Pagos load(ResultSet rs)throws SQLException{
           Reclamos_Pagos reclamosP =new Reclamos_Pagos();
           reclamosP.setID_RECLAMO_PAGO(rs.getLong(1));
           reclamosP.setNUMERO(rs.getString(2));
           reclamosP.setFECHA(rs.getDate(3));
           reclamosP.setTIPO(rs.getInt(4));
           reclamosP.setFK_PERSONA(rs.getLong(5));
           reclamosP.setPLACA(rs.getString(6));
           reclamosP.setFK_TRAMITE(rs.getLong(7));
           reclamosP.setFK_PAGO(rs.getLong(8));
           reclamosP.setESTADO(rs.getInt(9));
           reclamosP.setFK_USUARIO(rs.getLong(10));
           reclamosP.setFECHA_PROCESO(rs.getTimestamp(11));
           reclamosP.setOBSERVACION(rs.getString(12));
           return reclamosP;
   }

}
