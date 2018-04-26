
<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<% Model modelo = (Model) session.getAttribute("model");
            try {

                if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("activarPago")) {
                    Usuario usuario = (Usuario) session.getAttribute("usuario");
                    if (request.getParameter("id_tiquete") != null && request.getParameter("observacion") != null) {
                        long idTiq = Long.parseLong(request.getParameter("id_tiquete"));
                        String observacion = request.getParameter("observacion");
                        Tiquete tiq = modelo.consultarTiquetePorID(Long.parseLong(request.getParameter("id_tiquete")));
                        if (tiq != null) {
                            if (tiq.getEstado() == 3) {
                                java.util.List listD = modelo.consultarDetalleTiquete(tiq.getId_tiquete());
                                boolean sw = false;

                                for (int i = 0; i < listD.size(); i++) {
                                    Detalle_Tiquete dt = (Detalle_Tiquete)listD.get(i);
                                    if(dt.getFk_tramite()!=0){
                                        sw = true;
                                        break;
                                    }
                                }
                                if(sw){
                                Pago pago = modelo.consultarPagoByTiquete(tiq.getId_tiquete());
                                if (pago != null) {
                                    if (pago.getEstado() == 3) {

                                        try{

                                        modelo.getCon().setAutoCommit(false);
                                        boolean formulario = modelo.consultarPagoFormulario(pago.getId_pago());
                                        boolean formularioL = modelo.consultarPagoFormularioLicencia(pago.getId_pago());
                                        if (!formulario && !formularioL ) {

                                            ActivacionPagos actP = new ActivacionPagos();
                                            actP.setFk_pago(pago.getId_pago());
                                            actP.setFk_usuario(usuario.getId_usuario());
                                            actP.setObservacion(observacion);

                                            modelo.insertarActivacionPago(actP);

                                            modelo.actualizarDetalleById_Tiquete(idTiq, 1);
                                            modelo.getCon().commit();
                                            %><script>alert("Pago Activado correctamente");</script><%
                                        }else{
                                            %><script>alert("El pago se encuentra utilizado en un tramite activo");</script><%
                                        }
                                        
                                        }catch(Exception ex){
                                            System.out.println("Error al Activar el pago: ");
                                            ex.printStackTrace();
                                            %><script>alert("Error al Activar pago");</script><%
                                        }
                                    }
                                }
                                }else{
                                    %><script>alert("El pago no corresponde a un tramite Activo");</script><%
                                }
                            }
             } else {
%><script>alert("Pago no Existe");
</script><%               }


} else {
%><script>alert("ERROR EN EL PROCESO");
</script><%            }

%>

<%  } else {%>

<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%    }
} catch (Exception mexe) {
    modelo.getCon().rollback();
    mexe.printStackTrace();%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
            }%>