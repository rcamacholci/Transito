<%-- 
    Document   : procesarHorarioCurso
    Created on : 30/05/2011, 04:46:09 PM
    Author     : Administrador
--%>

<%
    try{
        modelo.Model model = (modelo.Model)session.getAttribute("model");
        modelo.Usuario usuario=(modelo.Usuario)session.getAttribute("usuario");
    	if(model!=null){
            if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("adicionarHorarioCurso.jsp")){
                procesos.procesoContravencional procesoContravencional = new procesos.procesoContravencional();
                boolean respuesta = procesoContravencional.adicionarHorarioCurso(model, usuario, request);
                if(respuesta){ %>
                    <script language="javascript" type="text/javascript">
                        window.parent.document.location.href = "consultarHorariosCursos.jsp";
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
