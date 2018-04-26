<%-- 
    Document   : procesarLiquidacionCiaExterno
    Created on : 4/08/2011, 01:54:07 PM
    Author     : Administrador
--%>

<%
    try{
        modelo.Model model = (modelo.Model)session.getAttribute("model");
        modelo.Usuario usuario=(modelo.Usuario)session.getAttribute("usuario");
    	if(model!=null){
            if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("generarLiquidacionCiaExterno.jsp")){
                procesos.procesoContravencional procesoContravencional = new procesos.procesoContravencional();
                boolean respuesta = procesoContravencional.generarLiquidacionCiaExterno(model, usuario, request);
                if(respuesta){ %>
                    <script language="javascript" type="text/javascript">
                        alert("La liquidacion ha sido ingresada exitosamente.");
                        window.parent.document.location.href = "generarLiquidacionCiaExterno.jsp";
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