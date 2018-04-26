/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package procesos;
import utility.Cuota;
import utility.PagoFinal;
import utility.PagoIntCuotaFinal;
import utility.CuotasIguales;
import utility.CuotasUniformes;

/**
 *
 * @author Administrador
 */
public class calcularAmortizacion {

    PagoFinal amortizacionPagoFinal = null;
    PagoIntCuotaFinal amortizacionCuotaFinal = null;
    CuotasIguales amortizacionCuotasIguales = null;
    CuotasUniformes amortizaconCuotasUniformes = null;
    Cuota[] amortizacion = null;
    Cuota[] resCuotas 	= null;
    int tipoAmortizacion = 0;
    int pGracia = 0;
    int tipoPer = 1;
    int valPeriodo = 1;
    int numCuotas = 0;
    int ajuste = 1;
    double valor = 0;
    double c_Inicial = 0;
    double interes = 0;
    java.sql.Date f_ini = null;

    public calcularAmortizacion(int tipoAmortizacion,int numCuotas,double valor,double c_Inicial,double interes,java.sql.Date f_ini){
        this.tipoAmortizacion = tipoAmortizacion;
        this.numCuotas = numCuotas;
        this.valor = valor;
        this.c_Inicial = c_Inicial;
        this.interes = interes;
        this.f_ini = f_ini;
        valPeriodo = calcularPeriodo(tipoPer);
        switch(tipoAmortizacion){
            case 1:
                    amortizacionPagoFinal = new PagoFinal(valor,c_Inicial,interes,numCuotas, valPeriodo,f_ini);
                    amortizacionPagoFinal.mostrarAmortizacion();
                    amortizacion = amortizacionPagoFinal.obtenerAmortizacion();
                    resCuotas = amortizacionPagoFinal.obtenerCuotas();
                    break;
            case 2:
                    amortizacionCuotaFinal = new PagoIntCuotaFinal(valor,c_Inicial,interes,numCuotas, valPeriodo,f_ini);
                    amortizacionCuotaFinal.mostrarAmortizacion();
                    amortizacion = amortizacionCuotaFinal.obtenerAmortizacion();
                    resCuotas = amortizacionCuotaFinal.obtenerCuotas();
                    break;
            case 3:
                    amortizacionCuotasIguales = new CuotasIguales(valor,c_Inicial,interes,numCuotas, pGracia,ajuste,valPeriodo,f_ini);
                    amortizacionCuotasIguales.mostrarAmortizacion();
                    amortizacion = amortizacionCuotasIguales.obtenerAmortizacion();
                    resCuotas = amortizacionCuotasIguales.obtenerCuotas();
                    break;
            case 4:
                    amortizaconCuotasUniformes = new CuotasUniformes(valor,c_Inicial,interes,numCuotas, pGracia,ajuste,valPeriodo,f_ini);
                    amortizaconCuotasUniformes.mostrarAmortizacion();
                    amortizacion = amortizaconCuotasUniformes.obtenerAmortizacion();
                    resCuotas = amortizaconCuotasUniformes.obtenerCuotas();
                    break;
        }

    }

    public int calcularPeriodo( int tipoPeriodo){
        int valPeriodo = -1;
         if(tipoPeriodo ==1){
                 valPeriodo =1;
         }else if(tipoPeriodo==2){
                 valPeriodo =3;
         }else if(tipoPeriodo ==3){
                 valPeriodo =6;
         }else{
                 valPeriodo =12;
         }
         return valPeriodo;
    }

    public Cuota[] getCuotas(){
        return this.resCuotas;
    }

}
