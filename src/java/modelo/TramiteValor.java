package modelo;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Civitrans
 */
import java.io.*;
import java.sql.*;

public class TramiteValor implements Serializable {
    private String nombret;
    private long valor;

    public String getNombret() {
        return nombret;
    }

    public void setNombret(String nombret) {
        this.nombret = nombret;
    }

    public long getValor() {
        return valor;
    }

    public void setValor(long valor) {
        this.valor = valor;
    }
     
 

    public static TramiteValor load(ResultSet rs) throws SQLException {
        TramiteValor tramite = new TramiteValor();
        tramite.setNombret(rs.getString(1));
        tramite.setValor(rs.getLong(2));
        return tramite;
    }
}

