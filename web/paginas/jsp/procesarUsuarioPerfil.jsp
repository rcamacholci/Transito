<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" errorPage="" %>
<%


Model modelo= (Model)session.getAttribute("model");

             modelo.getCon().setAutoCommit(false);
             if((request.getParameter("id_usuario")!=null)&&(request.getParameterValues("perfiles")!=null)){
             long idUsuario = Long.parseLong(request.getParameter("id_usuario"));
            
             String[] perfiles = request.getParameterValues("perfiles");

               if(perfiles!=null){
               modelo.EliminarPerfilesUsuario(idUsuario);
                    for(int i=0; i<perfiles.length;i++){
                        modelo.adicionarPerfilUsuario(idUsuario,Long.parseLong(perfiles[i]));
                        modelo.adicionarPerfilUsuario2(idUsuario,Long.parseLong(perfiles[i]));
                    }
                }
                modelo.getCon().commit();
                %>
                <script>
                    alert("  El Usuario se Actualizo Correctamente...");
                    window.location.href="verUsuarios.jsp";
                </script>
         <%
         }else{
                 %>
                <script>
                    alert("  El Usuario No Pudo ser Actualizado");
                    window.location.href="verUsuarios.jsp";
                </script>

<%
         }
       
    
 %>

