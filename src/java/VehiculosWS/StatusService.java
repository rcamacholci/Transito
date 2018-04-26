/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package VehiculosWS;

/**
 *
 * @author Administrador
 */
public class StatusService {

    private int statusCode;
    private int severity;
    private String statusMensaje;
    
    /**
     * @return the statusCode
     */
    public int getStatusCode() {
        return statusCode;
    }

    /**
     * @param statusCode the statusCode to set
     */
    public void setStatusCode(int statusCode) {
        this.statusCode = statusCode;
    }

    /**
     * @return the severity
     */
    public int getSeverity() {
        return severity;
    }

    /**
     * @param severity the severity to set
     */
    public void setSeverity(int severity) {
        this.severity = severity;
    }

    /**
     * @return the statusMensaje
     */
    public String getStatusMensaje() {
        return statusMensaje;
    }

    /**
     * @param statusMensaje the statusMensaje to set
     */
    public void setStatusMensaje(String statusMensaje) {
        this.statusMensaje = statusMensaje;
    }
    
}

