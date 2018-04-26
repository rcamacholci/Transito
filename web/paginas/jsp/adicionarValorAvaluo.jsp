<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <%
            try {
                Model modelo = (Model) session.getAttribute("model");


    %>
    <head>
        <title>Adicionar Valor Avaluo Factura</title>

        <META http-equiv=Content-Type content="text/html; charset=windows-1252" />

        <script type="text/javascript" src="../html/scripts/Retencion.js"></script>
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>


        <style type="text/css">
            <!--
            .style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
            .style3 {color: #FFFFFF}
            .style31 {color: #333333; font-size: 12px; font-weight: bold; font-family: Tahoma; }
            .Estilo2 {color: #FFFFFF; 	font-family: Tahoma; 	font-size: 12px; 	font-weight: bold; }
            -->
        </style>
        <script language="javascript" type="text/javascript">

            function validarcamposAvaluo(){
                var idVehiculo = document.getElementById('idVehiculo').value;
                var placaVeh = document.getElementById('placaVeh').value;
                var valorAvaluo = document.getElementById('valorAvaluo').value;
                if(document.form.valorAvaluo.value.length!=0){
                    if(confirm("¿Desea adicionar el valor del avaluo?")){
                        adicionarValorAvaluo(idVehiculo,placaVeh,valorAvaluo);
                    }
                }else{
                    alert("Digite el valor del avaluo !!!");
                }
                return false;
            }

        </script>

    </head>
    <body>
        <%
            long idVehiculo = Long.parseLong(request.getParameter("id"));
            Vehiculo vehiculo = modelo.consultarVehiculoById(idVehiculo);
            String placa = vehiculo.getPlaca();

            if (vehiculo != null) {
        %>
        <form  name="form"  method="post" action="">
            <input type="hidden" id="idVehiculo" value="<%=idVehiculo%>"/>
            <input type="hidden" id="placaVeh" value="<%=placa%>"/>
            <fieldset>
                <table width="52%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr style="border:none; background:url(../html/images/inicio_3.png)">
                        <td colspan="11" align="center"><span class="Estilo2">ADICIONAR VALOR AVALUO</span></td>
                    </tr>
                    <tr>
                        <td width="6%" scope="col" align="right"><label><span class="style2">PLACA&nbsp;&nbsp;</span></label></td>
                        <td width="13%" scope="col" align="left"><label><span class="style2">&nbsp;&nbsp;<%=placa%></span></label></td>
                        <td align="right" class="Estilo2"><span class="style2"><strong>&nbsp;&nbsp;VALOR&nbsp;AVALUO&nbsp;&nbsp;</strong> </span></td>
                        <td align="left"><input type="text" name="valorAvaluo" id="valorAvaluo" style="width:150px" onKeyPress="return soloNumeros(event)" value=""/></td>
                    </tr>
                    <tr>
                        <td colspan="4" align="center">
                            <input name="adicionar" type="button" id="adicionar" value="Guardar" onclick="validarcamposAvaluo()" >
                        </td>
                    </tr>
                </table>
            </fieldset>
        </form>
    </body>
</html>
<%
    }
} catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% }%>