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
public class Recurso_Perfil {
    private long id_recurso_perfil,fk_recurso,fk_perfil;
    private Date fecha_inicio,fecha_final;

    public Date getFecha_final() {
        return fecha_final;
    }

    public void setFecha_final(Date fecha_final) {
        this.fecha_final = fecha_final;
    }

    public Date getFecha_inicio() {
        return fecha_inicio;
    }

    public void setFecha_inicio(Date fecha_inicio) {
        this.fecha_inicio = fecha_inicio;
    }

    public long getFk_perfil() {
        return fk_perfil;
    }

    public void setFk_perfil(long fk_perfil) {
        this.fk_perfil = fk_perfil;
    }

    public long getFk_recurso() {
        return fk_recurso;
    }

    public void setFk_recurso(long fk_recurso) {
        this.fk_recurso = fk_recurso;
    }

    public long getId_recurso_perfil() {
        return id_recurso_perfil;
    }

    public void setId_recurso_perfil(long id_recurso_perfil) {
        this.id_recurso_perfil = id_recurso_perfil;
    }


    public static Recurso_Perfil load(ResultSet rs)throws SQLException{
        Recurso_Perfil recurso_perfil= new Recurso_Perfil();
        recurso_perfil.setId_recurso_perfil(rs.getLong(1));
        recurso_perfil.setFk_perfil(rs.getLong(2));
        recurso_perfil.setFk_recurso(rs.getLong(3));
        recurso_perfil.setFecha_inicio(rs.getDate(4));
        recurso_perfil.setFecha_final(rs.getDate(5));
        return recurso_perfil;
    }
         
}
