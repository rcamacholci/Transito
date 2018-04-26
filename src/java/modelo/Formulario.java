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
public class Formulario  implements Serializable{
    
  private long id_formulario,fk_linea,fk_aseguradora,fk_divipo,fk_radicacion,modelo,fk_tramite,fk_pago,fk_marca,modalidad_servicio,fk_departamento;
  private int clase_vehiculo,combustible,carroceria,motor_reg,serie_reg,tipo_doc_importacion,tipo_importacion,modalidad;
  private int entidad_remate,codigo_aduana,servicio,sede_movimiento,chasis_reg,rodaje,tipo_cabina;
  private String numero,placa,motor,chasis,serie,nro_poliza,observaciones,licencia_transito,documento_importacion,runt,runt2,simit,condicion_ingreso,vin,area_metropolitana;
  private Date fecha_documento,fecha_poliza,fecha_ingreso_rnma;
  private java.sql.Timestamp fecha_tramite;

    public String getRunt2() {
        return runt2;
    }

    public void setRunt2(String runt2) {
        this.runt2 = runt2;
    }

    public long getModalidad_servicio() {
        return modalidad_servicio;
    }

    public void setModalidad_servicio(long modalidad_servicio) {
        this.modalidad_servicio = modalidad_servicio;
    }

    public String getArea_metropolitana() {
        return area_metropolitana;
    }

    public void setArea_metropolitana(String area_metropolitana) {
        this.area_metropolitana = area_metropolitana;
    }

    public int getChasis_reg() {
        return chasis_reg;
    }

    public void setChasis_reg(int chasis_reg) {
        this.chasis_reg = chasis_reg;
    }

    public String getMotor() {
        return motor;
    }

    public void setMotor(String motor) {
        this.motor = motor;
    }

    public int getCarroceria() {
        return carroceria;
    }

    public void setCarroceria(int carroceria) {
        this.carroceria = carroceria;
    }

    public String getChasis() {
        return chasis;
    }

    public void setChasis(String chasis) {
        this.chasis = chasis;
    }

    public int getClase_vehiculo() {
        return clase_vehiculo;
    }

    public void setClase_vehiculo(int clase_vehiculo) {
        this.clase_vehiculo = clase_vehiculo;
    }

    public int getCodigo_aduana() {
        return codigo_aduana;
    }

    public void setCodigo_aduana(int codigo_aduana) {
        this.codigo_aduana = codigo_aduana;
    }

    public int getCombustible() {
        return combustible;
    }

    public void setCombustible(int combustible) {
        this.combustible = combustible;
    }

    public String getDocumento_importacion() {
        return documento_importacion;
    }

    public void setDocumento_importacion(String documento_importacion) {
        this.documento_importacion = documento_importacion;
    }

    public int getEntidad_remate() {
        return entidad_remate;
    }

    public void setEntidad_remate(int entidad_remate) {
        this.entidad_remate = entidad_remate;
    }

    public Date getFecha_documento() {
        return fecha_documento;
    }

    public void setFecha_documento(Date fecha_documento) {
        this.fecha_documento = fecha_documento;
    }

    public Date getFecha_poliza() {
        return fecha_poliza;
    }

    public void setFecha_poliza(Date fecha_poliza) {
        this.fecha_poliza = fecha_poliza;
    }

    public java.sql.Timestamp getFecha_tramite() {
        return fecha_tramite;
    }

    public void setFecha_tramite(java.sql.Timestamp fecha_tramite) {
        this.fecha_tramite = fecha_tramite;
    }

    public long getFk_aseguradora() {
        return fk_aseguradora;
    }

