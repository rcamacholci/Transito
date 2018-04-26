<%-- 
    Document   : pantallazo
    Created on : 18/02/2011, 05:15:09 PM
    Author     : Administrador
--%>

<%@page import="java.util.Calendar"%>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  import="java.sql.*" import="modelo.Model"  import="modelo.Usuario" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%Model modelo = (Model)request.getSession().getAttribute("model");///
  int diasDiferencia = modelo.alertaTasaUsura(); 
  Usuario user = (Usuario) request.getSession().getAttribute("usuario");
  //dependiendo del usuario y el recurso 
  boolean permiso =(((java.util.LinkedList)session.getAttribute("permisosU")).contains("agregarTasaUsura.jsp")); 
  
Calendar cal = Calendar.getInstance(); 
int yearServer =cal.get(Calendar.YEAR);
%>
<html>
    <head>
        <title>Inicio</title>
         <script type="text/javascript">
           function alerta(){
              
               switch(<%=diasDiferencia%>){
                   <%
                        if(permiso == true){
                    %>
                   case 0:                      
                            alert("Dias para cambiar la tasa de usura: " + <%=diasDiferencia%>);
                             window.top.location.href ="agregarTasaUsura.jsp";              
                       break;
                   case 1:
                       alert("Dias para cambiar la tasa de usura: " + <%=diasDiferencia%>);
                       break;
                   case 2:
                       alert("Dias para cambiar la tasa de usura: " + <%=diasDiferencia%>);
                       break;
                   case 3:
                       alert("Dias para cambiar la tasa de usura: " + <%=diasDiferencia%>);
                       break;
                   default:   
                       break;
                   <%}else{
                   %>
                         case 0:                      
                            alert("Los días restantes para cambiar la tasa de usura son: " + <%=diasDiferencia%>+" ,por favor comuniquese con la oficina de sistemas del organismo.");
                           window.top.location.href ="inicio.jsp";            
                       break;
                        

                        <%}%>     
               }
               
               
               
           }
           </script>
    </head>
    <body onload="alerta();">
        <%
            //Actualizar Vigencia en la tabla consecutivos
          boolean update = false;  
          int vigenciaConsecutivo = modelo.buscarVigenciaConsecutivo();
          if(yearServer > vigenciaConsecutivo ){
              //actualizar la vigencia al año del servidor en la tabla consecutivos.
              update = modelo.ActualizarConsecutivoVigencia(yearServer);
              ///si se realizo correctamente la actualizacion entonces hago commit
              if(update == true){
                    modelo.getCon().commit();  
              }else{
             //sino hago un rollback.             
             modelo.getCon().rollback();
          }
                  
          }
        
        %>
    </body>
</html>
