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
 * @author Administrador
 */
public class COMPARENDO_PATIO implements Serializable{
    private long ID_COMPARENDOS_PATIOS,FK_COMPARENDO,FK_PATIO,FK_PERSONA,CONSECUTIVO_INMO,FK_USUARIO;
    private  Date FECHA_INGRESO,FECHA_SALIDA,FECHA_RECIBO;
    private int TIPO,ESTADO;
    private String RECIBO,NUMERO_GRUA,PLACA_GRUA,NUMERO_SALIDA,PLACA,CLASE,SERVICIO,MARCA,LINEA,MOTOR,CHASIS,MODELO,COLOR,OBSERVACION;
    private String CED_AUTORIZADO,NOMBRE_AUTORIZADO,CED_PROPIETARIO,NOMBRE_PROPIETARIO;

    public long getID_COMPARENDOS_PATIOS() {
        return ID_COMPARENDOS_PATIOS;
    }

    public void setID_COMPARENDOS_PATIOS(long ID_COMPARENDOS_PATIOS) {
        this.ID_COMPARENDOS_PATIOS = ID_COMPARENDOS_PATIOS;
    }



    public long getCONSECUTIVO_INMO() {
        return CONSECUTIVO_INMO;
    }

    public void setCONSECUTIVO_INMO(long CONSECUTIVO_INMO) {
        this.CONSECUTIVO_INMO = CONSECUTIVO_INMO;
    }

    public int getESTADO() {
        return ESTADO;
    }

    public void setESTADO(int ESTADO) {
        this.ESTADO = ESTADO;
    }

    public Date getFECHA_INGRESO() {
        return FECHA_INGRESO;
    }

    public void setFECHA_INGRESO(Date FECHA_INGRESO) {
        this.FECHA_INGRESO = FECHA_INGRESO;
    }

    public Date getFECHA_RECIBO() {
        return FECHA_RECIBO;
    }

    public void setFECHA_RECIBO(Date FECHA_RECIBO) {
        this.FECHA_RECIBO = FECHA_RECIBO;
    }

    public Date getFECHA_SALIDA() {
        return FECHA_SALIDA;
    }

    public void setFECHA_SALIDA(Date FECHA_SALIDA) {
        this.FECHA_SALIDA = FECHA_SALIDA;
    }

    public long getFK_COMPARENDO() {
        return FK_COMPARENDO;
    }

    public void setFK_COMPARENDO(long FK_COMPARENDO) {
        this.FK_COMPARENDO = FK_COMPARENDO;
    }

     public long getFK_PATIO() {
        return FK_PATIO;
    }

    public void setFK_PATIO(long FK_PATIO) {
        this.FK_PATIO = FK_PATIO;
    }

    public long getFK_PERSONA() {
        return FK_PERSONA;
    }

    public void setFK_PERSONA(long FK_PERSONA) {
        this.FK_PERSONA = FK_PERSONA;
    }

    public String getNUMERO_GRUA() {
        return NUMERO_GRUA;
    }

    public void setNUMERO_GRUA(String NUMERO_GRUA) {
        this.NUMERO_GRUA = NUMERO_GRUA;
    }

    public String getNUMERO_SALIDA() {
        return NUMERO_SALIDA;
    }

    public void setNUMERO_SALIDA(String NUMERO_SALIDA) {
        this.NUMERO_SALIDA = NUMERO_SALIDA;
    }

    public String getPLACA_GRUA() {
        return PLACA_GRUA;
    }

    public void setPLACA_GRUA(String PLACA_GRUA) {
        this.PLACA_GRUA = PLACA_GRUA;
    }

    public String getRECIBO() {
        return RECIBO;
    }

    public void setRECIBO(String RECIBO) {
        this.RECIBO = RECIBO;
    }

    public int getTIPO() {
        return TIPO;
    }

    public void setTIPO(int TIPO) {
        this.TIPO = TIPO;
    }

    public String getCED_AUTORIZADO() {
        return CED_AUTORIZADO;
    }

    public void setCED_AUTORIZADO(String CED_AUTORIZADO) {
        this.CED_AUTORIZADO = CED_AUTORIZADO;
    }

