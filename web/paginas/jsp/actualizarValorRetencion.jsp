<%-- 
    Document   : actualizarValorRetencion
    Created on : 07-dic-2017, 9:12:01
    Author     : acadrasco
--%>

<%@page import="modelo.Model"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                Model modelo = (Model) session.getAttribute("model");
                String fecha_hoy = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
               


%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Actualizar Valores Retencion</title>
        <style type="text/css">
            <!--
            .style1 {color: #006699}
            -->
        </style>
        <script src="../../estilos/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <link href="../../estilos/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>        
        <link title=win2k-cold-1 media=all href="../html/css/calendar-green.css" rel="stylesheet" type="text/css"/>   
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <script src="../../estilos/js/jquery-3.2.1.js" type="text/javascript"></script>    
        <script src="../html/scripts/motorAjax.js" type="text/javascript"></script>
        <script>
            
            function consultarPlaca() {

                var dato = $("#placa").val();
                if (dato === '') {
                    alert("Debe digitar una placa..");
                    return;
                } else {
                    $.post("../../procesarConsultaPlaca", {'placa': dato}, function (data) {                        
                        $("#res").html(data);
                    });
                }
            }
            
            function calcularRetencion(){
                var dato = $("#avaluo").val();
                var calculo = dato * 0.01;
                $("#retencion").val(calculo);
            }
            
            function enviar(){
                var avaluo = $("#avaluo").val();
                var retencion = $("#retencion").val();
                var fk_vehiculo = $("#fk_vehiculo").val();
                if(avaluo ===''){
                     alert("Debe digitar un valor para el avaluo..");
                    return;
                }
                if(retencion ===''){
                     alert("Debe digitar un valor para la retencion..");
                    return;
                }
                if(fk_vehiculo ===''){
                     alert("Debe digitar un valor para el vehiculo..");
                    return;
                }else{
                    //alert(avaluo);
                   // alert(retencion);
                    //alert(fk_vehiculo);
                    $.post("../../procesarActualizarValoresRetencion", {'avaluo': avaluo,'retencion': retencion,'fk_vehiculo': fk_vehiculo}, function (data) {                        
                        $("#actualizar").html(data);
                    });
                    
                }
                
            }
        </script>
    </head>
    <body>
        
            <table align="center" border="0" width="50%">
                <tr>
                    <td  height="40px" align="center">
                        <h6 class="style1" align="center">Actualizar Valores de la Retencion</h6></td>
                </tr>
                <tr>
                    <td height="40px" align="center">
                        
                        <label>Placa: </label>

                    </td>
                    <td height="40px" align="center">
                       <input type="text" id="placa"/>
                    </td>
                </tr>  
                <tr>
                    
                    <td height="40px" align="center">
                        <input type="submit" value="Consultar" onclick="consultarPlaca();"/>
                    </td>
                </tr>   

            </table>	
        <div id="res"></div>
        <div id="actualizar"></div>
    </body>
</html>
<%  } else { %>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<%  }
} else { %>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%
    }
} catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
    }%>