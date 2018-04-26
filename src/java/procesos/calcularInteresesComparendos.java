/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package procesos;

import java.util.Date;
/**
 *
 * @author Civitrans
 */
public class calcularInteresesComparendos {

    String t = "s";
        int s = 14;
    String[][] tasas = {{"2007/01/01","2007/01/04","0.3102"},
                        {"2007/01/05","2007/03/31","0.20745"},
                        {"2007/04/01","2007/06/30","0.2512"},
                        {"2007/07/01","2007/09/30","0.2851"},
                        {"2007/10/01","2007/12/31","0.3189"},
                        {"2008/01/01","2008/03/31","0.32745"},
                        {"2008/04/01","2008/06/30","0.3288"},
                        {"2008/07/01","2008/09/30","0.32265"},
                        {"2008/10/01","2008/12/31","0.3153"},
                        {"2009/01/01","2009/03/31","0.30705"},
                        {"2009/04/01","2009/06/30","0.3042"},
                        {"2009/07/01","2009/09/30","0.2798"},
                        {"2009/10/01","2009/12/31","0.2592"},
                        {"2010/01/01","2010/03/31","0.2421"}};

    public void setTasas(String t,int s,String[][] tasas){
        this.t = t;
        this.s = s;
        this.tasas = tasas;
    }

    public float getValor(Date d1, Date d2, float deuda){
        int n_inicio = -1;
        int n_fin = -1;
        float interes = 0;
        try{
            for(int i=0;i<s;i++){
                if(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(new java.text.SimpleDateFormat("dd/MM/yyyy").format(d1)).getTime()>=new java.text.SimpleDateFormat("MM/dd/yyyy").parse(tasas[i][0]).getTime()&&new java.text.SimpleDateFormat("dd/MM/yyyy").parse(new java.text.SimpleDateFormat("dd/MM/yyyy").format(d1)).getTime()<=new java.text.SimpleDateFormat("MM/dd/yyyy").parse(tasas[i][1]).getTime())
                    n_inicio = i;

                if(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(new java.text.SimpleDateFormat("dd/MM/yyyy").format(d2)).getTime()>=new java.text.SimpleDateFormat("MM/dd/yyyy").parse(tasas[i][0]).getTime()&&new java.text.SimpleDateFormat("dd/MM/yyyy").parse(new java.text.SimpleDateFormat("dd/MM/yyyy").format(d2)).getTime()<=new java.text.SimpleDateFormat("MM/dd/yyyy").parse(tasas[i][1]).getTime())
                    n_fin = i;
            }
        }catch(Exception exc){
            exc.printStackTrace();
        }
        if(n_inicio!=-1&&n_fin==-1){
            System.out.println ("Debe actualizar las tasas de interes para periodos superiores a "+tasas[10][1]);
        }
        int n_dias = 0;
        float promedio = 0;
        float periodico = 0;

        if(n_fin!=-1&&n_inicio!=-1&&n_inicio<=n_fin){
            if(n_fin!=n_inicio){
                n_dias = daysBetweenDates(d1,new Date(tasas[n_inicio][1]));
                periodico = getInteresPeriodico(n_inicio,n_dias);
                promedio = deuda*periodico;
                for(int i=n_inicio+1;i<n_fin;i++){
                    n_dias = daysBetweenDates(new Date(tasas[i][0]),new Date(tasas[i][1]));
                    periodico = getInteresPeriodico(i,n_dias);
                    promedio += deuda*periodico;
                }
                n_dias = daysBetweenDates(new Date(tasas[n_fin][0]),d2);
            }else{
                n_dias = daysBetweenDates(d1,d2);
            }
            periodico = getInteresPeriodico(n_fin,n_dias);
            promedio += deuda*periodico;
            interes = Math.round(promedio);
        }
        return interes;
    }

    public int daysBetweenDates(Date d1, Date d2){
        long tr = d2.getTime()-d1.getTime();
        int dias = (int)(tr/86400000);
        return dias+1;
    }

    public float getInteresPeriodico(int indice,int n_dias){
        double bd = Math.pow(1+Float.parseFloat(tasas[indice][2]),(n_dias/365.0))-1;
        return (float)bd;
    }
}


