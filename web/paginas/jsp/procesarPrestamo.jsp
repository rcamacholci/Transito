<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%

Model modelo= (Model)session.getAttribute("model");
modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
String mensaje ="";
try{
    java.util.List lista   =  modelo.listarPrestamosSolicitudes();
    
    if(lista.size()<=4000){

    modelo.getCon().setAutoCommit(false);
    String placa ="";
    Prestamos_Carpeta prestamos_carpeta = new Prestamos_Carpeta();
    
    if(request.getParameter("placa")!=null){
        placa =  request.getParameter("placa");
        Vehiculo vehiculo = modelo.consultarVehiculo(placa.toUpperCase());
            if(vehiculo!=null){
                 Carpetas carpeta = modelo.consultarCarpeta(vehiculo.getId_vehiculo());
                    if(carpeta!=null){
                        Prestamos_Carpeta prestamosC = modelo.consultarPrestamoFkCarpeta(carpeta.getId_carpeta());
                           if(prestamosC==null){
                                if(request.getParameter("motivos")!=null){

                                        if(request.getParameter("motivos").equals("7")){
                                            if(request.getParameter("tramites")!=null){
                                                prestamos_carpeta.setTramite(Integer.parseInt(request.getParameter("tramites")));
                                            }
                                                if(request.getParameter("observacion")!=null){
                                                    prestamos_carpeta.setObservacion(request.getParameter("observacion"));
                                                }
                                        }
                                        

                                        prestamos_carpeta.setMotivo(Integer.parseInt(request.getParameter("motivos")));
                                        prestamos_carpeta.setEstado(1);
                                        prestamos_carpeta.setFecha_solicitud(new java.sql.Date(new java.util.Date().getTime()));
                                        prestamos_carpeta.setFk_carpeta(carpeta.getId_carpeta());
                                        prestamos_carpeta.setFk_usuario(usuario.getId_usuario());
                                        modelo.adicionarPrestamos(prestamos_carpeta);
                                        mensaje = "Solicitud Realizada con Exito";
                                        modelo.getCon().commit();
                                    }
                             }else{
                                if(prestamosC.getEstado()==2){
                                    mensaje="La carpeta Del vehiculo se encuentra Prestada";
                                }else{
                                     mensaje="La carpeta Del vehiculo se encuentra Solicitada";
                                }
                            }
                    }else{
                        mensaje="vehiculo no tiene carpeta asociada";
                    }

           }else{
               mensaje ="vehiculo no existe";
           }
    }else{
           mensaje= "Solicitud No pudo ser Realizada con Exito";
    }
%>
        
		   
    <% }else{ %><script language="javascript" type="text/javascript">
			alert("No puede realizarse la solicitud sobrepasa las 1000 permitidas, acercarse a Archivo");
			document.location.href = "prestamoCarpetas.jsp";
		</script>
<%	}

}catch(Exception ecx){
		modelo.getCon().rollback();
		ecx.printStackTrace();        %>
		<script language="javascript" type="text/javascript">
			alert("Solicitud de Prestamo No pudo Ser Realizada");
			document.location.href = "prestamoCarpetas.jsp";
		</script>		
<%  }

    if(!mensaje.equals("")){
        %>
        <script language="javascript" type="text/javascript">
            alert("Mensaje : <%=mensaje%>");
            document.location.href = "prestamoCarpetas.jsp";
	</script>
   <% }


%>
   

</body>
</html>
