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
public class Detalle_Rango_Comparendo {
private long id_rango_detalle;
    private long fk_rango,Estado,fk_agente,fk_usuario;
    private Date fecha_uso,fecha_asignacion;
    private String Numero;

    public Long GetIdRango_detalle() {
        return id_rango_detalle;
    }

    public void SetIdRango_detalle(Long id_rango) {
        this.id_rango_detalle = id_rango;
    }
    ///////////////////////////////////////////////////////////
      public Long GetFk_rango() {
        return fk_rango;
    }

    public void SetFk_rango(Long fk_rango) {
        this.fk_rango = fk_rango;
    }
//////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
      public String GetNumero() {
        return Numero;
    }

    public void SetNumero(String Numero) {
        this.Numero = Numero;
    }
//////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////
      public Long GetEstado() {
        return Estado;
    }

    public void SetEstado(Long Estado) {
        this.Estado = Estado;
    }
//////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
      public Long GetFk_agente() {
        return fk_agente;
    }

    public void SetFk_agente(Long fk_agente) {
        this.fk_agente = fk_agente;
    }
//////////////////////////////////////////////////////////

   public Date GetFecha_uso() {
        return fecha_uso;
    }

    public void Setfecha_uso(Date fecha_uso) {
        this.fecha_uso = fecha_uso;
    }

     public Long GetFk_usuario() {
        return fk_usuario;
    }

    public void SetFk_usuario(Long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }


       public Date GetFecha_asignacion() {
        return fecha_asignacion;
    }

    public void Setfecha_asignacion(Date fecha_asignacion) {
        this.fecha_asignacion = fecha_asignacion;
    }

   public static Detalle_Rango_Comparendo load(ResultSet rs)throws SQLException{
        Detalle_Rango_Comparendo rangos_comparendos= new Detalle_Rango_Comparendo();
        rangos_comparendos.SetIdRango_detalle(rs.getLong(1));
        rangos_comparendos.SetFk_rango(rs.getLong(2));
        rangos_comparendos.SetNumero(rs.getString(3));
        rangos_comparendos.SetEstado(rs.getLong(4));
        rangos_comparendos.SetFk_agente(rs.getLong(5));
        rangos_comparendos.Setfecha_asignacion(rs.getDate(6));
        rangos_comparendos.SetFk_usuario(rs.getLong(7));
        rangos_comparendos.Setfecha_uso(rs.getDate(8));

        return rangos_comparendos;
    }

}
