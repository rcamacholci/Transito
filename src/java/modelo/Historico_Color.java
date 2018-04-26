/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.* ;
import java.io.* ;
/**
 *
 * @author Project
 */
public class Historico_Color implements Serializable{
    
    private long id_historico ;
    private long fk_color ;
    private long fk_vehiculo ;
    private String gama ;
    private int secuencia ;
    private Date fecha_ini ;
    private Date fecha_fin ;
    private long fk_usuario;

    public long getId_historico() {
        return id_historico;
    }

    public void setId_historico(long id_historico) {
        this.id_historico = id_historico;
    }

    public long getFk_color() {
        return fk_color;
    }

    public void setFk_color(long fk_color) {
        this.fk_color = fk_color;
    }

    public long getFk_vehiculo() {
        return fk_vehiculo;
    }

    public void setFk_vehiculo(long fk_vehiculo) {
        this.fk_vehiculo = fk_vehiculo;
    }

    public String getGama() {
        return gama;
    }

    public void setGama(String gama) {
        this.gama = gama;
    }

    public int getSecuencia() {
        return secuencia;
    }

    public void setSecuencia(int secuencia) {
        this.secuencia = secuencia;
    }

    public Date getFecha_ini() {
        return fecha_ini;
    }

    public void setFecha_ini(Date fecha_ini) {
        this.fecha_ini = fecha_ini;
    }

    public Date getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }
    
    protected static Historico_Color load(ResultSet rst)throws SQLException{
        
        Historico_Color historico_color = new Historico_Color () ;
        historico_color.setId_historico(rst.getLong(1));
        historico_color.setFk_color(rst.getLong(2));
        historico_color.setFk_vehiculo(rst.getLong(3));
        historico_color.setGama(rst.getString(4));
        historico_color.setSecuencia(rst.getInt(5));
        historico_color.setFecha_ini(rst.getDate(6)); 
        historico_color.setFecha_fin(rst.getDate(7));
        historico_color.setFk_usuario(rst.getLong(8));
        
        return historico_color ;
    }

}
