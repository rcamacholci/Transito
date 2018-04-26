/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package VehiculosWS;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author jjpadillag
 */

public class CarterasWS {

    public CarterasWS(){
    }

    private String concepto;
    private String vigencia;
    private float debido;
    private float extemporaneidad;
    private float interes;
    private float costas;
    private float total;
    private int periodo;
//Descuentos
    //private float descuento_extemporaniedad, descuento_intereses;

    public String getConcepto() {
        return concepto;
    }

    public void setConcepto(String concepto) {
        this.concepto = concepto;
    }

    public String getVigencia() {
        return vigencia;
    }

    public void setVigencia(String vigencia) {
        this.vigencia = vigencia;
    }

    public float getDebido() {
        return debido;
    }

    public void setDebido(float debido) {
        this.debido = debido;
    }

    public float getExtemporaneidad() {
        return extemporaneidad;
    }

    public void setExtemporaneidad(float extemporaneidad) {
        this.extemporaneidad = extemporaneidad;
    }

    public float getInteres() {
        return interes;
    }

    public void setInteres(float interes) {
        this.interes = interes;
    }

    public float getCostas() {
        return costas;
    }

    public void setCostas(float costas) {
        this.costas = costas;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public int getPeriodo() {
        return periodo;
    }

    public void setPeriodo(int periodo) {
        this.periodo = periodo;
    }



    //Decuentos
/*
    public float getDescuento_extemporaniedad() {
        return descuento_extemporaniedad;
    }

    public void setDescuento_extemporaniedad(float descuento_extemporaniedad) {
        this.descuento_extemporaniedad = descuento_extemporaniedad;
    }

    public float getDescuento_intereses() {
        return descuento_intereses;
    }

    public void setDescuento_intereses(float descuento_intereses) {
        this.descuento_intereses = descuento_intereses;
    }
*/
    //Fin descuentos

        public static CarterasWS load(ResultSet rs)
        throws SQLException
    {
        CarterasWS carteraWS = new CarterasWS();
//Descuentos
       /* carteraWS.setConcepto(rs.getString(1));
        carteraWS.setVigencia(rs.getString(2));
        carteraWS.setDebido(rs.getFloat(3));
        carteraWS.setExtemporaneidad(rs.getFloat(4));
        carteraWS.setDescuento_extemporaniedad(rs.getFloat(5));
        carteraWS.setInteres(rs.getFloat(6));
        carteraWS.setDescuento_intereses(rs.getFloat(7));
        carteraWS.setCostas(rs.getFloat(8));
        carteraWS.setTotal(rs.getFloat(9));
        carteraWS.setPeriodo(rs.getInt(10));*/
//Fin descuentos
        
        carteraWS.setConcepto(rs.getString(1));
        carteraWS.setVigencia(rs.getString(2));
        carteraWS.setDebido(rs.getFloat(3));
        carteraWS.setExtemporaneidad(rs.getFloat(4));
        carteraWS.setInteres(rs.getFloat(5));
        carteraWS.setCostas(rs.getFloat(6));
        carteraWS.setTotal(rs.getFloat(7));
        carteraWS.setPeriodo(rs.getInt(8));
         

        return carteraWS;
    }

}
