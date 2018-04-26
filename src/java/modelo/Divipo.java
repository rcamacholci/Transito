/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo ;

/**
 *
 * @author Javier
 */
import java.io.*;
import java.sql.*;


public class Divipo implements Serializable {
    private long id_divipo;
    private String nombre_depto,nombre_poblado,nombre_municipio,codigo;
    private long fk_departamento,fk_municipio,fk_poblado;

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public long getFk_departamento() {
        return fk_departamento;
    }

    public void setFk_departamento(long fk_departamento) {
        this.fk_departamento = fk_departamento;
    }

    public long getFk_municipio() {
        return fk_municipio;
    }

    public void setFk_municipio(long fk_municipio) {
        this.fk_municipio = fk_municipio;
    }

    public long getFk_poblado() {
        return fk_poblado;
    }

    public void setFk_poblado(long fk_poblado) {
        this.fk_poblado = fk_poblado;
    }

    public long getId_divipo() {
        return id_divipo;
    }

    public void setId_divipo(long id_divipo) {
        this.id_divipo = id_divipo;
    }

    public String getNombre_depto() {
        return nombre_depto;
    }

    public void setNombre_depto(String nombre_depto) {
        this.nombre_depto = nombre_depto;
    }

    public String getNombre_municipio() {
        return nombre_municipio;
    }

    public void setNombre_municipio(String nombre_municipio) {
        this.nombre_municipio = nombre_municipio;
    }

    public String getNombre_poblado() {
        return nombre_poblado;
    }

    public void setNombre_poblado(String nombre_poblado) {
        this.nombre_poblado = nombre_poblado;
    }
    
public static Divipo load(ResultSet rs)throws SQLException{
    
    Divipo divipo = new Divipo();
    divipo.setId_divipo(rs.getLong(1));
    divipo.setNombre_depto(rs.getString(2));
    divipo.setNombre_poblado(rs.getString(3));
    divipo.setNombre_municipio(rs.getString(4));
    divipo.setCodigo(rs.getString(5));
    divipo.setFk_departamento(rs.getLong(6));
    divipo.setFk_municipio(rs.getLong(7));
    divipo.setFk_poblado(rs.getLong(8));
    
    return divipo;
}
   
}
