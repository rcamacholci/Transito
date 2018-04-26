/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author SISTEMAS
 */
public class Tipo_Financiacion {
    private long id_tipoFinanciacion,fk_conceptoCartera,fk_conceptoInteres,fk_conceptoMora,fk_sede;
    private int modalidad,periodo,periodo_mora,tipo_interesMora,cuotas_desde,cuotas_hasta,limite_gracia,ajuste_cuota;
    private  String nombre;
    private Date fecha_ini,fecha_fin;
    private double intereses,interes_mora,saldo_desde,saldo_hasta,inicial_desde,inicial_hasta;

    public int getAjuste_cuota() {
        return ajuste_cuota;
    }

    public void setAjuste_cuota(int ajuste_cuota) {
        this.ajuste_cuota = ajuste_cuota;
    }

    public int getCuotas_desde() {
        return cuotas_desde;
    }

    public void setCuotas_desde(int cuotas_desde) {
        this.cuotas_desde = cuotas_desde;
    }

    public int getCuotas_hasta() {
        return cuotas_hasta;
    }

    public void setCuotas_hasta(int cuotas_hasta) {
        this.cuotas_hasta = cuotas_hasta;
    }

    public Date getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public Date getFecha_ini() {
        return fecha_ini;
    }

    public void setFecha_ini(Date fecha_ini) {
        this.fecha_ini = fecha_ini;
    }

    public long getFk_conceptoCartera() {
        return fk_conceptoCartera;
    }

    public void setFk_conceptoCartera(long fk_conceptoCartera) {
        this.fk_conceptoCartera = fk_conceptoCartera;
    }

    public long getFk_conceptoInteres() {
        return fk_conceptoInteres;
    }

    public void setFk_conceptoInteres(long fk_conceptoInteres) {
        this.fk_conceptoInteres = fk_conceptoInteres;
    }

    public long getFk_conceptoMora() {
        return fk_conceptoMora;
    }

    public void setFk_conceptoMora(long fk_conceptoMora) {
        this.fk_conceptoMora = fk_conceptoMora;
    }

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getId_tipoFinanciacion() {
        return id_tipoFinanciacion;
    }

    public void setId_tipoFinanciacion(long id_tipoFinanciacion) {
        this.id_tipoFinanciacion = id_tipoFinanciacion;
    }

    public double getInicial_desde() {
        return inicial_desde;
    }

    public void setInicial_desde(double inicial_desde) {
        this.inicial_desde = inicial_desde;
    }

    public double getInicial_hasta() {
        return inicial_hasta;
    }

    public void setInicial_hasta(double inicial_hasta) {
        this.inicial_hasta = inicial_hasta;
    }

    public double getInteres_mora() {
        return interes_mora;
    }

    public void setInteres_mora(double interes_mora) {
        this.interes_mora = interes_mora;
    }

    public double getIntereses() {
        return intereses;
    }

    public void setIntereses(double intereses) {
        this.intereses = intereses;
    }

    public int getLimite_gracia() {
        return limite_gracia;
    }

    public void setLimite_gracia(int limite_gracia) {
        this.limite_gracia = limite_gracia;
    }

    public int getModalidad() {
        return modalidad;
    }

    public void setModalidad(int modalidad) {
        this.modalidad = modalidad;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getPeriodo() {
        return periodo;
    }

    public void setPeriodo(int periodo) {
        this.periodo = periodo;
    }

    public int getPeriodo_mora() {
        return periodo_mora;
    }

    public void setPeriodo_mora(int periodo_mora) {
        this.periodo_mora = periodo_mora;
    }

    public double getSaldo_desde() {
        return saldo_desde;
    }

    public void setSaldo_desde(double saldo_desde) {
        this.saldo_desde = saldo_desde;
    }

    public double getSaldo_hasta() {
        return saldo_hasta;
    }

    public void setSaldo_hasta(double saldo_hasta) {
        this.saldo_hasta = saldo_hasta;
    }

    public int getTipo_interesMora() {
        return tipo_interesMora;
    }

    public void setTipo_interesMora(int tipo_interesMora) {
        this.tipo_interesMora = tipo_interesMora;
    }
    
    public static Tipo_Financiacion load(ResultSet rs)throws SQLException{
        Tipo_Financiacion tipoFinanciacion = new Tipo_Financiacion();
        tipoFinanciacion.setId_tipoFinanciacion(rs.getLong(1));
        tipoFinanciacion.setNombre(rs.getString(2));
        tipoFinanciacion.setFecha_ini(rs.getDate(3));
        tipoFinanciacion.setFecha_fin(rs.getDate(4));
        tipoFinanciacion.setModalidad(rs.getInt(5));
        tipoFinanciacion.setFk_conceptoCartera(rs.getInt(6));
        tipoFinanciacion.setIntereses(rs.getDouble(7));
        tipoFinanciacion.setFk_conceptoInteres(rs.getInt(8));
        tipoFinanciacion.setPeriodo(rs.getInt(9));
        tipoFinanciacion.setInteres_mora(rs.getDouble(10));
        tipoFinanciacion.setFk_conceptoMora(rs.getInt(11));
        tipoFinanciacion.setPeriodo_mora(rs.getInt(12));
        tipoFinanciacion.setTipo_interesMora(rs.getInt(13));
        tipoFinanciacion.setSaldo_desde(rs.getDouble(14));
        tipoFinanciacion.setSaldo_hasta(rs.getDouble(15));
        tipoFinanciacion.setCuotas_desde(rs.getInt(16));
        tipoFinanciacion.setCuotas_hasta(rs.getInt(17));
        tipoFinanciacion.setLimite_gracia(rs.getInt(18));
        tipoFinanciacion.setInicial_desde(rs.getDouble(19));
        tipoFinanciacion.setInicial_hasta(rs.getDouble(20));
        tipoFinanciacion.setAjuste_cuota(rs.getInt(21));
        tipoFinanciacion.setFk_sede(rs.getLong(22));
        return tipoFinanciacion;
    }
          
    
}
