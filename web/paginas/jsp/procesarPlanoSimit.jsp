<%@ page import="java.util.*,java.io.*"%>  
<%
    try{
        modelo.Model model = (modelo.Model)session.getAttribute("model");
        modelo.Usuario usuario=(modelo.Usuario)session.getAttribute("usuario");
    	if(model!=null){
            if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("generarPlanoComparendos.jsp")){
                procesos.procesoContravencional procesoContravencional = new procesos.procesoContravencional();
                procesoContravencional.generarPlanos(model, usuario, 1);
                             
                %>
                <script language="javascript" type="text/javascript">
                        document.location.href = "../<%=procesoContravencional.getArchivoSimit().substring(39,procesoContravencional.getArchivoSimit().length())%>";
                </script>
     <%
           //response.setHeader("Content-Disposition", "attachment; filename= "+ procesoContravencional.getArchivoSimit().substring(71,procesoContravencional.getArchivoSimit().length())+"");

     try{
            
            String nFile = ""+procesoContravencional.getArchivoSimit()+"".trim();
            File file = new File(nFile);
            FileInputStream archivo = new FileInputStream(file);
            int longitud = archivo.available();
            byte[] datos = new byte[longitud];
            archivo.read(datos);
            archivo.close();

            // response.setContentType("application/octet-stream");
            response.setContentType("application/msword");
            response.setHeader("Content-Disposition","attachment;filename= "+ procesoContravencional.getArchivoSimit().substring(71,procesoContravencional.getArchivoSimit().length())+"");

            ServletOutputStream ouputStream = response.getOutputStream();
            ouputStream.write(datos);
            ouputStream.flush();
            ouputStream.close();

     }catch(Exception e){
            e.printStackTrace();
            }

  }
            
        }
    }catch(Exception exe){ %>
        <jsp:forward page="no_access.jsp">
            <jsp:param name="tipo" value="2"></jsp:param>
            <jsp:param name="msgError" value="<%=exe.getMessage()%>"></jsp:param>
        </jsp:forward>
<%  } %>