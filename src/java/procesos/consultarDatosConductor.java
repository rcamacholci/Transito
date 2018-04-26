/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package procesos;

import com.heinsohn.runt.general.consultas.ConductorOutDTO;
import com.heinsohn.runt.general.consultas.LicenciaConduccionDTO;
import modelo.Model;

/**
 *
 * @author Administrador
 */
public class consultarDatosConductor {

    public void getInformacion(){
        webservices.consultas.ServicioConsultaRUNTClient consultas = new webservices.consultas.ServicioConsultaRUNTClient();
        consultas.setTokenHuellaDigital(modelo.Model.userToken);
        consultas.setUser(Model.userHandler);//87012963139
        ConductorOutDTO infoConductor = consultas.consultarDatosConductor("C", "1045675127", null);
        if(infoConductor!=null){
            if(infoConductor.getConductor()!=null){
                System.out.println(infoConductor.getStatus().getStatusDesc());
                if(infoConductor.getConductor().getValue()!=null){
                    if(infoConductor.getConductor().getValue().getLicenciaConduccion()!=null){
                        for(LicenciaConduccionDTO licencia:infoConductor.getConductor().getValue().getLicenciaConduccion()){
                            System.out.println(licencia.getNumeroLC());
                        }
                    }else{
                        System.out.println("D");
                    }
                }else{
                    System.out.println("C");
                }
            }else{
                System.out.println("B");
            }
        }else{
            System.out.println("A");
        }
    }

}
