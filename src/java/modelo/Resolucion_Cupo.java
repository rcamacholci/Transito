/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;
import java.io.*;
import java.sql.*;
/**
 *
 * @author Administrador
 */
public class Resolucion_Cupo implements Serializable{

  private long   ID_RESOLUCION,SOLICITANTE,ASEGURADORA,MODELO,FK_LINEA,PBV,FK_USUARIO;
  private  String MT,CONSECUTIVO,PLACA,RESOLUCION,NUMERO_POLIZA,CLASE,MOTOR,CHASIS,SERIE,OBSERVACION;
  private  Date FECHA,FECHA_UTILIZADO;
  private  int SERVICIO,ESTADO;
  private  Timestamp FECHA_REGISTRO;

    public long getASEGURADORA() {
        return ASEGURADORA;
    }

    public void setASEGURADORA(long ASEGURADORA) {
        this.ASEGURADORA = ASEGURADORA;
    }

    public int getESTADO() {
        return ESTADO;
    }

    public void setESTADO(int ESTADO) {
        this.ESTADO = ESTADO;
    }

    public Date getFECHA_UTILIZADO() {
        return FECHA_UTILIZADO;
    }

    public void setFECHA_UTILIZADO(Date FECHA_UTILIZADO) {
        this.FECHA_UTILIZADO = FECHA_UTILIZADO;
    }

    public String getPLACA() {
        return PLACA;
    }

    public void setPLACA(String PLACA) {
        this.PLACA = PLACA;
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

    public String getCONSECUTIVO() {
        return CONSECUTIVO;
    }

    public void setCONSECUTIVO(String CONSECUTIVO) {
        this.CONSECUTIVO = CONSECUTIVO;
    }

    public Date getFECHA() {
        return FECHA;
    }

    public void setFECHA(Date FECHA) {
        this.FECHA = FECHA;
    }

    public Timestamp getFECHA_REGISTRO() {
        return FECHA_REGISTRO;
    }

    public void setFECHA_REGISTRO(Timestamp FECHA_REGISTRO) {
        this.FECHA_REGISTRO = FECHA_REGISTRO;
    }

   

    public long getFK_LINEA() {
        return FK_LINEA;
    }

    public void setFK_LINEA(long FK_LINEA) {
        this.FK_LINEA = FK_LINEA;
    }

    public long getFK_USUARIO() {
        return FK_USUARIO;
    }

    public void setFK_USUARIO(long FK_USUARIO) {
        this.FK_USUARIO = FK_USUARIO;
    }

    public long getID_RESOLUCION() {
        return ID_RESOLUCION;
    }

    public void setID_RESOLUCION(long ID_RESOLUCION) {
        this.ID_RESOLUCION = ID_RESOLUCION;
    }

    public long getMODELO() {
        return MODELO;
    }

    public void setMODELO(long MODELO) {
        this.MODELO = MODELO;
    }

    public String getMOTOR() {
        return MOTOR;
    }

    public void setMOTOR(String MOTOR) {
        this.MOTOR = MOTOR;
    }

    public String getMT() {
        return MT;
    }

    public void setMT(String MT) {
        this.MT = MT;
    }

    public String getNUMERO_POLIZA() {
        return NUMERO_POLIZA;
    }

    public void setNUMERO_POLIZA(String NUMERO_POLIZA) {
        this.NUMERO_POLIZA = NUMERO_POLIZA;
    }

    public String getOBSERVACION() {
        return OBSERVACION;
    }

    public void setOBSERVACION(String OBSERVACION) {
        this.OBSERVACION = OBSERVACION;
    }

    public long getPBV() {
        return PBV;
    }

    public void setPBV(long PBV) {
        this.PBV = PBV;
    }

    public String getRESOLUCION() {
        return RESOLUCION;
    }

    public void setRESOLUCION(String RESOLUCION) {
        this.RESOLUCION = RESOLUCION;
    }

    public String getSERIE() {
        return SERIE;
    }

    public void setSERIE(String SERIE) {
        this.SERIE = SERIE;
    }

    public int getSERVICIO() {
        return SERVICIO;
    }

    public void setSERVICIO(int SERVICIO) {
        this.SERVICIO = SERVICIO;
    }

    public long getSOLICITANTE() {
        return SOLICITANTE;
    }

    public void setSOLICITANTE(long SOLICITANTE) {
        this.SOLICITANTE = SOLICITANTE;
    }




    public static Resolucion_Cupo load(ResultSet rs)throws SQLException{
           Resolucion_Cupo resolucionC =new Resolucion_Cupo();
           resolucionC.setMT(rs.getString(1));
           resolucionC.setCONSECUTIVO(rs.getString(2));
           resolucionC.setRESOLUCION(rs.getString(3));
           resolucionC.setFECHA(rs.getDate(4));
           resolucionC.setSOLICITANTE(rs.getLong(5));
           resolucionC.setASEGURADORA(rs.getLong(6));
           resolucionC.setNUMERO_POLIZA(rs.getString(7));
           resolucionC.setCLASE(rs.getString(8));
           resolucionC.setMODELO(rs.getLong(9));
           resolucionC.setMOTOR(rs.getString(10));
           resolucionC.setCHASIS(rs.getString(11));
           resolucionC.setSERIE(rs.getString(12));
           resolucionC.setFK_LINEA(rs.getLong(13));
           resolucionC.setSERVICIO(rs.getInt(14));
           resolucionC.setPBV(rs.getLong(15));
           resolucionC.setFK_USUARIO(rs.getLong(16));
           resolucionC.setFECHA_REGISTRO(rs.getTimestamp(17));
           resolucionC.setOBSERVACION(rs.getString(18));
           resolucionC.setPLACA(rs.getString(19));
           resolucionC.setESTADO(rs.getInt(20));
           resolucionC.setFECHA_UTILIZADO(rs.getDate(21));
           return resolucionC;
   }


}
