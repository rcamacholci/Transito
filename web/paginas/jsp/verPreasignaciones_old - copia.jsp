<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1"  pageEncoding="ISO-8859-1" language="java" import="java.sql.*" import="modelo.DatosVehiculo" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Prestamos</title>
<style type="text/css">
<!--
.Estilo13 {color: #FFFFFF; font-weight: bold; }
.Estilo20 {font-size: 12px; font-weight: bold;  }
.style9 {color: #000000; font-weight: bold; font-family: Tahoma; font-size: 12px; }
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
if(request.getParameter("exc")!=null){
    long reportexcel = Long.parseLong(request.getParameter("exc"));
    if (reportexcel==1){
response.setContentType ("application/vnd.ms-excel"); //Tipo de fichero.
response.setHeader ("Content-Disposition", "attachment;filename=\"Preasignaciones vencidas.xls\"");
}
}

%>



<body>
<table width="100%" border="1" cellpadding="1" cellspacing="0">
   <tr style="border:none; background:url(../html/images/inicio_3.png)">
       <td width="5%"  style="border:none"><div align="center" class="style9">N</div></td>
    <td width="15%"  style="border:none"><div align="center" class="style9">FECHA</div></td>
    <td width="7%" style="border:none"><div align="center" class="style9">PLACA</div></td>
    <td width="12%" style="border:none"><div align="center" class="style9">MOTOR</div></td>
    <td width="12%" style="border:none"><div align="center" class="style9">CHASIS </div></td>
    <td width="10%" style="border:none"><div align="center" class="style9">SOLICITANTE</div></td>
    <td width="8%" style="border:none"><div align="center" class="style9">USUARIO</div></td>
  </tr>
  <%

  if(request.getParameter("num")!=null){

      if(request.getParameter("num").equals("1")){
       java.sql.Timestamp  fechaI = null;
       java.sql.Timestamp  fechaF = null;
                    if((request.getParameter("fechaI")!=null)&&(request.getParameter("fechaF")!=null)){
                        fechaI = new java.sql.Timestamp(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaI")).getTime());
                        fechaF = new java.sql.Timestamp(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaF")).getTime());
                        fechaF.setTime(fechaF.getTime()+86400000);
                        long fk_usuario = Long.parseLong(request.getParameter("fk_usuario"));
                        java.util.List lista = modelo.listarPreasignacionesByFechas(fechaI, fechaF,fk_usuario);
                            for(int i=0;i<lista.size();i++){
                                Preasignacion preasignacion = (Preasignacion)lista.get(i);
                                 if(preasignacion.getEstado()==1){
                                    Persona persona = modelo.consultarPersona(preasignacion.getFk_persona());
                                    Parametro parametro = null;
                                    if(persona!=null)
                                        parametro = modelo.consultarParametro(persona.getTipo_documento(), 5);
                                    Usuario usuario = modelo.consultarUsuario(preasignacion.getFk_usuario());

%>

                <tr bgcolor="#FFFFFF" id="<%= preasignacion.getId_preasignacion()%>"   onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=i+1%></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= preasignacion.getFecha()!=null?preasignacion.getFecha():"" %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= preasignacion.getPlaca() %></span></td>
		<td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= preasignacion.getMotor() %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= preasignacion.getChasis()!=null?preasignacion.getChasis():""%></span></td>
		<td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= preasignacion.getFk_persona()!=0?parametro.getNombreCorto()+" "+persona.getDocumento():"" %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=usuario.getNombre()%></span></td>
                </tr>

<%
                                  }
                          }
                  }
      }else{
            if(request.getParameter("num").equals("2")){
                String placa = "";
                if(request.getParameter("placa")!=null){
                    placa = request.getParameter("placa");
                    Preasignacion preasignacion = modelo.consultarPreasignacionByPlaca(placa.toUpperCase());
                        if(preasignacion!=null){
                                Persona persona = modelo.consultarPersona(preasignacion.getFk_persona());
                                Parametro parametro = modelo.consultarParametro(persona.getTipo_documento(), 5);
                                Usuario usuario = modelo.consultarUsuario(preasignacion.getFk_usuario());

%>

                <tr bgcolor="#FFFFFF" id="<%= preasignacion.getId_preasignacion() %>"   onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=preasignacion.getFecha()!=null? preasignacion.getFecha():"" %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= preasignacion.getPlaca() %></span></td>
		<td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= preasignacion.getMotor()%></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= preasignacion.getChasis() %></span></td>
		<td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= preasignacion.getFk_persona()!=0? parametro.getNombreCorto()+" "+persona.getDocumento():"" %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=usuario.getNombre()%></span></td>
  </tr>

     <%



                            }
            }

        }else{
                if(request.getParameter("num").equals("3")){
                     Parametro parametro = null;
                     Usuario usuario = null;
                      java.util.List lista = modelo.listarPreasignaciones();
                          for(int i=0;i<lista.size();i++){
                                Preasignacion preasignacion = (Preasignacion)lista.get(i);
                                Vehiculo vehiculo = modelo.consultarVehiculo(preasignacion.getPlaca().toUpperCase());
                                if(vehiculo==null){
                                    java.util.Date fechaActual =(new java.util.Date());
                                    long dif = fechaActual.getTime() -  preasignacion.getFecha().getTime();

                                    long dias =  (dif / 86400000L);
                                        if(dias>7){
                                            Persona persona = modelo.consultarPersona(preasignacion.getFk_persona());
                                            if(persona!=null){
                                                parametro = modelo.consultarParametro(persona.getTipo_documento(), 5);
                                                usuario = modelo.consultarUsuario(preasignacion.getFk_usuario());
                                            }
%>

                <tr bgcolor="#FFFFFF" id="<%= preasignacion.getId_preasignacion() %>"   onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=preasignacion.getFecha()!=null? preasignacion.getFecha():"" %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= preasignacion.getPlaca() %></span></td>
		<td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= preasignacion.getMotor()%></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= preasignacion.getChasis() %></span></td>
		<td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= preasignacion.getFk_persona()!=0? parametro.getNombreCorto()+" "+persona.getDocumento():"" %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=usuario!=null?usuario.getNombre():""%></span></td>
  </tr>

     <%
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
