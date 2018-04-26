<%--
    Document   : procesarExcedente
    Created on : 15/01/2013, 10:59:38 AM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
Model modelo = (Model)session.getAttribute("model");
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("recibosExcedente.jsp")){
                    
                Usuario usuario = (Usuario)session.getAttribute("usuario");
                modelo.getCon().setAutoCommit(false);

                if(request.getParameter("concep")!=null && request.getParameter("recibo")!=null && request.getParameter("reciboANT")!=null && request.getParameter("observacion")!=null ){
                String[] concep = request.getParameterValues("concep");
                long notiquete = Long.parseLong(request.getParameter("recibo"));
                long notiqueteAnt = Long.parseLong(request.getParameter("reciboANT"));
                String observacion = request.getParameter("observacion");
                
                for(int i=0;i<concep.length;i++){

                    long id_det_concepto = Long.parseLong(concep[i]);

                    Detalle_Tiquete detalle = modelo.consultarDetalleTiqueteByID(id_det_concepto);
                    Detalle_Tiquete detalleT = modelo.consultarDetalleTiqueteVAL(notiquete, detalle.getFk_concepto(), detalle.getFk_tramite());

                    java.util.List tc = modelo.consultarDetalleTiqueteConceptos(detalle.getId_det_tiquete());

                    try{
                        modelo.actualizarDetalleTiqById(id_det_concepto, 2);

                        for(int j=0;j<tc.size();j++){
                        Tiquete_Concepto t = (Tiquete_Concepto)tc.get(j);
                        Tiquete_Concepto tc1 = modelo.consultarDetTiqConceptosByIDFKConcepto(detalleT.getId_det_tiquete(), t.getFk_concepto());
                        float valor = t.getValor() - tc1.getValor();
                        valor = Math.abs(valor);
                        modelo.actualizarTiqueteConceptoByID(tc1.getId_tiqueteConcepto(), valor);
                        
                    }
                    modelo.getCon().commit();
                    }catch(Exception ex){
                    modelo.getCon().rollback();
                    System.out.println("Error: "+ex);
                    }

                }

                java.util.List listaD = modelo.listarDetalleTiqueteByTiquete(notiquete);
                
                try{

                for(int i=0;i<listaD.size();i++){
                    Detalle_Tiquete dt = (Detalle_Tiquete)listaD.get(i);
                    float valorDt = modelo.consultarValorDetTiquete(dt.getId_det_tiquete());
                    modelo.actualizarValorDetalleTiq(dt.getId_det_tiquete(), valorDt);
                }
                modelo.getCon().commit();
                }catch(Exception ex){
                    modelo.getCon().rollback();
                    System.out.println("Error: "+ex);
                }

                float valorT = modelo.consultarValorDetTiqueteByTiquete(notiquete);
                modelo.actualizarValorTiquete(notiquete, valorT);
                modelo.actualizarValorPago(notiquete, valorT);
                if(observacion!=null){
                modelo.adicionarReciboExcedente(notiqueteAnt, notiquete, usuario.getId_usuario(), observacion);
                }else{
                observacion = "Excedente Recibo";
                modelo.adicionarReciboExcedente(notiqueteAnt, notiquete, usuario.getId_usuario(), observacion);
                }
                modelo.getCon().commit();

                %><script>alert("Proceso realizado Exitosamente")</script><%

                }else{System.out.println("No encontro parametro");
                }

                }else{ %>
			   <jsp:forward page="no_access.jsp">
				 <jsp:param name="tipo" value="1"></jsp:param>
			   </jsp:forward>
	<%  }
	}else{ %>
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){
modelo.getCon().rollback();
mexe.printStackTrace();
%>

    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
