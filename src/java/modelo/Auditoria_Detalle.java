/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Administrador
 */
public class Auditoria_Detalle {
    private long id_auditoria_detalle;
    private long fk_auditoria;
    private String columna;
    private String valor_anterior;
    private String valor_nuevo;

    public String getColumna() {
        return columna;
    }

    public void setColumna(String columna) {
        this.columna = columna;
    }

    public long getFk_auditoria() {
        return fk_auditoria;
    }

    public void setFk_auditoria(long fk_auditoria) {
        this.fk_auditoria = fk_auditoria;
    }

    public long getId_auditoria_detalle() {
        return id_auditoria_detalle;
    }

    public void setId_auditoria_detalle(long id_auditoria_detalle) {
        this.id_auditoria_detalle = id_auditoria_detalle;
    }

    public String getValor_anterior() {
        return valor_anterior;
    }

    public void setValor_anterior(String valor_anterior) {
        this.valor_anterior = valor_anterior;
    }

    public String getValor_nuevo() {
        return valor_nuevo;
    }

    public void setValor_nuevo(String valor_nuevo) {
        this.valor_nuevo = valor_nuevo;
    }

     public static Auditoria_Detalle load(ResultSet rs) throws SQLException{

        Auditoria_Detalle auditoria_detalle = new Auditoria_Detalle();
        auditoria_detalle.setId_auditoria_detalle(rs.getLong(1));
        auditoria_detalle.setFk_auditoria(rs.getLong(2));
        auditoria_detalle.setColumna(rs.getString(3));
        auditoria_detalle.setValor_anterior(rs.getString(4));
        auditoria_detalle.setValor_nuevo(rs.getString(5));
        return auditoria_detalle;

    }

}
