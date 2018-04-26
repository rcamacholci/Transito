/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Administrador
 */
public class Comparendo_Curso {

    private long id_comparendo_curso;
    private long fk_persona;
    private long fk_comparendo;
    private int certificado;
    private Date fecha;
    private int lugar;
    private float valor;
    private int estado;
    private int descuento;

    public int getCertificado() {
        return certificado;
    }

    public void setCertificado(int certificado) {
        this.certificado = certificado;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public long getFk_comparendo() {
        return fk_comparendo;
    }

    public void setFk_comparendo(long fk_comparendo) {
        this.fk_comparendo = fk_comparendo;
    }

    public long getFk_persona() {
        return fk_persona;
    }

    public void setFk_persona(long fk_persona) {
        this.fk_persona = fk_persona;
    }

    public long getId_comparendo_curso() {
        return id_comparendo_curso;
    }

    public void setId_comparendo_curso(long id_comparendo_curso) {
        this.id_comparendo_curso = id_comparendo_curso;
    }

    public int getLugar() {
        return lugar;
    }

    public void setLugar(int lugar) {
        this.lugar = lugar;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }

    public int getDescuento() {
        return descuento;
    }

    public void setDescuento(int descuento) {
        this.descuento = descuento;
    }

    public static Comparendo_Curso load(ResultSet rs) throws SQLException{
        Comparendo_Curso comparendoCurso = new Comparendo_Curso();
        comparendoCurso.setId_comparendo_curso(rs.getLong(1));
        comparendoCurso.setFk_persona(rs.getLong(2));
        comparendoCurso.setFk_comparendo(rs.getLong(3));
        comparendoCurso.setCertificado(rs.getInt(4));
        comparendoCurso.setFecha(rs.getDate(5));
        comparendoCurso.setLugar(rs.getInt(6));
        comparendoCurso.setValor(rs.getFloat(7));
        comparendoCurso.setEstado(rs.getInt(8));
        comparendoCurso.setDescuento(rs.getInt(9));
        return comparendoCurso;
    }
}
