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
    <td width="12%"  style="border:none"><div align="center" class="style9">NUMERO</div></td>
    <td width="12%"  style="border:none"><div align="center" class="style9">FECHA</div></td>
    <td width="12%" style="border:none"><div align="center" class="style9">PLACA</div></td>
    <td width="12%" style="border:none"><div align="center" class="style9">VIGENCIA INICIAL</div></td>
    <td width="12%" style="border:none"><div align="center" class="style9">VIGENCIA FINAL</div></td>
    <td width="12%" style="border:none"><div align="center" class="style9">ESTADO</div></td>
    <td width="12%" style="border:none"><div align="center" class="style9">USUARIO</div></td>
  </tr>
  <%

  if(request.getParameter("num")!=null){
      if(request.getParameter("num").equals("1")){
                String placa = "";
                    if(session.getAttribute("placa")!=null){
                    placa =  session.getAttribute("placa")+"";
                    }
                if(request.getParameter("placa")!=null||!placa.isEmpty()){
                    if(placa.isEmpty()){
                    placa = request.getParameter("placa").trim().toUpperCase();
                    }
                    Vehiculo vehiculo = modelo.consultarVehiculo(placa);
                    if(vehiculo!=null){
                        List<Prescripcion> prescrip = modelo.consultarPrescripcionByPlaca(vehiculo.getId_vehiculo());
                        if(prescrip!=null){
                            for(int i=0;i<prescrip.size();i++){
                            Prescripcion pre = prescrip.get(i);
                            Usuario usuario = modelo.consultarUsuario(pre.getFk_usuario());
                            %>
                            <tr bgcolor="#FFFFFF" id="<%= pre.getId_prescripcion() %>"   onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= pre.getNumero() %></span></td>
                            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= pre.getFecha()!=null?new java.text.SimpleDateFormat("dd/MM/yyyy").format(pre.getFecha()):"" %></span></td>
                            <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= vehiculo.getPlaca() %></span></td>
                            <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= pre.getVigencia_inicial()%></span></td>
                            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= pre.getVigencia_final() %></span></td>
                            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= modelo.consultarParametroName(345, (int)pre.getEstado())%></span></td>
                            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=usuario.getNombre()%></span></td>
                            </tr>
                 <%}
                        }else{
                        %>
                        <script>
                            alert("No posee Prescipciones");
                        </script>
                        <%
                        }
                    }
              }
      }else{
                if(request.getParameter("num").equals("2")){
                    if(request.getParameter("fechaI")!=null&&request.getParameter("fechaF")!=null){
                        java.sql.Date fechaI = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaI")).getTime());
                        java.sql.Date fechaF = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaF")).getTime());
                          java.util.List lista   =  modelo.listarPrescripcionesCarteraByFechas(fechaI, fechaF);
                            for(int i=0;i<lista.size();i++){
                                Prescripcion prescrip = (Prescripcion)lista.get(i);
                                    if(prescrip!=null){
                                        Vehiculo vehiculo =  modelo.consultarVehiculoById(prescrip.getFk_vehiculo());
                                            if(vehiculo!=null){
                                                Usuario usuario = modelo.consultarUsuario(prescrip.getFk_usuario());     %>
                                                <tr bgcolor="#FFFFFF" id="<%= prescrip.getId_prescripcion() %>"   onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                                                    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= prescrip.getNumero() %></span></td>
                                                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= prescrip.getFecha()!=null?new java.text.SimpleDateFormat("dd/MM/yyyy").format(prescrip.getFecha()):"" %></span></td>
                                                <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= vehiculo.getPlaca() %></span></td>
                                                <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= prescrip.getVigencia_inicial()%></span></td>
                                                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= prescrip.getVigencia_final() %></span></td>
                                                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= modelo.consultarParametroName(345, (int)prescrip.getEstado())%></span></td>
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

   %>
</table>

</body>
</html>