<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.DatosVehiculo" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<title>Prestamos</title>
<style type="text/css">
<!--
.Estilo13 {color: #FFFFFF; font-weight: bold; }
.Estilo20 {font-size: 12px; font-weight: bold;  }
.style9 {color: #FFFFFF; font-weight: bold; font-family: Tahoma; font-size: 12px; }
.style17 {color: #333333; font-size: 11px; font-family: Tahoma; font-weight: bold; }
-->
</style>
<script language="javascript" type="text/javascript">
	function edit(opcion){
		window.location.href = "editarPrestamo.jsp?idpc="+opcion.id;
	}
	function sombrear(tr){
		tr.style.backgroundColor="#CCCCCC";
	}
	function renovar(tr){
		tr.style.backgroundColor="#FFFFFF";
	}
	
</script>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>

<%
Model modelo= (Model)session.getAttribute("model"); 


%>
<body>
<table width="100%" border="1" cellpadding="1" cellspacing="0">
   <tr style="border:none; background:url(../html/images/inicio_3.png)">
    <td width="10%"  style="border:none"><div align="center" class="style9">MOTIVO</div></td>
    <td width="10%" style="border:none"><div align="center" class="style9">PLACA</div></td>
    <td width="10%" style="border:none"><div align="center" class="style9">FOLIOS</div></td>
    <td width="15%" style="border:none"><div align="center" class="style9">F.&nbsp;SOLICITUD </div></td>
    <td width="15%" style="border:none"><div align="center" class="style9">ESTADO</div></td>
    <td width="10%" style="border:none"><div align="center" class="style9">USUARIO</div></td>
  </tr>
  <%
   
  if(request.getParameter("num")!=null){
      
      if(request.getParameter("num").equals("1")){
           java.util.List lista   =  modelo.listarPrestamos();
           for(int i=0;i<lista.size();i++){
               Tramite tramite = null;
                Prestamos_Carpeta pc = (Prestamos_Carpeta)lista.get(i);
                    if(pc.getEstado()==1){
                        Parametro motivo = modelo.consultarParametro(pc.getMotivo(), 334);
                        if(pc.getTramite()!=0 ){
                            tramite = modelo.consultarTramite(pc.getTramite());
                        }
                        Carpetas carpeta = modelo.consultarCarpetaById(pc.getFk_carpeta());
                        Vehiculo vehiculo = modelo.consultarVehiculoById(carpeta.getFk_vehiculo());
                        Parametro parametro = modelo.consultarParametro(pc.getEstado(), 337);
                        Usuario usuario = modelo.consultarUsuario(pc.getFk_usuario());
        %>

                <tr bgcolor="#FFFFFF" id="<%= pc.getId_prestamo()%>"   ondblclick="edit(this)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= pc.getTramite()!=0?tramite.getNombre():motivo.getNombre()%></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= vehiculo.getPlaca() %></span></td>
		<td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= carpeta.getFolios() %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= pc.getFecha_solicitud()!=null?new java.text.SimpleDateFormat("dd/MM/yyyy").format(pc.getFecha_solicitud()):"" %></span></td>
		<td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= parametro.getNombre()%></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=usuario.getNombre()%></span></td>
  </tr>
			  
     <%  
	 }
   }


      }else{
            if(request.getParameter("num").equals("2")){
                String placa = "";
                Tramite tramite = null;
                    if(request.getParameter("placa")!=null){
                        placa = request.getParameter("placa");
                        Vehiculo vehiculo = modelo.consultarVehiculo(placa.toUpperCase());
                            if(vehiculo!=null){
                                Carpetas carpeta = modelo.consultarCarpetaByFkVehiculo(vehiculo.getId_vehiculo());
                                    if(carpeta!=null){
                                         java.util.List lista = modelo.listarPrestamosByFkCarpeta(carpeta.getId_carpeta());
                                            for(int i=0;i<lista.size();i++){
                                             Prestamos_Carpeta pc = (Prestamos_Carpeta)lista.get(i);
                                                 if(pc.getEstado()==1){
                                                    Parametro motivo = modelo.consultarParametro(pc.getMotivo(), 334);
                                                        if(pc.getTramite()!=0 ){
                                                            tramite = modelo.consultarTramite(pc.getTramite());
                                                        }
                                                        Parametro parametro = modelo.consultarParametro(pc.getEstado(), 337);
                                                        Usuario usuario = modelo.consultarUsuario(pc.getFk_usuario());
    %>

                <tr bgcolor="#FFFFFF" id="<%= pc.getId_prestamo()%>"   ondblclick="edit(this)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=pc.getTramite()!=0?tramite.getNombre():motivo.getNombre()%></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= vehiculo.getPlaca() %></span></td>
		<td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= carpeta.getFolios() %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=pc.getFecha_solicitud()!=null?pc.getFecha_solicitud():"" %></span></td>
		<td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= parametro.getNombre()%></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=usuario.getNombre()%></span></td>
  </tr>

     <%
                                                  }
                                            }
                                    }
                            }
            }

        }else{
                if(request.getParameter("num").equals("3")){
                    java.sql.Date  fechaI = null;
                    java.sql.Date  fechaF = null;
                    Tramite tramite = null;
                    if((request.getParameter("fechaI")!=null)&&(request.getParameter("fechaF")!=null)){
                        fechaI = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaI")).getTime());
                        fechaF = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaF")).getTime());
                        java.util.List lista = modelo.listarPrestamosByFechas(fechaI, fechaF);
                            for(int i=0;i<lista.size();i++){
                                Prestamos_Carpeta pc = (Prestamos_Carpeta)lista.get(i);
                                                 if(pc.getEstado()==1){
                                                    Parametro motivo = modelo.consultarParametro(pc.getMotivo(), 334);
                                                        if(pc.getTramite()!=0 ){
                                                            tramite = modelo.consultarTramite(pc.getTramite());
                                                        }
                                                         Carpetas carpeta = modelo.consultarCarpetaById(pc.getFk_carpeta());
                                                        if (carpeta!=null){
                                                            Vehiculo vehiculo =  modelo.consultarVehiculoById(carpeta.getFk_vehiculo());
                                                                if(vehiculo!=null){
                                                                    Parametro parametro = modelo.consultarParametro(pc.getEstado(), 337);
                                                                    Usuario usuario = modelo.consultarUsuario(pc.getFk_usuario());
%>

                <tr bgcolor="#FFFFFF" id="<%= pc.getId_prestamo()%>"   ondblclick="edit(this)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=pc.getTramite()!=0?tramite.getNombre():motivo.getNombre() %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= vehiculo.getPlaca() %></span></td>
		<td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= carpeta.getFolios() %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=pc.getFecha_solicitud()!=null?pc.getFecha_solicitud():"" %></span></td>
		<td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= parametro.getNombre()%></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=usuario.getNombre()%></span></td>
                </tr>

<%
                                                                 }
                                                        }
                                               }
                                     }
                             }
                      }
                }
           }
      }

   %>
</table>

</body>
</html>
