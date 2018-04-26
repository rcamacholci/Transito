<%-- 
    Document   : ProcesarAnularPago
    Created on : 31/07/2012, 03:38:41 PM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<% Model modelo= (Model)session.getAttribute("model");
try{
        
	if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("AnularPagosCajas.jsp")){
                       
           Usuario usuario = (Usuario)session.getAttribute("usuario");
           String pagos = "";
           modelo.getCon().setAutoCommit(false);
             
             
           if(request.getParameterValues("Num_factura")!=null){
             
           String[] Num_factura = request.getParameterValues("Num_factura");
            
           for(int i=0; i<Num_factura.length;i++){
          
//Consultar Numero del pago

        long id_tiquete = 0;

        pagos = Num_factura[i].toUpperCase();
        
        java.util.List lista = modelo.consultarPagosByFactura(pagos);
        Tiquete tiquete = new Tiquete();
        
        for(int j=0;j<lista.size();j++){
           tiquete = (Tiquete)lista.get(j);
         if(tiquete!=null){
              id_tiquete = tiquete.getId_tiquete();
              
//Fin consultar Numero del pago

//Proceso de anulacion del pago

    	    Tiquete tiq = modelo.consultarTiquetePorID(id_tiquete);
            Taquilla taq = modelo.consultarTaquillaActivaByUsuario(usuario.getId_usuario());
            String observacion = "No pago";
             if(request.getParameter("anular")!=null){
                if(request.getParameter("anular").equals("1")){
                     if((tiq.getEstado()==4&&taq.getEstado()==1)||(tiq.getEstado()==4)){
                        try{
                            Pago pago = modelo.consultarPagoByTiquete(tiq.getId_tiquete());
                            if(pago!=null){
                                modelo.getCon().setAutoCommit(false);
                                java.util.List listat = modelo.consultarDetalleTiquete(tiq.getId_tiquete());
                                for(int k= 0; k < listat.size(); k++){
                                    Detalle_Tiquete dt = (Detalle_Tiquete)listat.get(k);
                                    if(dt.getFk_concepto()!=0||dt.getFk_tramite()!=0){
                                        for(int d=1;d<=dt.getCantidad();d++){
                                            modelo.actualizarEstadoDetalleTiqueteConcepto(dt.getId_det_tiquete(), 2, d);
                                            modelo.getCon().commit();
                                        }
                                    }
                                    if(dt.getFk_cartera()!=0){
                                        Cartera cartera = modelo.consultarCartera(dt.getFk_cartera());
                                        if(cartera!=null){
                                            /*Error en anulacion Aqui*/
                                   //         modelo.renovarCartera(cartera.getId_cartera(),pago.getId_pago());
                                       //     modelo.actualizarComparendo(cartera.getId_cartera(),1);
                                            modelo.eliminarPagoDetalleCartera(cartera.getId_cartera(),pago.getId_pago()+"");
                                     //       modelo.actualizarValoresCartera(cartera.getId_cartera());
                                            if(cartera.getTipo()==3){
                                         //       modelo.actualizarDetalleFinanciacion(cartera.getId_cartera(),1);
                                                boolean cuotasCanceladas = modelo.consultarCuotasCanceladas(cartera.getId_cartera());
                                                if(!cuotasCanceladas){
                                           //         modelo.actualizarComparendoFinanciacion(cartera.getId_cartera(), 1);
                                             //       modelo.actualizarFinanciacion(cartera.getId_cartera(), 1);
                                                }
                                            }
                                        }
                                    }
                                    modelo.actualizarEstadoDetalleTiquete(dt.getId_det_tiquete(), 2);
                                }
                                tiq.setEstado(4);
                                tiq.setFk_taquilla(taq.getId_taquilla());
                                tiq.setFk_usuario(usuario.getId_usuario());
                                tiq.setEstado_preliquidacion(3);
                                modelo.actualizarEstadoTiquete(tiq);
                                modelo.actualizarEstadoPago(pago.getId_pago(),5,observacion,taq.getId_taquilla(),usuario.getId_usuario());
                            //    modelo.actualizarSaldosAFavorxReferencia(1,tiq.getId_tiquete()+"");
                                modelo.getCon().commit();
                            }
                        }catch(Exception exc){
                            modelo.getCon().rollback();
                            exc.printStackTrace();
                        }
                    }
                }
            }
               
//Fin anulacion pago

            }
             }
                }
                
                %><script>alert("Preliquidaciones anulados correctamente"); window.parent.document.location.href = "AnularPagosCajas.jsp";</script><%
             }else{
                 %><script>alert("No ha seleccionado Pago a anular"); window.parent.document.location.href = "AnularPagosCajas.jsp"</script><%
             }

                %>

	<%  }else{ %>
	
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){
modelo.getCon().rollback();
mexe.printStackTrace(); %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>