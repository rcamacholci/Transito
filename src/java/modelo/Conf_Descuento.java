/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import procesos.calcularIntereses;

/**
 *
 * @author Jcarreno
 */
public class Conf_Descuento {

    private long tipo, id_concepto, fk_concepto_desc, usuairo, porcentaje, id;
    private String Vig_inicial, Vig_final, descripcion;
    private Date f_desde, f_hasta, f_proceso;
    private Conf_Descuento cnf_des;

    public static Conf_Descuento load(ResultSet rs) throws SQLException {
        Conf_Descuento cd = new Conf_Descuento();
        cd.setId(rs.getLong(1));
        cd.setId_concepto(rs.getLong(2));
        cd.setPorcentaje(rs.getLong(3));
        cd.setF_desde(rs.getDate(4));
        cd.setF_hasta(rs.getDate(5));
        cd.setFk_concepto_desc(rs.getLong(6));
        cd.setDescripcion(rs.getString(7));
        cd.setUsuairo(rs.getLong(8));
        cd.setVig_inicial(rs.getString(9));
        cd.setVig_final(rs.getString(10));
        cd.setTipo(rs.getLong(11));
        cd.setF_proceso(rs.getDate(12));
        return cd;
    }

    public Conf_Descuento getCnf_des(Model model, long tipo, long concepto, String fecha) {
        try {
            if (!model.hayConexion()) {
                throw new SQLException("SIN CONEXION");
            }
            PreparedStatement pst = null;
            ResultSet rst = null;
            try {
                pst = model.getCon().prepareStatement("Select \n"
                        + "* \n"
                        + "from\n"
                        + "Conf_Descuentos cd\n"
                        + "where \n"
                        + "Cd.Tipo = " + tipo + " \n"
                        + "and\n"
                        + "Cd.Fk_Concepto = " + concepto + " \n"
                        + "and \n"
                        + "Cast('" + fecha + "' as Date) Between Cd.Fecha_Ini and Cd.Fecha_Fin");
                rst = pst.executeQuery();
                if (rst.next()) {
                    return Conf_Descuento.load(rst);
                }
            } catch (Exception ex) {
                ex.printStackTrace();
                return null;
            } finally {
                if (pst != null) {
                    pst.close();
                }
                if (rst != null) {
                    rst.close();
                }
            }
        } catch (Exception e) {
            return null;
        }
        return null;
    }

    public List<Conf_Descuento> getListDescuento(Model model, long concepto) {
        try {
            if (!model.hayConexion()) {
                throw new SQLException("SIN CONEXION");
            }
            PreparedStatement pst = null;
            ResultSet rst = null;
            List<Conf_Descuento> array = new ArrayList<Conf_Descuento>();
            try {
                pst = model.getCon().prepareStatement("select * from Conf_descuentos where fk_concepto = ?");
                pst.setLong(1, concepto);
                rst = pst.executeQuery();
                while (rst.next()) {
                    array.add(Conf_Descuento.load(rst));
                }
                return array;
            } catch (Exception e) {
                System.out.println("Error En SubTry getListDescuento \n\r " + e.toString());
            } finally {

            }
        } catch (Exception e) {
            System.out.println("Error En MainTry getListDescuento \n\r " + e.toString());
        }
        return new ArrayList<Conf_Descuento>();
    }//getListDescuento

    public boolean eliminarDescuento(Model model, long fk_vehiculo, Usuario usuario, int op) throws SQLException {
        /**/
        if (!model.hayConexion()) {
            throw new SQLException("No hay Conexion");
        }
        PreparedStatement pst = null;
        ResultSet rst = null;
        model.getCon().setAutoCommit(false);
        try {
            model.getCon().setAutoCommit(false);
            String sql = "Select * from carteras where Fk_vehiculo = ? and Estado_cartera = 1 and tipo = 2 order by fecha_creacion,referencia asc";
            pst = model.getCon().prepareStatement(sql);
            pst.setLong(1, fk_vehiculo);
            rst = pst.executeQuery();
            calcularIntereses calcularI = new calcularIntereses();
            int s = model.consultarMaxCodigo();
            String tasas[][] = model.getIntereses();
            calcularI.setTasas("s", s, tasas);
            Cartera cartera;
            List<String> Permitidas = new ArrayList<String>();
            while (rst.next()) {
                cartera = Cartera.Load(rst);
                model.eliminarDescuentoInternacionDC(cartera.getId_cartera(), cartera.getReferencia(), 1093);
                model.actualizarValoresCartera(cartera.getId_cartera());
            }
            model.getCon().commit();
            /**/
        } catch (Exception e) {
            e.printStackTrace();
            model.getCon().rollback();
            return false;
        }
        return true;
    }

