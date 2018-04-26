<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" errorPage="" %>
<%
            Model modelo = (Model)session.getAttribute("model");
            java.sql.Date fechaUpdate = null;

             modelo.getCon().setAutoCommit(false);
            java.util.List<UsuarioRunt> usuariosToken = null;
            usuariosToken  = modelo.verificarUsuariosToken();
                String fecha="";
                UsuarioRunt info = null;
            if((request.getParameterValues("Ftoken")!=null)){
                 String[] perfiles = request.getParameterValues("Ftoken");
                int f09[]= new int[1000];
               if(perfiles!=null){
                 for(int i=0; i<perfiles.length;i++){
                   for(int j=0;j<usuariosToken.size();j++){
                    info =usuariosToken.get(j);
                    long ln =Long.parseLong(perfiles[i]);
                    if(info.getFk_usuario()== Long.parseLong(perfiles[i])){
                        fecha=info.getFecha_ini().toString();
                        fecha=fecha.substring(8,10)+"/"+fecha.substring(5,7)+"/2010";
                        System.out.println(fecha+"---"+info.getFk_usuario());
                        long fk = info.getFk_usuario();
                        fechaUpdate = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fecha).getTime());
                        modelo.actualizarusuruntfecha(fechaUpdate,fk);
                        f09[j]=1;
                          }else{
                            if(f09[j]!=1){
                                f09[j]=0;
                            }
                          }
                       }//NEXT
                      }//NEXTT
                 for(int j=0;j<usuariosToken.size();j++){
                            info =usuariosToken.get(j);
                             if(f09[j]==0){
                                fecha=info.getFecha_ini().toString();
                                fecha=fecha.substring(8,10)+"/"+fecha.substring(5,7)+"/2009";
                                System.out.println(fecha+"---"+info.getFk_usuario());
                                long fk = info.getFk_usuario();
                                fechaUpdate = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fecha).getTime());
                                modelo.actualizarusuruntfecha(fechaUpdate,fk);
                             }
                          }
                }//ENDIF
                modelo.getCon().commit();
                %>
                <script>
                    alert(" Los Usuarios se Actualizon Correctamente...");
                    window.location.href="validarusutoken.jsp";
                </script>
         <%
         }else{
                 %>
                <script>
                    alert("  Los Usuarios No Puden ser Actualizados");
                    window.location.href="validarusutoken.jsp";
                </script>

<%
         }


 %>
