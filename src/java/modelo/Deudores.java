/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author JgCarreno
 */
public class Deudores implements Serializable {

    private String TDocumento, Documento, Nombre, Apeliido1, Apellido2, Dirreccion, Ciudad, Telefono;
    private long Deuda;

    public static Deudores Load(ResultSet rs) throws SQLException {
        Deudores deu = new Deudores();
        deu.setTDocumento(rs.getString(1));
        deu.setDocumento(rs.getString(2));
        deu.setNombre(rs.getString(3));
        deu.setApeliido1(rs.getString(4));
        deu.setApellido2(rs.getString(5));
        deu.setDirreccion(rs.getString(6));
        deu.setCiudad(rs.getString(7));
        deu.setTelefono(rs.getString(8));
        deu.setDeuda(rs.getLong(9));
        return deu;
    }

    /**
     * @return the TDocumento
     */
    public String getTDocumento() {
        return TDocumento;
    }

    /**
     * @param TDocumento the TDocumento to set
     */
    public void setTDocumento(String TDocumento) {
        this.TDocumento = TDocumento;
    }

    /**
     * @return the Documento
     */
    public String getDocumento() {
        return Documento;
    }

    /**
     * @param Documento the Documento to set
     */
    public void setDocumento(String Documento) {
        this.Documento = Documento;
    }

    /**
     * @return the Nombre
     */
    public String getNombre() {
        return Nombre;
    }

    /**
     * @param Nombre the Nombre to set
     */
    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    /**
     * @return the Apeliido1
     */
    public String getApeliido1() {
        return Apeliido1;
    }

    /**
     * @param Apeliido1 the Apeliido1 to set
     */
    public void setApeliido1(String Apeliido1) {
        this.Apeliido1 = Apeliido1;
    }

    /**
     * @return the Apellido2
     */
    public String getApellido2() {
        return Apellido2;
    }

    /**
     * @param Apellido2 the Apellido2 to set
     */
    public void setApellido2(String Apellido2) {
        this.Apellido2 = Apellido2;
    }

    /**
     * @return the Dirreccion
     */
    public String getDirreccion() {
        return Dirreccion;
    }

    /**
     * @param Dirreccion the Dirreccion to set
     */
    public void setDirreccion(String Dirreccion) {
        this.Dirreccion = Dirreccion;
    }

    /**
     * @return the Ciudad
     */
    public String getCiudad() {
        return Ciudad;
    }

    /**
     * @param Ciudad the Ciudad to set
     */
    public void setCiudad(String Ciudad) {
        this.Ciudad = Ciudad;
    }

    /**
     * @return the Telefono
     */
    public String getTelefono() {
        return Telefono;
    }

    /**
     * @param Telefono the Telefono to set
     */
    public void setTelefono(String Telefono) {
        this.Telefono = Telefono;
    }

    /**
     * @return the Deuda
     */
    public long getDeuda() {
        return Deuda;
    }

    /**
     * @param Deuda the Deuda to set
     */
    public void setDeuda(long Deuda) {
        this.Deuda = Deuda;
    }

}
