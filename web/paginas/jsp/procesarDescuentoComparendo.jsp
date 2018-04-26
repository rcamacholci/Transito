<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="modelo.*"%>
<html>
   <head>
        <title>Procesar&nbsp;Liquidacion</title>
   </head>
   <body>
   <%

    Model model= (Model)session.getAttribute("model");
    Usuario usuario=(Usuario)session.getAttribute("usuario");

    try{


        java.sql.Date fecha = new java.sql.Date(new java.util.Date().getTime());

        if(request.getParameter("id_comparendo")!=null){

            long idComparendo = Long.parseLong(request.getParameter("id_comparendo"));
            Comparendo comparendo = model.consultarComparendoById(idComparendo);
            if(comparendo!=null){
                Liquidacion_Cia liquidacion = model.consultarLiquidacionCIA(comparendo.getId_comparendo(),comparendo.getFk_persona());
                if(liquidacion!=null){
                    if(liquidacion.getEstado()==2){
                        model.getCon().setAutoCommit(false);
                        Comparendo_Curso comparendoCurso = new Comparendo_Curso();
                        comparendoCurso.setFk_persona(comparendo.getFk_persona());
                        comparendoCurso.setFk_comparendo(comparendo.getId_comparendo());
                        comparendoCurso.setCertificado(Integer.parseInt(request.getParameter("certificado")));
                        comparendoCurso.setLugar(Integer.parseInt(request.getParameter("lugar")));
                        comparendoCurso.setValor(liquidacion.getValor());
                        comparendoCurso.setFecha(fecha);
                        comparendoCurso.setEstado(1);

                        float descuento = 0;
                        java.util.Date fechaLimite = new java.text.SimpleDateFormat("dd/MM/yyyy").parse("15/03/2010");
                        if(fechaLimite.getTime()>comparendo.getFecha().getTime()){
                            descuento = (float)0.5;
                        }else{
                            int dias = model.consultarDiasHabiles(new java.sql.Date(comparendo.getFecha().getTime()));
                            if(dias <= 5){
                                descuento = (float)0.5;
                            }else{
                                if(dias < 21){
                                    descuento = (float)0.25;
                                }
                            }
                        }
                        comparendoCurso.setDescuento((int)(descuento*100.0));
                        model.adicionarComparendoCurso(comparendoCurso);

                        Cartera cartera = model.consultarCartera(comparendo.getFk_cartera());
                        java.util.List listaD = model.listarDetalleCarteraAtributo(cartera.getId_cartera(),usuario.getFk_sede(),6);
                        for(int i=0;i<listaD.size();i++){
                            Detalle_Cartera detalleC = (Detalle_Cartera)listaD.get(i);
                            if(detalleC.getEstado()==1){
                                float totalDescuento = detalleC.getValor()*(float)((1.0-descuento));
                                    if(comparendo.getPolca()==1){
                                        if(detalleC.getFk_concepto()==73){
                                            totalDescuento = Math.round(totalDescuento-(liquidacion.getValor()*0.85));
                                            model.actualizarValorDetalleCartera(detalleC.getId_detalle_cartera(), 1,totalDescuento);
                                        }else{
                                            if(detalleC.getFk_concepto()==12){
                                            totalDescuento = Math.round(totalDescuento-(liquidacion.getValor()*0.15));
                                            model.actualizarValorDetalleCartera(detalleC.getId_detalle_cartera(), 1,totalDescuento);
                                            }
                                        }
                                }else{
                                     if(detalleC.getFk_concepto()==12){
                                            totalDescuento = Math.round(totalDescuento-(liquidacion.getValor()*0.9));
                                            model.actualizarValorDetalleCartera(detalleC.getId_detalle_cartera(), 1,totalDescuento);
                                        }else{
                                            totalDescuento = Math.round(totalDescuento-(liquidacion.getValor()*0.1));
                                            model.actualizarValorDetalleCartera(detalleC.getId_detalle_cartera(), 1,totalDescuento);
                                        }
                                }
                            }
                        }

                        Detalle_Cartera detalle=new Detalle_Cartera();
                        detalle.setFk_cartera(cartera.getId_cartera());
                        detalle.setFk_concepto(328);
                        detalle.setReferencia(comparendo.getNumero());
                        detalle.setFecha(fecha);
                        detalle.setFecha_sistema(new java.sql.Timestamp(fecha.getTime()));
                        detalle.setFk_usuario(usuario.getId_usuario());
                        detalle.setEstado(2);
                        detalle.setValor(Math.round((cartera.getValor()*descuento+liquidacion.getValor())*-1));
                        model.adicionarDetalleCartera(detalle);
                        //***************//
                        java.sql.Timestamp fechaSystem = new java.sql.Timestamp(new java.util.Date().getTime());
                        //***//
                        long estado=2;
                        model.UpdateAditoriaComparendo(fechaSystem, comparendoCurso.getFk_comparendo());
                        //***//
                        auditoria_comparendo aud = new auditoria_comparendo();
                       // System.out.println("ok vamos hace esto ->"+comp.getNumero());
                        aud.setFk_comparendo(comparendoCurso.getFk_comparendo());
                        aud.setFk_estado(1);
                        aud.setFecha_proceso(fechaSystem);
                        aud.setUsuario(usuario.getId_usuario());
                        aud.setEstado(estado);
                        aud.setFecha_inicio(fechaSystem);
                        aud.setFecha_fin(null);
                        model.InsertAuditoriaComparendo(aud);
                       //***************//

                        model.actualizarValoresCartera(cartera.getId_cartera());


                        model.getCon().commit();
                        %>
                        <script language="javascript"  type="text/javascript">
                              alert("El descuento se ha efectuado correctamente");
                              document.location.href= "formularioDescuentoComparendo.jsp?id=1";
                        </script>
                        <%
                     }
                }
            }
        }
    }catch(Exception exc){
        exc.printStackTrace();
        model.getCon().rollback();%>
        <script language="javascript"  type="text/javascript">
               alert("No se pudo efectuar el descuento");
               document.location.href= "formularioDescuentoComparendo.jsp?id=1";
        </script>
<% } %>
    </body>
</html>
