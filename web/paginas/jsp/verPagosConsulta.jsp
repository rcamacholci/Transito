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
		window.location.href = "detallePago.jsp?id_tiquete="+fila.id;
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
    <td width="10%" style="border:none"><div align="center" class="style9">TRAMITE</div></td>
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
                    Parametro tipo_pago = modelo.consultarParametro(tiquete.getTipo_pago(),301);
                    Persona persona = modelo.consultarPersona(tiquete.getFk_persona());
                    Vehiculo vehiculo = modelo.consultarVehiculoById(tiquete.getFk_vehiculo());
                    Parametro parametro = modelo.consultarParametro(persona.getTipo_documento(), 5);
                    Parametro estado = modelo.consultarParametro(tiquete.getEstado() , 77);
                    java.util.List detatique = modelo.consultarDetalleTiquete(tiquete.getId_tiquete());
                   for(int j=0;j<detatique.size();j++){
                    Detalle_Tiquete temp = (Detalle_Tiquete) detatique.get(j);
                    String estd ="";
                    Tramite trami = modelo.consultarTramite(temp.getFk_tramite());
                    if(temp.getEstado()==2){
                        estd="UTILIZADO";
                    }else{
                        estd="SIN UTILIZAR";
                    }
                  if(temp.getFk_tramite()!=0){
                  %>

                <tr bgcolor="#FFFFFF" id="<%= tiquete.getId_tiquete()%>"   onMouseOver="sombrear(this)" onMouseOut="renovar(this)" onclick="">
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=tipo_pago.getNombre()%></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= pago %></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= tiquete.getFk_vehiculo()!=0 ? vehiculo.getPlaca():"LICENCIA" %></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= tiquete.getFecha_proceso()!=null?new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm:ss").format(tiquete.getFecha_proceso()):"" %></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=trami.getNombre()%></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=estd%></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= tiquete.getValor_total() %></span></td>

              </tr>
     <%  }//si
        }//next
         }
        }
    }
   %>
</table>

</body>
</html>
