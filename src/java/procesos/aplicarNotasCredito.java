/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package procesos;

/**
 *
 * @author Civitrans
 */

import java.util.Iterator;
import modelo.Model;
import modelo.Cartera;
import modelo.Detalle_Cartera;
import modelo.Nota_Credito;
import modelo.Usuario;
import modelo.Taquilla;

public class aplicarNotasCredito {

    private int resultado = 0;
    private String mensaje = "";

    public aplicarNotasCredito(Model model,Usuario usuario,long fk_registro,java.sql.Date fecha,long fk_persona,String referencia,float valor) throws Exception{

        Taquilla taquilla = model.consultar_Taquilla_Actual(usuario.getFk_sede(),usuario.getId_usuario());
        if(taquilla!=null){
            if(taquilla.getFk_caja()==4 || taquilla.getFk_caja()==5){
                Nota_Credito notaCredito = new Nota_Credito();
                int vigencia = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                int factura = model.consultarConsecutivo(usuario.getFk_sede(), 2, vigencia);
                model.actualizarConsecutivo(usuario.getFk_sede(),2, vigencia);
                String consecutivo = "N"+("000000".substring(0, 6-(factura+"").length()))+factura;
                notaCredito.setEstado(1);
                notaCredito.setFecha_proceso(new java.sql.Timestamp(new java.util.Date().getTime()));
                notaCredito.setFk_registro(fk_registro);
                notaCredito.setNumero(consecutivo);
                notaCredito.setValor(valor);
                notaCredito.setFk_persona(fk_persona);
                notaCredito.setFk_usuario(usuario.getId_usuario());
                notaCredito.setReferencia(referencia);
                notaCredito.setFecha(fecha);
                notaCredito.setFk_sede(usuario.getFk_sede());
                notaCredito.setTipo(1);
                notaCredito.setId_nota_credito(model.adicionarNotaCredito(notaCredito));//1 METODO MODEL A CREAR.. CON BEANS...
                getInteresesCostasVehiculos(model,notaCredito);
            }else{
                System.out.println("No hay una caja de recaudo externo habilitada por el usuario");
            }
        }
    }

    public void getInteresesCostasVehiculos(Model model,Nota_Credito notaCredito) throws Exception {
        try {
             float acumulado = notaCredito.getValor();
             procesos.calcularIntereses calcularI = new procesos.calcularIntereses();
             int s = model.consultarMaxCodigo();
             String tasas[][] = model.getIntereses();
             calcularI.setTasas("s", s, tasas);
             model.ajustarInteresesCostasVehiculos(notaCredito.getFk_registro(), notaCredito.getFk_usuario(), notaCredito.getFecha());
             java.util.List  carteras = model.listarCarteraVehiculo(notaCredito.getFk_registro());
             Iterator itt = carteras.iterator();
             while (itt.hasNext()) {
                 if(acumulado>0){
                     Cartera cartera = (Cartera)itt.next();
                     if(acumulado>=cartera.getSaldo()){
                        model.actualizarCartera(cartera.getId_cartera(),0, 12, 0, notaCredito.getFecha(), cartera.getFecha_saldo(), 4);
                        java.util.List lista_dc = model.listarDetalleCartera(cartera.getId_cartera());
                        for (int j = 0; j < lista_dc.size(); j++) {
                            Detalle_Cartera dc = (Detalle_Cartera) lista_dc.get(j);
                            model.actualizarDetalleCartera(dc.getId_detalle_cartera(), 5, notaCredito.getId_nota_credito(), 1);
                            model.adicionarNotaCartera(notaCredito.getId_nota_credito(),dc.getId_detalle_cartera(),dc.getValor());
                        }
                        acumulado = acumulado - (float)cartera.getSaldo();
                     }else{
                         if(acumulado>0){
                            model.actualizarCartera(cartera.getId_cartera(),0, 1, 0, notaCredito.getFecha(), cartera.getFecha_saldo(), 4);
                            java.util.List lista_dc = model.listarDetalleCartera(cartera.getId_cartera());
                            float acumulado2 = acumulado;
                            for (int j = 0; j < lista_dc.size(); j++) {
                                Detalle_Cartera dc = (Detalle_Cartera) lista_dc.get(j);
                                if(acumulado2>=dc.getValor()){
                                    model.actualizarDetalleCartera(dc.getId_detalle_cartera(), 5, notaCredito.getId_nota_credito(), 1);
                                    model.adicionarNotaCartera(notaCredito.getId_nota_credito(),dc.getId_detalle_cartera(),dc.getValor());
                                    acumulado2 = acumulado2 - dc.getValor();
                                }else{
                                    if(acumulado2>0){
                                        float rest = dc.getValor() - acumulado2;
                                        model.actualizarValorDetalleCartera(dc.getId_detalle_cartera(),5,acumulado2,notaCredito.getId_nota_credito());//MODIFICAR METODO CUANDO PAGO SEA = 0
                                        Detalle_Cartera ndc = new Detalle_Cartera();
                                        ndc.setFecha(notaCredito.getFecha());
                                        ndc.setEstado(1);
                                        ndc.setFecha_sistema(new java.sql.Timestamp(new java.util.Date().getTime()));
                                        ndc.setFk_cartera(dc.getFk_cartera());
                                        ndc.setFk_concepto(dc.getFk_concepto());
                                        ndc.setFk_usuario(notaCredito.getFk_usuario());
                                        ndc.setReferencia(dc.getReferencia());
                                        ndc.setValor(rest);
                                        model.adicionarDetalleCartera(ndc);
                                        model.adicionarNotaCartera(notaCredito.getId_nota_credito(),dc.getId_detalle_cartera(),dc.getValor());
                                        acumulado2 = 0;
                                    }
                                }
                            }
                            model.actualizarValoresCartera(cartera.getId_cartera());
                            model.getCon().commit();
                            acumulado = 0;
                            break;
                        }
                     }
                 }else{
                     break;
                 }
             }
             if(acumulado>0){
                modelo.Saldo_Favor saldoFavor = new modelo.Saldo_Favor();
                int vigencia = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                int numeroSF = model.consultarConsecutivo(notaCredito.getFk_sede(),8,vigencia);
                String consecutivoSF = ("00000").substring(0,5-(numeroSF+"").length())+numeroSF;
                model.actualizarConsecutivo(notaCredito.getFk_sede(),8,vigencia);
                saldoFavor.setNumero(consecutivoSF);
                saldoFavor.setFk_persona(notaCredito.getFk_persona());
                saldoFavor.setTipo(2);
                saldoFavor.setValor(acumulado);
                saldoFavor.setReferencia(notaCredito.getId_nota_credito()+"");
                saldoFavor.setEstado(1);
                saldoFavor.setFecha(notaCredito.getFecha());
                saldoFavor.setFecha_proceso(notaCredito.getFecha_proceso());
                saldoFavor.setFk_usuario(notaCredito.getFk_usuario());
                model.adicionarSaldoFavor(saldoFavor);
             }
             resultado = 1;
         }catch(Exception exc){
             resultado = 0;
             mensaje = exc.getMessage();
             exc.printStackTrace();
         }
    }

    public int getResultado(){
        return resultado;
    }

    public String mensaje(){
        return mensaje;
    }
}