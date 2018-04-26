/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Javier
 */
import java.io.*;
import java.sql.*;
public class Reincidentes implements Serializable{

    private String nombre,numero,mes,documento;
    private long cantidad;
  //---------------------------------//
    public String getnombre() {
        return nombre;
    }

    public void setnombre(String fecha_fin) {
        this.nombre = fecha_fin;
    }

    public String getnumero() {
        return numero;
    }

    public void setnumero(String fecha_fin) {
        this.numero = fecha_fin;
    }

    public String getmes() {
        return mes;
    }

    public void setmes(String fecha_fin) {
        this.mes = fecha_fin;
    }

    public String getdocumento() {
        return documento;
    }

    public void setdocumento(String fecha_fin) {
        this.documento = fecha_fin;
    }

    public Long getcantidad() {
        return cantidad;
    }

    public void setcantidad(Long fecha_fin) {
        this.cantidad = fecha_fin;
    }



    public static Reincidentes load (ResultSet rs)throws SQLException{
          Reincidentes caja = new Reincidentes();

          caja.setnombre(rs.getString(1));
          caja.setdocumento(rs.getString(2));
          caja.setnumero(rs.getString(3));
          caja.setmes(rs.getString(4));
          caja.setcantidad(rs.getLong(5));
          return caja;
        }
}
