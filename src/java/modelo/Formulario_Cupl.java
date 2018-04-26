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
 * @author Jefrey
 */
public class Formulario_Cupl {
    
    private long id_formulario_cupl, fk_formulario;
    private int estado;
    private String no_cupl;
    private Date fecha_inicio, fecha_fin;

    public Formulario_Cupl() {
    }

    public Formulario_Cupl(long id_formulario_cupl, long fk_formulario, int estado, String no_cupl, Date fecha_inicio, Date fecha_fin) {
        this.id_formulario_cupl = id_formulario_cupl;
        this.fk_formulario = fk_formulario;
        this.estado = estado;
        this.no_cupl = no_cupl;
        this.fecha_inicio = fecha_inicio;
        this.fecha_fin = fecha_fin;
    }

    public long getId_formulario_cupl() {
        return id_formulario_cupl;
    }

    public void setId_formulario_cupl(long id_formulario_cupl) {
        this.id_formulario_cupl = id_formulario_cupl;
    }

    public long getFk_formulario() {
        return fk_formulario;
    }

    public void setFk_formulario(long fk_formulario) {
        this.fk_formulario = fk_formulario;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public String getNo_cupl() {
        return no_cupl;
    }

    public void setNo_cupl(String no_cupl) {
        this.no_cupl = no_cupl;
    }

    public Date getFecha_inicio() {
        return fecha_inicio;
    }

    public void setFecha_inicio(Date fecha_inicio) {
        this.fecha_inicio = fecha_inicio;
    }

    public Date getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }
    
    public static Formulario_Cupl load(ResultSet rs)throws SQLException{
        
        Formulario_Cupl formulario= new Formulario_Cupl();
        
        formulario.setId_formulario_cupl(rs.getLong(1));
        formulario.setFk_formulario(rs.getLong(2));
        formulario.setNo_cupl(rs.getString(3));
        formulario.setFecha_inicio(rs.getDate(4));
        formulario.setFecha_fin(rs.getDate(5));
        
        return formulario;
           
    }
    
}
