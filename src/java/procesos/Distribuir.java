/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package procesos;

import static java.lang.System.out;
import java.sql.SQLException;
import modelo.*;

/**
 *
 * @author Jcarreno
 */
public class Distribuir {

    public boolean setDistribucion(Model modelo, Taquilla taq) throws SQLException {
        java.util.List tiquetes = modelo.listarTiquete(taq.getId_taquilla());
        for (int i = 0; i < tiquetes.size(); i++) {
            Tiquete tiquete = (Tiquete) tiquetes.get(i);
            if (tiquete.getEstado() == 3) {
                Pago pago = modelo.consultarPagoByTiquete(tiquete.getId_tiquete());
                String fecha_hoy = new java.text.SimpleDateFormat("dd/MM/yyyy").format(pago.getFecha());
                java.util.List detalles = modelo.consultarDetalleTiquete(tiquete.getId_tiquete());
                java.util.HashMap<Long, Double> relacion = new java.util.HashMap<Long, Double>();
                for (int j = 0; j < detalles.size(); j++) {
                    Detalle_Tiquete detalle_tiquete = (Detalle_Tiquete) detalles.get(j);
                    if (detalle_tiquete.getFk_concepto() != 0) {
                        if (relacion.containsKey(detalle_tiquete.getFk_concepto())) {
                            double valorAnt = relacion.get(detalle_tiquete.getFk_concepto());
                            double valorSig = detalle_tiquete.getValor_total();
                            relacion.put(detalle_tiquete.getFk_concepto(), valorAnt + valorSig);
                        } else {
                            double valorSig = detalle_tiquete.getValor_total();
                            relacion.put(detalle_tiquete.getFk_concepto(), valorSig);
                        }
                    } else {
                        if (detalle_tiquete.getFk_tramite() != 0) {
                            java.util.List<Tiquete_Concepto> concepto_tramite = modelo.consultarTiqueteTramiteConcepto(detalle_tiquete.getId_det_tiquete());
                            for (int k = 0; k < concepto_tramite.size(); k++) {
                                Tiquete_Concepto tiq_conc = (Tiquete_Concepto) concepto_tramite.get(k);
                                if (relacion.containsKey(tiq_conc.getFk_concepto())) {
                                    double valorAnt = relacion.get(tiq_conc.getFk_concepto());
                                    double valorSig = tiq_conc.getValor();
                                    relacion.put(tiq_conc.getFk_concepto(), valorAnt + valorSig);
                                } else {
                                    double valorSig = tiq_conc.getValor();
                                    relacion.put(tiq_conc.getFk_concepto(), valorSig);
                                }
                            }
                        } else {
                            if (detalle_tiquete.getFk_cartera() != 0) {
                                java.util.List detalle_cartera = modelo.listarDetalleCarteraPagos(detalle_tiquete.getFk_cartera(), pago.getId_pago());
                                for (int k = 0; k < detalle_cartera.size(); k++) {
                                    Detalle_Cartera det = (Detalle_Cartera) detalle_cartera.get(k);
                                    if (relacion.containsKey(det.getFk_concepto())) {
                                        double valorAnt = relacion.get(det.getFk_concepto());
                                        double valorSig = det.getValor();
                                        Conf_Descuento cd = null;//new Conf_Descuento().getCnf_des(modelo, 1, det.getFk_concepto(),fecha_hoy);
                                        if (cd != null) {
                                            Detalle_Cartera dc = modelo.consultarDetalleCartera(det.getFk_cartera(), cd.getFk_concepto_desc());
                                            if (dc != null) {
                                                valorSig += dc.getValor();
                                            }
                                        }
                                        relacion.put(det.getFk_concepto(), valorAnt + valorSig);
                                    } else {
                                        double valorSig = det.getValor();
                                        Conf_Descuento cd = null;//new Conf_Descuento().getCnf_des(modelo, 1, det.getFk_concepto(),fecha_hoy);
                                        if (cd != null) {
                                            Detalle_Cartera dc = modelo.consultarDetalleCartera(det.getFk_cartera(), cd.getFk_concepto_desc());
                                            if (dc != null) {
                                                valorSig += dc.getValor();
                                            }
                                        }
                                        relacion.put(det.getFk_concepto(), valorSig);
                                    }
                                }
                            }
                        }
                    }
                }
                if (!relacion.keySet().isEmpty()) {
                    java.util.Iterator<Long> it = relacion.keySet().iterator();
                    while (it.hasNext()) {
                        long concepto = it.next();
                        double valor = relacion.get(concepto);
                        java.util.List configuracion = modelo.consultarDistribucionSedeConceptos(pago.getFk_sede(), concepto);
                        for (int k = 0; k < configuracion.size(); k++) {
                            Configuracion_distribucion conf = (Configuracion_distribucion) configuracion.get(k);
                            if (conf.getPorcentaje() > 0) {
                                if (concepto != 1093 || concepto != 1094) {
                                    Distribucion distribucion = new Distribucion();
                                    distribucion.setFk_sede(pago.getFk_sede());
                                    distribucion.setFk_entidad_distribucion(conf.getFk_entidad_distribucion());
                                    distribucion.setFk_concepto_distribucion(concepto);
                                    distribucion.setFk_pago(pago.getId_pago());
                                    distribucion.setValor_base(valor);
                                    distribucion.setValor(valor * conf.getPorcentaje() / 100.0);
                                    distribucion.setFecha_proceso(new java.sql.Timestamp(new java.util.Date().getTime()));
                                    modelo.adicionarDistribucion(distribucion);
                                }
                            }
                        }
                    }
                }
            }
        }
        taq.setEstado(5);
        modelo.actualizarTaquilla(taq, taq.getId_taquilla());
        modelo.getCon().commit();
        out.print("DISTRIBUIDA");

//        java.util.List<Pago> temp = modelo.listarPagosTaquilla(taq.getId_taquilla(), 0);
//        if (temp.size() > 0) {
//            for (int i = 0; i < temp.size(); i++) {
//                Pago pago = temp.get(i);
//                System.out.println("Update ->" + pago.getId_pago());
//                modelo.updateDistribucionINtereces(pago.getId_pago());
//                modelo.getCon().commit();
//            }
//        }

        /*try {
           /// modelo.AutoCuadre();
        } catch (SQLException e) {
            System.out.println("procesos.Distribuir.setDistribucion()");
            System.out.println("Error: "+e.getMessage());
        }*/

        return true;
    }

}
