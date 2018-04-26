/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.Date;

/**
 *
 * @author Civitrans
 */
public class UsuarioRunt {

    private long idUsuarioRunt;
    private long fk_usuario;
    private String codigo;
    private String password;
    private String template;
    private java.sql.Date fecha_ini;
    private java.sql.Date fecha_fin;

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public Date getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public Date getFecha_ini() {
        return fecha_ini;
    }

    public void setFecha_ini(Date fecha_ini) {
        this.fecha_ini = fecha_ini;
    }

    public long getFk_usuario() {
        return fk_usuario;
    }

    public void setFk_usuario(long fk_usuario) {
        this.fk_usuario = fk_usuario;
    }

    public long getIdUsuarioRunt() {
        return idUsuarioRunt;
    }

    public void setIdUsuarioRunt(long idUsuarioRunt) {
        this.idUsuarioRunt = idUsuarioRunt;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getTemplate() {
        return template;
    }

    public void setTemplate(String template) {
        this.template = template;
    }

    public static UsuarioRunt load(java.sql.ResultSet rs) throws java.sql.SQLException{
        UsuarioRunt usuarioRunt = new UsuarioRunt();
        usuarioRunt.setIdUsuarioRunt(rs.getLong(1));
        usuarioRunt.setFk_usuario(rs.getLong(2));
        usuarioRunt.setCodigo(rs.getString(3));
        usuarioRunt.setPassword(rs.getString(4));
        usuarioRunt.setTemplate(rs.getString(5));
        usuarioRunt.setFecha_ini(rs.getDate(6));
        usuarioRunt.setFecha_fin(rs.getDate(7));
        return usuarioRunt;
    }

}
