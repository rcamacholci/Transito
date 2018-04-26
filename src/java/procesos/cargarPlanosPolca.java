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
import org.apache.commons.fileupload.servlet.*;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.*;

/**
 *
 * @author Administrador
 */
public class cargarPlanosPolca {

    private String msg = "";

     public String getMsg() {
        return msg;
    }

    public cargarPlanosPolca(javax.servlet.http.HttpServletRequest request, modelo.Model model) {

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
                                if(lista.size()!=4){
                                String COMCONSECUTIVO = lista.get(0).toString(); System.out.println("COMCONSECUTIVO : "+COMCONSECUTIVO);
                                String COMNUMERO = lista.get(1).toString(); System.out.println("COMNUMERO : "+COMNUMERO);
                                String COMFECHA = lista.get(2).toString();  System.out.println("COMFECHA : "+COMFECHA);
                                String COMHORA = lista.get(3).toString(); System.out.println("COMHORA : "+COMHORA);
                                String COMDIR = lista.get(4).toString(); System.out.println("COMDIR : "+COMDIR);
                                String COMDIVIPOMUNI = lista.get(5).toString(); System.out.println("COMDIVIPOMUNI : "+COMDIVIPOMUNI);
                                String COMLOCALIDADCOMUNA = lista.get(6).toString(); System.out.println("COMLOCALIDADCOMUNA : "+COMLOCALIDADCOMUNA);
                                String COMPLACA = lista.get(7).toString(); System.out.println("COMPLACA : "+COMPLACA);
                                String COMDIVIPOMATRI = lista.get(8).toString(); System.out.println("COMDIVIPOMATRI : "+COMDIVIPOMATRI);
                                String COMTIPOVEHI =lista.get(9).toString(); System.out.println("COMTIPOVEHI : "+COMTIPOVEHI);
                                String COMTIPOSER = lista.get(10).toString(); System.out.println("COMTIPOSER : "+COMTIPOSER);
                                String COMCODIGORADIO = lista.get(11).toString(); System.out.println("COMCODIGORADIO : "+COMCODIGORADIO);
                                String COMCODIGOMODALIDAD = lista.get(12).toString(); System.out.println("COMCODIGOMODALIDAD : "+COMCODIGOMODALIDAD);
                                String COMCODIGOPASAJEROS = lista.get(13).toString(); System.out.println("COMCODIGOPASAJEROS : "+COMCODIGOPASAJEROS);
                                String COMINFRACTOR = lista.get(14).toString(); System.out.println("COMINFRACTOR : "+COMINFRACTOR);
                                String COMTIPODOC = lista.get(15).toString(); System.out.println("COMTIPODOC : "+COMTIPODOC);
                                String COMNOMBE =lista.get(16).toString();    System.out.println("COMNOMBE : "+COMNOMBE);
                                String COMAPELLIDO = lista.get(17).toString();   System.out.println("COMAPELLIDO : "+COMAPELLIDO);
                                String COMEDADINFRACTOR = lista.get(18).toString();    System.out.println("COMEDADINFRACTOR : "+COMEDADINFRACTOR);
                                String COMDIRINFRACTOR = lista.get(19).toString();     System.out.println("COMDIRINFRACTOR : "+COMDIRINFRACTOR);
                                String COMEMAIL = lista.get(20).toString();     System.out.println("COMEMAIL : "+COMEMAIL);
                                String COMTELEINFRACTOR = lista.get(21).toString();    System.out.println("COMTELEINFRACTOR : "+COMTELEINFRACTOR);
                                String COMIDCIUDAD = lista.get(22).toString();     System.out.println("COMIDCIUDAD : "+COMIDCIUDAD);
                                String COMLICENCIA = lista.get(23).toString();    System.out.println("COMLICENCIA : "+COMLICENCIA);
                                String COMCATEGORIA = lista.get(24).toString();    System.out.println("COMCATEGORIA : "+COMCATEGORIA);
                                String COMSECREEXPIDE = lista.get(25).toString();     System.out.println("COMSECREEXPIDE : "+COMSECREEXPIDE);
                                String COMFECHAVENCE = lista.get(26).toString();    System.out.println("COMFECHAVENCE : "+COMFECHAVENCE);
                                String COMTIPOINFRAC = lista.get(27).toString();     System.out.println("COMTIPOINFRAC : "+COMTIPOINFRAC);
                                String COMPLICTRANSITO = lista.get(28).toString();    System.out.println("COMPLICTRANSITO : "+COMPLICTRANSITO);
                                String COMDIVIPOLICEN = lista.get(29).toString();    System.out.println("COMDIVIPOLICEN : "+COMDIVIPOLICEN);
                                String COMIDENTIFICACION = lista.get(30).toString();     System.out.println("COMIDENTIFICACION : "+COMIDENTIFICACION);
                                String COMIDTIPODOCPROP = lista.get(31).toString();    System.out.println("COMIDTIPODOCPROP : "+COMIDTIPODOCPROP);
                                String COMNOMBREPROP = lista.get(32).toString();   System.out.println("COMNOMBREPROP : "+COMNOMBREPROP);
                                String COMNOMBREEMPRESA = lista.get(33).toString();     System.out.println("COMNOMBREEMPRESA : "+COMNOMBREEMPRESA);
                                String COMNITEMPRESA = lista.get(34).toString();    System.out.println("COMNITEMPRESA : "+COMNITEMPRESA);
                                String COMTARJETAOPERACION = lista.get(35).toString();   System.out.println("COMTARJETAOPERACION : "+COMTARJETAOPERACION);
                                String COMPPLACAAGENTE =lista.get(36).toString();    System.out.println("COMPPLACAAGENTE : "+COMPPLACAAGENTE);
                                String COMOBSERVA = lista.get(37).toString();    System.out.println("COMOBSERVA : "+COMOBSERVA);
                                String COMFUGA = lista.get(38).toString();   System.out.println("COMFUGA : "+COMFUGA);
                                String COMACCI = lista.get(39).toString();    System.out.println("COMACCI : "+COMACCI);
                                String COMINMOV = lista.get(40).toString();    System.out.println("COMINMOV : "+COMINMOV);
                                String COMPATIOINMOVILIZA = lista.get(41).toString();    System.out.println("COMPATIOINMOVILIZA : "+COMPATIOINMOVILIZA);
                                String COMDIRPATIOINMOVI = lista.get(42).toString();    System.out.println("COMDIRPATIOINMOVI : "+COMDIRPATIOINMOVI);
                                String COMGRUANUMERO =lista.get(43).toString();    System.out.println("COMGRUANUMERO : "+COMGRUANUMERO);
                                String COMPLACAGRUA = lista.get(44).toString();    System.out.println("COMPLACAGRUA : "+COMPLACAGRUA);
                                String COMCONSECUTIINMOVI = lista.get(45).toString();    System.out.println("COMCONSECUTIINMOVI : "+COMCONSECUTIINMOVI);
                                String COMIDENTIFICACIONTEST = lista.get(46).toString();   System.out.println("COMIDENTIFICACIONTEST : "+COMIDENTIFICACIONTEST);
                                String COMNOMBRETESTI = lista.get(47).toString();   System.out.println("COMNOMBRETESTI : "+COMNOMBRETESTI);
                                String COMDIRECRESTESTI = lista.get(48).toString();   System.out.println("COMDIRECRESTESTI : "+COMDIRECRESTESTI);
                                String COMTELETESTIGO = lista.get(49).toString();   System.out.println("COMTELETESTIGO : "+COMTELETESTIGO);
                                String COMVALOR = lista.get(50).toString();   System.out.println("COMVALOR : "+COMVALOR);
                                String COMVALAD = lista.get(51).toString();   System.out.println("COMVALAD : "+COMVALAD);
                                String COMORGANISMO = lista.get(52).toString();   System.out.println("COMORGANISMO : "+COMORGANISMO);
                                String COMESTADOCOM = lista.get(53).toString();   System.out.println("COMESTADOCOM : "+COMESTADOCOM);
                                String COMPOLCA = lista.get(54).toString();   System.out.println("COMPOLCA : "+COMPOLCA);
                                String COMINFRACCION = lista.get(55).toString();   System.out.println("COMINFRACCION : "+COMINFRACCION);
                                String COMVALINFRA = lista.get(56).toString();   System.out.println("COMVALINFRA : "+COMVALINFRA);
                                java.sql.Date fechaUpdate = new java.sql.Date(new java.util.Date().getTime());
                                java.sql.Timestamp fechaSystem= new java.sql.Timestamp(new java.util.Date().getTime());
                                java.sql.Timestamp fecha_comparendo = new java.sql.Timestamp(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(COMFECHA).getTime());
                                modelo.Persona pers = new modelo.Persona();
                                if(!COMHORA.equals("")){
                                       System.out.println("PARTE HORA ***********************************");
                                   // String hora = COMHORA.substring(0, 2);
                                   // String minutos = COMHORA.substring(2, 4);
                                int hora = Integer.parseInt(COMHORA.substring(0, 2));
                                int minutos = Integer.parseInt(COMHORA.substring(2, 4));
                                System.out.println("hora : "+hora);
                                System.out.println("minutos : "+minutos);
                                fecha_comparendo.setHours(Integer.parseInt(COMHORA.substring(0, 2)));
                                fecha_comparendo.setMinutes(Integer.parseInt(COMHORA.substring(2, 4)));
                                 System.out.println("PARTE HORA FIN ***********************************");
                                }
                                modelo.Comparendo compare = model.consultar_Comparendo(COMNUMERO);
                                if(compare == null){
                                    modelo.Comparendo comparendo = new modelo.Comparendo();
                                   pers = model.consultarPersona(Integer.parseInt(COMTIPODOC.equals("2")?"4":COMTIPODOC),COMINFRACTOR);
                                    if(pers == null){
                                         System.out.println("PARTE 1 PERSONA ***********************************");
                                         System.out.println("persona no encontrada");
                                         modelo.Persona perso = new modelo.Persona();
                                         perso.setTipo_documento(Integer.parseInt(COMTIPODOC.equals("2")?"4":COMTIPODOC));
                                         System.out.println("tipo doc :"+Integer.parseInt(COMTIPODOC.equals("2")?"4":COMTIPODOC));
                                         perso.setDocumento(COMINFRACTOR);
                                         System.out.println("cedula : "+COMINFRACTOR);
                                         if(!COMNOMBE.equals(""))
                                            perso.setNombre_1(COMNOMBE);
                                            System.out.println("nombre : "+COMNOMBE);
                                         if(!COMAPELLIDO.equals(""))
                                            perso.setApellido_1(COMAPELLIDO);
                                            System.out.println("apellido : "+COMAPELLIDO);
                                         model.adicionarPersona(perso);
                                         pers = model.consultarPersona(Integer.parseInt(COMTIPODOC.equals("2")?"4":COMTIPODOC), COMINFRACTOR);
                                         System.out.println("persona2 : "+pers.getId_persona()+" - "+pers.getNombre_1()+" - "+pers.getApellido_1());
                                        if(!COMDIRINFRACTOR.equals("")){
                                            System.out.println("PARTE 2 DIRECCION ***********************************");
                                            modelo.Direccion direccion = new modelo.Direccion();
                                            direccion.setFk_persona(pers.getId_persona());
                                            direccion.setFecha(fechaUpdate);
                                            direccion.setDescripcion(COMDIRINFRACTOR);
                                            direccion.setFk_divipo(838);

                                            if(!COMTELEINFRACTOR.equals(""))
                                                direccion.setTelefono(COMTELEINFRACTOR);
                                                model.adicionarDireccion(direccion);
                                        }
                                    }
                                    modelo.Cartera cartera = new modelo.Cartera();
                                    cartera.setFk_persona(pers.getId_persona());
                                    cartera.setFk_sede(234);
                                    cartera.setTipo(1);
                                    cartera.setReferencia(COMNUMERO);
                                    cartera.setFecha_creacion(fechaUpdate);
                                    cartera.setFecha_ingreso(fechaUpdate);
                                    modelo.Agente agente = model.consultarAgente(Integer.parseInt(COMPPLACAAGENTE));
                                    if(agente==null){
                                        System.out.println("PARTE 3 AGENTE ***********************************");
                                        agente.setPlaca(Integer.parseInt(COMPPLACAAGENTE));
                                        agente.setNombre("AGENTE DE POLCA");
                                        agente.setTipo(1);
                                        agente.setFecha_inicio(fechaUpdate);
                                        agente.setFecha_proceso(fechaUpdate);
                                        model.adicionarAgente(agente);
                                        agente = model.consultarAgente(Integer.parseInt(COMPPLACAAGENTE));
                                    }
                                        modelo.Infraccion infraccion = model.consultarInfraccionByNumero(COMINFRACCION);
                                    if(infraccion!=null){

                                            if(!COMVALINFRA.equals("")){
                                                 System.out.println("PARTE 4 INFRACCION ***********************************");
                                                cartera.setValor(Double.parseDouble(COMVALINFRA));
                                                cartera.setSaldo(Double.parseDouble(COMVALINFRA));
                                                cartera.setFecha_saldo(fechaUpdate);
                                                cartera.setEstado_cartera(1);
                                                cartera.setFecha_estado(fechaUpdate);
                                                cartera.setEstado_vigencia(1);
                                                cartera.setFecha_estado_vigencia(fechaUpdate);
                                                cartera.setFk_usuario(1);
                                                cartera.setFk_concepto(12);
                                                long Fk_cartera = model.adicionarCartera(cartera);
                                                comparendo.setFk_persona(pers.getId_persona());
                                                comparendo.setFk_usuario_organismo(1);
                                                comparendo.setFk_sede(234);//id_sede
                                                comparendo.setFk_infraccion(infraccion.getId_infraccion());
                                                comparendo.setFk_agente(agente.getId_agente());
                                                comparendo.setNumero(COMNUMERO);
                                                comparendo.setFecha(fecha_comparendo);//fecha comparendo
                                                comparendo.setFirmado(1);
                                                comparendo.setEstado(1);
                                                comparendo.setFecha_proceso(fechaSystem);
                                                comparendo.setFk_cartera(Fk_cartera);

                                                if(!COMLICENCIA.equals(""))
                                                    comparendo.setLicencia_conduccion(COMLICENCIA);
                                                if(!COMCATEGORIA.equals(""))
                                                    comparendo.setCategoria(COMCATEGORIA);
                                                if(!COMFECHAVENCE.equals("")){
                                                    comparendo.setFecha_vencimiento(new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(COMFECHAVENCE).getTime()));
                                                }
                                                if(!COMSECREEXPIDE.equals("")){
                                                    comparendo.setSede_expedicion(Long.parseLong(COMSECREEXPIDE));
                                                }
                                                if(!COMPLICTRANSITO.equals(""))
                                                    comparendo.setLicencia_transito(COMPLICTRANSITO);
                                                if(!COMDIR.equals(""))
                                                    comparendo.setLugar(COMDIR);
                                                if(!COMPLACA.equals(""))
                                                    comparendo.setPlaca(COMPLACA);
                                                if(!COMTIPOVEHI.equals(""))
                                                    comparendo.setClase(Integer.parseInt(COMTIPOVEHI));
                                                if(!COMTIPOSER.equals(""))
                                                    comparendo.setServicio(Integer.parseInt(COMTIPOSER.equals("1")?"4":COMTIPOSER.equals("3")?"1":COMTIPOSER.equals("4")?"5":COMTIPOSER.equals("5")?"3":COMTIPOSER));
                                                //1-Oficial 4, 2-Público 2, 3-Particular 1, 4-Otros 5, 5-Diplomatico 3, 6-Consular 6
                                                if(!COMTIPOINFRAC.equals(""))
                                                    comparendo.setTipo_infractor(Integer.parseInt(COMTIPOINFRAC));
                                                if(!COMOBSERVA.equals(""))
                                                    comparendo.setObservaciones(COMOBSERVA);
                                                if(!COMFUGA.equals("")){
                                                   comparendo.setFuga(Integer.parseInt(COMFUGA.equals("S")?"1":"0"));
                                                }else{
                                                     comparendo.setFuga(0);
                                                }
                                                if(!COMACCI.equals("")){
                                                    comparendo.setAccidente(Integer.parseInt(COMACCI.equals("S")?"1":"0"));
                                                }else{
                                                    comparendo.setAccidente(0);
                                                }
                                                if(!COMINMOV.equals("")){
                                                    comparendo.setInmovilizacion(Integer.parseInt(COMINMOV.equals("S")?"1":"0"));
                                                }else{
                                                    comparendo.setInmovilizacion(0);
                                                }
                                                if(!COMPOLCA.equals("")){
                                                   comparendo.setPolca(Integer.parseInt(COMPOLCA.equals("S")?"1":"0"));
                                                }else{
                                                    comparendo.setPolca(0);
                                                }

                                                 model.adicionarComparendo(comparendo);
                                                 model.adicionarComparendoArchivoPolca(comparendo);
                                                 modelo.Comparendo compa = model.consultar_Comparendo(COMNUMERO) ;

                                                    modelo.Detalle_Cartera detalle = new modelo.Detalle_Cartera();
                                                    detalle.setFk_cartera(Fk_cartera);
                                                    detalle.setReferencia(COMNUMERO);
                                                    detalle.setFecha(fechaUpdate);
                                                    detalle.setFecha_sistema(fechaSystem);
                                                    detalle.setFk_usuario(1);
                                                    detalle.setEstado(1);
                                                if(!COMPOLCA.equals("0")){
                                                    detalle.setFk_concepto(88);
                                                    detalle.setValor((float)(0));
                                                    model.adicionarDetalleCartera(detalle);
                                                    detalle.setFk_concepto(12);
                                                    detalle.setValor((float)(cartera.getSaldo()*0.45));
                                                    model.adicionarDetalleCartera(detalle);
                                                    detalle.setFk_concepto(73);
                                                    detalle.setValor((float)(cartera.getSaldo()*0.55));
                                                    model.adicionarDetalleCartera(detalle);
                                                }else{
                                                    detalle.setFk_concepto(88);
                                                    detalle.setValor((float)(cartera.getSaldo()*0.10));
                                                    model.adicionarDetalleCartera(detalle);
                                                    detalle.setFk_concepto(12);
                                                    detalle.setValor((float)(cartera.getSaldo()*0.90));
                                                    model.adicionarDetalleCartera(detalle);
                                                }
                                                if(COMINMOV.equals("S")){
                                                     modelo.COMPARENDO_PATIO comp_patio = new modelo.COMPARENDO_PATIO();
                                                     modelo.Patio patio = model.consultarPatio(COMPATIOINMOVILIZA);
                                                     if(patio == null){
                                                          System.out.println("PARTE 5 PATIO ***********************************");
                                                          patio = new modelo.Patio();
                                                          patio.setFecha_ini(new java.sql.Date(fechaUpdate.getTime()));
                                                          patio.setTipo(1);
                                                          patio.setFk_sede(234);
                                                             if(!COMPATIOINMOVILIZA.equals(""))
                                                                 patio.setNombre(COMPATIOINMOVILIZA);
                                                             if(!COMDIRPATIOINMOVI.equals(""))
                                                                 patio.setDireccion(COMDIRPATIOINMOVI);
                                                         patio.setId_patio(model.adicionarPatio(patio));
                                                           System.out.println("id_patio :"+patio.getId_patio());
                                                     }
                                                     comp_patio.setFK_COMPARENDO(compa.getId_comparendo());
                                                     comp_patio.setFK_PATIO(patio.getId_patio());
                                                     comp_patio.setFECHA_INGRESO(new java.sql.Date(compa.getFecha().getTime()));
                                                     comp_patio.setFK_PERSONA(pers.getId_persona());
                                                     comp_patio.setTIPO(1);
                                                     comp_patio.setESTADO(1);
                                                     if(!COMGRUANUMERO.equals(""))
                                                        comp_patio.setNUMERO_GRUA(COMGRUANUMERO);
                                                     if(!COMPLACAGRUA.equals(""))
                                                         comp_patio.setPLACA_GRUA(COMPLACAGRUA);
                                                     if(!COMCONSECUTIINMOVI.equals(""))
                                                         comp_patio.setCONSECUTIVO_INMO(Long.parseLong(COMCONSECUTIINMOVI));
                                                       System.out.println("PARTE 6 COMPA_ PATIOS ANTES***********************************");
                                                     model.adicionarComparendos_Patios(comp_patio);
                                                      System.out.println("PARTE 7 COMPA_ PATIOS DESPUES***********************************");
                                                 }
                                                model.actualizarValoresCartera(Fk_cartera);
                                                cont = cont + 1;
                                            }
                                    }

                                }else{
                                     cont1 = cont1 + 1;
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
