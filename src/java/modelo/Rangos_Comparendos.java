/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author acer
 */
import java.io.*;
import java.sql.*;
public class Rangos_Comparendos {
    private long id_rango,estado,fk_usuario;
    private String num_inicial,num_final,num_resolucion;
    private Date fecha_proceso, fecha_resolucion;

    public Long GetIdRango() {
        return id_rango;
    }

    public void SetIdRango(Long id_rango) {
        this.id_rango = id_rango;
    }

    public String GetNum_Inicial() {
        return num_inicial;
    }

    public void SetNum_Inicial(String num_inicial) {
        this.num_inicial = num_inicial;
    }

     public String GetNum_Final() {
        return num_final;
    }

    public void SetNum_Final(String num_final) {
        this.num_final = num_final;
    }

     public Date GetFecha_Proceso() {
        return fecha_proceso;
    }

    public void Setfecha_Proceso(Date fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }

    public Long GetEstado() {
        return estado;
    }

    public void SetEstado(Long estado) {
        this.estado = estado;
    }

   public String GetNum_resolucion() {
        return num_resolucion;
    }

    public void SetNum_resolucion(String num_resolucion) {
        this.num_resolucion = num_resolucion;
    }

   public Date GetFecha_Resolucion() {
        return fecha_resolucion;
    }

    public void Setfecha_Resolucion(Date fecha_resolucion) {
        this.fecha_resolucion = fecha_resolucion;
    }

    public Long GetFk_usuario() {
        return fk_usuario;
    }

    public void SetFk_usuario(Long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

   public static Rangos_Comparendos load(ResultSet rs)throws SQLException{
        Rangos_Comparendos rangos_comparendos= new Rangos_Comparendos();
        rangos_comparendos.SetIdRango(rs.getLong(1));
        rangos_comparendos.SetNum_Inicial(rs.getString(2));
        rangos_comparendos.SetNum_Final(rs.getString(3));
        rangos_comparendos.Setfecha_Proceso(rs.getDate(4));
        rangos_comparendos.SetEstado(rs.getLong(5));
        rangos_comparendos.SetNum_resolucion(rs.getString(6));
        rangos_comparendos.Setfecha_Resolucion(rs.getDate(7));
        rangos_comparendos.SetFk_usuario(rs.getLong(8));
        return rangos_comparendos;
    }

}
