/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package procesos;

import modelo.Model;
import modelo.Cartera;
import modelo.Detalle_Cartera;
import modelo.Nota_Credito;
import modelo.Usuario;
import modelo.Taquilla;
import modelo.Comparendo;

/**
 *
 * @author Administrador
 */
public class aplicarNotaCreditoGeneral {
    
    private int resultado = 0;
    private String mensaje = "";
    
    public aplicarNotaCreditoGeneral(Model model, Usuario usuario, long fk_cartera, java.sql.Date fecha, long fk_persona, String referencia, float valor) throws Exception {
        
        Taquilla taquilla = model.consultar_Taquilla_Actual(usuario.getFk_sede(), usuario.getId_usuario());
        if (taquilla != null) {
            if (taquilla.getFk_caja() == 4 || taquilla.getFk_caja() == 5) {
                Cartera cartera = model.consultarCartera(fk_cartera);
                if (cartera != null) {
                    Comparendo comparendo = model.consultar_Comparendo(cartera.getReferencia());
                    if (comparendo != null) {
                        model.getCon().setAutoCommit(false);
                        Nota_Credito notaCredito = new Nota_Credito();
                        int vigencia = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                        int factura = model.consultarConsecutivo(usuario.getFk_sede(), 2, vigencia);
                        model.actualizarConsecutivo(usuario.getFk_sede(), 2, vigencia);
                        String consecutivo = "N" + ("000000".substring(0, 6 - (factura + "").length())) + factura;
                        notaCredito.setEstado(1);
                        notaCredito.setFecha_proceso(new java.sql.Timestamp(new java.util.Date().getTime()));
                        notaCredito.setFk_registro(comparendo.getId_comparendo());
                        notaCredito.setNumero(consecutivo);
                        notaCredito.setValor(valor);
                        notaCredito.setFk_persona(fk_persona);
                        notaCredito.setFk_usuario(usuario.getId_usuario());
                        notaCredito.setReferencia(referencia);
                        notaCredito.setFecha(fecha);
                        notaCredito.setFk_sede(usuario.getFk_sede());
                        notaCredito.setTipo(2);
                        notaCredito.setId_nota_credito(model.adicionarNotaCredito(notaCredito));//1 METODO MODEL A CREAR.. CON BEANS...
                        aplicarNota(model, notaCredito, cartera);
                    }
                }
            } else {
                System.out.println("No hay una caja de recaudo externo habilitada por el usuario");
            }
        }
    }
    
    public void aplicarNota(Model model, Nota_Credito notaCredito, Cartera cartera) throws Exception {
        try {
            model.getCon().setAutoCommit(false);
            model.actualizarCartera(cartera.getId_cartera(), 0, 12, 0, notaCredito.getFecha(), cartera.getFecha_saldo(), 4);
            java.util.List lista_dc = model.listarDetalleCartera(cartera.getId_cartera());
            for (int j = 0; j < lista_dc.size(); j++) {
                Detalle_Cartera dc = (Detalle_Cartera) lista_dc.get(j);
                model.actualizarDetalleCartera(dc.getId_detalle_cartera(), 5, notaCredito.getId_nota_credito(), 1);
                model.adicionarNotaCartera(notaCredito.getId_nota_credito(), dc.getId_detalle_cartera(), dc.getValor());
            }
            model.getCon().commit();
            resultado = 1;
        } catch (Exception exc) {
            resultado = 0;
            mensaje = exc.getMessage();
            exc.printStackTrace();
        }
    }
    
    public int getResultado() {
        return resultado;
    }
    
    public String mensaje() {
        return mensaje;
    }
}
