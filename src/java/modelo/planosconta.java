/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.util.* ;
import java.sql.* ;
import java.io.*;

public class planosconta {

   private String plano;

public String getplano() {
        return plano ;
    }

    public void setplano(String plano) {
        this.plano = plano;
    }
   
    protected static planosconta load(ResultSet rst)throws SQLException{

        planosconta v = new planosconta() ;
        v.setplano(rst.getString(1)) ;
    
        return v ;
    }



}
