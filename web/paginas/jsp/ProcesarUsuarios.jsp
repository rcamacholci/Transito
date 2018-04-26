
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" errorPage="" import="java.text.SimpleDateFormat"%>
<%

            Model modelo= (Model)session.getAttribute("model");

             java.sql.Date fechaUpdate = null;
             modelo.getCon().setAutoCommit(false);
             java.util.List<Usuario> usu = null;
             usu  = modelo.ListarUsuario();
             String fecha=request.getParameter("fecha");
             Usuario info = null;
            if((request.getParameterValues("Fusuario")!=null)){
                 String[] perfiles = request.getParameterValues("Fusuario");
                int f09[]= new int[1000];
                
               if(perfiles!=null){
                 for(int i=0; i<perfiles.length;i++){
                   for(int j=0;j<usu.size();j++){
                    info = usu.get(j);
                    long ln =Long.parseLong(perfiles[i]);
                    if(info.getId_usuario()== Long.parseLong(perfiles[i])){
                        long fk = info.getId_usuario();
                                fechaUpdate = null;
                                modelo.HabilitarUsuarios(fechaUpdate,fk); 
                        f09[j]=1;
                          }else{
                            if(f09[j]!=1){
                                f09[j]=0;
                            }//if
                          }//if
                       }//NEXT
                      }//NEXTT
                for(int j=0;j<usu.size();j++){
                            info =usu.get(j);
                             if(f09[j]==0 && info.getFechaFin()==null){
                                long fk = info.getId_usuario();
                                fechaUpdate = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fecha).getTime());
                                modelo.HabilitarUsuarios(fechaUpdate,fk);
                             }
                          }
                }//ENDIF
                modelo.getCon().commit();
                %>
                <script>
                    alert(" Los Usuarios se Actualizon Correctamente...");
                    window.location.href="AdministrarUsuario.jsp";
                </script>
         <%
         }else{
         %>
                <script>
                    alert("  Los Usuarios No Puden ser Actualizados");
                    window.location.href="AdministrarUsuario.jsp";
                </script>
<%}%>
