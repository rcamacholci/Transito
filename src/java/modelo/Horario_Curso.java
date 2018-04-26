/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

/**
 *
 * @author Administrador
 */
public class Horario_Curso {

    private long idHorarioCurso;
    private java.sql.Timestamp fecha;
    private int cupos;
    private int estado;

    public int getCupos() {
        return cupos;
    }

    public void setCupos(int cupos) {
        this.cupos = cupos;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Timestamp getFecha() {
        return fecha;
    }

    public void setFecha(Timestamp fecha) {
        this.fecha = fecha;
    }

    public long getIdHorarioCurso() {
        return idHorarioCurso;
    }

    public void setIdHorarioCurso(long idHorarioCurso) {
        this.idHorarioCurso = idHorarioCurso;
    }

    public static Horario_Curso load(ResultSet rs)throws SQLException{
        Horario_Curso horarioCurso = new Horario_Curso();
        horarioCurso.setIdHorarioCurso(rs.getLong(1));
        horarioCurso.setFecha(rs.getTimestamp(2));
        horarioCurso.setCupos(rs.getInt(3));
        horarioCurso.setEstado(rs.getInt(4));
        return horarioCurso;
    }
}
