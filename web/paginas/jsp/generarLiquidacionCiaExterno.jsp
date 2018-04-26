<%-- 
    Document   : generarLiquidacionCiaExterno
    Created on : 4/08/2011, 12:26:36 PM
    Author     : Administrador
--%>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
            try {
                if (session.getAttribute("model") != null) {
                    if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                        Model model = (Model) session.getAttribute("model");
                        if (model != null) {
%>
<html>
    <head>
        <title>Adicionar Liquidacion Cia</title>
        <style type="text/css">
            .label {font-size: 11px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold ; width:110px}
            .text {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; width:120px; text-transform:uppercase}
            .date {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; width:100px }
            .bdate {font-size: 10px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold; width:20px }
            .select {font-size: 11px; color:#003366; text-align:left ; font-family:Arial; font-weight:bold; width:120px }
            .input { width:130px }
            .check { font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; }
        </style>
        <link title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
        <script type="text/javascript" src="../html/scripts/adicionarComparendo.js"></script>
        <script type="text/javascript" src="../html/scripts/consultasGenerales.js"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <script type="text/javascript" language="javascript">
            function enviarLiquidacion(){
                var comparendo = document.form.comparendo.value;
                if(comparendo.length>0){
                    if(!isNaN(comparendo)){
                        if(document.form.fecha.value.length==10){
                            if(document.form.documento.value.length>4&&document.form.nombres.value.length>5){
                                if(document.form.infraccion.value.length>0&&document.form.nombreInfraccion.value.length>0){
                                    document.form.target = "proceso";
                                    document.form.action = "procesarLiquidacionCiaExterno.jsp";
                                    document.form.submit();
                                }else{
                                    alert("Digite el numero de la infraccion");
                                }
                            }else{
                                alert("Digite el numero de identificacion de la persona");
                            }
                        }else{
                            alert("Digite una fecha valida del comparendo (dd/mm/yyyy)");
                        }
                    }else{
                        alert("El comparendo solo posee valores numericos");
                    }
                }else{
                    alert("Digite un numero de comparendo");
                }
            }
        </script>
    </head>
    <body>
        <div align="center">
            <div align="center" style="width:560px">
                <form name="form" method="post" action="javascript:enviarLiquidacion()">
                    <fieldset>
                        <legend></legend>
                        <table border="0" align="center" width="550px" cellpadding="1" cellspacing="1">
                            <tr>
                                <td align="center"><div class="text" style="width:250px">GENERAR LIQUIDACION CIA EXTERNA</div></td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>

                                    <table border="0" align="center" width="550px" cellpadding="1" cellspacing="2" style="border:none">
                                        <tr>
                                            <td class="label"># Comparendo</td>
                                            <td class="input">
                                                <input name="comparendo" autocomplete="off"  type="text" class="text" onBlur="existeComparendo(this)" onkeypress="return soloNumeros(event)"/>
                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label" colspan="2"><input type="checkbox" name="polca" id="polca" value="1" checked><label for="polca" class="label">Polca</label></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Fecha</td>
                                            <td class="input"><input type="text" name="fecha" id="fecha" class="date"  style="background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onKeyUp="mascara(this,'/',true)" maxlength="10" />
                                                <input name="bfecha" type="button" id="bfecha" class="bdate" value="<<"/>
                                                <script type="text/javascript">
                                                    Calendar.setup({
                                                        inputField     :    "fecha",      // id del campo de texto
                                                        ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                                        button         :    "bfecha"   // el id del botón que lanzará el calendario
                                                    });
                                                </script>
                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label">Numero Infraccion</td>
                                            <td class="input">
                                                <input name="infraccion" id="infraccion" type="text" class="date" readonly/>
                                                <input name="button" type="button" id="binfraccion" class="bdate" value="<<" onclick="listaInfraccion()"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label">Nombre Infraccion </td>
                                            <td colspan="4"><textarea rows="5" name="nombreInfraccion" type="text" class="text" readonly style="font-size:11px; width:420px; height:50px"></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label">Tipo Documento </td>
                                            <td class="input">
                                                <select name="tipoDocumento" id="tipoDocumento" class="select" onChange="consultaPersona(this.id, 'documento', 'nombres')">
                                            <%  List lista_id = model.listadoParametros(5);
                                                    Iterator itrtor = lista_id.iterator();
                                                    while (itrtor.hasNext()) {
                                                        Parametro parametro = (Parametro) itrtor.next();%>
                                                    <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
                                                    <%  }%>
                                                </select>
                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label">Numero Documento</td>
                                            <td class="input"><input name="documento" type="text" id="documento" class="text" onkeypress="return soloNumeros(event)" onBlur="consultaPersona('tipoDocumento', this.id, 'nombres');buscarLicenciaConduccion()"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label">Nombre y Apellido </td>
                                            <td colspan="4"><input name="nombres" type="text" id="nombres" class="text" style="width:420px" readonly="true"/></td>
                                        </tr>
                                    </table></td>
                            </tr>
                            <tr>
                                <td colspan="5" align="center">
                                    <input type="submit" name="guardar" id="guardar" class="check" disabled value="Guardar Comparendo" />
                                    <iframe src="#" name="proceso" id="proceso" style="display:none"></iframe>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </form>
            </div>
        </div>
    </body>
</html>
<%   }
                    } else {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<% }
                } else {%>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%            }
            } catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="2"></jsp:param>
    <jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param>
</jsp:forward>
<%  }%>


