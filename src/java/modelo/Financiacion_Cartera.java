/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * Author  : Jorge Lopez
 */

package modelo;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Jorge Lopez
 */
public class Financiacion_Cartera {
    private long id_fin_cartera;
    private long fk_financiacion;
    private long fk_cartera;

    public long getFk_cartera() {
        return fk_cartera;
    }

    public void setFk_cartera(long fk_cartera) {
        this.fk_cartera = fk_cartera;
    }

    public long getFk_financiacion() {
        return fk_financiacion;
    }

    public void setFk_financiacion(long fk_financiacion) {
        this.fk_financiacion = fk_financiacion;
    }

    public long getId_fin_cartera() {
        return id_fin_cartera;
    }

    public void setId_fin_cartera(long id_fin_cartera) {
        this.id_fin_cartera = id_fin_cartera;
    }

    public static Financiacion_Cartera Load(ResultSet rs)throws SQLException{
        Financiacion_Cartera financiacion_cartera = new Financiacion_Cartera();
        financiacion_cartera.setId_fin_cartera(rs.getLong(1));
        financiacion_cartera.setFk_financiacion(rs.getLong(2));
        financiacion_cartera.setFk_cartera(rs.getLong(3));
        return financiacion_cartera;


    }

}

