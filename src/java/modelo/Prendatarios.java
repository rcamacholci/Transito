/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.io.*;
import java.sql.*;
public class Prendatarios {

    private String Observaciones;
   
   
    public String getObservaciones() {
        return Observaciones;
    }

    public void setObservaciones(String Observaciones) {
        this.Observaciones = Observaciones;
    }

    public static Prendatarios load(ResultSet rs)throws SQLException{
        
        Prendatarios prendatarios= new Prendatarios();
        prendatarios.setObservaciones(rs.getString(1));
          
        return prendatarios;
    
    }

}
