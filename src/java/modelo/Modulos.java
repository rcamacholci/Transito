/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Sistemas
 */

import java.io.*;
import java.sql.*;
public class Modulos {

     private String modulo;
     private long codigo;
     
     public long getCodigo() {
        return codigo;
    }

    public void setCodigo(long codigo) {
        this.codigo = codigo;
    }
     
      public String getModulo() {
        return modulo;
    }

    public void setModulo(String modulo) {
        this.modulo = modulo;
    }

    public static Modulos load(ResultSet rs)throws SQLException{
        Modulos modulos= new Modulos();

        modulos.setCodigo(rs.getLong(1));
        modulos.setModulo(rs.getString(2));
         
        return modulos;



    }

}