    public String getCED_PROPIETARIO() {
        return CED_PROPIETARIO;
    }

    public void setCED_PROPIETARIO(String CED_PROPIETARIO) {
        this.CED_PROPIETARIO = CED_PROPIETARIO;
    }

    public String getCHASIS() {
        return CHASIS;
    }

    public void setCHASIS(String CHASIS) {
        this.CHASIS = CHASIS;
    }

    public String getCLASE() {
        return CLASE;
    }

    public void setCLASE(String CLASE) {
        this.CLASE = CLASE;
    }

    public String getCOLOR() {
        return COLOR;
    }

    public void setCOLOR(String COLOR) {
        this.COLOR = COLOR;
    }

    public long getFK_USUARIO() {
        return FK_USUARIO;
    }

    public void setFK_USUARIO(long FK_USUARIO) {
        this.FK_USUARIO = FK_USUARIO;
    }

    public String getLINEA() {
        return LINEA;
    }

    public void setLINEA(String LINEA) {
        this.LINEA = LINEA;
    }

    public String getMARCA() {
        return MARCA;
    }

    public void setMARCA(String MARCA) {
        this.MARCA = MARCA;
    }

    public String getMODELO() {
        return MODELO;
    }

    public void setMODELO(String MODELO) {
        this.MODELO = MODELO;
    }

    public String getMOTOR() {
        return MOTOR;
    }

    public void setMOTOR(String MOTOR) {
        this.MOTOR = MOTOR;
    }

    public String getNOMBRE_AUTORIZADO() {
        return NOMBRE_AUTORIZADO;
    }

    public void setNOMBRE_AUTORIZADO(String NOMBRE_AUTORIZADO) {
        this.NOMBRE_AUTORIZADO = NOMBRE_AUTORIZADO;
    }

    public String getNOMBRE_PROPIETARIO() {
        return NOMBRE_PROPIETARIO;
    }

    public void setNOMBRE_PROPIETARIO(String NOMBRE_PROPIETARIO) {
        this.NOMBRE_PROPIETARIO = NOMBRE_PROPIETARIO;
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

    public String getSERVICIO() {
        return SERVICIO;
    }

    public void setSERVICIO(String SERVICIO) {
        this.SERVICIO = SERVICIO;
    }



    public static COMPARENDO_PATIO load(ResultSet rs)throws SQLException{
       COMPARENDO_PATIO patio= new COMPARENDO_PATIO();
       patio.setID_COMPARENDOS_PATIOS(rs.getLong(1));
       patio.setFK_COMPARENDO(rs.getLong(2));
       patio.setFK_PATIO(rs.getLong(3));
       patio.setFECHA_INGRESO(rs.getDate(4));
       patio.setFK_PERSONA(rs.getLong(5));
       patio.setNUMERO_SALIDA(rs.getString(6));
       patio.setFECHA_SALIDA(rs.getDate(7));
       patio.setRECIBO(rs.getString(8));
       patio.setFECHA_RECIBO(rs.getDate(9));
       patio.setTIPO(rs.getInt(10));
       patio.setESTADO(rs.getInt(11));
       patio.setCONSECUTIVO_INMO(rs.getLong(12));
       patio.setNUMERO_GRUA(rs.getString(13));
       patio.setPLACA_GRUA(rs.getString(14));
       patio.setPLACA(rs.getString(15));
       patio.setCLASE(rs.getString(16));
       patio.setSERVICIO(rs.getString(17));
       patio.setMARCA(rs.getString(18));
       patio.setLINEA(rs.getString(19));
       patio.setMOTOR(rs.getString(20));
       patio.setCHASIS(rs.getString(21));
       patio.setMODELO(rs.getString(22));
       patio.setCOLOR(rs.getString(23));
       patio.setOBSERVACION(rs.getString(24));
       patio.setFK_USUARIO(rs.getLong(25));
       patio.setCED_AUTORIZADO(rs.getString(26));
       patio.setNOMBRE_AUTORIZADO(rs.getString(27));
       patio.setCED_PROPIETARIO(rs.getString(28));
       patio.setNOMBRE_PROPIETARIO(rs.getString(29));
       return patio;


 }




}
