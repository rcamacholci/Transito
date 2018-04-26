/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;


import java.io.*;
import java.sql.*;

public class FechaMaxUsuario {

private Date fecha;

public Date getFecha() {
        return fecha ;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    protected static FechaMaxUsuario load(ResultSet rst)throws SQLException{

        FechaMaxUsuario v = new FechaMaxUsuario() ;
        v.setFecha(rst.getDate(1)) ;

        return v ;
    }



}
