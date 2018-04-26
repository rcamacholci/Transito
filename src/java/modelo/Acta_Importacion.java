/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.*;
/**
 *
 * @author Administrador
 */
public class Acta_Importacion {

  private long id_importacion,fk_divipo,fk_persona_importador,fk_linea,fk_usuario,fk_marca;
  private Timestamp fecha_reg;
  private Date  fecha_manifiesto, fecha_levante;
  private String numeroManifiesto,placa,tipoRegistro,numeroLevante,paisOrigen,clase,carroceria,origen;
  private String modelo,combustible,motor,chasis,serie,vin,ejes,cilindraje,fichaHomologacion,tipoAutomotor,pesoBruto;
  private int pasajeros,puertas;

    public String getCarroceria() {
        return carroceria;
    }

    public void setCarroceria(String carroceria) {
        this.carroceria = carroceria;
    }

    public String getChasis() {
        return chasis;
    }

    public void setChasis(String chasis) {
        this.chasis = chasis;
    }

    public String getCilindraje() {
        return cilindraje;
    }

    public void setCilindraje(String cilindraje) {
        this.cilindraje = cilindraje;
    }

    public String getClase() {
        return clase;
    }

    public void setClase(String clase) {
        this.clase = clase;
    }

    public String getCombustible() {
        return combustible;
    }

    public void setCombustible(String combustible) {
        this.combustible = combustible;
    }

    public String getEjes() {
        return ejes;
    }

    public void setEjes(String ejes) {
        this.ejes = ejes;
    }

    public Date getFecha_levante() {
        return fecha_levante;
    }

    public void setFecha_levante(Date fecha_levante) {
        this.fecha_levante = fecha_levante;
    }

    public Date getFecha_manifiesto() {
        return fecha_manifiesto;
    }

    public void setFecha_manifiesto(Date fecha_manifiesto) {
        this.fecha_manifiesto = fecha_manifiesto;
    }

    public Timestamp getFecha_reg() {
        return fecha_reg;
    }

    public void setFecha_reg(Timestamp fecha_reg) {
        this.fecha_reg = fecha_reg;
    }

    public String getFichaHomologacion() {
        return fichaHomologacion;
    }

    public void setFichaHomologacion(String fichaHomologacion) {
        this.fichaHomologacion = fichaHomologacion;
    }

    public long getFk_divipo() {
        return fk_divipo;
    }

    public void setFk_divipo(long fk_divipo) {
        this.fk_divipo = fk_divipo;
    }

    public long getFk_linea() {
        return fk_linea;
    }

    public void setFk_linea(long fk_linea) {
        this.fk_linea = fk_linea;
    }

     public long getFk_marca() {
        return fk_marca;
    }

    public void setFk_marca(long fk_marca) {
        this.fk_marca = fk_marca;
    }

    public long getFk_persona_importador() {
        return fk_persona_importador;
    }

    public void setFk_persona_importador(long fk_persona_importador) {
        this.fk_persona_importador = fk_persona_importador;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getId_importacion() {
        return id_importacion;
    }

    public void setId_importacion(long id_importacion) {
        this.id_importacion = id_importacion;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public String getMotor() {
        return motor;
    }

    public void setMotor(String motor) {
        this.motor = motor;
    }

    public String getNumeroLevante() {
        return numeroLevante;
    }

    public void setNumeroLevante(String numeroLevante) {
        this.numeroLevante = numeroLevante;
    }

    public String getNumeroManifiesto() {
        return numeroManifiesto;
    }

    public void setNumeroManifiesto(String numeroManifiesto) {
        this.numeroManifiesto = numeroManifiesto;
    }

    public String getOrigen() {
        return origen;
    }

    public void setOrigen(String origen) {
        this.origen = origen;
    }

    public String getPaisOrigen() {
        return paisOrigen;
    }

    public void setPaisOrigen(String paisOrigen) {
        this.paisOrigen = paisOrigen;
    }

    public int getPasajeros() {
        return pasajeros;
    }

    public void setPasajeros(int pasajeros) {
        this.pasajeros = pasajeros;
    }

    public String getPesoBruto() {
        return pesoBruto;
    }

    public void setPesoBruto(String pesoBruto) {
        this.pesoBruto = pesoBruto;
    }

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    public int getPuertas() {
        return puertas;
    }

    public void setPuertas(int puertas) {
        this.puertas = puertas;
    }

    public String getSerie() {
        return serie;
    }

    public void setSerie(String serie) {
        this.serie = serie;
    }

    public String getTipoAutomotor() {
        return tipoAutomotor;
    }

    public void setTipoAutomotor(String tipoAutomotor) {
        this.tipoAutomotor = tipoAutomotor;
    }

    public String getTipoRegistro() {
        return tipoRegistro;
    }

    public void setTipoRegistro(String tipoRegistro) {
        this.tipoRegistro = tipoRegistro;
    }

    public String getVin() {
        return vin;
    }

    public void setVin(String vin) {
        this.vin = vin;
    }

    public static Acta_Importacion load(ResultSet rs)throws SQLException{
           Acta_Importacion acta_Importacion =new Acta_Importacion();
           acta_Importacion.setCarroceria(rs.getString(1));
           acta_Importacion.setChasis(rs.getString(2));
           acta_Importacion.setCilindraje(rs.getString(3));
           acta_Importacion.setClase(rs.getString(4));
           acta_Importacion.setCombustible(rs.getString(5));
           acta_Importacion.setEjes(rs.getString(6));
           acta_Importacion.setFecha_levante(rs.getDate(7));
           acta_Importacion.setFecha_manifiesto(rs.getDate(8));
           acta_Importacion.setFecha_reg(rs.getTimestamp(9));
           acta_Importacion.setFichaHomologacion(rs.getString(10));
           acta_Importacion.setFk_divipo(rs.getLong(11));
           acta_Importacion.setFk_linea(rs.getLong(12));
           acta_Importacion.setFk_persona_importador(rs.getLong(13));
           acta_Importacion.setFk_usuario(rs.getLong(14));
           acta_Importacion.setId_importacion(rs.getLong(15));
           acta_Importacion.setModelo(rs.getString(16));
           acta_Importacion.setMotor(rs.getString(17));
           acta_Importacion.setNumeroLevante(rs.getString(18));
           acta_Importacion.setNumeroManifiesto(rs.getString(19));
           acta_Importacion.setOrigen(rs.getString(20));
           acta_Importacion.setPaisOrigen(rs.getString(21));
           acta_Importacion.setPasajeros(rs.getInt(22));
           acta_Importacion.setPesoBruto(rs.getString(23));
           acta_Importacion.setPlaca(rs.getString(24));
           acta_Importacion.setPuertas(rs.getInt(25));
           acta_Importacion.setSerie(rs.getString(26));
           acta_Importacion.setTipoAutomotor(rs.getString(27));
           acta_Importacion.setTipoRegistro(rs.getString(28));
           acta_Importacion.setVin(rs.getString(29));
           acta_Importacion.setFk_marca(rs.getLong(30));
           return acta_Importacion;
   }


}
