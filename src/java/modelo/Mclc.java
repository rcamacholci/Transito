/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;
import java.util.* ;
import java.sql.* ;
import java.io.*;
import java.sql.Date ;

/**
 *
 * @author Administrador
 */
public class Mclc implements Serializable{
     private String placa ;
     private String clase ;
     private String servicio ;
     private String marca ;
     private String linea ;
     private String carroceria ;
     private String propietario ;

public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    public String getClase() {
        return clase;
    }

    public void setClase(String clase) {
        this.clase = clase;
    }

    public String getServicio() {
        return servicio;
    }

    public void setServicio(String servicio) {
        this.servicio = servicio;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getLinea() {
        return linea;
    }

    public void setLinea(String linea) {
        this.linea = linea;
    }

    public String getCarroceria() {
        return carroceria;
    }

    public void setCarroceria(String carroceria) {
        this.carroceria = carroceria;
    }

     public String getPropietario() {
        return propietario;
    }

    public void setPropietario(String propietario) {
        this.propietario = propietario;
    }

    protected static Mclc load(ResultSet rst)throws SQLException{

        Mclc v = new Mclc() ;
        v.setPlaca(rst.getString(1)) ;
        v.setClase(rst.getString(2)) ;
        v.setServicio(rst.getString(3)) ;
        v.setMarca(rst.getString(4)) ;
        v.setLinea(rst.getString(5)) ;
        v.setCarroceria(rst.getString(6)) ;
        v.setPropietario(rst.getString(7)) ;

        return v ;
    }


}
