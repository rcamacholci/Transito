/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package modelo;

/**
 *
 * @author Civitrans
 */
public class Encrypt {
    
    public static String encriptar(String texto){
        String clave = "24";
        String[] order1 = {"012","021","102","120","201","210"};
        int[][] order2 = {{1,1,1},{1,1,-1},{1,-1,1},{1,-1,-1},{-1,1,1},{-1,1,-1},{-1,-1,1},{-1,-1,-1}};
        int[][] order3 = {{1,0,0},{1,2,8},{2,4,3},{2,5,6},{1,2,5},{2,1,6},{3,4,3},{5,1,2},{7,2,9}};
        int[][] codes = new int[texto.length()][3];
        int value = getClave(clave);
        int c = getRealClave(value);
        for (int i = 0; i<texto.length(); i++) {
            String tri = getTriangle(c);
            int x = Integer.parseInt(""+tri.charAt(0));
            int y = Integer.parseInt(""+tri.charAt(1));
            int z = Integer.parseInt(""+tri.charAt(2));
            String code = getTriangle((int)texto.charAt(i));
            codes[i][0] = Math.abs((Integer.parseInt(""+code.charAt(Integer.parseInt(""+order1[x].charAt(0))))+10+(order2[y][0]*order3[z][0]))%10);
            codes[i][1] = Math.abs((Integer.parseInt(""+code.charAt(Integer.parseInt(""+order1[x].charAt(1))))+10+(order2[y][1]*order3[z][1]))%10);
            codes[i][2] = Math.abs((Integer.parseInt(""+code.charAt(Integer.parseInt(""+order1[x].charAt(2))))+10+(order2[y][2]*order3[z][2]))%10);
            value = value - 1;
            if(value<0)
                value = getClave(clave);
            c = getRealClave(value);
        }
        String text = "";
        for (int i = 0; i<texto.length(); i++) {
            text += codes[i][0]+""+codes[i][1]+""+codes[i][2];
        }
        String fin = "";
        for (int i = 0; i<text.length()-1; i=i+2) {
            int v = Integer.parseInt(text.charAt(i)+""+text.charAt(i+1));
            fin = (char)v + fin;
        }
        if(text.length()%2!=0){
            fin = ((char)Integer.parseInt(""+text.charAt(text.length()-1))) + fin;
        }
        return fin;
    }
    
    public static String desencriptar(String texto){
        String clave = "24";
        StringBuffer sb = new StringBuffer(texto);
        texto = sb.reverse().toString();
        String all = "";
        for (int i = 0; i<texto.length(); i++) {
            String ln = ""+(int)texto.charAt(i);
            if(texto.length()%3!=0&&i==texto.length()-1)
                all += ln;
            else
                all += ln.length()<2?"0"+ln:ln;
        }
        int value = getClave(clave);
        int c = getRealClave(value);
        String[] order1 = {"012","021","102","120","201","210"};
        int[][] order2 = {{1,1,1},{1,1,-1},{1,-1,1},{1,-1,-1},{-1,1,1},{-1,1,-1},{-1,-1,1},{-1,-1,-1}};
        int[][] order3 = {{1,0,0},{1,2,8},{2,4,3},{2,5,6},{1,2,5},{2,1,6},{3,4,3},{5,1,2},{7,2,9}};
        int[][] codes = new int[all.length()/3][3];
        int n = 0;
        for (int i = 0; i<all.length()-2; i=i+3) {
            String tri = getTriangle(c);
            int x = Integer.parseInt(""+tri.charAt(0));
            int y = Integer.parseInt(""+tri.charAt(1));
            int z = Integer.parseInt(""+tri.charAt(2));
            codes[n][Integer.parseInt(""+order1[x].charAt(0))] = (Integer.parseInt(""+all.charAt(i))+10+(order2[y][0]*-1*order3[z][0]))%10;
            codes[n][Integer.parseInt(""+order1[x].charAt(1))] = (Integer.parseInt(""+all.charAt(i+1))+10+(order2[y][1]*-1*order3[z][1]))%10;
            codes[n][Integer.parseInt(""+order1[x].charAt(2))] = (Integer.parseInt(""+all.charAt(i+2))+10+(order2[y][2]*-1*order3[z][2]))%10;
            n++;
            value = value - 1;
            if(value<0)
                value = getClave(clave);
                c = getRealClave(value);
        }
        String fin = "";
        for (int i = 0; i<all.length()/3; i++) {
            int word = Integer.parseInt(codes[i][0]+""+codes[i][1]+""+codes[i][2]);
            fin += (char)word;
        }
        return fin;
    }
    
    private static int getRealClave(int clave){
        int n1= clave/72;
        int d = clave%72;
        int n2= d/9;
        int n3= d%9;
        return n1*100+n2*10+n3;
    }

    private static int getClave(String clave){
        int a = ((int)clave.charAt(0)-(Character.isDigit(clave.charAt(0))?48:55))*36;
        int b = (int)clave.charAt(1)-(Character.isDigit(clave.charAt(1))?48:55);
        return a + b;
    }

    //Triangulacion de Clave
    private static String getTriangle(int clave){
        return "000".substring(0,3-(""+clave).length())+clave;
    }

    public static String getSecurityCode(java.util.Date fecha){
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTimeInMillis(fecha.getTime());
        int mes = calendar.get(java.util.Calendar.MONTH);
        int dia = calendar.get(java.util.Calendar.DATE);
        int diaS = calendar.get(java.util.Calendar.DAY_OF_WEEK);
        int diaA = calendar.get(java.util.Calendar.DAY_OF_YEAR);
        int semM = calendar.get(java.util.Calendar.WEEK_OF_MONTH);
        int semA = calendar.get(java.util.Calendar.WEEK_OF_YEAR);
        double a = Math.sin(semM);
        double b = Math.log(dia);
        double c = Math.cos(semA);
        double d = Math.tan(diaS);
        double e = Math.exp(mes);
        double f = a + b + c + d+ e;
        String g = Double.toString(f).replaceAll("[.]", "");
        int j = 1;
        String key = "";
        out:
        while(true){
            for(int i=0;i<g.length();i++){
                if(j>=diaA&&j<diaA+4){
                    key += g.charAt(i)+"";
                }else{
                    if(j>=diaA+4){
                        break out;
                    }
                }
                j++;
            }
        }
        return key;
    }
}
