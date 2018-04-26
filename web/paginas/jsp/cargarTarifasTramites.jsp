<%-- 
    Document   : cargarTarifasTramites
    Created on : 01-dic-2017, 11:26:12
    Author     : acadrasco
--%>

<%@page import="modelo.Salarios_Minimos"%>
<%@page import="modelo.Sede"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>
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
                Salarios_Minimos sm = modelo.buscarUltimoSalarioMinimo();

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>cargarTarifasTramites</title>
        <script src="../../estilos/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <link href="../../estilos/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>        
        <link title=win2k-cold-1 media=all href="../html/css/calendar-green.css" rel="stylesheet" type="text/css"/>   
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <script src="../../estilos/js/jquery-3.2.1.js" type="text/javascript"></script>        
        <script src="../html/scripts/motorAjax_1.js" type="text/javascript"></script>
        <script src="../html/scripts/motorAjax.js" type="text/javascript"></script>

        <script type="text/javascript">

            function quitarConcepto(elem1){                
                var fk_concepto = document.getElementById(elem1.id).value;
                var fk_tramite = $("#fk_tramite").val();
                var resol = $("#Resolucion").val();
                if (resol === '') {
                    alert("Debe digitar un numero de resolucion.....");
                    return;
                }
                var opcion = confirm("¿Desea Retirar el concepto ?");
                    if (opcion === true) {
                        $.post("../../ListaConceptos", {'op': fk_tramite, 'resol': resol,'fkc': fk_concepto,'quitar':1}, function (data) {
                        $("#asociar").css("display", "none");
                        $("#asoc").css("display", "none");        
                        $("#listaConcepto").css("display", "block");
                        $("#listaConcepto").html(data);
                        
                    });                        
                    } else {
                        return;
                    }//fin else
                
                
            }

            function mostrarConcepto() {
                var fk_concepto = $("#listaConceptos").val();
                if (fk_concepto === '-1') {
                    alert("Debe seleccionar una opcion en la lista de conceptos");
                    return;
                } else {

                    $.post("../../mostrarConcepto", {'fk_concepto': fk_concepto}, function (data) {
                        $("#listaConcepto").css("display", "none");
                        $("#asociar").css("display", "block");
                        $("#asociar").html(data);
                    });

                }
            }


            function asociarConceptoTramite() {
                var fk_tramite = $("#fk_tramite").val();
                var clase = $("#ctramites").val();
                if (clase === '-1') {
                    alert("Debe seleccionar una opcion de la clase de tramite");
                    return;
                }
                if (fk_tramite === '-1') {
                    alert("Debe escoger un tramite de la lista.....");
                    return;
                } else {
                    $.post("../../asociarConceptoTramite", {'clase': clase, 'fkt': fk_tramite}, function (data) {
                        $("#listaConcepto").css("display", "none");
                        $("#asoc").css("display", "block");
                        $("#asoc").html(data);
                    });

                }

            }

            function enviarSalario(elem, elem1) {

                var salario = document.getElementById(elem.id).value;
                var fk_concepto = document.getElementById(elem1.id).value;
                var fk_tramite = $("#fk_tramite").val();
                $.post("../../ProcesarSalarioMinimo", {'valor': salario, 'fkc': fk_concepto, 'fkt': fk_tramite}, function (data) {
                    $("#listaConcepto").css("display", "none");
                    $("#resp").html(data);
                });
            }



            function mandarId(elem, elem1, elem2, elem3, elem4) {
                var ide = elem.id;
                var ids = elem2.id;
                var idvant = elem3.id;
                var idbtn = elem4.id;
                var valor = document.getElementById(elem.id).value;
                var fk_concepto = document.getElementById(elem1.id).value;
                var fk_tramite = $("#fk_tramite").val();
                var resol = $("#Resolucion").val();
                var fecha = $("#fecha").val();
                var sede = <%=sede.getId_sede()%>;

                if (resol === '') {
                    alert("Debe digitar un numero de resolucion.....");
                    return;
                }
                if (fk_tramite === '-1') {
                    alert("Debe escoger un tramite de la lista.....");
                    return;
                }
                if (valor === '') {
                    alert("Debe digitar un valor para el concepto.....");
                    return;
                } else {
                    var opcion = confirm("¿Desea Registrar el valor del concepto ?");
                    if (opcion === true) {
                        $.post("../../procesarPaseVigencia", {'valor': valor, 'fkc': fk_concepto, 'fkt': fk_tramite, 'resol': resol, 'fhr': fecha, 'sede': sede, 'id': ide, 'ids': ids, 'idvant': idvant, 'idbtn': idbtn}, function (data) {

                            $("#resp").html(data);
                        });
                    } else {
                        return;
                    }//fin else

                }//fin else





            }

            function cargarListaTramites() {
                var dato = $("#ctramites").val();
                if (dato === '-1') {
                    alert("Debe seleccionar una opcion de la clase de tramite");
                    return;
                } else {
                    $.post("../../ListaTramites", {'op': dato}, function (data) {
                        $("#resol").css("display", "block");
                        $("#Resolucion").val('');
                        $("#listaConcepto").css("display", "none");
                        $("#lista").html(data);
                    });
                }
            }

            function cargarListaConceptos() {
                var fk_concepto = $("#fk_concepto").val();
                var fk_tramite = $("#fk_tramite").val();
                var resol = $("#Resolucion").val();
                var fecha = $("#fecha").val();
                var sede = <%=sede.getId_sede()%>;
                var dato = $("#listaT").val();
                if (resol === '') {
                    alert("Debe digitar un número de resolución.....");
                    return;
                }
                if (dato === '-1') {
                    alert("Debe seleccionar una opcion de la clase de tramite");
                    return;
                } else {
                    $.post("../../ListaConceptos", {'op': dato, 'resol': resol, 'fhr': fecha, 'fkc': fk_concepto, 'fkt': fk_tramite, 'sede': sede}, function (data) {
                        $("#asociar").css("display", "block");
                        $("#listaConcepto").css("display", "block");
                        $("#listaConcepto").html(data);
                        $("#asociar").css("display", "none");
                        $("#asoc").css("display", "none");
                    });
                }
            }


            function calcularValor(elem, elem1) {

                var salario = document.getElementById(elem.id).value;
            <% double smlv = (sm.getValor() / 30);%>
                var smlvd = Math.round(<%=smlv%> * salario);
                document.getElementById(elem1.id).value = smlvd.valueOf();
            }




        </script>
        <style>
            body {
                font-family: verdana;
                font-size: 12px;
            }


        </style>
    </head>
    <body>

        <div style="text-align: left;">    
            

            <h5 style="text-align: center;">Cargar las Tarifas de los Tramites </h5></br>
            <table align='center' width='60%' border='1' > 
                <tr>
                    <td width="70%">
                        <label>Clase de tramite:</label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <select name="clase" id="ctramites" onchange="cargarListaTramites();" style="width:200px;">
                            <option value="-1">Seleccione una opción</option>

                            <%            //listar las clases de tramites
                                // Recorremos el hashMap y mostramos por pantalla el par valor y clave
                                java.util.List hm = modelo.listarClaseTramite();
                                java.util.Iterator it = hm.iterator();
                                for (Object elem : hm) {
                                    HashMap hash = (HashMap<String, String>) elem;
                                    System.out.println(hash.get("CODIGO"));
                                    System.out.println(hash.get("NOMBRE"));

                            %>
                            <option value="<%=hash.get("CODIGO")%>"><%=hash.get("NOMBRE")%></option>
                            <% }


                            %>
                        </select>
                        <div id="resol" style="display: none">
                            <table class="mws-table" style="width: 80%;" >
                                <tr style="color: #000000;text-align: center">
                                    <td   style="border:none"><div align="left"><span class="txt" >N. Resolución:</span></div></td>
                                    <td style="border:none">&nbsp;&nbsp;&nbsp;&nbsp;<input name="Resolucion" type="text" id="Resolucion" onkeypress="return soloNumeros(event)" style="width:200px" />
                                    </td>
                                    <td >&nbsp;</td>
                                    <td   style="border:none"><div align="left"><span >&nbsp;&nbsp;Fecha</span></div></td>
                                    <td colspan="1"><span><input   id="fecha" name="fecha" type="text" style="width:150px" disabled readonly onkeyup="mascara(this, '/', true)" maxlength="10" value="<%=fecha_hoy%>"/></span>&nbsp;<input name="bfecha" type="button" id="bfecha" value="<" />
                                        <script type="text/javascript">
                                            Calendar.setup({
                                                inputField: "fecha",
                                                ifFormat: "%d/%m/%Y",
                                                button: "bfecha"
                                            });
                                        </script>
                                    </td>
                                </tr>
                            </table>
                        </div></br>
                        <div id="lista"></div>
                    </td>
                </tr>
            </table>

            </br>
            <div id="listaConcepto"></div>
            <div id="resp"></div>
            <div id="asoc"></div>
            <div id="asociar"></div>

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