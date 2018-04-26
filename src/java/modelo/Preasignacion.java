/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Civitrans
 */
import java.sql.*;
import java.io.Serializable;

public class Preasignacion implements Serializable{
    private long id_preasignacion;
    private String placa;
    private String motor;
    private String chasis;
    private String serie;
    private String vin;
    private int servicio;
    private int clase;
    private int origenRegistro;
    private int tipo;
    private int estado;
    private int marca;
    private int linea;
    private int modelo;
    private String actaImportacion;
    private String estadoAutomotor;
    private String numeroSolicitud;
    private String estadoSolicitud;
    private java.sql.Timestamp fecha;
    private long fk_usuario;
    private long fk_persona;

    public String getChasis() {
        return chasis;
    }

    public void setChasis(String chasis) {
        this.chasis = chasis;
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

    public long getId_preasignacion() {
        return id_preasignacion;
    }

    public void setId_preasignacion(long id_preasignacion) {
        this.id_preasignacion = id_preasignacion;
    }

    public String getMotor() {
        return motor;
    }

    public void setMotor(String motor) {
        this.motor = motor;
    }

    public int getOrigenRegistro() {
        return origenRegistro;
    }

    public void setOrigenRegistro(int origenRegistro) {
        this.origenRegistro = origenRegistro;
    }

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    public String getSerie() {
        return serie;
    }

    public void setSerie(String serie) {
        this.serie = serie;
    }

    public int getServicio() {
        return servicio;
    }

    public void setServicio(int servicio) {
        this.servicio = servicio;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    public String getVin() {
        return vin;
    }

    public void setVin(String vin) {
        this.vin = vin;
    }

    public String getActaImportacion() {
        return actaImportacion;
    }

    public void setActaImportacion(String actaImportacion) {
        this.actaImportacion = actaImportacion;
    }

    public String getEstadoAutomotor() {
        return estadoAutomotor;
    }

    public void setEstadoAutomotor(String estadoAutomotor) {
        this.estadoAutomotor = estadoAutomotor;
    }

    public int getLinea() {
        return linea;
    }

    public void setLinea(int linea) {
        this.linea = linea;
    }

    public int getMarca() {
        return marca;
    }

    public void setMarca(int marca) {
        this.marca = marca;
    }

    public int getModelo() {
        return modelo;
    }

    public void setModelo(int modelo) {
        this.modelo = modelo;
    }

    public String getEstadoSolicitud() {
        return estadoSolicitud;
    }

    public void setEstadoSolicitud(String estadoSolicitud) {
        this.estadoSolicitud = estadoSolicitud;
    }

    public String getNumeroSolicitud() {
        return numeroSolicitud;
    }

    public void setNumeroSolicitud(String numeroSolicitud) {
        this.numeroSolicitud = numeroSolicitud;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    }

    public static Preasignacion load(ResultSet rs)throws SQLException{
        Preasignacion preasignacion = new Preasignacion();
        preasignacion.setId_preasignacion(rs.getLong(1));
        preasignacion.setPlaca(rs.getString(2));
        preasignacion.setMotor(rs.getString(3));
        preasignacion.setChasis(rs.getString(4));
        preasignacion.setSerie(rs.getString(5));
        preasignacion.setVin(rs.getString(6));
        preasignacion.setServicio(rs.getInt(7));
        preasignacion.setClase(rs.getInt(8));
        preasignacion.setOrigenRegistro(rs.getInt(9));
        preasignacion.setTipo(rs.getInt(10));
        preasignacion.setEstado(rs.getInt(11));
        preasignacion.setFecha(rs.getTimestamp(12));
        preasignacion.setMarca(rs.getInt(13));
        preasignacion.setLinea(rs.getInt(14));
        preasignacion.setModelo(rs.getInt(15));
        preasignacion.setActaImportacion(rs.getString(16));
        preasignacion.setEstadoAutomotor(rs.getString(17));
        preasignacion.setNumeroSolicitud(rs.getString(18));
        preasignacion.setEstadoSolicitud(rs.getString(19));
        preasignacion.setFk_usuario(rs.getLong(20));
        preasignacion.setFk_persona(rs.getLong(21));
        return preasignacion;
    }
}