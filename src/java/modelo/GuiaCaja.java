/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Administrador
 */
import java.io.*;
import java.sql.*;
public class GuiaCaja implements Serializable {
    private long id_guia_caja,fk_vehiculo,fk_usuario;
    private Date fecha;
    private String caja,codigo,folio,estado,letra_caja;

    public String getCaja() {
        return caja;
    }

    public void setCaja(String caja) {
        this.caja = caja;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getFk_vehiculo() {
        return fk_vehiculo;
    }

    public void setFk_vehiculo(long fk_vehiculo) {
        this.fk_vehiculo = fk_vehiculo;
    }

    public String getFolio() {
        return folio;
    }

    public void setFolio(String folio) {
        this.folio = folio;
    }

    public long getId_guia_caja() {
        return id_guia_caja;
    }

    public void setId_guia_caja(long id_guia_caja) {
        this.id_guia_caja = id_guia_caja;
    }

    public String getLetra_caja() {
        return letra_caja;
    }

    public void setLetra_caja(String letra_caja) {
        this.letra_caja = letra_caja;
    }

    public static GuiaCaja load(ResultSet rs)throws SQLException{
        GuiaCaja caja = new GuiaCaja();
        caja.setId_guia_caja(rs.getLong(1));
        caja.setFk_vehiculo(rs.getLong(2));
        caja.setCaja(rs.getString(3));
        caja.setCodigo(rs.getString(4));
        caja.setFolio(rs.getString(5));
        caja.setEstado(rs.getString(6));
        caja.setLetra_caja(rs.getString(7));
        caja.setFk_usuario(rs.getLong(8));
        caja.setFecha(rs.getDate(9));
        return caja;

    }
    }