    public boolean aplicarDescuentoCartera(Model model, long fk_vehiculo, Usuario usuario) throws SQLException {
        try {
            if (!model.hayConexion()) {
                throw new SQLException("No hay Conexion");
            }
            PreparedStatement pst = null;
            ResultSet rst = null;
            try {
                model.getCon().setAutoCommit(false);
                String sql = "Select * from carteras where Fk_vehiculo = ? and Estado_cartera = 1 order by fecha_creacion,referencia asc";
                pst = model.getCon().prepareStatement(sql);
                pst.setLong(1, fk_vehiculo);
                rst = pst.executeQuery();
                calcularIntereses calcularI = new calcularIntereses();
                int s = model.consultarMaxCodigo();
                String tasas[][] = model.getIntereses();
                calcularI.setTasas("s", s, tasas);
                Cartera cartera;
                List<String> Permitidas = new ArrayList<String>();
                while (rst.next()) {
                    cartera = Cartera.Load(rst);
                    /*indicador*/
                    int idc = cartera.getTipo() == 2 ? 249 : cartera.getTipo() == 1 ? 318 : 319;
                    java.util.Date fechaInicio = new java.util.Date(cartera.getFecha_saldo().getTime());
                    java.util.Date fechaRef = new java.util.Date(tasas[0][0]);
                    java.util.Date fechaActual = new java.util.Date();
                    fechaInicio = fechaInicio.getTime() < fechaRef.getTime() ? fechaRef : fechaInicio;
                    float valorReal = model.valorDetalleCarteraAtributos(cartera.getId_cartera(), cartera.getFk_sede(), 3);
                    float interes = calcularI.getValor(fechaInicio, fechaActual, valorReal);
                    float descuento = 0;
                    int interesR = Math.round(interes);
                    //    System.out.println("interesR="+interesR);
                    interesR = interesR <= 0 ? 0 : interesR;
                    boolean existeC = model.existeConcepto(idc, cartera.getId_cartera());
                    String fecha_hoy = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
                    /*Descuento*/
                    cnf_des = getCnf_des(model, 1, idc, fecha_hoy);
                    if (cnf_des != null) {
                        boolean ws = false;
                        if (Permitidas.isEmpty()) {
                            for (int i = Integer.parseInt(cnf_des.getVig_inicial()); i <= Integer.parseInt(cnf_des.getVig_final()); i++) {
                                Permitidas.add(i + "");
                            }
                        }

                        if (!Permitidas.contains(cartera.getReferencia())) {
                            //null
                        } else {
                            int interesD = (int) ((interesR * cnf_des.getPorcentaje()) / 100);
                            descuento = -interesD;

                            if (!model.existeConcepto((int) cnf_des.getFk_concepto_desc(), cartera.getId_cartera())) {
                                Detalle_Cartera dc = new Detalle_Cartera();
                                dc.setEstado(1);
                                dc.setFecha(cartera.getFecha_creacion());
                                dc.setFecha_sistema(new java.sql.Timestamp(new java.util.Date().getTime()));
                                dc.setFk_cartera(cartera.getId_cartera());
                                dc.setFk_concepto(cnf_des.getFk_concepto_desc());
                                dc.setFk_usuario(usuario.getId_usuario());
                                dc.setReferencia(cartera.getReferencia());
                                dc.setValor(-interesD);
                                model.adicionarDetalleCartera(dc);
                            } else {
                                model.actualizarDetalleCartera(cartera.getId_cartera(), 1, idc, (double) -interesD);
                            }//Else
                            ws = true;
                        }//Else
                    } else {
                        model.eliminarDescuentoInternacionDC(cartera.getId_cartera(), cartera.getReferencia(), 1093);
                    }//else
                    java.text.SimpleDateFormat formato = new java.text.SimpleDateFormat("dd/MM/yyyy");
                    String fechaInicio2 = formato.format(fechaInicio);
                    System.out.println("Fecha inicio= " + fechaInicio2);
                    String fechaActual2 = formato.format(fechaActual);
                    System.out.println("Fecha Actual= " + fechaActual2);
                    if (!fechaInicio2.equals(fechaActual2) || fechaInicio.after(fechaActual)) {
                        if (!existeC) {
                            if (interesR > 0) {
                                Detalle_Cartera dc = new Detalle_Cartera();
                                dc.setEstado(1);
                                dc.setFecha(cartera.getFecha_creacion());
                                dc.setFecha_sistema(new java.sql.Timestamp(new java.util.Date().getTime()));
                                dc.setFk_cartera(cartera.getId_cartera());
                                dc.setFk_concepto(idc);
                                dc.setFk_usuario(usuario.getId_usuario());
                                dc.setReferencia(cartera.getReferencia());
                                dc.setValor(interesR);
                                model.adicionarDetalleCartera(dc);
                            }
                        } else {
                            model.actualizarDetalleCartera(cartera.getId_cartera(), 1, idc, (double) interesR);
                        }

                        if (interesR >= 0) {
                            idc = cartera.getTipo() == 1 ? 302 : cartera.getTipo() == 2 ? 276 : 303;
                            interes = Float.parseFloat(model.consultarPorcentajeCostas(cartera.getEstado_vigencia(), cartera.getFk_concepto()));
                            valorReal = model.valorDetalleCarteraAtributos(cartera.getId_cartera(), cartera.getFk_sede(), 4);
                            float costas = (float) ((valorReal + descuento) * interes);
                            int costasR = Math.round(costas);
                            costasR = costasR < 0 ? 0 : costasR;
                            costasR = interesR == 0 ? 0 : costasR;
                            existeC = model.existeConcepto(idc, cartera.getId_cartera());
                            if (!existeC) {
                                if (costasR > 0) {
                                    Detalle_Cartera dc = new Detalle_Cartera();
                                    dc.setEstado(1);
                                    dc.setFecha(cartera.getFecha_creacion());
                                    dc.setFecha_sistema(new java.sql.Timestamp(new java.util.Date().getTime()));
                                    dc.setFk_cartera(cartera.getId_cartera());
                                    dc.setFk_concepto(idc);
                                    dc.setFk_usuario(usuario.getId_usuario());
                                    dc.setReferencia(cartera.getReferencia());
                                    float iva = ((costasR * 19) / 100);
                                    System.out.println("Iva :" + iva);
                                    costasR += iva;
                                    dc.setValor(costasR);
                                    model.adicionarDetalleCartera(dc);
                                }
                            } else {
                                float iva = ((costasR * 19) / 100);
                                System.out.println("Iva :" + iva);
                                costasR += iva;
                                model.actualizarDetalleCartera(cartera.getId_cartera(), 1, idc, (double) costasR);
                            }
                        }
                        model.actualizarValoresCartera(cartera.getId_cartera());
                        model.getCon().commit();
                    }
                }//while
                return true;
            } catch (Exception e) {
                System.out.println("Exception");
                e.printStackTrace();
                model.getCon().rollback();
                return false;
            } finally {
                if (pst != null) {
                    pst = null;
                }
                if (rst != null) {
                    rst = null;
                }
            }
        } catch (SQLException e) {
            System.out.println("SqlException");
            model.getCon().rollback();
            e.printStackTrace();
            return false;
        }
    }

