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
                document.form.action = "verSaldoFavor.jsp?id_saldo="+opcion.id;
		document.form.submit();
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
<form method="post" name="form" action="">
    <table width="100%" border="1" cellpadding="1" cellspacing="0">
       <tr style="border:none; background:url(../html/images/inicio_3.png)">
        <td width="10%"  style="border:none"><div align="center" class="style9">NUMERO</div></td>
        <td width="10%" style="border:none"><div align="center" class="style9">FECHA</div></td>
        <td width="10%" style="border:none"><div align="center" class="style9">VALOR</div></td>
        <td width="10%" style="border:none"><div align="center" class="style9">TIPO</div></td>
        <td width="20%" style="border:none"><div align="center" class="style9">REFERENCIA</div></td>
        <td width="10%" style="border:none"><div align="center" class="style9">VEHICULO</div></td>
        <td width="10%" style="border:none"><div align="center" class="style9">ESTADO</div></td>
        <td width="10%" style="border:none"><div align="center" class="style9">USUARIO</div></td>
      </tr>
      <%

      if(session.getAttribute("id_persona")!=null){
        java.util.List lista= modelo.consultarSaldosAFavor(Long.parseLong(session.getAttribute("id_persona").toString()));
        for(int i=0;i<lista.size();i++){
             Saldo_Favor saldoF = (Saldo_Favor)lista.get(i);
             if(saldoF!=null){
                String referencia = "";
                String tipoN = "";
                String placa = "";
                if(saldoF.getTipo()==1){
                    Tiquete tiquete = modelo.consultarTiquetePorID(Long.parseLong(saldoF.getReferencia()));
                    referencia = tiquete.getNumero_factura();
                    tipoN = "PAGO TITULO VALOR";
                    Vehiculo veh = modelo.consultarVehiculoById(tiquete.getFk_vehiculo());
                    if(veh!=null)
                        placa = veh.getPlaca();
                }else{
                    Nota_Credito notaC = modelo.consultarNotaCredito(Long.parseLong(saldoF.getReferencia()));
                    referencia = notaC.getReferencia();
                    tipoN = "PAGO NOTA CREDITO";
                    Vehiculo veh = modelo.consultarVehiculoById(notaC.getFk_registro());
                    if(veh!=null)
                        placa = veh.getPlaca();
                }
                Usuario usuario = modelo.consultarUsuario(saldoF.getFk_usuario());%>
                <tr bgcolor="#FFFFFF" id="<%= saldoF.getId_saldo_favor() %>"   onMouseOver="sombrear(this)" onMouseOut="renovar(this)" ondblclick="edit(this)">
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= saldoF.getNumero() %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= saldoF.getFecha()!=null?new java.text.SimpleDateFormat("dd/MM/yyyy").format(saldoF.getFecha()):"" %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= saldoF.getValor() %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= tipoN %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= referencia %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= placa %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= modelo.consultarParametroName(346, saldoF.getEstado())%></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=usuario.getNombre()%></span></td>
                </tr>
     <%      }
         }
      }
       %>
    </table>
</form>
</body>
</html>
