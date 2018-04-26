<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*"  import="modelo.Parametro"  errorPage="" %>

<%
Usuario usuario = (Usuario)session.getAttribute("usuario");
Model modelo = (Model)session.getAttribute("model");
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("InteresesComparendos.jsp")){
                int dias = 0;
                modelo.getCon().setAutoCommit(false);

                    if(request.getParameter("comparendo")!=null){
                        Comparendo comp = modelo.consultar_Comparendo(request.getParameter("comparendo"));

                         float descuento = 0;
                         
                                java.util.Date fechaLimite = new java.text.SimpleDateFormat("dd/MM/yyyy").parse("15/03/2010");
                         if(fechaLimite.getTime()>comp.getFecha().getTime()){
                                descuento = (float)0.5;
                         }else{
                                dias = modelo.consultarDiasHabiles(new java.sql.Date(comp.getFecha().getTime()));
                         }

                        if(comp!=null){
                             if(dias > 30){

                            if(comp.getEstado()==1){
                            if(request.getParameter("intereses")!=null&&request.getParameter("vradicional")!=null){
                                long costas = Long.parseLong(request.getParameter("vradicional"));
                                long intereses = Long.parseLong(request.getParameter("intereses"));
                                String fk_cartera = ""+comp.getFk_cartera()+"".trim();
                                int conc = 0;

                                    if(fk_cartera!=null){
                                        java.util.List dt = modelo.consultarDetalleCarteraIntComp(comp.getFk_cartera());
                                        Detalle_Cartera dtca = (Detalle_Cartera)dt.get(1);
                                        for(int i= 0 ;i<dt.size();i++){
                                        Detalle_Cartera dtc = (Detalle_Cartera)dt.get(i);
                                            if(dtc.getFk_concepto()==307||dtc.getFk_concepto()==318){
                                                conc = 1;
                                            }
                                            System.out.println("detalle_cartera: "+dtc.getFk_concepto());
                                        }

                                        if(conc==0){

                                        try{
                                        modelo.agregardetCateraInteresesComp(dtca.getFk_cartera(), (long)307, comp.getNumero(), dtca.getFecha(), usuario.getId_usuario() ,1, costas);
                                        modelo.agregardetCateraInteresesComp(dtca.getFk_cartera(), (long)318, comp.getNumero(), dtca.getFecha(), usuario.getId_usuario() ,1, intereses);
                                        modelo.getCon().commit();
                                        }catch(Exception ex){
                                        modelo.getCon().rollback();
                                        }
                                        modelo.actualizarCateraInteresesComp(comp.getFk_cartera());
                                        modelo.getCon().commit();

                                        %>
                                        <script>
                                            alert("Se cargaron los intereses y las costas correctamente");
                                            window.document.location.href = "InteresesComparendos.jsp";
                                        </script>
<%

                                        }else{
                                        %>
                                         <script>
                                            alert("El comparendo ya posee intereses");
                                            window.document.location.href = "InteresesComparendos.jsp";
                                        </script>

<%
                                        }
                                    }
                            }else{
                            modelo.getCon().rollback();
                            }
                          }else{
                             %>
                        <script>
                        alert("El comparendo no se encuentra activo");
			window.document.location.href = "InteresesComparendos.jsp";
                        </script>
                        <%
                          }
                            }else{
                             %>
                        <script>
                        alert("El comparendo posee descuentos activos");
			window.document.location.href = "InteresesComparendos.jsp";
                        </script>
                        <%
                            }
                        }else{
                        %>
                        <script>
                        alert("El comparendo no existe");
			window.document.location.href = "InteresesComparendos.jsp";
                        </script>
                        <%
                        }
                    }

%>


<%  }else{ %>
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