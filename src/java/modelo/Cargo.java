/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Sistemas-Jefrey
 */
public class Cargo {

    private long id_cargo, fk_usuario, grupo_cargo, cargo, fk_usuario_proceso;
    private String codigo;
    private Date fecha_ini, fecha_fin, fecha_proceso;

    public long getId_cargo() {
        return id_cargo;
    }

    public void setId_cargo(long id_cargo) {
        this.id_cargo = id_cargo;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getGrupo_cargo() {
        return grupo_cargo;
    }

    public void setGrupo_cargo(long grupo_cargo) {
        this.grupo_cargo = grupo_cargo;
    }

    public long getCargo() {
        return cargo;
    }

    public void setCargo(long cargo) {
        this.cargo = cargo;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public Date getFecha_ini() {
        return fecha_ini;
    }

    public void setFecha_ini(Date fecha_ini) {
        this.fecha_ini = fecha_ini;
    }

    public Date getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public long getFk_usuario_proceso() {
        return fk_usuario_proceso;
    }

    public void setFk_usuario_proceso(long fk_usuario_proceso) {
        this.fk_usuario_proceso = fk_usuario_proceso;
    }

    public Date getFecha_proceso() {
        return fecha_proceso;
    }

    public void setFecha_proceso(Date fecha_proceso) {
        this.fecha_proceso = fecha_proceso;
    }



    public static Cargo load (ResultSet rs)throws SQLException{
          Cargo cargo = new Cargo();

          cargo.setId_cargo(rs.getLong(1));
          cargo.setFk_usuario(rs.getLong(2));
          cargo.setGrupo_cargo(rs.getLong(3));
          cargo.setFecha_ini(rs.getDate(4));
          cargo.setFecha_fin(rs.getDate(5));
          cargo.setCodigo(rs.getString(6));
          cargo.setCargo(rs.getLong(7));
          cargo.setFk_usuario_proceso(rs.getLong(8));
          cargo.setFecha_proceso(rs.getDate(5));

          return cargo;

        }

}