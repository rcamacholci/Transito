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
String mensaje = "";
long id_prestamo ;

    try{

      if(request.getParameter("num").equals("1")){
            modelo.getCon().setAutoCommit(false);
                if(request.getParameter("id_prestamo")!=null){
                    id_prestamo =  Long.parseLong(request.getParameter("id_prestamo"));
                    modelo.prestarCarpeta(new java.sql.Date(new java.util.Date().getTime()), id_prestamo);
                    int folios = Integer.parseInt(request.getParameter("folios"));
                    Prestamos_Carpeta pc = modelo.consultarPrestamoById(id_prestamo);
                    modelo.actualizarFoliosCarpeta(folios, pc.getFk_carpeta());
                    mensaje = "Prestamo Realizado con Exito";
                    modelo.getCon().commit();
                }else{
                    mensaje= " Prestamo No pudo ser Realizado con Exito ";
                }
       }else{
            if(request.getParameter("num").equals("2")){
                modelo.getCon().setAutoCommit(false);
                    int foliosN,foliosV,foliosT;
                    if((request.getParameter("foliosN")!=null)&&(!request.getParameter("foliosN").isEmpty())){
                        foliosN = Integer.parseInt(request.getParameter("foliosN"));
                    }else{
                        foliosN = 0;
                        // EUN281
                    }
                    if(request.getParameter("id_prestamo")!=null){
                        id_prestamo =  Long.parseLong(request.getParameter("id_prestamo"));
                        Prestamos_Carpeta pc = modelo.consultarPrestamoById(id_prestamo);
                        Carpetas carpeta = modelo.consultarCarpetaById(pc.getFk_carpeta());
                        foliosV = carpeta.getFolios();
                        foliosT = foliosN + foliosV;
                        modelo.actualizarFoliosCarpeta(foliosT, pc.getFk_carpeta());
                        modelo.devolverCarpeta(new java.sql.Date(new java.util.Date().getTime()), id_prestamo);
                        mensaje = "Devolucion de la carpeta Realizada con Exito";
                        modelo.getCon().commit();
                        
                    }else{
                        mensaje= " Devolucion No pudo ser Realizada";
                    }
            }else{
                     if(request.getParameter("num").equals("3")){
                         modelo.getCon().setAutoCommit(false);
                         String Obser = "CARPETA NO FUE PRESTADA";
                         java.sql.Date systemFecha = new java.sql.Date(new java.util.Date().getTime());
                         long PrestamoId ;
                            if(request.getParameter("idPrestamo")!=null){
                                PrestamoId =  Long.parseLong(request.getParameter("idPrestamo"));
                                modelo.cancelarCarpeta(Obser, systemFecha, systemFecha, PrestamoId);
                                mensaje = "Prestamo Cancelado con Exito";
                                modelo.getCon().commit();

                            }
                    }
            }
       }
%>
        
		   
    <%  
    }catch(Exception ecx){
        modelo.getCon().rollback();
        ecx.printStackTrace();
    %>
        <script language="javascript" type="text/javascript">
                alert("Solicitud de Prestamo No pudo Ser Realizada");
        </script>

<%       if(request.getParameter("num").equals("1")||(request.getParameter("num").equals("3"))){
    %>
        <script language="javascript" type="text/javascript">
                window.parent.document.location.href = "consultarPrestamosCarpetas.jsp";
        </script>
    <%  }else{ %>
            <script language="javascript" type="text/javascript">
                window.parent.document.location.href = "devolucionesCarpetas.jsp";
        </script>
    
        <% }


    }

    if(!mensaje.equals("")){
        if(request.getParameter("num").equals("1")){
%>
        <script language="javascript" type="text/javascript">
            alert("Mensaje : <%=mensaje%>");
            window.parent.document.location.href = "consultarPrestamosCarpetas.jsp";
	</script>
<%      }else{
            if(request.getParameter("num").equals("2")){
            %>
            <script language="javascript" type="text/javascript">
            alert("Mensaje : <%=mensaje%>");
            window.parent.document.location.href = "devolucionesCarpetas.jsp";
	</script>
            <%
            }else{
                 %>
            <script language="javascript" type="text/javascript">
            alert("Mensaje : <%=mensaje%>");
            window.parent.document.location.href = "consultarPrestamosCarpetas.jsp";
	</script>
            <%

            }
        }
    }
%>
   

</body>
</html>
