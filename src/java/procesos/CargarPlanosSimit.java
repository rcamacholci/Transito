/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package procesos;
import java.util.List;
import java.util.Iterator;
import java.io.File;
import java.util.StringTokenizer;
import javax.swing.JOptionPane;
import modelo.Cartera;
import modelo.Detalle_Cartera;
import modelo.Persona;
import modelo.Taquilla;
import modelo.Usuario;
import modelo.Vehiculo;
import modelo.pagos_simit;
import org.apache.commons.fileupload.servlet.*;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.*;


/**
 *
 * @author ORLA
 */
public class CargarPlanosSimit {

    private String msg = "";

     public String getMsg(){
        return msg;
    }

    public void CargarPlano(javax.servlet.http.HttpServletRequest request, modelo.Model model,Usuario usuario){

        String fileName = "";
        try {
            String archivo = "";
            model.conectar();
            model.getCon().setAutoCommit(false);
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
                        fileName = "C:/Civitrans/transito/build/web/paginas/data/SimitPlanos/" + archivo;
                        //crear carpeta SimitPlanos
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
                                if(lista.size()!=4){
                                String Sconsecutivo = lista.get(0).toString(); System.out.println("get1 : "+Sconsecutivo);
                                String Sfecha = lista.get(1).toString(); System.out.println("get2 : "+Sfecha);
                                String Shora = lista.get(2).toString(); System.out.println("get3 : "+Shora);
                                String Sfecha_2 = lista.get(3).toString(); System.out.println("get4 : "+Sfecha_2);
                                String Sbanco_origen = lista.get(4).toString(); System.out.println("get5 : "+Sbanco_origen);
                                String Scanal_orige = lista.get(5).toString(); System.out.println("get6 : "+Scanal_orige);
                                String Svalor  = lista.get(6).toString(); System.out.println("get7 : "+Svalor);
                                String Scheque = lista.get(7).toString(); System.out.println("get8 : "+Scheque);
                                String Svalor2 = lista.get(8).toString(); System.out.println("get9 : "+Svalor2);
                                String Sreferencia= lista.get(9).toString(); System.out.println("get10 : "+Sreferencia);
                                String Scedula = lista.get(10).toString(); System.out.println("get11 : "+Scedula);
                                String Stipo_recaudo = lista.get(11).toString(); System.out.println("get12 : "+Stipo_recaudo);
                                String Sdivipo = lista.get(12).toString(); System.out.println("get13 : "+Sdivipo);
                                String Svolante_pago = lista.get(13).toString(); System.out.println("get14 : "+Svolante_pago);
                                String Snumero_comp = lista.get(14).toString(); System.out.println("get15 : "+Snumero_comp);
                                String Spolca = lista.get(15).toString(); System.out.println("get16 : "+Spolca);
                                String Scostas = lista.get(16).toString(); System.out.println("get17 : "+Scostas);
                                String Sfecha_comp = lista.get(17).toString(); System.out.println("get18 : "+Sfecha_comp);
                                String Splaca = lista.get(18).toString(); System.out.println("get19 : "+Splaca);
                                String Scancelo_intereses = lista.get(19).toString(); System.out.println("get20 : "+Scancelo_intereses);
                                String Sintereses = lista.get(20).toString(); System.out.println("get21 : "+Sintereses);



                                java.sql.Date fechaUpdate = new java.sql.Date(new java.util.Date().getTime());
                                java.sql.Timestamp fechaSystem= new java.sql.Timestamp(new java.util.Date().getTime());
                                java.sql.Timestamp fecha_comparendo = new java.sql.Timestamp(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(Sfecha_comp).getTime());
                                java.sql.Date fecha_1 = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(Sfecha).getTime());
                                java.sql.Timestamp fecha_2 = new java.sql.Timestamp(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(Sfecha_2).getTime());
                                modelo.Persona pers = new modelo.Persona();
                                if(!Shora.equals("")){
                                       System.out.println("PARTE HORA ***********************************");
                                 // String hora = COMHORA.substring(0, 2);
                                 // String minutos = COMHORA.substring(2, 4);
                                 // int hora = Integer.parseInt(Shora.substring(0, 2));
                                 // int minutos = Integer.parseInt(Shora.substring(2, 4));
                                 // System.out.println("hora : "+hora);
                                 // System.out.println("minutos : "+minutos);
                                 // fecha_comparendo.setHours(Integer.parseInt(Shora.substring(0, 2)));
                                 // fecha_comparendo.setMinutes(Integer.parseInt(Shora.substring(2, 4)));
                                 System.out.println("PARTE HORA FIN ***********************************");
                                }
                               modelo.Comparendo compare = model.consultar_Comparendo(Snumero_comp);
                               System.out.println("COMPARENDO***********************************");
                               if(compare!=null){
                                   Cartera car = model.consultarCartera(compare.getFk_cartera());
                                 /*  System.out.println("CARTERA***********************************");
                                   pagos_simit psimit = new pagos_simit();
                                   System.out.println("***********************************");
                                   psimit.setFecha(fecha_1);
                                   System.out.println("***********************************");
                                   psimit.setFecha_tipo_pago(fecha_2);
                                   System.out.println("***********************************");
                                   psimit.setEstado(3);
                                   System.out.println("***********************************");
                                   psimit.setFk_sede(234);
                                   psimit.setTipo_pago(3);
                                   System.out.println("***********************************");
                                   psimit.setNumero_tipo_pago(Sreferencia);
                                   System.out.println("***********************************");
                                   psimit.setValor_total(Float.parseFloat(Svalor));
                                   System.out.println("***********************************");
                                   psimit.setValor_iva(Float.parseFloat(Svalor2));
                                   System.out.println("***********************************");
                                   psimit.setValor_descuento(0);
                                   System.out.println("***********************************");
                                   psimit.setNumero_factura(Svolante_pago);
                                   System.out.println("***********************************");
                                   //psimit.setFk_tiquete();
                                   System.out.println("***********************************");
                                   psimit.setFk_persona(compare.getFk_persona());
                                   System.out.println("***********************************");
                                   Vehiculo veh = model.consultarVehiculo(Splaca);

                                   if(veh!=null){
                                   System.out.println("***********************************");
                                   psimit.setFk_vehiculo(veh.getId_vehiculo());
                                   }else{
                                        System.out.println("******N*U*L*L******");
                                   }

                                   System.out.println("***********************************");
                                   psimit.setFk_banco(Long.parseLong(Sbanco_origen));

                        //java.sql.Date fechaPago = new java.sql.Date(((java.util.Date) encabezadoArchivo.get("FECHARECAUDO")).getTime());*/
                        modelo.UsuarioCaja usuarioCaja = model.consultarCajaUsuario(usuario.getId_usuario());
                        System.out.println("****************USUARIO CAJA*******************");
                                   
                                   /***/
            modelo.tiquete_simit tiquete = new modelo.tiquete_simit();
            tiquete.setEstado(3);
            tiquete.setFecha(fecha_1);
            tiquete.setFecha_proceso(fecha_2);
            tiquete.setFk_persona(compare.getFk_persona());
           Vehiculo veh = model.consultarVehiculo(Splaca);

           if(veh!=null){
           System.out.println("***********************************");
           tiquete.setFk_vehiculo(veh.getId_vehiculo());
           }else{
                System.out.println("******N*U*L*L******");
           }

            tiquete.setTipo_pago(3);
            tiquete.setReferencia(Sreferencia);
            tiquete.setFecha_referencia(fecha_1);
            tiquete.setFk_banco(Long.parseLong(Sbanco_origen));
            /*int factura = model.consultarConsecutivo(idSede, 12, vigencia);
            String consecutivo = "D" + ("000000".substring(0, 6 - (factura + "").length())) + factura;
            model.actualizarConsecutivo(idSede, 12, vigencia);*/
            tiquete.setNumero_factura(Svolante_pago);
                                   /***/
                       if(usuarioCaja!=null){
                           System.out.println("***********************************");
                            model.getCon().setAutoCommit(false);
                            modelo.Taquilla taquilla = model.consultarTaquillaByFecha(6, 234, usuario.getId_usuario(),fecha_1);
                            if(taquilla==null){
                                System.out.println("*****************taquilla******************");
                                taquilla = new modelo.Taquilla();
                                taquilla.setEstado(3);
                                taquilla.setFecha_ini(new java.sql.Timestamp(fecha_1.getTime()));
                                taquilla.setFk_caja(6);
                                taquilla.setFk_sede(234);
                                taquilla.setFk_usuario(usuario.getId_usuario());
                                taquilla.setValor_nota_debito(0);
                                taquilla.setValor_taquilla(0);
                                taquilla.setFecha_fin(new java.sql.Timestamp(fecha_1.getTime()));
                                model.adicionarTaquilla(taquilla);
                                model.getCon().commit();
                                System.out.println("***************** fin taquilla ******************");
                            }
                             taquilla = model.consultarTaquillaByFecha(6, 234, usuario.getId_usuario(),fecha_1);
                             //psimit.setFk_taquilla(taquilla.getId_taquilla());
            tiquete.setFk_taquilla(taquilla.getId_taquilla());
            tiquete.setFk_usuario(usuario.getId_usuario());
            tiquete.setValor_total(Float.parseFloat(Svalor));
            int security = ((int) (Math.random() * 100000));
            tiquete.setValor_total_descuento(security);
            tiquete.setValor_total_iva(Float.parseFloat(Svalor));
            tiquete.setEstado_preliquidacion(2);
            tiquete.setId_tiquete(model.adicionarTiqueteSimit(tiquete));
                        pagos_simit  pago = new pagos_simit();
            pago.setFecha(tiquete.getFecha());
            pago.setFk_sede(usuario.getFk_sede());
            pago.setFk_taquilla(tiquete.getFk_taquilla());
            pago.setFk_tiquete(tiquete.getId_tiquete());
            pago.setNumero_factura(Svolante_pago);
            pago.setTipo_pago(tiquete.getTipo_pago());
            pago.setFk_usuario(tiquete.getFk_usuario());
            pago.setFk_persona(tiquete.getFk_persona());
            pago.setFk_vehiculo(tiquete.getFk_vehiculo());
            pago.setNumero_tipo_pago(tiquete.getReferencia());
            pago.setFecha_tipo_pago(tiquete.getFecha_referencia());
            pago.setFk_banco(tiquete.getFk_banco());
            pago.setValor_descuento(tiquete.getValor_total_descuento());
            pago.setValor_iva(tiquete.getValor_total_iva());
            pago.setValor_total(tiquete.getValor_total());
            pago.setEstado(3);
            pago.setObservacion("");
            long idPago = model.adicionarPagoSimit(pago);

                             System.out.println("***************** fin******************");
                            }
                             //psimit.setFk_usuario(usuario.getId_usuario());
                             System.out.println("***************** "+usuario.getId_usuario()+" ******************");

                             System.out.println("***************** fin taquilla ******************");
                             //model.adicionarPagoSimit(psimit);
                             model.actualizarCartera(car.getId_cartera(),0, 10,0,fecha_1 , fecha_1,1);
                            }
                            }
                            }

                            System.out.println("cantidad guardada: "+cont);
                            System.out.println("cantidad no guardada : "+cont1);
                            model.getCon().commit();
                            msg = "Archivo Cargado Correctamente";
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
