/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author acer
 */
import java.io.*;
import java.sql.*;
public class Rein implements Serializable {
private String id_banco;


    public String getRein() {
        return id_banco;
    }

    public void setRein(String id_banco) {
        this.id_banco = id_banco;
    }

     public static Rein load(ResultSet rs)throws SQLException{
        Rein banco = new Rein();

        banco.setRein(rs.getString(1));
        return banco;
    }
}

