/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package procesos;

import java.sql.SQLException;
import modelo.*;

/**
 *
 * @author Administrador
 */
public class AplicarExcedenteRecibo {

    private String Msg = "";

    public String getMsg() {
        return Msg;
    }

    public void setMsg(String Msg) {
        this.Msg = Msg;
    }

    public boolean AplicarExcedente(Model model, Usuario usuario, javax.servlet.http.HttpServletRequest request, java.util.List listado) throws SQLException {

        model.getCon().setAutoCommit(false);
        try {

            String ReciboN, ReciboV;
            double total = 0;
System.out.print("Antes del ReciboV y N =\n");
            ReciboV = request.getParameter("reciboV").toUpperCase();
            ReciboN = request.getParameter("reciboN").toUpperCase();

System.out.print("IF"+ ReciboV+" // "+ReciboN);
            if (ReciboV != null && ReciboN != null) {
System.out.print("Despues del Si\n");
                Tiquete tiqV = model.consultarTiqueteByFactura(ReciboV);

                if (tiqV != null) {
System.out.print("Despues del Si TiqV\n");
                    if (tiqV.getEstado() == 3) {
                        System.out.print("Despues del Si esatdo tiqv\n");
                        Detalle_Tiquete dtV = model.consultarDetalleTiqueteEstado(tiqV.getId_tiquete(), 2);
                        if (dtV == null) {
                            System.out.print("Despues del Si dtV\n");
                            Tiquete tiqN = model.consultarTiqueteByFactura(ReciboN);
                            if (tiqN != null) {
System.out.print("Despues del Si TiqN\n");
                                if (tiqN.getEstado() == 4) {
                                    System.out.print("Despues del Si TiqN estado\n");
                                    Detalle_Tiquete dtN = model.consultarDetalleTiqueteEstado(tiqN.getId_tiquete(), 2);
                                    if (dtN == null) {
                                        System.out.print("Despues del Si DtN\n");
                                        System.out.print("Despues lista"+listado.size()+" \n");
                                        float valor32 = 0;
                                        float lic=0;
                                        for (int i = 0; i < listado.size(); i++) {
                                            long conc = Long.parseLong(listado.get(i).toString());
                                            if(conc == 13 ||conc == 42 || conc == 48 || conc == 78){
                                                Tiquete_Concepto tcV = model.consultartiqueteConceptoByNumeroTiq(tiqV.getId_tiquete(), conc);
                                                valor32 += tcV.getValor();
                                            }else{
                                                if(conc == 64){
                                                Tiquete_Concepto tcV = model.consultartiqueteConceptoByNumeroTiq(tiqV.getId_tiquete(), conc);
                                                lic+=tcV.getValor();
                                                }
                                            }
                                        }
                                        for (int i = 0; i < listado.size(); i++) {
                                            long conc = Long.parseLong(listado.get(i).toString());
                                            if(conc!=13||conc!=42||conc!=48||conc!=78||conc!=64){
                                            System.out.print("Concepto"+conc+" \n");
                                            Tiquete_Concepto tcV = model.consultartiqueteConceptoByNumeroTiq(tiqV.getId_tiquete(), conc);
                                            Tiquete_Concepto tcN = model.consultartiqueteConceptoByNumeroTiq(tiqN.getId_tiquete(), conc);
                                            if(tcV!=null&&tcN!=null){
                                            tcV.setValor(conc==32?valor32+tcV.getValor():conc==33?valor32+tcV.getValor():conc==34?valor32+tcV.getValor():conc==35?valor32+tcV.getValor():tcV.getValor());
                                            total = tcN.getValor() - tcV.getValor();

                                            if (total >= 0) {
                                                System.out.print(" lista "+i+" concepto "+conc+"Despues total "+total+" \n");
                                                model.actualizarTiqueteConceptoByID(tcN.getId_tiqueteConcepto(), total);
                                            }
                                            }
                                            }else{
                                            if(lic>0 && conc==64 ){
                                            Tiquete_Concepto tcV = model.consultartiqueteConceptoByNumeroTiq(tiqV.getId_tiquete(), conc);
                                            Tiquete_Concepto tcN = model.consultartiqueteConceptoByNumeroTiq(tiqN.getId_tiquete(), 8559);
                                            if(tcV!=null&&tcN!=null){
                                            total = tcN.getValor() - tcV.getValor();
                                            if (total >= 0) {
                                                System.out.print(" lista "+i+" concepto "+conc+"Despues total "+total+" \n");
                                                model.actualizarTiqueteConceptoByID(tcN.getId_tiqueteConcepto(), total);
                                            }
                                            }
                                            }
                                            }
                                        }
                                        java.util.List list = model.consultarDetalleTiquete(tiqN.getId_tiquete());
                                        System.out.print("Despues list "+list.size()+" \n");
                                        for (int i = 0; i < list.size(); i++) {
                                            Detalle_Tiquete dt = (Detalle_Tiquete) list.get(i);
                                            float valorDT = model.consultarValorDetTiquete(dt.getId_det_tiquete());
                                            model.actualizarValorDetalleTiq(dt.getId_det_tiquete(), valorDT);
                                        }
                                        System.out.print("Despues ok  \n");
                                        float valorDetalleT = model.consultarValorDetTiqueteByfk_tiquete(tiqN.getId_tiquete());
                                        model.actualizarValorTiquete(tiqN.getId_tiquete(), valorDetalleT);
                                        model.actualizarValorPago(tiqN.getId_tiquete(), valorDetalleT);
                                        Msg = "" + valorDetalleT;
                                        model.actualizarEstadoDetalleTiqueteFkTiquete(tiqV.getId_tiquete(), 2);
                                        model.adicionarReciboExcedente(tiqV.getId_tiquete(), tiqN.getId_tiquete(), usuario.getId_usuario(), "Aplicado");
                                        model.getCon().commit();
                                        return true;
                                    } else {
                                        Msg = "El tiquete Nuevo se encuentra utilizado";
                                    }
                                } else {
                                    Msg = "El tiquete Nuevo no se encuentra en estado Preliquidado";
                                }
                            } else {
                                Msg = "El tiquete Nuevo se encuentra en estado Utilizado";
                            }
                        } else {
                            Msg = "El tiquete anterior se encuentra en estado Utilizado";
                        }
                    } else {
                        Msg = "El tiquete anterior no se encuentra en estado Aplicado";
                    }
                } else {
                    Msg = "El tiquete anterior no se encuentra registrado en el sistema";
                }
            } else {
                Msg = "No se encontraron Recibos a aplicar";
            }
        } catch (Exception e) {
            model.getCon().rollback();
            e.printStackTrace();
            return false;
        }

        return false;
    }
}
