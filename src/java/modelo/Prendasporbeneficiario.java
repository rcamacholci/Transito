/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.io.*;
import java.sql.*;
public class Prendasporbeneficiario {

    
    private String Placa, Estadovehiculo, Estadoalerta, Observaciones;
    private Date Fechaprenda, Fechalevantada;
   
    public String getPlaca() {
        return Placa;
    }

    public void setPlaca(String Placa) {
        this.Placa = Placa;
    }

    public String getEstadovehiculo() {
        return Estadovehiculo;
    }

    public void setEstadovehiculo(String Estadovehiculo) {
        this.Estadovehiculo = Estadovehiculo;
    }

    public String getEstadoalerta() {
        return Estadoalerta;
    }

    public void setEstadoalerta(String Estadoalerta) {
        this.Estadoalerta = Estadoalerta;
    }

    public Date getFechaprenda() {
        return Fechaprenda;
    }

    public void setFechaprenda(Date Fechaprenda) {
        this.Fechaprenda = Fechaprenda;
    }

     public Date getFechalevantada() {
        return Fechalevantada;
    }

    public void setFechalevantada(Date Fechalevantada) {
        this.Fechalevantada = Fechalevantada;
    }

    public String getObservaciones() {
        return Observaciones;
    }

    public void setObservaciones(String Observaciones) {
        this.Observaciones = Observaciones;
    }

    public static Prendasporbeneficiario load(ResultSet rs)throws SQLException{
        
        Prendasporbeneficiario prendasporbeneficiario= new Prendasporbeneficiario();
        
        prendasporbeneficiario.setPlaca(rs.getString(1));
        prendasporbeneficiario.setEstadovehiculo(rs.getString(2));
        prendasporbeneficiario.setEstadoalerta(rs.getString(3));
        prendasporbeneficiario.setFechaprenda(rs.getDate(4));
        prendasporbeneficiario.setFechalevantada(rs.getDate(5));
        prendasporbeneficiario.setObservaciones(rs.getString(6));
        
        return prendasporbeneficiario;
    
    }

}
