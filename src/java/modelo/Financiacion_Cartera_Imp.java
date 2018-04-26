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
public class Financiacion_Cartera_Imp {
    private long id_fin_cartera_imp;
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

    public long getId_fin_cartera_imp() {
        return id_fin_cartera_imp;
    }

    public void setId_fin_cartera_imp(long id_fin_cartera_imp) {
        this.id_fin_cartera_imp = id_fin_cartera_imp;
    }

    public static Financiacion_Cartera_Imp Load(ResultSet rs)throws SQLException{
        Financiacion_Cartera_Imp financiacion_Cartera_Imp = new Financiacion_Cartera_Imp();
        financiacion_Cartera_Imp.setId_fin_cartera_imp(rs.getLong(1));
        financiacion_Cartera_Imp.setFk_financiacion(rs.getLong(2));
        financiacion_Cartera_Imp.setFk_cartera(rs.getLong(3));
        return financiacion_Cartera_Imp;


    }

}

