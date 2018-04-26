/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package procesos;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.sql.SQLException;
import modelo.Model;
import modelo.SimitComparendo;
import modelo.SimitPlano;
import modelo.Usuario;

/**
 *
 * @author Desarrollo
 */
public class PlanosInfotic {
    private String msg;
    public String archivo;
   public String c(String c){
        return (c==null)?"":c;
    }

    public boolean generarPlanos(Model model, Usuario usuario,int Servicio,int Fi,int Ff) {
        try {
            if (model != null && usuario != null) {
                model.getCon().setAutoCommit(false);
                int vigencia = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                System.out.println("***GENERAR PLANOS***");
                System.out.println(vigencia);
                System.out.println("SEDE USUARIO: "+usuario.getFk_sede());
                System.out.println("SERVICIO: "+Servicio);
                String fecha = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
                System.out.println("FECHA: "+fecha);
                String dir = "C:/Civitrans/transito/build/web/paginas/data/Infotic/"+fecha;
                System.out.println("DIRECTORIO   wdwe : "+dir);
                File f = new File(dir);
                if(!f.exists())
                    f.mkdirs();
                generarPlanoParticular(model, Servicio, dir, Fi, Ff);
                return true;
            }
        } catch (Exception exc) {
            try {
                model.getCon().rollback();
                exc.printStackTrace();
                msg = "Se ha generado una excepcion al generar los planos :" + exc.getMessage();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return false;
    }

    public void generarPlanoParticular(Model model,int Servicio,String dir,int Fi,int Ff)  throws Exception{

        String nombre = Servicio==1?"Particular":Servicio==2?"Publico":Servicio==3?"Diplomatico":Servicio==4?"Oficial":Servicio==5?"Otros":"Especial";

        java.util.Date freporte = new java.util.Date();
        System.out.println("***GENERAR PLANOS COMPARENDOS***");
        System.out.println("FECHA REPORTE: "+freporte);
        java.sql.Date fcomparendo = new java.sql.Date(freporte.getTime());
        System.out.println("FECHA COMPARENDO: "+fcomparendo);
        File f = new File(dir+"/"+nombre+".txt");
        if(!f.exists())
        f.createNewFile();
        FileOutputStream fos = new FileOutputStream(f);
        DataOutputStream dos = new DataOutputStream(fos);
        model.CarteraInfotic(Servicio, Fi, Ff);
        System.out.println("/*Servicio: "+Servicio);
        java.util.List<modelo.Infotic> lista = model.consultarCarteraInfotic();
        String x = ",";
        int i = 1;
        double sumaReg = 0;
        long digitoControl = 0;

        System.out.println("***GENERACION DE PLANO - PARA***");
        String Cabecera = "NO,PLACA,SERVICIO,COLOR,MODELO,MARCA,LINEA,VIEGENCIA,ESTADO_CARTERA,VALOR,INTERES,COSTAS,EXTEMPORANEIDA,NOMBRES,DIRECCION,CELULAR,TELEFONO \r\n";
        dos.writeBytes(Cabecera);
        for(modelo.Infotic r:lista){
            String detalle = i+x+
                    c(r.getPLACA())+x+
                    c(r.getSERVICIO())+x+
                    c(r.getCOLOR())+x+
                    c(r.getMODELO())+x+
                    c(r.getMARCA())+x+
                    c(r.getLINEA())+x+
                    c(r.getVIEGENCIA())+x+
                    c(r.getESTADO_CARTERA())+x+
                    r.getVALOR()+x+
                    r.getNTERES()+x+
                    r.getCOSTAS()+x+
                    r.getEXTEMPORANIEDA()+x+
                    r.getNOMBRES()+x+
                    r.getDIRECCION()+x+
                    r.getCELULAR()+x+
                    r.getTELEFONO();
            //digitoControl += getDigitoControl(detalle);
            dos.writeBytes(detalle);
            dos.writeBytes("\r\n");
            System.out.println("DETALLE: "+ detalle);

           //model.actualizarEstadoSimitComparendo(r.getID_SIMIT_COMPARENDO(),8,idSimiPlano);
          //model.actualizarSimitRecaudo(r.getID_SIMIT_COMPARENDO(),2,idSimiPlano,i,fcomparendo);
            i++;
        }
        dos.close();
        fos.close();
        archivo = dir+"/"+nombre;
    }
}
