<%-- 
    Document   : ReporteMCLC
    Created on : 21/04/2018, 09:19:33 AM
    Author     : acadrasco
--%>

<%@page import="modelo.Marca"%>
<%@page import="modelo.Parametro"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                modelo.Model modelo = (modelo.Model) session.getAttribute("model");
                String departamentoExpedicion = "";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reporte Vehiculos MCLC</title>
        <link href="../../estilos/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="../../estilos/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>        
        <script src="../../estilos/js/jquery-3.2.1.js" type="text/javascript"></script>
        <script src="../html/scripts/motorAjax.js" type="text/javascript"></script>        
       
        <script>

            /*Buscar Carroceria*/
            function bscCarroceria() {
                var clase = $("#clase").val();
                if (clase === '-1') {
                    alert('Debes escoger una clase');
                    $("#clase").focus();
                    return;
                } else {
                    alert('here');
                    // Si en vez de por post lo queremos hacer por get, cambiamos el $.post por $.get
                    $.post('cargarCarroceria.jsp', {
                        clase: clase
                    }, function (responseText, status) {
                        $('#carroceriadiv').html(responseText);
                    });
                }//fin else
            }

            /*Buscar Lineas*/
            function bscLineas() {

                var marca = $("#marcas").val();
                if (marca === '-1') {
                    alert('Debes escoger una clase');
                    $("#marcas").focus();
                    return;
                } else {
                    alert('here');
                    // Si en vez de por post lo queremos hacer por get, cambiamos el $.post por $.get
                    $.post('cargarLineas2.jsp', {
                        marca: marca
                    }, function (responseText, status) {
                        $('#divlineas').html(responseText);
                    });
                }//fin else

            }

            $(document).ready(function () {
                $('#submit').click(function (event) {
                    alert("EStoy en la funcion");
                    var clase = $("#clase").val();
                    alert(clase);
                    var carrocerias = $("#carrocerias").val();
                    alert(carrocerias);
                    var marcas = $("#marcas").val();
                    alert(marcas);
                    var lineas = $("#lineas").val();
                    alert(lineas);

                    if (clase === '-1') {
                        alert('Debes escoger una clase');
                        $("#clase").focus();
                        return;
                    }
                    if (carrocerias === '-1') {
                        alert('Debes escoger una carrocerias');
                        $("#carrocerias").focus();
                        return;
                    }
                    if (marcas === '-1') {
                        alert('Debes escoger una marca');
                        $("#marcas").focus();
                        return;
                    }
                    if (lineas === '-1') {
                        alert('Debes escoger una linea');
                        $("#lineas").focus();
                        return;
                    }

                    if (clase === '-1' && carrocerias === '-1' && marcas === '-1' && lineas === '-1') {
                        alert('Debes escoger todas las opciones para generar el reporte');
                    } else {
                        alert(clase);
                        alert(carrocerias);
                        alert(marcas);
                        alert(lineas);

                        // Si en vez de por post lo queremos hacer por get, cambiamos el $.post por $.get
                        $.post('mclc.jsp', {
                            clase: clase,
                            carrocerias: carrocerias,
                            marcas: marcas,
                            lineas: lineas
                        }, function (responseText, status) {
                            $("#clase").val('-1');
                            $("#carrocerias").val('-1');
                            $("#marcas").val('-1');
                            $("#lineas").val('-1');
                            $('#respuesta').html(responseText);
                        });


                    }//fin else

                });
                
              
            });
             function verReporte() {
                ancho = 789;
                alto = 250;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "reportes/ReporteMclc.jasper";
                var nombre = "ReporteMclc";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }
        </script>
    </head>
    <body>
        <div class="container">       

            <div class="hero-unit">
                <h5 align="center">Reporte de Vehiculos</h5>
            </div>

            </br>
            <div class="mx-auto" style="width:50%;">        
                <div class="row">
                    <div class="form-group col-md-6">
                        <div class="form-group"> <!-- Clases -->
                            <label for="clase" >Clases:</label>
                            <select  class="form-control form-control-sm" id="clase" onChange="bscCarroceria()" >
                                <option value="-1" selected="selected" >Seleccione la Clase</option>
                                <%  java.util.List clases = modelo.listadoParametros(1);
                                    for (int i = 0; i < clases.size(); i++) {
                                        Parametro parametro = (Parametro) clases.get(i);%>                                
                                <option  value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%></option>
                                <%} %>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-6"><div id="carroceriadiv" class="form-group"></div> <!-- Carrocerias --> </div>
                </div>  
                <div class="row">
                    <div class="form-group col-md-6">    
                        <div class="form-group"> <!-- Marcas -->
                            <label for="marcas">Marcas:</label>
                            <select  class="form-control form-control-sm" id="marcas" onChange="bscLineas()">
                                <option value="-1" selected="selected">Seleccione la Marca</option>
                                <%
                                    java.util.List marcas = modelo.listadoMarcas();
                                    for (int i = 0; i < marcas.size(); i++) {
                                        Marca marca = (Marca) marcas.get(i);
                                %>
                                <option value="<%=marca.getCodigo()%>"><%= marca.getNombre()%> </option>
                                <% }%>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-6"> <div class="form-group" id="divlineas"></div> <!-- Lineas --> </div>               

                </div>  
                <div class="row">  <div class="form-group col-md-6"><input type="submit" class="btn btn-info btn-sm" value="Consultar" id="submit" >  <!-- Input submit --></div></div>
            </div>    

            <div id="respuesta"></div>

        </div>
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