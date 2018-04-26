/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package procesos;

/**
 *
 * @author Civitrans
 */
import java.io.File;
import java.io.FileInputStream;
import java.io.DataInputStream;
import java.util.HashMap;
import java.util.List;
import java.util.LinkedList;
import modelo.Model;
import modelo.Pagos_externos;
import modelo.Propietario;
import modelo.Usuario;
import modelo.UsuarioCaja;
import modelo.Vehiculo;

public class aplicarPagosExternos {

    boolean resultado;
    java.util.HashMap<String, Float> mapa;

    public aplicarPagosExternos(Model model, Usuario usuario, File f) throws Exception {

        resultado = false;
        mapa = new java.util.HashMap<String, Float>();
        try {
            if (model != null) {
                if (f != null) {
                    if (f.exists()) {
                        FileInputStream fis = new FileInputStream(f);
                        DataInputStream dis = new DataInputStream(fis);
                        String line = "";

                        HashMap encabezadoArchivo = new HashMap();
                        HashMap encabezadoLote = new HashMap();
                        List listaDetalle = new LinkedList();
                        HashMap controlLote = new HashMap();
                        HashMap controlArchivo = new HashMap();

                        while ((line = dis.readLine()) != null) {
                            int tipoRegistro = Integer.parseInt(line.substring(0, 2));
                            if (tipoRegistro == 1) {
                                long codigoEmpresa = Long.parseLong(line.substring(2, 12));
                                java.sql.Date fechaRecaudo = new java.sql.Date(new java.text.SimpleDateFormat("yyyyMMdd").parse(line.substring(12, 20)).getTime());
                                System.out.println(line.substring(0,12));
                                long codigoEntidad = Long.parseLong(line.substring(20, 23));
                                String numeroCuenta = line.substring(23, 40);
                                java.util.Date fechaArchivo = new java.text.SimpleDateFormat("yyyyMMdd").parse(line.substring(40, 48));
                                String horaGrabacion = line.substring(48, 52);
                                String modificador = line.substring(52, 53);
                                long tipoCuenta = Long.parseLong(line.substring(53, 55));
                                String reservado = line.substring(55, line.length());
                                encabezadoArchivo.put("CODIGOEMPRESA", codigoEmpresa);
                                encabezadoArchivo.put("FECHARECAUDO", fechaRecaudo);
                                encabezadoArchivo.put("CODIGOENTIDAD", codigoEntidad);
                                encabezadoArchivo.put("NUMEROCUENTA", numeroCuenta);
                                encabezadoArchivo.put("FECHAARCHIVO", fechaArchivo);
                                encabezadoArchivo.put("HORAGRABACION", horaGrabacion);
                                encabezadoArchivo.put("MODIFICADOR", modificador);
                                encabezadoArchivo.put("TIPOCUENTA", tipoCuenta);
                                encabezadoArchivo.put("RESERVADO", reservado);
                            } else if (tipoRegistro == 5) {
                                long codigoServicio = Long.parseLong(line.substring(2, 15));
                                long numeroLote = Long.parseLong(line.substring(15, 19));
                                String reservado = line.substring(19, line.length());
                                encabezadoLote.put("CODIGOSERVICIO", codigoServicio);
                                encabezadoLote.put("NUMEROLOTE", numeroLote);
                                encabezadoLote.put("RESERVADO", reservado);
                            } else if (tipoRegistro == 8) {
                                long totalLote = Long.parseLong(line.substring(2, 11));
                                long valorLote_ant = Long.parseLong(line.substring(11, 29));
                                float valorLote = (float) (valorLote_ant / 100.0);
                                long numeroLote = Long.parseLong(line.substring(29, 33));
                                String reservado = line.substring(33, line.length());
                                controlLote.put("TOTALLOTE", totalLote);
                                controlLote.put("VALORLOTE", valorLote);
                                controlLote.put("NUMEROLOTE", numeroLote);
                                controlLote.put("RESERVADO", reservado);
                            } else if (tipoRegistro == 9) {
                                long totalRegistros = Long.parseLong(line.substring(2, 11));
                                long valorTotal_ant = Long.parseLong(line.substring(11, 29));
                                float valorTotal = (float) (valorTotal_ant / 100.0);
                                String reservado = line.substring(29, line.length());
                                controlArchivo.put("TOTALREGISTROS", totalRegistros);
                                controlArchivo.put("VALORTOTAL", valorTotal);
                                controlArchivo.put("RESERVADO", reservado);
                            } else {
                                if (tipoRegistro == 6) {
                                    HashMap detalle = new HashMap();
                                    String referencia = line.substring(2, 50);
                                    long valor_ant = Long.parseLong(line.substring(50, 64));
                                    float valor = (float) (valor_ant / 100.0);
                                    long procedenciaPago = Long.parseLong(line.substring(64, 66));
                                    long mediosPago = Long.parseLong(line.substring(66, 68));
                                    long numeroOperacion = Long.parseLong(line.substring(68, 74));
                                    long numeroAutorizacion = Long.parseLong(line.substring(74, 80));
                                    long codigoEntidad = Long.parseLong(line.substring(80, 83));
                                    long codigoSucursal = Long.parseLong(line.substring(83, 87));
                                    long secuencia = Long.parseLong(line.substring(87, 94));
                                    String causalDevolucion = line.substring(94, 97);
                                    String reservado = line.substring(97, line.length());
                                    detalle.put("REFERENCIA", referencia);
                                    detalle.put("VALOR", valor);
                                    detalle.put("PROCEDENCIAPAGO", procedenciaPago);
                                    detalle.put("MEDIOSPAGO", mediosPago);
                                    detalle.put("NUMEROOPERACION", numeroOperacion);
                                    detalle.put("NUMEROAUTORIZACION", numeroAutorizacion);
                                    detalle.put("CODIGOENTIDAD", codigoEntidad);
                                    detalle.put("CODIGOSUCURSAL", codigoSucursal);
                                    detalle.put("SECUENCIA", secuencia);
                                    detalle.put("CAUSALDEVOLUCION", causalDevolucion);
                                    detalle.put("RESERVADO", reservado);
                                    listaDetalle.add(detalle);
                                }
                            }
                        }

                        java.sql.Date fechaPago = new java.sql.Date(((java.util.Date) encabezadoArchivo.get("FECHARECAUDO")).getTime());
                        UsuarioCaja usuarioCaja = model.consultarCajaUsuario(usuario.getId_usuario());
                        System.out.println("Lista ->"+listaDetalle.size());
                        if(usuarioCaja!=null&&listaDetalle.size()>0){
                            model.getCon().setAutoCommit(false);
                            modelo.Taquilla taquilla = model.consultarTaquillaByFecha(5, usuario.getFk_sede(), usuario.getId_usuario(),fechaPago);
                            System.out.println("antes de crear taquilla");
                            if(taquilla==null){
                                System.out.println("crear taquilla");
                                taquilla = new modelo.Taquilla();
                                taquilla.setEstado(3);
                                taquilla.setFecha_ini(new java.sql.Timestamp(fechaPago.getTime()));
                                taquilla.setFecha_fin(new java.sql.Timestamp(fechaPago.getTime()));
                                taquilla.setFk_caja(5);
                                taquilla.setFk_sede(usuario.getFk_sede());
                                taquilla.setFk_usuario(usuario.getId_usuario());
                                taquilla.setValor_nota_debito(0);
                                taquilla.setValor_taquilla(0);
                                taquilla.setFecha_fin(new java.sql.Timestamp(fechaPago.getTime()));
                                //taquilla.setId_taquilla();
                                model.adicionarTaquilla(taquilla);
                                taquilla = model.consultarTaquillaByFecha(5, usuario.getFk_sede(), usuario.getId_usuario(),fechaPago);
                                System.out.println("taquilla");

                            }
                            for (int i = 0; i < listaDetalle.size(); i++) {
                                HashMap detalle = (HashMap) listaDetalle.get(i);
                                String referencia = detalle.get("REFERENCIA").toString();
                                referencia = referencia.substring(referencia.length() - 6, referencia.length());
                                long v = Long.parseLong(referencia);
                                referencia = detalle.get("REFERENCIA").toString();
                                referencia = referencia.substring(referencia.length() - 8, referencia.length());
                                float valor = Float.parseFloat(detalle.get("VALOR").toString());
                                Vehiculo vehiculo = model.consultarVehiculoById(v);
                                if (vehiculo != null) {
                                    long idPersona = 146149;
                                    Propietario propietario = model.getUnicoPropietarioVehiculo(vehiculo.getId_vehiculo());
                                    if (propietario != null) {
                                        idPersona = propietario.getFk_persona();
                                    }
                                    procesos.aplicarPago aplicarPago = new procesos.aplicarPago();
                                    boolean aplicado = aplicarPago.adicionarPagoBanco(model, taquilla.getId_taquilla(), usuario.getFk_sede(), usuario.getId_usuario(), fechaPago, idPersona, v, valor, referencia, fechaPago, 23);
                                    System.out.println(referencia+" : "+aplicado);
                                    long ap = 0;
                                    if(aplicado==true){
                                        ap= 1;
                                    }else{
                                        ap=2;
                                    }
                                    Pagos_externos pe = new Pagos_externos();
                                    pe.setReferencia(referencia);
                                    pe.setFk_vehiculo(vehiculo.getId_vehiculo());
                                    pe.setFecha_inicio(fechaPago);
                                    pe.setAplico(ap);
                                    System.out.println("/*");
                                    System.out.println(referencia);
                                    System.out.println(vehiculo.getId_vehiculo());
                                    System.out.println(fechaPago);
                                    System.out.println(ap);
                                    System.out.println("*/");


                                    model.insert_Pagos_externo(pe);
                                }
                            }
                            float valor_taquilla = model.consultarValorTaquilla(taquilla.getId_taquilla());
                            taquilla.setValor_nota_debito(valor_taquilla);
                            taquilla.setValor_taquilla(valor_taquilla);
                            model.actualizarTaquilla(taquilla,taquilla.getId_taquilla());model.getCon().commit();
                            resultado = true;
                            model.getCon().commit();
                        }
                    }
                }
            }
        } catch (Exception exc) {
            model.getCon().rollback();
            exc.printStackTrace();
        }

    }

    public boolean getResultado() {
        return this.resultado;
    }

    public java.util.HashMap getLista() {
        return this.mapa;
    }
}
