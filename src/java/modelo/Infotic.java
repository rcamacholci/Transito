/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

/**
 *
 * @author Desarrollo
 */
public class Infotic {
private String PLACA;
private String SERVICIO;
private String COLOR;
private String MODELO;
private String MARCA;
private String LINEA;
private String VIEGENCIA;
private String ESTADO_CARTERA;
private float VALOR;
private float NTERES;
private float COSTAS;
private float EXTEMPORANIEDA;
private String NOMBRES;
private String DIRECCION;
private String CELULAR;
private String TELEFONO;


public static Infotic load(java.sql.ResultSet rs)throws java.sql.SQLException{
        Infotic inf = new Infotic();
        inf.setPLACA(rs.getString(1));
        inf.setSERVICIO(rs.getString(2));
        inf.setCOLOR(rs.getString(3));
        inf.setMODELO(rs.getString(4));
        inf.setMARCA(rs.getString(5));
        inf.setLINEA(rs.getString(6));
        inf.setVIEGENCIA(rs.getString(7));
        inf.setESTADO_CARTERA(rs.getString(8));
        inf.setVALOR(rs.getFloat(9));
        inf.setNTERES(rs.getFloat(10));
        inf.setCOSTAS(rs.getFloat(11));
        inf.setEXTEMPORANIEDA(rs.getFloat(12));
        inf.setNOMBRES(rs.getString(13));
        inf.setDIRECCION(rs.getString(14));
        inf.setCELULAR(rs.getString(15));
        inf.setTELEFONO(rs.getString(16));
        
        return inf;
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

    public String getCOLOR() {
        return COLOR;
    }

    public void setCOLOR(String COLOR) {
        this.COLOR = COLOR;
    }

    public String getMODELO() {
        return MODELO;
    }

    public void setMODELO(String MODELO) {
        this.MODELO = MODELO;
    }

    public String getMARCA() {
        return MARCA;
    }

    public void setMARCA(String MARCA) {
        this.MARCA = MARCA;
    }

    public String getLINEA() {
        return LINEA;
    }

    public void setLINEA(String LINEA) {
        this.LINEA = LINEA;
    }

    public String getVIEGENCIA() {
        return VIEGENCIA;
    }

    public void setVIEGENCIA(String VIEGENCIA) {
        this.VIEGENCIA = VIEGENCIA;
    }

    public String getESTADO_CARTERA() {
        return ESTADO_CARTERA;
    }

    public void setESTADO_CARTERA(String ESTADO_CARTERA) {
        this.ESTADO_CARTERA = ESTADO_CARTERA;
    }

    public float getVALOR() {
        return VALOR;
    }

    public void setVALOR(float VALOR) {
        this.VALOR = VALOR;
    }

    public float getNTERES() {
        return NTERES;
    }

    public void setNTERES(float NTERES) {
        this.NTERES = NTERES;
    }

    public float getCOSTAS() {
        return COSTAS;
    }

    public void setCOSTAS(float COSTAS) {
        this.COSTAS = COSTAS;
    }

    public float getEXTEMPORANIEDA() {
        return EXTEMPORANIEDA;
    }

    public void setEXTEMPORANIEDA(float EXTEMPORANIEDA) {
        this.EXTEMPORANIEDA = EXTEMPORANIEDA;
    }

    /**
     * @return the NOMBRES
     */
    public String getNOMBRES() {
        return NOMBRES;
    }

    /**
     * @param NOMBRES the NOMBRES to set
     */
    public void setNOMBRES(String NOMBRES) {
        this.NOMBRES = NOMBRES;
    }

    /**
     * @return the DIRECCION
     */
    public String getDIRECCION() {
        return DIRECCION;
    }

    /**
     * @param DIRECCION the DIRECCION to set
     */
    public void setDIRECCION(String DIRECCION) {
        this.DIRECCION = DIRECCION;
    }

    /**
     * @return the CELULAR
     */
    public String getCELULAR() {
        return CELULAR;
    }

    /**
     * @param CELULAR the CELULAR to set
     */
    public void setCELULAR(String CELULAR) {
        this.CELULAR = CELULAR;
    }

    /**
     * @return the TELEFONO
     */
    public String getTELEFONO() {
        return TELEFONO;
    }

    /**
     * @param TELEFONO the TELEFONO to set
     */
    public void setTELEFONO(String TELEFONO) {
        this.TELEFONO = TELEFONO;
    }

}
