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
public class Radicacion_Dato_Vehiculo {
private long id_rad_dat_vehiculo,fk_formulario;
private String valor;
private int grupo,parametro,subgrupo;

    public long getFk_formulario() {
        return fk_formulario;
    }

    public void setFk_formulario(long fk_formulario) {
        this.fk_formulario = fk_formulario;
    }

    public int getGrupo() {
        return grupo;
    }

    public void setGrupo(int grupo) {
        this.grupo = grupo;
    }

    public long getId_rad_dat_vehiculo() {
        return id_rad_dat_vehiculo;
    }

    public void setId_rad_dat_vehiculo(long id_rad_dat_vehiculo) {
        this.id_rad_dat_vehiculo = id_rad_dat_vehiculo;
    }

    public int getParametro() {
        return parametro;
    }

    public void setParametro(int parametro) {
        this.parametro = parametro;
    }

    public int getSubgrupo() {
        return subgrupo;
    }

    public void setSubgrupo(int subgrupo) {
        this.subgrupo = subgrupo;
    }

    public String getValor() {
        return valor;
    }

    public void setValor(String valor) {
        this.valor = valor;
    }

    

public static Radicacion_Dato_Vehiculo load(ResultSet rs)throws SQLException{
    
    Radicacion_Dato_Vehiculo radicacion = new Radicacion_Dato_Vehiculo();
    
    radicacion.setId_rad_dat_vehiculo(rs.getLong(1));
    radicacion.setFk_formulario(rs.getLong(2));
    radicacion.setGrupo(rs.getInt(3));
    radicacion.setParametro(rs.getInt(4));
    radicacion.setSubgrupo(rs.getInt(5));   
    radicacion.setValor(rs.getString(6));
       
    
     return  radicacion;
}
}
