/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.io.Serializable;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author DESARROLLO
 */
public class Actos_Administrativos implements Serializable {
    private long ID_ACTO_ADMINISTRATIVO,FK_USUARIO,FK_VEHICULO;
    private  String NUMERO,TRAMITE,MODIFICACION,PLACA,OBSERVACIONES;
    private Date FECHA,FECHA_PROCESO;
    private int ESTADO,TIPO;

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

    public Date getFECHA_PROCESO() {
        return FECHA_PROCESO;
    }

    public void setFECHA_PROCESO(Date FECHA_PROCESO) {
        this.FECHA_PROCESO = FECHA_PROCESO;
    }

    public long getFK_USUARIO() {
        return FK_USUARIO;
    }

    public void setFK_USUARIO(long FK_USUARIO) {
        this.FK_USUARIO = FK_USUARIO;
    }

    public long getFK_VEHICULO() {
        return FK_VEHICULO;
    }

    public void setFK_VEHICULO(long FK_VEHICULO) {
        this.FK_VEHICULO = FK_VEHICULO;
    }

    public long getID_ACTO_ADMINISTRATIVO() {
        return ID_ACTO_ADMINISTRATIVO;
    }

    public void setID_ACTO_ADMINISTRATIVO(long ID_ACTO_ADMINISTRATIVO) {
        this.ID_ACTO_ADMINISTRATIVO = ID_ACTO_ADMINISTRATIVO;
    }

    public String getMODIFICACION() {
        return MODIFICACION;
    }

    public void setMODIFICACION(String MODIFICACION) {
        this.MODIFICACION = MODIFICACION;
    }

    public String getNUMERO() {
        return NUMERO;
    }

    public void setNUMERO(String NUMERO) {
        this.NUMERO = NUMERO;
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

    public String getTRAMITE() {
        return TRAMITE;
    }

    public void setTRAMITE(String TRAMITE) {
        this.TRAMITE = TRAMITE;
    }

    public String getOBSERVACIONES() {
        return OBSERVACIONES;
    }

    public void setOBSERVACIONES(String OBSERVACIONES) {
        this.OBSERVACIONES = OBSERVACIONES;
    }



     public static Actos_Administrativos load(ResultSet rs)throws SQLException{
        Actos_Administrativos actosA= new Actos_Administrativos();
        actosA.setID_ACTO_ADMINISTRATIVO(rs.getLong(1));
        actosA.setNUMERO(rs.getString(2));
        actosA.setFECHA(rs.getDate(3));
        actosA.setFECHA_PROCESO(rs.getDate(4));
        actosA.setESTADO(rs.getInt(5));
        actosA.setFK_USUARIO(rs.getLong(6));
        actosA.setTIPO(rs.getInt(7));
        actosA.setTRAMITE(rs.getString(8));
        actosA.setMODIFICACION(rs.getString(9));
        actosA.setPLACA(rs.getString(10));
        actosA.setFK_VEHICULO(rs.getLong(11));
        actosA.setOBSERVACIONES(rs.getString(12));
        return actosA;
    }
}
