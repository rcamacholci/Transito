<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" errorPage="" import="java.text.SimpleDateFormat"%>
<%

            Model modelo= (Model)session.getAttribute("model");
             java.sql.Date fechaUpdate = null;
             modelo.getCon().setAutoCommit(false);
             java.util.List<Caja> usu = null;
             usu  = modelo.listarCajas();
             String fecha=request.getParameter("fecha");
             Caja info = null;
            if((request.getParameterValues("Fusuario")!=null)){
                 String[] perfiles = request.getParameterValues("Fusuario");
                int f09[]= new int[1000];

               if(perfiles!=null){
                 for(int i=0; i<perfiles.length;i++){
                   for(int j=0;j<usu.size();j++){
                    info = usu.get(j);
                    long ln =Long.parseLong(perfiles[i]);
                    if(info.getId_caja()== Long.parseLong(perfiles[i])){
                        long fk = info.getId_caja();
                                fechaUpdate = null;
                                modelo.ActualizaCaja(fechaUpdate, fk);
                                System.out.println("Actualiza");
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
                             if(f09[j]==0 && info.getFecha_fin()==null){
                                long fk = info.getId_caja();
                                fechaUpdate = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fecha).getTime());
                                System.out.println("Actualiza-fin");
                                modelo.ActualizaCaja(fechaUpdate, fk);
                             }
                          }
                }//ENDIF
                modelo.getCon().commit();
                %>
                <script>
                    alert("Se Actualizon Correctamente...");
                    window.location.href="HabilitarCajas.jsp";
                </script>
         <%
         }else{
         %>
                <script>
                    alert("No Puden ser Actualizados");
                    window.location.href="HabilitarCajas.jsp";
                </script>
<%}%>