    public void setFk_aseguradora(long fk_aseguradora) {
        this.fk_aseguradora = fk_aseguradora;
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

    public long getFk_radicacion() {
        return fk_radicacion;
    }

    public void setFk_radicacion(long fk_radicacion) {
        this.fk_radicacion = fk_radicacion;
    }

    public long getId_formulario() {
        return id_formulario;
    }

    public void setId_formulario(long id_formulario) {
        this.id_formulario = id_formulario;
    }

    public String getLicencia_transito() {
        return licencia_transito;
    }

    public void setLicencia_transito(String licencia_transito) {
        this.licencia_transito = licencia_transito;
    }

    public long getModelo() {
        return modelo;
    }

    public void setModelo(long modelo) {
        this.modelo = modelo;
    }

    public int getMotor_reg() {
        return motor_reg;
    }

    public void setMotor_reg(int motor_reg) {
        this.motor_reg = motor_reg;
    }

    public String getNro_poliza() {
        return nro_poliza;
    }

    public void setNro_poliza(String nro_poliza) {
        this.nro_poliza = nro_poliza;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    public int getSede_movimiento() {
        return sede_movimiento;
    }

    public void setSede_movimiento(int sede_movimiento) {
        this.sede_movimiento = sede_movimiento;
    }

    public String getSerie() {
        return serie;
    }

    public void setSerie(String serie) {
        this.serie = serie;
    }

    public int getSerie_reg() {
        return serie_reg;
    }

    public void setSerie_reg(int serie_reg) {
        this.serie_reg = serie_reg;
    }

    public int getServicio() {
        return servicio;
    }

    public void setServicio(int servicio) {
        this.servicio = servicio;
    }

    public int getTipo_doc_importacion() {
        return tipo_doc_importacion;
    }

    public void setTipo_doc_importacion(int tipo_doc_importacion) {
        this.tipo_doc_importacion = tipo_doc_importacion;
    }

    public int getTipo_importacion() {
        return tipo_importacion;
    }

    public void setTipo_importacion(int tipo_importacion) {
        this.tipo_importacion = tipo_importacion;
    }

    public int getModalidad() {
        return modalidad;
    }

    public void setModalidad(int modalidad) {
        this.modalidad = modalidad;
    }

    public long getFk_tramite() {
        return fk_tramite;
    }

    public void setFk_tramite(long fk_tramite) {
        this.fk_tramite = fk_tramite;
    }

    public String getRunt() {
        return runt;
    }

    public void setRunt(String runt) {
        this.runt = runt;
    }

    public String getSimit() {
        return simit;
    }

    public void setSimit(String simit) {
        this.simit = simit;
    }

    public long getFk_pago() {
        return fk_pago;
    }

    public void setFk_pago(long fk_pago) {
        this.fk_pago = fk_pago;
    }

    public int getRodaje() {
        return rodaje;
    }

    public void setRodaje(int rodaje) {
        this.rodaje = rodaje;
    }

    public int getTipo_cabina() {
        return tipo_cabina;
    }

    public void setTipo_cabina(int tipo_cabina) {
        this.tipo_cabina = tipo_cabina;
    }

    public String getCondicion_ingreso() {
        return condicion_ingreso;
    }

    public void setCondicion_ingreso(String condicion_ingreso) {
        this.condicion_ingreso = condicion_ingreso;
    }

    public Date getFecha_ingreso_rnma() {
        return fecha_ingreso_rnma;
    }

    public void setFecha_ingreso_rnma(Date fecha_ingreso_rnma) {
        this.fecha_ingreso_rnma = fecha_ingreso_rnma;
    }

    public String getVin() {
        return vin;
    }

    public void setVin(String vin) {
        this.vin = vin;
    }

    public long getFk_marca() {
        return fk_marca;
    }

    public void setFk_marca(long fk_marca) {
        this.fk_marca = fk_marca;
    }

    public long getFk_departamento() {
        return fk_departamento;
    }

    public void setFk_departamento(long fk_departamento) {
        this.fk_departamento = fk_departamento;
    }





    
    public static Formulario load(ResultSet rs)throws SQLException{
        Formulario formulario= new Formulario();
        
        formulario.setId_formulario(rs.getLong(1));
        formulario.setFk_linea(rs.getLong(2));
        formulario.setFk_aseguradora(rs.getLong(3));
        formulario.setFk_divipo(rs.getLong(4));
        formulario.setNumero(rs.getString(5));
        formulario.setFecha_tramite(rs.getTimestamp(6));
        formulario.setPlaca(rs.getString(7));
        formulario.setClase_vehiculo(rs.getInt(8));
        formulario.setModelo(rs.getInt(9));
        formulario.setCombustible(rs.getInt(10));
        formulario.setCarroceria(rs.getInt(11));
        formulario.setMotor(rs.getString(12));
        formulario.setMotor_reg(rs.getInt(13));
        formulario.setChasis(rs.getString(14));
        formulario.setChasis_reg(rs.getInt(15));
        formulario.setSerie(rs.getString(16));
        formulario.setSerie_reg(rs.getInt(17));
        formulario.setTipo_doc_importacion(rs.getInt(18));
        formulario.setTipo_importacion(rs.getInt(19));
        formulario.setEntidad_remate(rs.getInt(20));
        formulario.setCodigo_aduana(rs.getInt(21));
        formulario.setDocumento_importacion(rs.getString(22));
        formulario.setFecha_documento(rs.getDate(23));
        formulario.setServicio(rs.getInt(24));
        formulario.setNro_poliza(rs.getString(25));
        formulario.setFecha_poliza(rs.getDate(26));
        formulario.setObservaciones(rs.getString(27));
        formulario.setLicencia_transito(rs.getString(28));
        formulario.setSede_movimiento(rs.getInt(29));
        formulario.setFk_radicacion(rs.getLong(30));
        formulario.setModalidad(rs.getInt(31));
        formulario.setFk_tramite(rs.getLong(32));
        formulario.setRunt(rs.getString(33));
        formulario.setSimit(rs.getString(34));
        formulario.setFk_pago(rs.getLong(35));
        formulario.setFecha_ingreso_rnma(rs.getDate(36));
        formulario.setCondicion_ingreso(rs.getString(37));
        formulario.setRodaje(rs.getInt(38));
        formulario.setTipo_cabina(rs.getInt(39));
        formulario.setRunt2(rs.getString(40));
        formulario.setVin(rs.getString(41));
        formulario.setFk_marca(rs.getLong(42));
        formulario.setArea_metropolitana(rs.getString(43));
        formulario.setModalidad_servicio(rs.getLong(44));
        formulario.setFk_departamento(rs.getLong(45));
        return formulario;
           
    }

    @Override
    public String toString() {
        return super.toString();
    }
        
        

}
