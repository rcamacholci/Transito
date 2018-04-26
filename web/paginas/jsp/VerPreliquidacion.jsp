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
	function verPago(fila){
		window.location.href = "preliquidacion.jsp?id_tiquete="+fila.id;
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
    <td width="10%"  style="border:none"><div align="center" class="style9">TIPO PAGO </div></td>
    <td width="10%" style="border:none"><div align="center" class="style9">FACTURA</div></td>
    <td width="10%" style="border:none"><div align="center" class="style9">REFERENCIA</div></td>
    <td width="10%" style="border:none"><div align="center" class="style9">FECHA</div></td>
    <td width="10%" style="border:none"><div align="center" class="style9">DOCUMENTO</div></td>
    <td width="9%" style="border:none"><div align="center" class="style9">PERSONA</div></td>
	<td width="9%" style="border:none"><div align="center" class="style9">ESTADO</div></td>
	<td width="9%" style="border:none"><div align="center" class="style9">VALOR</div></td>
  </tr>
  <%

    String pago = "";
    if(request.getParameter("pago")!=null){
        pago = request.getParameter("pago").toUpperCase();
        java.util.List lista = modelo.consultarPagosByFactura(pago);
        for(int i=0;i<lista.size();i++){
            Tiquete tiquete = (Tiquete)lista.get(i);
            if(tiquete!=null){
                 if(tiquete.getEstado()==4){
                    Parametro tipo_pago = modelo.consultarParametro(tiquete.getTipo_pago(),301);
                    Persona persona = modelo.consultarPersona(tiquete.getFk_persona());
                    Vehiculo vehiculo = modelo.consultarVehiculoById(tiquete.getFk_vehiculo());
                    Parametro parametro = modelo.consultarParametro(persona.getTipo_documento(), 5);
                    Parametro estado = modelo.consultarParametro(tiquete.getEstado() , 77);  %>

                <tr bgcolor="#FFFFFF" id="<%= tiquete.getId_tiquete()%>"   onMouseOver="sombrear(this)" onMouseOut="renovar(this)" onclick="verPago(this)">
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=tipo_pago.getNombre()%></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= pago %></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= tiquete.getFk_vehiculo()!=0 ? vehiculo.getPlaca():"LICENCIA" %></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= tiquete.getFecha_proceso()!=null?new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm:ss").format(tiquete.getFecha_proceso()):"" %></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= tiquete.getFk_persona()!=0? parametro.getNombreCorto()+" "+persona.getDocumento():"" %></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=tiquete.getFk_persona()!=0? persona.getNombre_1()+" "+persona.getApellido_1():"" %></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=estado.getNombre() %></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= tiquete.getValor_total() %></span></td>
              </tr>
     <% }else{
     %><script>alert("El tiquete no se encuentra en estado preliquidado")</script><%
     }
     }
        }
    }
   %>
</table>

</body>
</html>
