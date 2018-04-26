/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package procesos;

import java.util.LinkedList;
import java.util.List;
import javax.servlet.http.*;
import modelo.*;
import org.ita.webservice.ProcessStatus;
import org.ita.webservice.Pago;

/**
 *
 * @author jjpadillag
 */
public class aplicarPagosOnline {

    private String mensaje;

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public boolean adicionarPagoOnline(Model model, HttpServletRequest request, Usuario usuario) throws Exception {

        int l = 0;
        long idTaquilla = Long.parseLong(request.getParameter("idTaquilla"));
        List<org.ita.webservice.Pago> listaPagos = consultarPagosEfectivos();
        List<String> listaIdPagos = new LinkedList();
        float valorPago = 0;
        long banco = 93;
        int ctiquete = 0;
        boolean paso = false;
        model.getCon().setAutoCommit(false);

        try {

            if (listaPagos.size() > 0) {
                while (l < listaPagos.size()) {
                    org.ita.webservice.Pago p = (org.ita.webservice.Pago) listaPagos.get(l);
                    listaIdPagos.add("" + p.getId());
                    System.out.println("Lista de id de pagos: " + listaIdPagos.get(l));
                    Vehiculo vehiculo = model.consultarVehiculo(p.getPlaca().toUpperCase());
                    if (vehiculo != null) {
                        valorPago = Float.parseFloat("" + p.getValorPagado());

                        String fechaP = p.getFechaProceso().substring(8, 10) + "/" + p.getFechaProceso().substring(5, 7) + "/" + p.getFechaProceso().substring(0, 4);
                        System.out.println("FECHAP: " + fechaP);
                        java.sql.Date fechaPago = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fechaP).getTime());
                        System.out.println("FECHAPAGO: " + fechaPago);
                        java.util.List listap = model.crearListaPropietarios(vehiculo.getId_vehiculo());
                        Propietario propietario = (Propietario) listap.get(0);
                        Persona persona = model.consultarPersona(propietario.getFk_persona());

                        if (persona != null) {
                            //Proceso Descargue de Cartera
                            System.out.println(" |persona !=null ");
                            int vigencia = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                            Tiquete tiquete = new Tiquete();
                            tiquete.setEstado(3);
                            tiquete.setFecha(fechaPago);
                            tiquete.setFecha_proceso(new java.sql.Timestamp(new java.util.Date().getTime()));
                            tiquete.setFk_persona(persona.getId_persona());
                            tiquete.setFk_vehiculo(vehiculo.getId_vehiculo());
                            tiquete.setTipo_pago(10);
                            tiquete.setReferencia(p.getReferencia());
                            tiquete.setFecha_referencia(fechaPago);
                            tiquete.setFk_banco(banco);
                            int factura = model.consultarConsecutivo(usuario.getFk_sede(), 17, vigencia);
                            String consecutivo = "PO" + ("000000".substring(0, 6 - (factura + "").length())) + factura;
                            model.actualizarConsecutivo(usuario.getFk_sede(), 17, vigencia);
                            System.out.println(" | consecutivo: "+consecutivo);
                            tiquete.setNumero_factura(consecutivo);
                            tiquete.setFk_taquilla(idTaquilla);
                            tiquete.setFk_usuario(usuario.getId_usuario());
                            tiquete.setValor_total(valorPago);
                            int security = ((int) (Math.random() * 100000));
                            tiquete.setValor_total_descuento(security);
                            tiquete.setValor_total_iva(valorPago);
                            tiquete.setEstado_preliquidacion(2);
                            tiquete.setId_tiquete(model.adicionarTiquete(tiquete));
                            System.out.println(" | Tiquete : "+consecutivo);
                            modelo.Pago pago = new modelo.Pago();
                            pago.setFecha(tiquete.getFecha());
                            pago.setFk_sede(usuario.getFk_sede());
                            pago.setFk_taquilla(tiquete.getFk_taquilla());
                            pago.setFk_tiquete(tiquete.getId_tiquete());
                            pago.setNumero_factura(consecutivo);
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
                            long idPago = model.adicionarPago(pago);
                            System.out.println(" | Pago >: "+idPago);
                        //Detalle pago Online
                            PagoOnline pagoOnline = new PagoOnline();

                            pagoOnline.setFk_vehiculo(tiquete.getFk_vehiculo());
                            pagoOnline.setFk_persona(tiquete.getFk_persona());
                            pagoOnline.setFk_pago(idPago);
                            pagoOnline.setReferencia(p.getReferencia());
                            pagoOnline.setValor(tiquete.getValor_total());
                            pagoOnline.setFecha(fechaPago);
                            pagoOnline.setEstado(2);
                            pagoOnline.setFk_usuario(tiquete.getFk_usuario());
                            pagoOnline.setFecha_proceso(tiquete.getFecha_proceso());
                            pago.setId_pago(idPago);
                            model.adicionarPagoOnline(pagoOnline);
                            System.out.println(" | Pago en linea Add: "+consecutivo);

                            //Calculo de intereses a bajar
                            model.AjustarValorInteresCostas(vehiculo.getId_vehiculo(), usuario.getId_usuario(), fechaPago);
                            java.util.List carteras = model.listarCarteraVehiculo(vehiculo.getId_vehiculo());
                            float valorTotal = valorPago;

                            if (carteras.size() > 0) {
                                for (int i = 0; i < carteras.size() && valorTotal > 0; i++) {
                                    Cartera cartera = (Cartera) carteras.get(i);
                                    java.util.List listaDc = model.listarDetalleCartera(cartera.getId_cartera());
                                    float pagado = 0;
                                    int j = 0;
                                    for (j = 0; j < listaDc.size() && valorTotal > 0; j++) {
                                        Detalle_Cartera dc = (Detalle_Cartera) listaDc.get(j);
                                        if (valorTotal >= dc.getValor()) {
                                            valorTotal -= dc.getValor();
                                            pagado += dc.getValor();
                                            model.actualizarDetalleCartera(dc.getId_detalle_cartera(), 2, idPago, 1);
                                        } else {
                                            model.actualizarValorDetalleCartera(dc.getId_detalle_cartera(), 2, valorTotal, idPago);
                                            float diferencia = dc.getValor() - valorTotal;
                                            pagado += valorTotal;
                                            valorTotal = 0;
                                            Detalle_Cartera dc2 = new Detalle_Cartera();
                                            dc2.setFecha(tiquete.getFecha());
                                            dc2.setEstado(1);
                                            dc2.setFecha_sistema(new java.sql.Timestamp(new java.util.Date().getTime()));
                                            dc2.setFk_cartera(dc.getFk_cartera());
                                            dc2.setFk_concepto(dc.getFk_concepto());
                                            dc2.setFk_usuario(usuario.getId_usuario());
                                            dc2.setReferencia(dc.getReferencia());
                                            dc2.setValor(diferencia);
                                            dc2.setFk_pago(0);
                                            model.adicionarDetalleCartera(dc2);
                                            break;
                                        }
                                    }
                                    java.sql.Date fechaMod = cartera.getFecha_saldo();
                                    if (j == listaDc.size()) {
                                        model.actualizarCartera(cartera.getId_cartera(), 0, 2, idPago, tiquete.getFecha(), fechaMod, 1);
                                    } else {
                                        model.actualizarCartera(cartera.getId_cartera(), (float) (cartera.getSaldo() - pagado), 1, idPago, tiquete.getFecha(), fechaMod, 1);
                                    }
                                    Detalle_Cartera dc = new Detalle_Cartera();
                                    dc.setFecha(tiquete.getFecha());
                                    dc.setEstado(2);
                                    dc.setFecha_sistema(new java.sql.Timestamp(new java.util.Date().getTime()));
                                    dc.setFk_cartera(cartera.getId_cartera());
                                    int codP = (cartera.getTipo() == 1 || cartera.getTipo() == 5) ? 320 : (cartera.getTipo() == 2 ? 322 : 321);
                                    dc.setFk_concepto(codP);
                                    dc.setFk_usuario(usuario.getId_usuario());
                                    dc.setReferencia(idPago + "");
                                    dc.setValor((float) (-1 * pagado));
                                    model.adicionarDetalleCartera(dc);
                                    Detalle_Tiquete dt = new Detalle_Tiquete();
                                    dt.setCantidad(1);
                                    dt.setFk_cartera(cartera.getId_cartera());
                                    dt.setFk_tiquete(tiquete.getId_tiquete());
                                    dt.setEstado(1);
                                    dt.setValor_descuento(pagado);
                                    dt.setValor_iva(pagado);
                                    dt.setValor_total(pagado);
                                    dt.setValor_unitario(pagado);
                                    model.adicionarDetalleTiquete(dt);
                                }
                            }
                            if (valorTotal > 0) {
                                modelo.Saldo_Favor saldoFavor = new modelo.Saldo_Favor();
                                int numeroSF = model.consultarConsecutivo(usuario.getFk_sede(), 8, vigencia);
                                String consecutivoSF = ("00000").substring(0, 5 - (numeroSF + "").length()) + numeroSF;
                                model.actualizarConsecutivo(usuario.getFk_sede(), 8, vigencia);
                                saldoFavor.setNumero(consecutivoSF);
                                saldoFavor.setFk_persona(persona.getId_persona());
                                saldoFavor.setTipo(2);
                                saldoFavor.setValor(valorTotal);
                                saldoFavor.setReferencia(tiquete.getId_tiquete() + "");
                                saldoFavor.setEstado(1);
                                saldoFavor.setFecha(fechaPago);
                                saldoFavor.setFecha_proceso(new java.sql.Timestamp(new java.util.Date().getTime()));
                                saldoFavor.setFk_usuario(usuario.getId_usuario());
                                model.adicionarSaldoFavor(saldoFavor);
                            }
                        }
                    }
                    l++;
                }
                paso = true;
                model.getCon().commit();
            }
            if (paso && listaIdPagos.size() > 0) {
            ProcessStatus p =  actualizarPagosAplicados(listaIdPagos);

              if(p.isEstado()){
                return true;
              }
            }

        } catch (Exception ex) {
            model.getCon().rollback();
            ex.printStackTrace();
        }
        return false;
    }

    private static ProcessStatus actualizarPagosAplicados(java.util.List<java.lang.String> lstIdPagos) {
        org.ita.webservice.PagosEnLinea_Service service = new org.ita.webservice.PagosEnLinea_Service();
        org.ita.webservice.PagosEnLinea port = service.getPagosEnLineaPort();
        return port.actualizarPagosAplicados(lstIdPagos);
    }

    private static java.util.List<org.ita.webservice.Pago> consultarPagosEfectivos() {
        org.ita.webservice.PagosEnLinea_Service service = new org.ita.webservice.PagosEnLinea_Service();
        org.ita.webservice.PagosEnLinea port = service.getPagosEnLineaPort();
        return port.consultarPagosEfectivos();
    }
}
