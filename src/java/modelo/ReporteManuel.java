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
public class ReporteManuel {

    private String placa;
    private int V2004, V2005, V2006, V2007, V2008, V2009, V2010, V2011, V2012, V2013, V2014, V2015;
    private int V2016;
    private int V2017;

    public int getV2004() {
        return V2004;
    }

    public void setV2004(int V2004) {
        this.V2004 = V2004;
    }

    public int getV2005() {
        return V2005;
    }

    public void setV2005(int V2005) {
        this.V2005 = V2005;
    }

    public int getV2006() {
        return V2006;
    }

    public void setV2006(int V2006) {
        this.V2006 = V2006;
    }

    public int getV2007() {
        return V2007;
    }

    public void setV2007(int V2007) {
        this.V2007 = V2007;
    }

    public int getV2008() {
        return V2008;
    }

    public void setV2008(int V2008) {
        this.V2008 = V2008;
    }

    public int getV2009() {
        return V2009;
    }

    public void setV2009(int V2009) {
        this.V2009 = V2009;
    }

    public int getV2010() {
        return V2010;
    }

    public void setV2010(int V2010) {
        this.V2010 = V2010;
    }

    public int getV2011() {
        return V2011;
    }

    public void setV2011(int V2011) {
        this.V2011 = V2011;
    }

    public int getV2012() {
        return V2012;
    }

    public void setV2012(int V2012) {
        this.V2012 = V2012;
    }

    public int getV2013() {
        return V2013;
    }

    public void setV2013(int V2013) {
        this.V2013 = V2013;
    }

    public int getV2014() {
        return V2014;
    }

    public void setV2014(int V2014) {
        this.V2014 = V2014;
    }

    public int getV2015() {
        return V2015;
    }

    public void setV2015(int V2015) {
        this.V2015 = V2015;
    }

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    public static ReporteManuel load(ResultSet rs) throws SQLException {
        ReporteManuel reporteM = new ReporteManuel();
        reporteM.setPlaca(rs.getString(1));
        reporteM.setV2004(rs.getInt(2));
        reporteM.setV2005(rs.getInt(3));
        reporteM.setV2006(rs.getInt(4));
        reporteM.setV2007(rs.getInt(5));
        reporteM.setV2008(rs.getInt(6));
        reporteM.setV2009(rs.getInt(7));
        reporteM.setV2010(rs.getInt(8));
        reporteM.setV2011(rs.getInt(9));
        reporteM.setV2012(rs.getInt(10));
        reporteM.setV2013(rs.getInt(11));
        reporteM.setV2014(rs.getInt(12));
        reporteM.setV2015(rs.getInt(13));
        reporteM.setV2016(rs.getInt(14));
        reporteM.setV2017(rs.getInt(15));
        return reporteM;
    }

    /**
     * @return the V2016
     */
    public int getV2016() {
        return V2016;
    }

    /**
     * @param V2016 the V2016 to set
     */
    public void setV2016(int V2016) {
        this.V2016 = V2016;
    }

    /**
     * @return the V2017
     */
    public int getV2017() {
        return V2017;
    }

    /**
     * @param V2017 the V2017 to set
     */
    public void setV2017(int V2017) {
        this.V2017 = V2017;
    }
}
