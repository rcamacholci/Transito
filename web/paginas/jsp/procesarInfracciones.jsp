<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelo.*"%>
<%

try{
      System.out.println("ENTRO TRY 1");
   	if(session.getAttribute("model")!=null){
              System.out.println("ENTRO IF 1");
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("infracciones.jsp")){
                        Model modelo= (Model)session.getAttribute("model");
                        Sede sede = (Sede)session.getAttribute("sede");

                        System.out.println("ENTRO IF 2");
             try{
             System.out.println("ENTRO TRY 2");
        modelo.getCon().setAutoCommit(false);
        String infraccionN = (request.getParameter("infraccionN")).toUpperCase();
        long valor = Long.parseLong(request.getParameter("valor"));
        String descripcion = request.getParameter("descripcion");
        int salarios = Integer.parseInt(request.getParameter("salarios"));
        java.sql.Date  fecha = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha")).getTime());

        if(!infraccionN.equals("")&&valor!=0&&!descripcion.equals("")&&salarios!=0&&fecha!=null){
              System.out.println("ENTRO IF 3");
            Infraccion infracc = modelo.consultarInfraccionByNumero(infraccionN.toUpperCase());
                if(infracc!=null){
                 System.out.println("ENTRO ELSE 1");
                 %>
                    <script language="javascript" type="text/javascript">
                        alert("Infraccion Ya esta Registrada");
                          document.location.href = "infracciones.jsp";
                    </script>
            <%  }else{
                 System.out.println("ENTRO IF 4");
                    Infraccion infraccionNueva = new Infraccion();
                    Valor_Infraccion valorI = new Valor_Infraccion();
                    infraccionNueva.setDescripcion(descripcion);
                    infraccionNueva.setFk_ley(1);
                    infraccionNueva.setNumero(infraccionN.toUpperCase());
                    infraccionNueva.setTipo(2);
                    infraccionNueva.setFk_sede(sede.getId_sede());
                    infraccionNueva.setSalarios_minimos(salarios);
                    infraccionNueva.setFecha_ini(fecha);
                    long id_infraccion = modelo.adicionarInfraccion(infraccionNueva);
                    if(id_infraccion!=0){
                         System.out.println("ENTRO IF 5");
                        valorI.setFk_infraccion(id_infraccion);
                        valorI.setPorcentaje(100);
                        valorI.setValor((float)valor);
                        valorI.setFecha_ini(fecha);
                        modelo.adicionarValorInfraccion(valorI);
                        modelo.getCon().commit();
            %>
                        <script language="javascript" type="text/javascript">
                            alert("Registro Exitoso");
                             document.location.href = "infracciones.jsp";
                        </script>
                <%
                    }else{
                        %>
        <script language="javascript" type="text/javascript">
            alert("Infraccion no Pudo ser Ingresada");
            document.location.href = "infracciones.jsp";
        </script>
     <%             }
                }
        }else{ %>
        <script language="javascript" type="text/javascript">
            alert("Infraccion no Pudo ser Ingresada");
            document.location.href = "infracciones.jsp";
        </script>
     <% }
         %>

<%  }catch(Exception ecx){
        modelo.getCon().rollback();
        ecx.printStackTrace();        %>
        <script language="javascript" type="text/javascript">
			 alert("Infraccion no Pudo ser Ingresada");
			 document.location.href = "infracciones.jsp";
		</script>
<%  }
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
mexe.printStackTrace();
%>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
