<%-- 
    Document   : crearConcepto
    Created on : 13-dic-2017, 13:29:28
    Author     : acadrasco
--%>

<%@page import="java.util.HashMap"%>
<%@page import="modelo.Sede"%>
<%@page import="modelo.Model"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                Model modelo = (Model) session.getAttribute("model");
                String fecha_hoy = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
                Sede sede = (Sede) session.getAttribute("sede");


%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crear Concepto</title>
        <script src="../../estilos/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <link href="../../estilos/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>        
        <link title=win2k-cold-1 media=all href="../html/css/calendar-green.css" rel="stylesheet" type="text/css"/>   
        <link href="../../estilos/css/tasaUsura.css" rel="stylesheet" type="text/css"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <script src="../../estilos/js/jquery-3.2.1.js" type="text/javascript"></script>        
        <script src="../html/scripts/motorAjax_1.js" type="text/javascript"></script>
        <script src="../html/scripts/motorAjax.js" type="text/javascript"></script>
        <script type="text/javascript">
            function enviarConcepto() {
                var nombreConcepto = $("#nombreConcepto").val();
                var observacion = $("#observacion").val();
                var clase = $("#clase").val();
                var sede = <%=sede.getId_sede()%>;
                if (nombreConcepto === '') {
                    alert("Debe digiitar un nombre para el tramite......");
                    return;
                }
                if (clase === '-1') {
                    alert("Debe seleccionar una opcion de la clase de tramite.....");
                    return;
                } else {
                    $.post("../../procesarConcepto", {'nombreConcepto': nombreConcepto, 'observacion': observacion, 'clase': clase,
                        'sede': sede}, function (data) {
                        $("#principal").css("display", "none");
                        $("#crear").html(data);
                    });
                }

            }
            function listarTramites() {
                var dato = $("#listaC").val();
                if (dato === '-1') {
                    alert("Debe seleccionar una opcion de la clase de tramite");
                    return;
                } else {
                    $.post("../../listarTramitesAsociar", {'op': dato}, function (data) {
                        $("#principal").css("display", "none");
                        $("#listaA").html(data);
                    });

                }

            }


            function mandarId(elem,elem1) {                  
                var idbtn = elem1.id;               
                var fk_tramite = document.getElementById(elem.id).value;
                var fk_concepto = $("#fk_concepto").val();
                var sede = <%=sede.getId_sede()%>;
                if (fk_tramite === '-1') {
                    alert("Debe escoger un tramite de la lista.....");
                    return;
                } else {
                    var opcion = confirm("¿Desea Registrar el valor del concepto ?");
                    if (opcion === true) {
                        $.post("../../ProcesarSedeTramitesConcepto", {'valor': 0, 'fkc': fk_concepto, 'fkt': fk_tramite, 'resol': '0', 'fhr':<%=fecha_hoy%>, 'sede': sede,'idbtn': idbtn}, function (data) {

                            $("#resp").html(data);
                        });
                    } else {
                        return;
                    }//fin else

                }//fin else

            }
        </script>
    </head>
    <body>
        <div id="principal">  
            <h5 align="center">Ingresar Nuevo Concepto</h5>
            <table width="20%" border="1" align="center" >
                <tr>
                    <td><label for="nombreConcepto">Nombre Concepto:</label></td>
                    <td> <label for="observacion">Observación:</label></td>
                    <td><label>Clase:</label></td>

                </tr>
                <tr>
                    <td><input type="text" name="nombreConcepto" id="nombreConcepto"></td>
                    <td><textarea id="observacion" name="observacion" rows="2" cols="30"></textarea></td>
                    <td><select id="clase" name="clase">
                            <option value="-1">Seleccione una opcion.......</option>
                            <%                          java.util.List hm = modelo.listarClaseConcepto();
                                for (int i = 0; i < hm.size(); i++) {
                                    HashMap hash = (HashMap<String, String>) hm.get(i);
                            %>      
                            <option value="<%=hash.get("CODIGO")%>"><%=hash.get("NOMBRE")%></option>
                            <%}%>   
                        </select></td>
                </tr> 
                <tr>
                    <td><input type="submit" id="enviar" value="Registrar Concepto" onclick="enviarConcepto();"/></td>>

                </tr>

            </table>
        </div>            
        </br>

        <div id="crear"></div>
        <div id="listaA"></div>
        <div id="resp"></div>


        </br>

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