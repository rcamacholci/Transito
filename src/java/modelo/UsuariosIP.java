/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.io.*;
import java.sql.*;

public class UsuariosIP {

    
    private long id_usuario_ip, fk_usuario;
    private String ip, observacion;
    private Date fecha_ini, fecha_fin;

    public long getid_usuario_ip(){
        return id_usuario_ip;
    }

    public void setid_usuario_ip(long id_usuario_ip) {
        this.id_usuario_ip = id_usuario_ip;
    }
    
    public long getfk_usuario(){
        return fk_usuario;
    }

    public void setfk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

   public String getip() {
        return ip;
    }

    public void setip(String ip) {
        this.ip = ip;
    }

    public Date getfecha_ini() {
        return fecha_ini;
    }

    public void setfecha_ini(Date fecha_ini) {
        this.fecha_ini = fecha_ini;
    }

     public Date getfecha_fin() {
        return fecha_fin;
    }

    public void setfecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public String getobservacion() {
        return observacion;
    }

    public void setobservacion(String observacion) {
        this.observacion = observacion;
    }

    public static UsuariosIP load(ResultSet rs)throws SQLException{
        
        UsuariosIP ip = new UsuariosIP();
        
        ip.setid_usuario_ip(rs.getLong(1));
        ip.setfk_usuario(rs.getLong(2));
        ip.setip(rs.getString(3));
        ip.setfecha_ini(rs.getDate(4));
        ip.setfecha_fin(rs.getDate(5));
        ip.setobservacion(rs.getString(6));
        
        return ip;
    
    }

}
