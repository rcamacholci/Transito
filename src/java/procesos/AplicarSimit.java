/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package procesos;

import modelo.Cartera;
import modelo.Detalle_Cartera;
import modelo.Detalle_Tiquete;
import modelo.Model;
import modelo.Tiquete;
import modelo.Pago;
import modelo.pagos_simit;
import modelo.tiquete_simit;

/**
 *
 * @author Administrador
 */
public class AplicarSimit {

    public boolean adicionarPagoSimit(Model model,long idTaquilla,long idSede,long idUsuario,java.sql.Date fechaPago,long idPersona,long idVehiculo,float valor,String referencia,java.sql.Date fechaReferencia,long banco) {

        try{
            int vigencia = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
            tiquete_simit tiquete = new tiquete_simit();
            tiquete.setEstado(3);
            tiquete.setFecha(fechaPago);
            tiquete.setFecha_proceso(new java.sql.Timestamp(new java.util.Date().getTime()));
            tiquete.setFk_persona(idPersona);
            tiquete.setFk_vehiculo(idVehiculo);
            tiquete.setTipo_pago(3);
            tiquete.setReferencia(referencia);
            tiquete.setFecha_referencia(fechaReferencia);
            tiquete.setFk_banco(banco);
            int factura = model.consultarConsecutivo(idSede, 12, vigencia);
            String consecutivo = "D" + ("000000".substring(0, 6 - (factura + "").length())) + factura;
            model.actualizarConsecutivo(idSede, 12, vigencia);
            tiquete.setNumero_factura(consecutivo);
            tiquete.setFk_taquilla(idTaquilla);
            tiquete.setFk_usuario(idUsuario);
            tiquete.setValor_total(valor);
            int security = ((int) (Math.random() * 100000));
            tiquete.setValor_total_descuento(security);
            tiquete.setValor_total_iva(valor);
            tiquete.setEstado_preliquidacion(2);
            tiquete.setId_tiquete(model.adicionarTiqueteSimit(tiquete));

            pagos_simit  pago = new pagos_simit();
            pago.setFecha(tiquete.getFecha());
            pago.setFk_sede(idSede);
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
            long idPago = model.adicionarPagoSimit(pago);
            pago.setId_pago(idPago);
            model.ajustarInteresesCostasVehiculos(idVehiculo,idUsuario,fechaPago);
            java.util.List carteras = model.listarCarteraVehiculo(idVehiculo);
            float valorTotal = valor;
            if(carteras.size()>0){
                for (int i = 0; i < carteras.size()&&valorTotal>0; i++) {
                    Cartera cartera = (Cartera) carteras.get(i);
                    java.util.List listaDc = model.listarDetalleCartera(cartera.getId_cartera());
                    float pagado = 0;
                    int j = 0;
                    for (j = 0; j < listaDc.size()&&valorTotal>0; j++) {
                        Detalle_Cartera dc = (Detalle_Cartera) listaDc.get(j);
                        if (valorTotal >= dc.getValor()) {
                            valorTotal -= dc.getValor();
                            pagado += dc.getValor();
                            model.actualizarDetalleCartera(dc.getId_detalle_cartera(), 2, idPago, 1);
                        }else{
                            model.actualizarValorDetalleCartera(dc.getId_detalle_cartera(), 2, valorTotal,idPago);
                            float diferencia = dc.getValor() - valorTotal;
                            pagado += valorTotal;
                            valorTotal = 0;
                            Detalle_Cartera dc2 = new Detalle_Cartera();
                            dc2.setFecha(tiquete.getFecha());
                            dc2.setEstado(1);
                            dc2.setFecha_sistema(new java.sql.Timestamp(new java.util.Date().getTime()));
                            dc2.setFk_cartera(dc.getFk_cartera());
                            dc2.setFk_concepto(dc.getFk_concepto());
                            dc2.setFk_usuario(idUsuario);
                            dc2.setReferencia(dc.getReferencia());
                            dc2.setValor(diferencia);
                            dc2.setFk_pago(0);
                            model.adicionarDetalleCartera(dc2);
                            break;
                        }
                    }
                    java.sql.Date fechaMod = cartera.getFecha_saldo();
                    if(j==listaDc.size()){
                        model.actualizarCartera(cartera.getId_cartera(),0,2,idPago,tiquete.getFecha(),fechaMod,1);
                    }else{
                        model.actualizarCartera(cartera.getId_cartera(),(float)(cartera.getSaldo()-pagado),1,idPago,tiquete.getFecha(),fechaMod,1);
                    }
                    Detalle_Cartera dc = new Detalle_Cartera();
                    dc.setFecha(tiquete.getFecha());
                    dc.setEstado(2);
                    dc.setFecha_sistema(new java.sql.Timestamp(new java.util.Date().getTime()));
                    dc.setFk_cartera(cartera.getId_cartera());
                    int codP = (cartera.getTipo()==1||cartera.getTipo()==5)?320:(cartera.getTipo()==2?322:321);
                    dc.setFk_concepto(codP);
                    dc.setFk_usuario(idUsuario);
                    dc.setReferencia(idPago+"");
                    dc.setValor((float)(-1*pagado));
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
            if(valorTotal>0){
                modelo.Saldo_Favor saldoFavor = new modelo.Saldo_Favor();
                int numeroSF = model.consultarConsecutivo(idSede,8,vigencia);
                String consecutivoSF = ("00000").substring(0,5-(numeroSF+"").length())+numeroSF;
                model.actualizarConsecutivo(idSede,8,vigencia);
                saldoFavor.setNumero(consecutivoSF);
                saldoFavor.setFk_persona(idPersona);
                saldoFavor.setTipo(2);
                saldoFavor.setValor(valorTotal);
                saldoFavor.setReferencia(tiquete.getId_tiquete()+"");
                saldoFavor.setEstado(1);
                saldoFavor.setFecha(fechaPago);
                saldoFavor.setFecha_proceso(new java.sql.Timestamp(new java.util.Date().getTime()));
                saldoFavor.setFk_usuario(idUsuario);
                model.adicionarSaldoFavor(saldoFavor);
            }
            return true;
        }catch(Exception exc){
            exc.printStackTrace();
        }
        return false;
    }
}

