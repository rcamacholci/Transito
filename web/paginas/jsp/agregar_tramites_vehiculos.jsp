<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<html>
    <%
            try {
                if (session.getAttribute("model") != null) {
                    if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {

                        Model modelo = (Model) session.getAttribute("model");
                        Parametro parametro = new Parametro();
                        Tramite tramite = new Tramite();
                        Parametro parametro_estado = new Parametro();
    %>
    <head>
        <style>
            .select {font-size: 11px; color:#003366; text-align:left ; font-family:Arial; font-weight:bold; width:180px }
        </style>
        <link title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
        <script type="text/javascript" src="../html/scripts/adicionarComparendo.js"></script>
        <script type="text/javascript" src="../html/scripts/consultasGenerales.js"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <style type="text/css">
            <!--
            .Estilo1 {font-size: 11px; color:#003366; text-aling:center; font-family:Arial; font-weight:bold}
            .Estilo2 {font-size: 14px; color:#CC0000}
            .Estilo4 {color: #333333;font-size: 14px;}
            .Estilo6 {font-size: 14px; color: #009900; }
            .Estilo7 {
                color: #FFFFFF;
                font-weight: bold;
                font-size: 12;
            }
            .Estilo13 {
                font-size: 14px;
                color: #333333;
            }
            .Estilo15 {
                color: #333333;
                font-size: 12px;
            }
            .Estilo18 {
                color: #333333;
                font-size: 12px;
                font-weight: bold;
            }
            .Estilo21 {color: #333333; font-size: 12; }
            .Estilo23 {
                font-size: 12px;
                font-weight: bold;
            }
            -->
        </style>
        <script>
            function validarCampos(){
                var sw = false;
                if(document.form.placa.value.length > 0){
                    if(document.form.tipoDocumento.value.length>0){
                        if(document.form.documento.value.length> 0){
                            if(document.form.nombre.value.length>0){
                                if(document.form.tipoTramite.value.length>0){
                                    if(document.form.estado.value.length>0){
                                        if(document.form.fechaO.value.length>0){
                                        }else{
                                            alert("Escoja Una Fecha");
                                            sw = true;
                                        }
                                    }else{
                                        alert("escoja un estado");
                                        sw = true;
                                    }
                                }else{
                                    alert("Escoja Un tramite");
                                    sw = true;
                                }
                            }else{
                                alert("Valor Del Nombre Vacio");
                                sw = true;
                            }
                        }else{
                            alert("Digite El Numero Del Documeto");
                            sw = true;
                        }
                    }else{
                        alert("Debe Escoger El Tipo Del Documeto");
                        sw = true;
                    }
                } else{
                    alert("La Placa No Fue Consultada Correctamente");
                    sw = true;
                }
                if(sw == true){
                    return false
                }else{
                    document.formu.submit();
                }
            }
        </script>
    </head>
    <body>
        <form name="form" id="form" method="post" action="guardar_tramites_vehiculos.jsp?placa=<%=request.getParameter("placa2")%>" onSubmit="validarCampos(); return false">
            <fieldset>
                <table width="60%" border="0" align="center">
                    <tr>
                        <td>
                            <fieldset>
                                <table width="100%" border="0" align="center">
                                    <tr>
                                        <td class="Estilo23" align="center">ADICIONAR TRAMITES A VEHICULOS</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                    </tr>
                                </table>
                                <fieldset>
                                    <legend class="Estilo18">Datos Del Vehiculo</legend>
                                    <table width="100%" border="0" align="center">
                                        <tr>
                                            <td width="10%" class="Estilo18">Placa :</td>
                                            <td width="24%"><label for="placa"></label>
                                                <input type="text" style="width:100px; text-align:center" name="placa" id="placa" class="Estilo1" readonly value="<%=request.getParameter("placa2")%>"></td>
                                            <td width="14%">&nbsp;</td>
                                            <td width="52%">&nbsp;</td>
                                        </tr>
                                    </table>
                                </fieldset>
                                <fieldset>
                                    <legend class="Estilo18">Datos Del Solicitante</legend>
                                    <table width="100%" height="85" border="0" align="center">
                                        <tr>
                                            <td width="16%" class="Estilo18">Tipo Documento :</td>
                                            <td width="30%">
                                                <select name="tipoDocumento" id="tipoDocumento" class="select" onChange="consultaPersona(this.id, 'documento', 'nombres')">
                                                    <%  List lista_id = modelo.listadoParametros(5);

                        Iterator itrtor = lista_id.iterator();
                        while (itrtor.hasNext()) {
                            parametro = (Parametro) itrtor.next();%>
                                                    <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
                                                    <%  }%>
                                                </select>
                                            </td>
                                            <td width="22%" class="Estilo18">Numero Del Documento :</td>
                                            <td width="32%" align="center"><span class="input1">
                                                    <input name="documento" style="width:150px; text-align:center" type="text" id="documento" class="Estilo1" onBlur="consultaPersona('tipoDocumento', this.id, 'nombre')"/>
                                                </span></td>
                                        </tr>
                                        <tr>
                                            <td height="46" colspan="4" align="center"><p><span class="Estilo18" >Nombre Completo</span></p>
                                                <p>
                                                    <input name="nombre" style="width:500px; text-align:center" type="text" class="Estilo18" id="nombre" readonly  />
                                                </p></td>
                                        </tr>
                                    </table>
                                </fieldset>
                                <fieldset>
                                    <legend class="Estilo18">Datos Del Tramite</legend>
                                    <table width="100%" border="0" align="center">
                                        <tr>
                                            <td width="22%" class="Estilo18">Nombre Tramite :</td>
                                            <td colspan="2">
                                                <select name="tipoTramite" id="tipoTramite" class="select">
                                                    <%
                        List lista_tramites = modelo.consultarTramites(1, 234);
                        Iterator itrtor2 = lista_tramites.iterator();
                        while (itrtor2.hasNext()) {
                            tramite = (Tramite) itrtor2.next();
                                                    %>
                                                    <option value="<%=tramite.getNombre() + ""%>"><%=tramite.getNombre()%></option>
                                                    <%  }%>
                                                </select>
                                            </td>
                                            <td width="9%" class="Estilo18">Estado :</td>
                                            <td width="32%">
                                                <select name="estado" id="estado" class="select">
                                                    <%
                        List lista_listado_parametro = modelo.listadoParametros(52);
                        Iterator itrtor3 = lista_listado_parametro.iterator();
                        while (itrtor3.hasNext()) {
                            parametro_estado = (Parametro) itrtor3.next();
                            if (parametro_estado.getNombre() == "APROBADA") {
                                System.out.print("entro agregar tramites " + parametro_estado.getNombre());
                                                    %>

                                                    <option selectd value="<%=parametro_estado.getNombre() + ""%>"><%=parametro_estado.getNombre()%></option>
                                                    <% } else
                                System.out.print("NO entro agregar tramites ");
                            {%>
                                                    <option value="<%=parametro_estado.getNombre() + ""%>"><%=parametro_estado.getNombre()%></option>
                                                    <% }%>
                                                    <%  }%>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td width="12%" align="right" class="Estilo18">Fecha:</td>
                                            <td colspan="2" align="center">


                                                <span class="Estilo8">
                                                    <input id="fechaO" name="fechaO" type="text" value="" style=" width:100px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; color:#333333; text-align:center" onKeyUp="mascara(this,'/',true)" maxlength="10"/>
                                                </span>	 <input name="btfechaO" type="button" id="btfechaO" value="&lt;" style="width:20px; text-align:center"/>
                                                <script type="text/javascript">
                                                    Calendar.setup({
                                                        inputField     :    "fechaO",      // id del campo de texto
                                                        ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                                        button         :    "btfechaO"   // el id del bot?n que lanzar? el calendario
                                                    });
                                                </script>



                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td colspan="2">&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td colspan="5" align="center">
                                                <button type="submit" name="guardar" id="guardar" class="check">Guardar Tramite <img src="../html/images/guardar.png" width="19" height="18"/></button>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </form>
    </body>
</html>
<%  } else {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<%  }
                } else {%>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%    }
            } catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%}%>
