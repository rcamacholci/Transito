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
public class Valor_Infraccion implements Serializable{
    private long id_valorinfraccion,fk_infraccion;
    private float valor;
    private int resolucion,porcentaje;
    private Date fecha,fecha_ini,fecha_fin;

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
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

    public long getFk_infraccion() {
        return fk_infraccion;
    }

    public void setFk_infraccion(long fk_infraccion) {
        this.fk_infraccion = fk_infraccion;
    }

    public long getId_valorinfraccion() {
        return id_valorinfraccion;
    }

    public void setId_valorinfraccion(long id_valorinfraccion) {
        this.id_valorinfraccion = id_valorinfraccion;
    }

    public int getPorcentaje() {
        return porcentaje;
    }

    public void setPorcentaje(int porcentaje) {
        this.porcentaje = porcentaje;
    }

    public int getResolucion() {
        return resolucion;
    }

    public void setResolucion(int resolucion) {
        this.resolucion = resolucion;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }
    
   public static Valor_Infraccion  load(ResultSet rs)throws SQLException{
       
        Valor_Infraccion valor_infraccion = new Valor_Infraccion();
        
                valor_infraccion.setId_valorinfraccion(rs.getLong(1));
                valor_infraccion.setFk_infraccion(rs.getLong(2));
                valor_infraccion.setPorcentaje(rs.getInt(3));
                valor_infraccion.setValor(rs.getFloat(4));
                valor_infraccion.setResolucion(rs.getInt(5));
                valor_infraccion.setFecha(rs.getDate(6));
                valor_infraccion.setFecha_ini(rs.getDate(7));
                valor_infraccion.setFecha_fin(rs.getDate(8));
                
                 return valor_infraccion;
        
        
   }
    
    
}
