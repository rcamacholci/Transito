<%@page  import = "modelo.Model,modelo.Preasignacion" import = "java.util.*" import = "java.sql.*"   %>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
  Model model = null;
    java.util.List<Vehiculo> vehiculo = null;
      try{
        model = (Model)session.getAttribute("model");
        modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
          String pl = request.getParameter("placa");
            vehiculo  = model.consultarVplaca(pl);
            Vehiculo vehiculo2 = vehiculo.get(0);
            if(model!=null){
                     if(request.getParameter("placa")!=null){
                          // if(usuario.getId_usuario()==15){
                            /// System.out.println("Holaaaaaaaaaaaa: "+usuario.getId_usuario()+" -- "+ pl);
                            model.editarRuntSincronizacion(vehiculo2.getId_vehiculo());
                                 %> <script> 
                                     alert("Estado Runt Vehiculo Acualizado con exito.");
                                     window.location.href = "verDatosVehiculo.jsp?id=0&placa="+<%=pl%> +"&placa2="+<%=pl%>;
					document.form.action = "verDatosVehiculo.jsp?id=0&placa="+<%=pl%>+"&placa2="+<%=pl%>; </script> <%
                       // }else{
                        
                      //  }
                    }else{
                    %> <script> alert("Lo sentimos campo de placa vacio");</script> <%
                    }
             }
     }catch(Exception exc){
         exc.printStackTrace();
         model.getCon().rollback();
    
     }

     
%>
