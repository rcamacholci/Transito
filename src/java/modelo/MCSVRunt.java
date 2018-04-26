/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

/**
 *
 * @author dell
 */
public class MCSVRunt {
    
    private String placa;
    private String marca;
    private String motor;
    private String chasis;
    private String serie;
    private String vin;

    public String getChasis() {
        return chasis;
    }

    public void setChasis(String chasis) {
        this.chasis = chasis;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getMotor() {
        return motor;
    }

    public void setMotor(String motor) {
        this.motor = motor;
    }

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    public String getSerie() {
        return serie;
    }

    public void setSerie(String serie) {
        this.serie = serie;
    }

    public String getVin() {
        return vin;
    }

    public void setVin(String vin) {
        this.vin = vin;
    }
    
    public static MCSVRunt load(java.sql.ResultSet rst)throws java.sql.SQLException{
        MCSVRunt mcsvRunt = new MCSVRunt();
        mcsvRunt.setPlaca(rst.getString(1));
        mcsvRunt.setMarca(rst.getString(2));
        mcsvRunt.setMotor(rst.getString(3));
        mcsvRunt.setChasis(rst.getString(4));
        mcsvRunt.setSerie(rst.getString(5));
        mcsvRunt.setVin(rst.getString(6));
        return mcsvRunt;
    }
}
