<%
    try{
        modelo.Model model = (modelo.Model)session.getAttribute("model");
        modelo.Usuario usuario=(modelo.Usuario)session.getAttribute("usuario");
    	if(model!=null){
            if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("aplicarReciboExcedente.jsp")){
                procesos.AplicarExcedenteRecibo Rexcedente = new procesos.AplicarExcedenteRecibo();
                java.util.List listadoConceptos = new java.util.LinkedList();
                String[] conceptos = request.getParameterValues("valor1");

                for(int i=0;i<conceptos.length;i++){
                    listadoConceptos.add(conceptos[i]);
                }

                boolean respuesta = Rexcedente.AplicarExcedente(model, usuario, request, listadoConceptos);
                if(respuesta){ %>
                    <script language="javascript" type="text/javascript">
                        alert("El Excedente ha sido aplicado exitosamente...! Valor Recibo: "+'<%=Rexcedente.getMsg() %>')
                        parent.document.location.href = "aplicarReciboExcedente.jsp";
                    </script>
        <%      }else{  %>
                    <script language="javascript" type="text/javascript">
                        alert("<%=Rexcedente.getMsg()%>");
                    </script>
        <%      }
            }
        }
    }catch(Exception exe){
        exe.printStackTrace();
%>
        <jsp:forward page="no_access.jsp">
            <jsp:param name="tipo" value="2"></jsp:param>
            <jsp:param name="msgError" value="<%=exe.getMessage()%>"></jsp:param>
        </jsp:forward>
<%  } %>