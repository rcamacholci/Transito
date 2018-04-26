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
try{
	if(session.getAttribute("model")!=null){
            modelo.Model modelo = (Model)session.getAttribute("model");
%>
<body>
<table width="100%" border="1" cellpadding="1" cellspacing="0">
   <tr style="border:none; background:url(../html/images/inicio_3.png)">
    <td width="12%" style="border:none"><div align="center" class="style9">CAJA</div></td>
    <td width="12%" style="border:none"><div align="center" class="style9">LETRA CAJA</div></td>
    <td width="12%" style="border:none"><div align="center" class="style9">FOLIOS</div></td>
    <td width="12%" style="border:none"><div align="center" class="style9">CODIGO</div></td>
    <td width="12%" style="border:none"><div align="center" class="style9">FECHA</div></td>

  </tr>
  <%
   
    String placa = request.getParameter("placa");
    if(placa!=null){
        Vehiculo vehiculo = modelo.consultarVehiculo(placa.trim().toUpperCase());
        if(vehiculo==null){
            if(placa.length()==6){
                if(Character.isLetter(placa.charAt(2))){
                    if(placa.charAt(2)<='J'){
                        int newDgto = (((int)placa.charAt(2))-64)%10;
                        placa = new StringBuffer(placa).replace(2, 3, newDgto+"").toString();
                        vehiculo=modelo.consultarVehiculo(placa);
                    }
                }else{
                    char newChar = (char)(74-((10-Integer.valueOf((placa.charAt(2)+"")))%10));
                    placa = new StringBuffer(placa).replace(2, 3, newChar+"").toString();
                    vehiculo=modelo.consultarVehiculo(placa);
                }
            }
        }
        if(vehiculo!=null){
            java.util.List<GuiaCaja> guias = modelo.consultarGuiaCajaByPlaca(vehiculo.getId_vehiculo());
            for(int i=0;i<guias.size();i++){
               GuiaCaja guia = (GuiaCaja)guias.get(i); %>
               <tr>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= guia.getCaja()%></span></td>

                    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= guia.getLetra_caja() %></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= guia.getFolio() %></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= guia.getCodigo() %></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= guia.getFecha()!=null?new java.text.SimpleDateFormat("dd/MM/yyyy").format(guia.getFecha()):"" %></span></td>
                </tr>
        <%  }
        }
    }
%>
</table>

</body>
<%  }
}catch(Exception mexe){
    mexe.printStackTrace(); %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
</html>
