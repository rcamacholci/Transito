/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package procesos;
import java.util.List;
import java.util.Iterator;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.StringTokenizer;
import javax.swing.JOptionPane;
import modelo.Cartera;
import org.apache.commons.fileupload.servlet.*;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.*;

/**
 * @author Administrador
 */
public class CargueCobro {

    private String msg = "";

     public String getMsg() {
        return msg;
    }
    public  String getFechaActual() {
        return (new SimpleDateFormat("dd-MM-yyyy")).format(new Date());
    }



    public CargueCobro (javax.servlet.http.HttpServletRequest request, modelo.Model model) {

        String fileName = "";
        try {
            String archivo = "";
            if (ServletFileUpload.isMultipartContent(request)) {
                ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                List fileItemsList = servletFileUpload.parseRequest(request);
                org.apache.commons.fileupload.FileItem fileItem = null;
                Iterator it = fileItemsList.iterator();
                while (it.hasNext()) {
                    FileItem fileItemTemp = (FileItem) it.next();
                    if (fileItemTemp.isFormField()) {
                        if (fileItemTemp.getFieldName().equals("filename")) {
                            archivo = fileItemTemp.getString();
                        }
                    } else {
                        fileItem = fileItemTemp;
                    }
                }
                if (fileItem != null) {
                    if (fileItem.getSize() > 0) {
                        fileName = "C:/Civitrans/transito/build/web/paginas/data/planes/" + archivo;
                        File saveTo = new File(fileName);
                        try {
                            fileItem.write(saveTo);
                            java.io.FileInputStream fis = new java.io.FileInputStream(saveTo);
                            java.io.DataInputStream dis = new java.io.DataInputStream(fis);
                            String linea = "";
                            model.getCon().setAutoCommit(false);
                            int cont = 0;
                            int cont1 = 0;
                            while ((linea = dis.readLine()) != null) {
                                java.util.List lista = obtenerCampos(linea);

                                if(!lista.get(0).toString().trim().equals("GUIA")){
                                String c = lista.get(0).toString().trim(); System.out.println("Guia :"+c);
                                String placa = lista.get(1).toString().trim(); System.out.println("Placa :"+placa);
                                String vig_ini = lista.get(2).toString().trim(); System.out.println("Vigencia :"+vig_ini);
                                String vig_fin = lista.get(3).toString().trim(); System.out.println("Vigencia F :"+vig_fin);
                                long estado = Long.parseLong(lista.get(4).toString().trim()); System.out.println("Estado :"+estado);//java.sql.Timestamp fecha_comparendo = new java.sql.Timestamp(new java.text.SimpleDateFormat("dd/MM/yyyy").parse());
                                String fesys = getFechaActual();

                                if(!placa.isEmpty()){
                                    modelo.Vehiculo veh = model.consultarVehiculo(placa);
                                    /**/
                                                   if(veh==null){
                                                        if(placa.length()==6){
                                                            if(Character.isLetter(placa.charAt(2))){
                                                                if(placa.charAt(2)<='J'){
                                                                    int newDgto = (((int)placa.charAt(2))-64)%10;
                                                                    placa = new StringBuffer(placa).replace(2, 3, newDgto+"").toString();
                                                                    veh=model.consultarVehiculo(placa);
                                                                }
                                                            }else{
                                                                char newChar = (char)(74-((10-Integer.valueOf((placa.charAt(2)+"")))%10));
                                                                placa = new StringBuffer(placa).replace(2, 3, newChar+"").toString();
                                                                veh=model.consultarVehiculo(placa);
                                                            }
                                                        }
                                                    }
                                    //}                    /**/

                                    if(veh!=null){
                                    java.util.LinkedList<modelo.Cartera> tempcar = model.listarCarteraVehiculo(veh.getId_vehiculo(),vig_ini,vig_fin);
                                    modelo.Cartera car = new Cartera();
                                    long ini = Long.parseLong(vig_ini);
                                    long fin = Long.parseLong(vig_fin);
                                    System.out.println("LIST "+tempcar.size());
                                    if(tempcar.size()>0){
                                        for (int i = 0;i<tempcar.size();i++) {
                                            car = tempcar.get(i);
                                            if(car.getTipo()==2){
                                                System.out.println("referencia: "+car.getReferencia()+" id_cartera: "+car.getId_cartera());
                                                car.setEstado_vigencia((int)estado);
                                                model.CargueCobroVeh(car);
                                            }else{
                                            break;
                                               /**/
                                            }//tipo cartera
                                        }
                                            java.io.File f = new java.io.File("C:/Civitrans/transito/build/web/paginas/data/planes/Log Cargados a cobro +  "+fesys+".txt");
                                            java.io.FileOutputStream fos = new java.io.FileOutputStream(f,true);
                                            java.io.DataOutputStream dos = new java.io.DataOutputStream(fos);
                                            dos.writeBytes(c+","+veh.getPlaca()+","+ini+","+fin+","+fesys+"\n");
                                            dos.writeBytes("\n");
                                            dos.close();
                                            fos.close();
                                            cont+=1;
                                    }else{//list=0
                                            java.io.File f = new java.io.File("C:/Civitrans/transito/build/web/paginas/data/planes/Log Paz y Salvo +  "+fesys+".txt");
                                            java.io.FileOutputStream fos = new java.io.FileOutputStream(f,true);
                                            java.io.DataOutputStream dos = new java.io.DataOutputStream(fos);
                                            dos.writeBytes(c+","+veh.getPlaca()+","+ini+","+fin+","+fesys+"\n");
                                            dos.writeBytes("\n");
                                            dos.close();
                                            fos.close();
                                            cont1+=1;

                                    }
                                    }else{//null vehiculos
                                            java.io.File f = new java.io.File("C:/Civitrans/transito/build/web/paginas/data/planes/Log Vehiculo Notfound + "+fesys+".txt");
                                            java.io.FileOutputStream fos = new java.io.FileOutputStream(f,true);
                                            java.io.DataOutputStream dos = new java.io.DataOutputStream(fos);
                                            dos.writeBytes(c+","+placa+","+vig_fin+","+vig_ini+","+fesys+"\n");
                                            dos.close();
                                            fos.close();
                                            cont1+=1;
                                            }
                                }else{
                                            java.io.File f = new java.io.File("C:/Civitrans/transito/build/web/paginas/data/planes/Log Placa IsEmpty + "+fesys+".txt");
                                            java.io.FileOutputStream fos = new java.io.FileOutputStream(f,true);
                                            java.io.DataOutputStream dos = new java.io.DataOutputStream(fos);
                                            dos.writeBytes(c+","+placa+","+vig_fin+","+vig_ini+","+fesys+"\n");
                                            dos.writeBytes("\n");
                                            dos.close();
                                            fos.close();
                                            cont1+=1;
                                }
                                java.sql.Date fechaUp = new java.sql.Date(new java.util.Date().getTime());
                                modelo.Persona pers = new modelo.Persona();


                              }
                            }
                            System.out.println("cantidad guardada: "+cont);
                            System.out.println("cantidad no guardada : "+cont1);
                            model.getCon().commit();
                           // msg = "Archivo Cargado Correctamente";
                             msg = "Archivo Cargado Correctamente : \n cantidad Cargada: " + cont + " \n cantidad no Cargada : " + cont1;
                        } catch (Exception e) {
                            msg = "Error no se pudo importar el archivo: "+e;
                            e.printStackTrace();
                            model.getCon().rollback();

                        }
                    }
                }
            }
        } catch (Exception excw) {
            excw.printStackTrace();
        }
    }

     public java.util.List obtenerCampos(String text){
        java.util.List lista = new java.util.LinkedList();
        int start = 0;
        int end = 0;
        while(true){
            end = text.indexOf(",", start);
            if(end!=-1){
                lista.add(text.substring(start, end));
                start = end+1;
            }else{
                lista.add(text.substring(start, text.length()));
                break;
            }

        }
        return lista;
    }

}