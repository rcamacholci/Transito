<%-- 
    Document   : procesarArchivosPlanos
    Created on : 25/03/2011, 05:46:34 PM
    Author     : Administrador
--%>

<%
    try{
        modelo.Model model = (modelo.Model)session.getAttribute("model");
        modelo.Usuario usuario=(modelo.Usuario)session.getAttribute("usuario");
    	if(model!=null){
            if(true||((java.util.LinkedList)session.getAttribute("permisosU")).contains("generarArchivosPlanos.jsp")) {
                procesos.procesoContravencional procesoContravencional = new procesos.procesoContravencional();
                int est = Integer.parseInt(request.getParameter("estado"));
                boolean respuesta = procesoContravencional.generarPlanos(model, usuario, est);
                if(respuesta){ %>
                    <script language="javascript" type="text/javascript">
                        if(confirm("El comparendo ha sido ingresado exitosamente, desea ver los detalles?")){
                            window.parent.document.location.href = "consultarComparendo.jsp?id=0&comparendo=<%=request.getParameter("comparendo")%>";
                        }else{
                            window.parent.document.location.href = "adicionarComparendo.jsp";
                        }
                    </script>
        <%      }else{  %>
                    <script language="javascript" type="text/javascript">
                        alert("<%=procesoContravencional.getMsg()%>");
                    </script>
        <%      }
            }
        }
    }catch(Exception exe){ %>
        <jsp:forward page="no_access.jsp">
            <jsp:param name="tipo" value="2"></jsp:param>
            <jsp:param name="msgError" value="<%=exe.getMessage()%>"></jsp:param>
        </jsp:forward>
<%  } %>