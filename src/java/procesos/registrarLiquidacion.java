/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package procesos;

import modelo.Model;
import modelo.Persona;
import webservices.liquidacion.LiquidacionServicesClient;

/**
 *
 * @author Civitrans
 */
public class registrarLiquidacion {

    private String respuestaRunt = "";
    private byte[] reciboPDF = null;

    public boolean generarRecibo(javax.servlet.http.HttpServletRequest request,Model model,long usuario){

        try{
            LiquidacionServicesClient liquidacionService = new LiquidacionServicesClient();
            liquidacionService.setUser(Model.userHandler);
            liquidacionService.setTokenHuellaDigital(Model.userToken);
            String identificadorAT = "8634001";
            String nombreAT = "SABANAGRANDE - ATLANTICO(DPTAL)";
            String clasificacion = "";
            if(request.getParameter("categoria")!=null){
                int categoria = Integer.parseInt(request.getParameter("categoria"));
                switch(categoria){
                    case 1: clasificacion = "MOTO";break;
                    case 2: clasificacion = "MOTO";break;
                    case 3: clasificacion = "AUTOMOVIL";break;
                    case 4: clasificacion = "AUTOMOVIL";break;
                    case 5: clasificacion = "AUTOMOVIL";break;
                    case 6: clasificacion = "AUTOMOVIL";break;
                    case 7: clasificacion = "AUTOMOVIL";break;
                    case 8: clasificacion = "AUTOMOVIL";break;
                }
            }
            java.sql.Date fecha_liquidacion = new java.sql.Date(new java.util.Date().getTime());
            boolean generaPDF = true;
            String tipo = "";
            int tipoDocumento = Integer.parseInt(request.getParameter("tipos"));
            switch(tipoDocumento){
                case 1: tipo = "C";break;
                case 3: tipo = "E";break;
                case 4: tipo = "T";break;
                case 5: tipo = "P";break;
            }
            String numeroDocumento = request.getParameter("documento").trim();
            String numeroLiquidacion = "0001";
            String tipoLiquidacion = null;
            String multiLiquidacion = "N";
            double valorOT = 0;
            String tramite = request.getParameter("tramite");
            int claseTipificacion = clasificacion.equals("MOTO")?10:1;
            java.util.List<String[]> tramites = new java.util.LinkedList();
            String[] tipificacion = model.consultarTramiteRUNT(Long.parseLong(tramite), claseTipificacion);
            tramites.add(tipificacion);
            int cantidadLiquidacion = 1;
            com.heinsohn.runt.general.solicitudes.LiquidacionOutDTO liquidacionOut = liquidacionService.registrarLiquidacion("",identificadorAT, nombreAT, clasificacion, fecha_liquidacion, generaPDF, null,tipo, numeroDocumento, numeroLiquidacion, tipoLiquidacion, valorOT, tramites, cantidadLiquidacion,multiLiquidacion,"","");
            if(liquidacionOut!=null){
                if(liquidacionOut.getStatus().getStatusCode().equals("1")){
                    Persona persona = model.consultarPersona(tipoDocumento, numeroDocumento);
                    String placaLrunt = request.getParameter("placa")!=null?request.getParameter("placa").toUpperCase():"";
                    model.registrarLiquidacionRUNT(liquidacionOut,0,placaLrunt,persona.getId_persona(),1,Long.parseLong(tramite),usuario);
                    reciboPDF = liquidacionOut.getLiquidacionPDF();
                    respuestaRunt = "RUNT: "+liquidacionOut.getStatus().getStatusDesc();
                    return true;
                }else{
                    respuestaRunt = "RUNT: "+liquidacionOut.getStatus().getStatusDesc();
                }
            }else{
                respuestaRunt = "RUNT: No hay conexion con el servicio Web";
            }
        }catch(Exception exc){
           exc.printStackTrace();
           respuestaRunt = exc.getMessage();
        }
        return false;
    }

    public byte[] getReciboPDF() {
        return reciboPDF;
    }

    public String getRespuestaRunt() {
        return respuestaRunt;
    }

}
