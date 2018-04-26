/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package VehiculosWS;

import java.io.IOException;
import java.sql.SQLException;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;
import modelo.*;
import VehiculosWS.CarterasWS;

/**
 *
 * @author jjpadillag
 */
@WebService
public class ConsultarVehiculoWS {

    public ConsultarVehiculoWS() {
    }

    /**
     * Web service operation
     * @param placa
     * @return 
     */
    @WebMethod(operationName = "consultarPlaca")
    public VehiculosWS consultarPlaca(@WebParam(name = "placa") String placa) {

        VehiculosWS vehiculo = new VehiculosWS();

        Model model = new Model();
        boolean conexion = false;

        if (placa.length() >= 1 && placa.length() <= 6) {
            try {
                model.conectar();
                conexion = true;
            } catch (Exception ex) {
                StatusService statusService = new StatusService();
                statusService.setStatusCode(4);
                statusService.setSeverity(4);
                statusService.setStatusMensaje("Há ocurrido un error al conectar con la base de datos");
                vehiculo.setStatusService(statusService);
                ex.printStackTrace();
                System.out.println("Error: " + ex.getMessage());
                conexion = false;
                return vehiculo;
            }

            if (conexion) {
                try {
                    vehiculo = model.consultarVehiculoWS(placa.toUpperCase());
                    return vehiculo;
                } catch (Exception ex) {
                    StatusService statusService = new StatusService();
                    statusService.setStatusCode(4);
                    statusService.setSeverity(4);
                    statusService.setStatusMensaje("Há ocurrido un error al consultar el vehículo");
                    vehiculo.setStatusService(statusService);
                    ex.printStackTrace();
                    System.out.println("Error en la consulta : " + ex.getMessage());
                    return vehiculo;
                }
            }

        }

        return null;
    }

}
