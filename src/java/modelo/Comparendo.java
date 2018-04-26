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
public class Comparendo implements Serializable{
    private long id_comparendo,fk_persona,fk_usuario_organismo;
    private long fk_sede,fk_infraccion,fk_agente,fk_cartera,sede_expedicion,fk_parqueadero,fk_usuario,fk_via;
    private String numero,lugar,placa,licencia_transito,observaciones,observaciones_estado,licencia_conduccion,categoria;
    private Timestamp fecha ,fecha_proceso;
    private Date fecha_vencimiento,sancionado;
    private int clase,servicio,tipo_infractor,fuga,accidente,inmovilizacion;
    private int polca,firmado,estado;

    public int getAccidente() {
        return accidente;
    }

    public void setAccidente(int accidente) {
        this.accidente = accidente;
    }

    public int getClase() {
        return clase;
    }

    public void setClase(int clase) {
        this.clase = clase;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Timestamp getFecha() {
        return fecha;
    }

    public void setFecha(Timestamp fecha) {
        this.fecha = fecha;
    }

    public Timestamp getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Timestamp fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public int getFirmado() {
        return firmado;
    }

    public void setFirmado(int firmado) {
        this.firmado = firmado;
    }

    public long getFk_agente() {
        return fk_agente;
    }

    public void setFk_agente(long fk_agente) {
        this.fk_agente = fk_agente;
    }

    public long getFk_cartera() {
        return fk_cartera;
    }

    public void setFk_cartera(long fk_cartera) {
        this.fk_cartera = fk_cartera;
    }

    public long getFk_infraccion() {
        return fk_infraccion;
    }

    public void setFk_infraccion(long fk_infraccion) {
        this.fk_infraccion = fk_infraccion;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    }

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getFk_usuario_organismo() {
        return fk_usuario_organismo;
    }

    public void setFk_usuario_organismo(long fk_usuario_organismo) {
        this.fk_usuario_organismo = fk_usuario_organismo;
    }

    public int getFuga() {
        return fuga;
    }

    public void setFuga(int fuga) {
        this.fuga = fuga;
    }

    public long getId_comparendo() {
        return id_comparendo;
    }

    public void setId_comparendo(long id_comparendo) {
        this.id_comparendo = id_comparendo;
    }

    public int getInmovilizacion() {
        return inmovilizacion;
    }

    public void setInmovilizacion(int inmovilizacion) {
        this.inmovilizacion = inmovilizacion;
    }

    public String getLicencia_transito() {
        return licencia_transito;
    }

    public void setLicencia_transito(String licencia_transito) {
        this.licencia_transito = licencia_transito;
    }

    public String getLugar() {
        return lugar;
    }

    public void setLugar(String lugar) {
        this.lugar = lugar;
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

    public String getObservaciones_estado() {
        return observaciones_estado;
    }

    public void setObservaciones_estado(String observaciones_estado) {
        this.observaciones_estado = observaciones_estado;
    }

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    public int getPolca() {
        return polca;
    }

    public void setPolca(int polca) {
        this.polca = polca;
    }

    public int getServicio() {
        return servicio;
    }

    public void setServicio(int servicio) {
        this.servicio = servicio;
    }

    public int getTipo_infractor() {
        return tipo_infractor;
    }

    public void setTipo_infractor(int tipo_infractor) {
        this.tipo_infractor = tipo_infractor;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public Date getFecha_vencimiento() {
        return fecha_vencimiento;
    }

    public void setFecha_vencimiento(Date fecha_vencimiento) {
        this.fecha_vencimiento = fecha_vencimiento;
    }

    public String getLicencia_conduccion() {
        return licencia_conduccion;
    }

    public void setLicencia_conduccion(String licencia_conduccion) {
        this.licencia_conduccion = licencia_conduccion;
    }

    public long getSede_expedicion() {
        return sede_expedicion;
    }

    public void setSede_expedicion(long sede_expedicion) {
        this.sede_expedicion = sede_expedicion;
    }

    public long getFk_parqueadero() {
        return fk_parqueadero;
    }

    public void setFk_parqueadero(long fk_parqueadero) {
        this.fk_parqueadero = fk_parqueadero;
    }

        public Date getSancionado() {
        return sancionado;
    }

    public void setSancionado(Date sancion){
        this.sancionado = sancionado;
    }

  /*public long getfk_usuario() {
        return fk_usuario;
    }

    public void setfk_usuario(long sede_expedicion) {
        this.sede_expedicion = sede_expedicion;
    }*/

    public long getfk_via() {
        return sede_expedicion;
    }

    public void setfk_via(long sede_expedicion) {
        this.sede_expedicion = sede_expedicion;
    }

    public static Comparendo load(ResultSet rs)throws SQLException{

        Comparendo comparendo = new Comparendo();

        comparendo.setId_comparendo(rs.getLong(1));
        comparendo.setFk_persona(rs.getLong(2));
        comparendo.setFk_usuario_organismo(rs.getLong(3));
        comparendo.setFk_sede(rs.getLong(4));
        comparendo.setFk_infraccion(rs.getLong(5));
        comparendo.setFk_agente(rs.getLong(6));
        comparendo.setNumero(rs.getString(7));
        comparendo.setFecha(rs.getTimestamp(8));
        comparendo.setLugar(rs.getString(9));
        comparendo.setPlaca(rs.getString(10));
        comparendo.setClase(rs.getInt(11));
        comparendo.setServicio(rs.getInt(12));
        comparendo.setTipo_infractor(rs.getInt(13));
        comparendo.setLicencia_transito(rs.getString(14));
        comparendo.setObservaciones(rs.getString(15));
        comparendo.setFuga(rs.getInt(16));
        comparendo.setAccidente(rs.getInt(17));
        comparendo.setInmovilizacion(rs.getInt(18));
        comparendo.setPolca(rs.getInt(19));
        comparendo.setFirmado(rs.getInt(20));
        comparendo.setEstado(rs.getInt(21));
        comparendo.setObservaciones_estado(rs.getString(22));
        comparendo.setFecha_proceso(rs.getTimestamp(23));
        comparendo.setFk_cartera(rs.getLong(24));
        comparendo.setLicencia_conduccion(rs.getString(25));
        comparendo.setCategoria(rs.getString(26));
        comparendo.setFecha_vencimiento(rs.getDate(27));
        comparendo.setSede_expedicion(rs.getLong(28));
        comparendo.setFk_parqueadero(rs.getLong(29));
        comparendo.setfk_via(rs.getLong(30));
       // comparendo.setSancionado(rs.getDate(30));
        return comparendo;
    }   
 }
