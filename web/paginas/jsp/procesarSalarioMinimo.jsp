<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelo.*"%>
<%

try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("salariosMinimos.jsp")){
                        Model modelo= (Model)session.getAttribute("model");
    try{
        modelo.getCon().setAutoCommit(false);
        long vigencia = Long.parseLong(request.getParameter("vigencia"));
        long valor = Long.parseLong(request.getParameter("valor"));
        
        if(vigencia!=0&&valor!=0){
            java.util.List sm = modelo.consultarSalariosMinimos(1, vigencia);
                if(sm.size()>0){%>
                    <script language="javascript" type="text/javascript">
                        alert("Vigencia "+<%=vigencia%>+" Ya esta Registrada");
                          document.location.href = "salariosMinimos.jsp";
                    </script>
            <%  }else{
                    Salarios_Minimos salarioM = new Salarios_Minimos();
                    salarioM.setVigencia(vigencia);
                    salarioM.setValor(valor);
                    modelo.adicionarSalarioMinimo(salarioM);
                    modelo.getCon().commit();
                      %>
                <script language="javascript" type="text/javascript">
                    alert("Registro Exitoso");
                     document.location.href = "salariosMinimos.jsp";
                </script>
                <%
                }
        }else{ %>
        <script language="javascript" type="text/javascript">
            alert("Salario minimo no Pudo ser Ingresado");
            document.location.href = "salariosMinimos.jsp";
        </script>
     <% }
         %>

<%  }catch(Exception ecx){
        modelo.getCon().rollback();
        ecx.printStackTrace();        %>
        <script language="javascript" type="text/javascript">
			alert("Salario minimo no Pudo ser Ingresado");
			document.location.href = "salariosMinimos.jsp";
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
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
