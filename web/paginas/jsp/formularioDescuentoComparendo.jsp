<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
            try {
                if (session.getAttribute("model") != null) {
                    if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Cartera</title>
        <link title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript">

            function generarLiqCIA(){
                document.form.action = "generarLiquidacionCIA.jsp";
                document.form.submit();
            }

            function addCertificado(){
                if(document.form.certificado.value.length>0){
                    if(document.form.fecha.value.length>0){
                        if(document.form.lugar.value!=0){
                            document.form.action = "procesarDescuentoComparendo.jsp";
                            document.form.submit();
                        }else{
                            alert("Seleccione un lugar de expedicion del certificado");
                        }
                    }else{
                        alert("Digite la fecha del certificado");
                    }
                }else{
                    alert("Digite el numero del certificado");
                }
            }

            function rver(){
                if(document.form.busqueda[1].checked){
                document.form.action = "formularioDescuentoComparendoExterno.jsp?id=1";
                document.form.submit();
                }else{
                    alert("Ya se encuentra en Local");
                }
            }

            function addConsignacion(){
                if(document.form.referencia.value.length>0){
                    if(document.form.fecha_pago.value.length>0){
                        document.form.action = "procesarLiquidacionCIA.jsp";
                        document.form.submit();
                    }else{
                        alert("Digite la fecha de pago");
                    }
                }else{
                    alert("Digite el numero de la consignacion");
                }
            }

        </script>


        <style type="text/css">
            <!--
            .style2 {
                color: #FFFFFF;
                font-weight: bold;
                font-size: 12px;
                font-family: Tahoma;
            }
            .Estilo9 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
            .Estilo10 {color: #333333}
            -->
        </style>
    </head>
    <body>

        <center>
            <form name="form" id="form" method="post" action="#">
                <%

        modelo.Model model = (modelo.Model) session.getAttribute("model");
        if (model != null) {
            String comparendo = "";

            if (request.getParameter("id").equals("0")) {
                comparendo = request.getParameter("comparendo");
            } else {
                comparendo = session.getAttribute("comparendo") + "";
            }
            if (comparendo != null) {
                Comparendo cparendo = model.consultar_Comparendo(comparendo);
                if (cparendo != null) {
                    Persona persona = model.consultarPersona(cparendo.getFk_persona());
                    Cartera cartera = new Cartera();
                    Parametro parametro = model.consultarParametro(cparendo.getEstado(), 67);
                    cartera = model.consultarCartera(cparendo.getFk_cartera());
                    double valor = 0;
                    double saldo = 0;
                    String estado = "NO EXISTE";
                    if (cartera != null) {
                        Parametro parametro2 = model.consultarParametro(cartera.getEstado_cartera(), 21);
                        valor = cartera.getValor();
                        saldo = cartera.getSaldo();
                        estado = parametro2.getNombre();
                        Infraccion infraccion = model.consultarInfraccion(cparendo.getFk_infraccion());
                        String descuento = "";
                        java.util.Date fechaLimite = new java.text.SimpleDateFormat("dd/MM/yyyy").parse("15/03/2010");
                        if(fechaLimite.getTime()>cparendo.getFecha().getTime()){
                            descuento = "50%";
                        }else{
                            int dias = model.consultarDiasHabiles(new java.sql.Date(cparendo.getFecha().getTime()));
                            if(dias <= 5){
                                descuento = "50%";
                            }else{
                                if(dias < 21){
                                    descuento = "25%";
                                }
                            }
                        }
                %>
                <fieldset>
                    <div align="center">

                    </div>
                    <table width="64%" border="0" align="center">
                        <tr style="border:none; background:url(../html/images/inicio_3.png)">
                            <td colspan="11" align="center"><span class="style2 style14 style7">DESCUENTOS DE COMPARENDOS </span></td>
                        </tr>
                        <tr>
                            <td colspan="8">
                                 <input type="hidden" name="id_comparendo" value="<%=cparendo.getId_comparendo()%>"/>
                            </td>
                        </tr>
                        <tr>
                            <td width="11%" class="style2"><span class="Estilo9">N&ordm;&nbsp;COMPARENDO</span></td>
                            <td  width="12%" align="left">
                                <input name="textfield1" type="text" style="text-align:center; width:110px" value="<%= cparendo.getNumero()%>" readonly/></td>

                            <td width="23%"><span class="Estilo9">FECHA</span></td>
                            <td  width="13%">
                                <input name="textfield2" type="text" style="text-align:center; width:110px" value="<%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(cparendo.getFecha())%>" readonly/>
                            </td>
                            <td width="15%"><span class="Estilo9">ESTADO&nbsp;COMPARENDO</span></td>
                            <td  width="26%"><input name="textfield3" type="text" style="text-align:center; width:110px" value="<%= parametro.getNombre()%>" readonly/></td>
                        </tr>

                        <tr>
                            <td width="11%" class="style2"><span class="Estilo9">VALOR</span></td>
                            <td  width="12%" align="left">
                                <input name="textfield4" type="text" style="text-align:center; width:110px" value="<%= valor%>" readonly/></td>

                            <td width="23%"><span class="Estilo9">SALDO</span></td>
                            <td  width="13%"><input name="textfield5" type="text" style="text-align:center; width:110px" value="<%= saldo%>" readonly/></td>

                            <td width="15%"><span class="Estilo9">ESTADO&nbsp;CARTERA</span></td>
                            <td  width="26%"><input name="textfield6" type="text" style="text-align:center;width:110px" value="<%= estado%>" readonly/></td>
                        </tr>
                        <tr>
                            <td width="11%" class="style2 Estilo10">DOCUMENTO</td>
                            <td  width="12%" align="left">
                                <input name="textfield4" type="text" style="text-align:center; width:110px" value="<%= persona.getDocumento()%>" readonly/></td>

                            <td width="23%"><span class="Estilo9">NOMBRE</span></td>
                            <td colspan="3"><input name="textfield5" type="text" style="text-align:center; width:370px" value="<%= persona.getNombre_1() + " " + persona.getApellido_1()%>" readonly/></td>
                        </tr>
                        <tr>
                            <td width="11%" class="style2 Estilo10">N&ordm; INFRACCION </td>
                            <td align="left" colspan="5"><input name="textfield52" type="text" style="text-align:center; width:560px; font-size:10px" value="<%= infraccion.getNumero() + " - " + infraccion.getDescripcion()%>" readonly/></td>

                        </tr>

                        <tr class="style2">
                            <td height="20%" colspan="2">&nbsp;</td>				  <td colspan="1" width="23%" valign="middle" align="center"><span class="Estilo9">
				  <input type="radio" name="busqueda" value="1" checked="checked" onClick="rver()"/>
				  Local</span></td>
                            <td colspan="1" valign="middle"align="center" width="13%"><span class="Estilo9">
				  <input type="radio" name="busqueda" value="2" onClick="rver()"/>
				  Externo </span></td>
                            </tr>

                        <%
                        Liquidacion_Cia liquidacion = model.consultarLiquidacionCIA(cparendo.getId_comparendo(),cparendo.getFk_persona());
                        if (liquidacion==null) {
                            if(descuento.length()>0){ %>
                                <tr class="style2">
                                    <td colspan="8" align="center"><input id="generarLiquidacion" style="width:200px; background-color:#006600; color:#FFFFFF"  name="generarLiquidacion" type="button" value="Generar Liquidacion CIA "  onclick="generarLiqCIA()"/></td>
                                </tr>
                                <tr class="style2">
                                    <td colspan="8">&nbsp;</td>
                                </tr>
                       <%   }
                       } else {
                            if(liquidacion.getEstado()==1){ %>
                                <tr style="border:none; background:url(../html/images/inicio_3.png)">
                                    <td colspan="11" align="center"><span class="style2 style14 style7"> DATOS CONSIGNACION CIA </span></td>
                                </tr>
                                <tr>
                                    <td width="11%" class="style2"><span class="Estilo9">&nbsp;</span></td>
                                    <td width="12%" class="style2"><span class="Estilo9">LIQUIDACION N#</span></td>
                                    <td  width="23%" align="left">
                                        <input name="numero" type="text" readonly style="text-align:center; width:110px" value="<%=liquidacion.getNumero()%>"/>
                                    </td>
                                    <td width="13%"><span class="Estilo9">VALOR</span></td>
                                    <td  width="15%"><input name="valorliquidacion" type="text" readonly style="text-align:center; width:110px" value="<%=liquidacion.getValor()%>" /></td>
                                    <td width="26%" class="style2"><span class="Estilo9">&nbsp;</span></td>
                                </tr>
                         <% }else{
                                Comparendo_Curso comparendoCurso = model.consultarComparendoCurso(cparendo.getId_comparendo());
                                if (comparendoCurso == null) { %>
                                        <tr style="border:none; background:url(../html/images/inicio_3.png)">
                                            <td colspan="11" align="center"><span class="style2 style14 style7">ADICIONAR CERTIFICADO CURSO DE CAPACITACION </span></td>
                                        </tr>
                                        <tr>
                                            <td width="11%" class="style2"><span class="Estilo9">CERTIFICADO</span></td>
                                            <td  width="12%" align="left">
                                                <input name="certificado" type="text" style="text-align:center; width:110px" value=""/></td>
                                            <td width="23%"><span class="Estilo9">FECHA</span></td>
                                            <td  width="13%">
                                                <input name="fecha" id="fecha" type="text" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; width:80px"  onkeyup="mascara(this,'/',true)" maxlength="10" value=""/>
                                            <input name="Bfecha_comp" type="button" id="Bfecha_comp" value="<<" style="width:18px"/>
                                                <script type="text/javascript">
                                                   Calendar.setup({
                                                   inputField     :    "fecha",      // id del campo de texto
                                                   ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                                   button         :    "Bfecha_comp"   // el id del botón que lanzará el calendario
                                                  });
                                                </script>
                                            </td>
                                            <td width="15%"><span class="Estilo9">VALOR</span></td>
                                            <td  width="26%"><input name="valor" type="text" readonly style="text-align:center; width:110px" value="<%=liquidacion.getValor()%>" /></td>
                                        </tr>
                                        <tr>
                                            <td width="11%" class="style2 Estilo10">LUGAR </td>
                                            <td align="left" colspan="3">
                                                <select name="lugar" style="width:300px; font-size:10px">
                                                <%  java.util.List listaL = model.listadoParametros(348);
                                                    for(int i=0;i<listaL.size();i++){
                                                        Parametro parametrol = (Parametro)listaL.get(i); %>
                                                        <option value="<%=parametrol.getCodigo()%>"><%=parametrol.getNombre()%></option>
                                                 <% } %>
                                                </select>
                                            </td>
                                            <td width="15%"><span class="Estilo9">PAGO</span></td>
                                            <td  width="26%"><input name="pago" readonly type="text" style="text-align:center; width:110px" value="<%=liquidacion.getReferencia() %>" /></td>
                                        </tr>
                               <tr>
                                    <td colspan="6" align="center"><input id="adicionarCertificado" style="width:200px; background-color:teal; color:#FFFFFF"  name="adicionarCertificado" type="button" value="Aplicar Descuento <%=descuento%>"  onclick="addCertificado()"/>
                                    </td>
                                </tr>
                          <%  } else {
                                  int certificado = comparendoCurso.getCertificado();
                                  String fechaCurso = new java.text.SimpleDateFormat("dd/MM/yyyy").format(comparendoCurso.getFecha());
                                  float valorCurso = comparendoCurso.getValor();
                                  String lugar = model.consultarParametroName(348, comparendoCurso.getLugar());
                                   String estadoCurso = model.consultarParametroName(349, comparendoCurso.getEstado());%>
                                    <tr style="border:none; background:url(../html/images/inicio_3.png)">
                                        <td colspan="11" align="center"><span class="style2 style14 style7">DESCUENTOS POR CURSOS DE CAPACITACION </span></td>
                                    </tr>
                                    <tr>
                                        <td width="11%" class="style2"><span class="Estilo9">CERTIFICADO</span></td>
                                        <td  width="12%" align="left">
                                            <input name="certificado" type="text" style="text-align:center; width:110px" value="<%= certificado%>" readonly/></td>
                                        <td width="23%"><span class="Estilo9">FECHA</span></td>
                                        <td  width="13%">
                                            <input name="fecha" type="text" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; width:110px" value="<%= fechaCurso%>" readonly/>				  </td>

                                        <td width="15%"><span class="Estilo9">VALOR</span></td>
                                        <td  width="26%"><input name="valor" type="text" style="text-align:center; width:110px" value="<%= valorCurso%>" readonly/></td>
                                    </tr>
                                    <tr>
                                        <td width="11%" class="style2 Estilo10">LUGAR </td>
                                        <td align="left" colspan="3">
                                            <input name="lugar" type="text" style="text-align:center; width:300px; font-size:10px" value="<%= lugar%> " readonly/></td>
                                        <td width="15%"><span class="Estilo9">ESTADO</span></td>
                                        <td  width="26%"><input name="estado" type="text" style="text-align:center; width:110px" value="<%= estadoCurso%>" readonly/></td>
                                    </tr>
                            <%  }//cierra comparendo curso si existe
                           }  // cierra si existe liquidacion
                      } %>
                    </table>
                </fieldset>
                    <%
                    }
                }
            }
        } %>
            </form>
        </center>

    </body>
</html>
<%

    } else {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<%  }
                } else {%>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%        }
    }catch  (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%            }%>