    /**
     * @return the tipo
     */
    public long getTipo() {
        return tipo;
    }

    /**
     * @param tipo the tipo to set
     */
    public void setTipo(long tipo) {
        this.tipo = tipo;
    }

    /**
     * @return the id_concepto
     */
    public long getId_concepto() {
        return id_concepto;
    }

    /**
     * @param id_concepto the id_concepto to set
     */
    public void setId_concepto(long id_concepto) {
        this.id_concepto = id_concepto;
    }

    /**
     * @return the fk_concepto_desc
     */
    public long getFk_concepto_desc() {
        return fk_concepto_desc;
    }

    /**
     * @param fk_concepto_desc the fk_concepto_desc to set
     */
    public void setFk_concepto_desc(long fk_concepto_desc) {
        this.fk_concepto_desc = fk_concepto_desc;
    }

    /**
     * @return the usuairo
     */
    public long getUsuairo() {
        return usuairo;
    }

    /**
     * @param usuairo the usuairo to set
     */
    public void setUsuairo(long usuairo) {
        this.usuairo = usuairo;
    }

    /**
     * @return the porcentaje
     */
    public long getPorcentaje() {
        return porcentaje;
    }

    /**
     * @param porcentaje the porcentaje to set
     */
    public void setPorcentaje(long porcentaje) {
        this.porcentaje = porcentaje;
    }

    /**
     * @return the id
     */
    public long getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(long id) {
        this.id = id;
    }

    /**
     * @return the Vig_inicial
     */
    public String getVig_inicial() {
        return Vig_inicial;
    }

    /**
     * @param Vig_inicial the Vig_inicial to set
     */
    public void setVig_inicial(String Vig_inicial) {
        this.Vig_inicial = Vig_inicial;
    }

    /**
     * @return the Vig_final
     */
    public String getVig_final() {
        return Vig_final;
    }

    /**
     * @param Vig_final the Vig_final to set
     */
    public void setVig_final(String Vig_final) {
        this.Vig_final = Vig_final;
    }

    /**
     * @return the descripcion
     */
    public String getDescripcion() {
        return descripcion;
    }

    /**
     * @param descripcion the descripcion to set
     */
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    /**
     * @return the f_desde
     */
    public Date getF_desde() {
        return f_desde;
    }

    /**
     * @param f_desde the f_desde to set
     */
    public void setF_desde(Date f_desde) {
        this.f_desde = f_desde;
    }

    /**
     * @return the f_hasta
     */
    public Date getF_hasta() {
        return f_hasta;
    }

    /**
     * @param f_hasta the f_hasta to set
     */
    public void setF_hasta(Date f_hasta) {
        this.f_hasta = f_hasta;
    }

    /**
     * @return the f_proceso
     */
    public Date getF_proceso() {
        return f_proceso;
    }

    /**
     * @param f_proceso the f_proceso to set
     */
    public void setF_proceso(Date f_proceso) {
        this.f_proceso = f_proceso;
    }

    /**
     * @return the cnf_des
     */
    /**
     * @param cnf_des the cnf_des to set
     */
    public void setCnf_des(Conf_Descuento cnf_des) {
        this.cnf_des = cnf_des;
    }

}
