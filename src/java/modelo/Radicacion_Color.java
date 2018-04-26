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
public class Radicacion_Color implements Serializable {
    
private long id_radicacion_color,fk_color,fk_formulario;
private String gama;
private int sequencia;

    public long getFk_color() {
        return fk_color;
    }

    public void setFk_color(long fk_color) {
        this.fk_color = fk_color;
    }

    public long getFk_formulario() {
        return fk_formulario;
    }

    public void setFk_formulario(long fk_formulario) {
        this.fk_formulario = fk_formulario;
    }

    public String getGama() {
        return gama;
    }

    public void setGama(String gama) {
        this.gama = gama;
    }

    public long getId_radicacion_color() {
        return id_radicacion_color;
    }

    public void setId_radicacion_color(long id_radicacion_color) {
        this.id_radicacion_color = id_radicacion_color;
    }

    public int getSequencia() {
        return sequencia;
    }

    public void setSequencia(int sequencia) {
        this.sequencia = sequencia;
    }
    public static Radicacion_Color load(ResultSet rs)throws SQLException{
            Radicacion_Color radicacion = new Radicacion_Color();
            radicacion.setId_radicacion_color(rs.getLong(1));
            radicacion.setFk_color(rs.getLong(2));
            radicacion.setFk_formulario(rs.getLong(3));
            radicacion.setGama(rs.getString(4));
            radicacion.setSequencia(rs.getInt(5));
            return radicacion;
        }

}
