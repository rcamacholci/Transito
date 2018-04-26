package modelo;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Javier
 */
import java.io.*;
import java.sql.*;
public class UsuarioCaja implements Serializable{

    private long id_usuarioCaja,fk_sede,fk_caja,fk_usuario;
    private Date fechaInicio,fechaFin;

    public Date getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(Date fechaFin) {
        this.fechaFin = fechaFin;
    }

    public Date getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(Date fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public long getFk_caja() {
        return fk_caja;
    }

    public void setFk_caja(long fk_caja) {
        this.fk_caja = fk_caja;
    }

    public long getFk_sede() {
        return fk_sede;
    }

    public void setFk_sede(long fk_sede) {
        this.fk_sede = fk_sede;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getId_usuarioCaja() {
        return id_usuarioCaja;
    }

    public void setId_usuarioCaja(long id_usuarioCaja) {
        this.id_usuarioCaja = id_usuarioCaja;
    }


    public static UsuarioCaja load(ResultSet rs)throws SQLException{
        UsuarioCaja usuarioCaja= new UsuarioCaja();
        usuarioCaja.setId_usuarioCaja(rs.getLong(1));
        usuarioCaja.setFk_usuario(rs.getLong(2));
        usuarioCaja.setFk_sede(rs.getLong(3));
        usuarioCaja.setFk_caja(rs.getLong(4));
        usuarioCaja.setFechaInicio(rs.getDate(5));
        usuarioCaja.setFechaFin(rs.getDate(6));
        return usuarioCaja;
    } 
}
