
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"
         import="modelo.Concepto" import="java.util.LinkedList"  import="java.util.HashMap" import = "modelo.Entidad_Distribucion" 
		 import = "modelo.Configuracion_distribucion" errorPage="" %>
                  
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                        Model modelo = (Model) session.getAttribute("model");
    try{
            modelo.getCon().setAutoCommit(false);
            java.util.HashMap lista = (java.util.HashMap)session.getAttribute("confDistribucion");
            java.util.Iterator ite = lista.keySet().iterator();
            while(ite.hasNext()){
                    Object elem = ite.next();
                    java.util.StringTokenizer st = new java.util.StringTokenizer(elem.toString(),"|");
                    while(st.hasMoreTokens()){
                            long sede = Long.parseLong(st.nextToken());
                            long concepto = Long.parseLong(st.nextToken());
                            long entidad = Long.parseLong(st.nextToken());
                            float valor = Float.parseFloat(lista.get(elem).toString());

                            Configuracion_distribucion conf_dist = new Configuracion_distribucion () ;
                            conf_dist.setFk_sede(sede) ;
                            conf_dist.setFk_entidad_distribucion(entidad) ;
                            conf_dist.setFk_concepto(concepto) ;
                            conf_dist.setPorcentaje(valor) ;
                            conf_dist.setFecha_ini(new java.sql.Date(new java.util.Date().getTime()));
                            float porcentaje_ant = modelo.getPorcentaje_distribucion(sede, conf_dist.getFk_concepto(),conf_dist.getFk_entidad_distribucion());
                            if(porcentaje_ant!=conf_dist.getPorcentaje()){
                                modelo.finalizar_configuracion_distribucion(sede, conf_dist.getFk_concepto(),conf_dist.getFk_entidad_distribucion());
                                modelo.adicionar_configuracion_distribucion(conf_dist) ;
                            }
                    }
            }
            modelo.getCon().commit();  %>
            <script>
                alert("La configuracion ha sido guardada..");
                document.location.href = "configuracion_distribucion.jsp?sec=0";
            </script>
<%        }catch(Exception exc){
            modelo.getCon().rollback();  %>
            <script>
                alert("No se pudo guardar la configuracion");
                document.location.href = "configuracion_distribucion.jsp?sec=0";
            </script>
<%        }   %>
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
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>