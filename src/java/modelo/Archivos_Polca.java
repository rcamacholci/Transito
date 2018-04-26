/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author digitalizacion
 */
import java.io.*;
import java.sql.*;

public class Archivos_Polca {

    private long id_archivo_polca;
    private String num_comparendo;

    public long getid_archivo_polca() {
        return id_archivo_polca;
    }

    public void setid_archivo_polca(long id_archivo_polca) {
        this.id_archivo_polca = id_archivo_polca;
    }

    public String getnum_comparendo() {
        return num_comparendo;
    }

    public void setnum_comparendo(String num_comparendo) {
        this.num_comparendo = num_comparendo;
    }

     public static Archivos_Polca load(ResultSet rs)throws SQLException{
        Archivos_Polca archivopolca = new Archivos_Polca();

        archivopolca.setid_archivo_polca(rs.getLong(1));
        archivopolca.setnum_comparendo(rs.getString(2));
      
        return archivopolca;
    }
}
