/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package VehiculosWS;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import VehiculosWS.CarterasWS;

/**
 *
 * @author jjpadillag
 */

public class VehiculosWS {

    public VehiculosWS(){
    }

    private long referencia;
    private String placa;
    private String marca;
    private String linea;
    private String clase;
    private String servicio;
    private String modelo;
    private String estado;
    private List<String> propietario;
    private List<CarterasWS> carteraWS;
    private String fechaActual;
    private StatusService statusService;
    
    public long getReferencia() {
        return referencia;
    }

    public void setReferencia(long referencia) {
        this.referencia = referencia;
    }

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getLinea() {
        return linea;
    }

    public void setLinea(String linea) {
        this.linea = linea;
    }

    public String getClase() {
        return clase;
    }

    public void setClase(String clase) {
        this.clase = clase;
    }

    public String getServicio() {
        return servicio;
    }

    public void setServicio(String servicio) {
        this.servicio = servicio;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public List<String> getPropietario() {
        return propietario;
    }

    public void setPropietario(List<String> propietario) {
        this.propietario = propietario;
    }


    public List<CarterasWS> getCarteraWS() {
        return carteraWS;
    }

    public void setCarteraWS(List<CarterasWS> carteraWS) {
        this.carteraWS = carteraWS;
    }

    public String getFechaActual() {
        return (new SimpleDateFormat("dd/MM/yyyy")).format(new Date());
    }

    public void setFechaActual(String fechaActual) {
        this.fechaActual = fechaActual;
    }
    
    /**
     * @return the statusService
     */
    public StatusService getStatusService() {
        return statusService;
    }

    /**
     * @param statusService the statusService to set
     */
    public void setStatusService(StatusService statusService) {
        this.statusService = statusService;
    }

    public static VehiculosWS load(ResultSet rs)
        throws SQLException
    {
        VehiculosWS vehiculoWS = new VehiculosWS();
        vehiculoWS.setPlaca(rs.getString(1));
        vehiculoWS.setMarca(rs.getString(2));
        vehiculoWS.setLinea(rs.getString(3));
        vehiculoWS.setClase(rs.getString(4));
        vehiculoWS.setServicio(rs.getString(5));
        vehiculoWS.setModelo(rs.getString(6));
        vehiculoWS.setEstado(rs.getString(7));
        vehiculoWS.setReferencia(rs.getLong(8));
        return vehiculoWS;
    }

}
