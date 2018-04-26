<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
            try {
                if (session.getAttribute("model") != null) {
                    if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("formularioDescuentoComparendo.jsp")) {
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
                //alert("entro");
                document.form.action = "generarLiquidacionCIA.jsp";
                document.form.submit();
                addCertificado();
            }

         
           function rver(){
                if(document.form.busqueda[2].checked){
                document.form.action = "formularioDescuentoComparendo.jsp?id=1";
                document.form.submit();
                }else{
                    alert("Ya se encuentra en Externo")
                }
            }

            function addCertificado(){
                if(document.form.certificado.value.length>0){
                    
                    if(document.form.fecha.value.length>0){
                      //  alert("entro");
                        if(document.form.curso.value!=0 && document.form.ot.value!=0 ){
                        //    alert("entro 3");
                           document.form.action = "GenerarDescuentoComparendo.jsp";
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

function nuevoAjax(){
                var xmlhttp= false;
                try{
                    xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
                }catch(e){
                    try {
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }catch(E){
                        xmlhttp = false;
                    }
                }

                if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
                    xmlhttp = new XMLHttpRequest();
                }

                return xmlhttp;
            }

function getvalorLiquidacionCia(){

    var id_comparendo = document.getElementById("id_comparendo").value;
    var ajax = new nuevoAjax();
    ajax.open("POST", "getvalorLiquidacionCia.jsp",true);
    ajax.onreadystatechange=function() {
        if (ajax.readyState==4) {
            var docxml = ajax.responseXML;
            var valorcertificado = docxml.getElementsByTagName('ValorCertificado')[0].childNodes[0].nodeValue;
            var ValorDescuento = docxml.getElementsByTagName('ValorDescuento')[0].childNodes[0].nodeValue;
            var ValorTotal = docxml.getElementsByTagName('ValorTotal')[0].childNodes[0].nodeValue;

            if(valorcertificado!=null&&ValorDescuento!=null){
                document.form.valorcertificadocia.value = valorcertificado;
                document.form.vrDescuento.value = ValorDescuento;
                document.form.tpagar.value = ValorTotal;
            }else{
                document.form.valorcertificadocia.value = "";
                document.form.vrDescuento.value = "";
                document.form.tpagar.value = "";
            }
        }
    }
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("id_comparendo="+id_comparendo);

}

function pasos(){
  // alert("entro"+document.form.op.value);
    if(document.form.op.value==2){
 //       alert("entro"+document.form.op.value);
            document.getElementById('curso').style.display = "none";
            document.getElementById('ot').style.display = "block";
    }else{
            if(document.form.op.value==1){
            document.getElementById('curso').style.display = "block";
            document.getElementById('ot').style.display = "none";
            }else{
            document.getElementById('curso').style.display = "none";
            document.getElementById('ot').style.display = "none";
            }
    }
}

    function ver(){
    if(document.form.busqueda[0].checked){
    document.getElementById('Tr').style.display = "none";
    //   document.getElementById('tabla2').style.display = "none";
    //    document.getElementById('tabla3').style.display = "none";
    //     document.getElementById('tabla4').style.display = "none";
    //      window.frames[0].location.href="pantallazo.jsp";
    }else{
    if(document.form.busqueda[1].checked){
    // 	document.getElementById('tabla1').style.display = "none";
    //   document.getElementById('tabla2').style.display = "none";
    //    document.getElementById('tabla3').style.display = "block";
    document.getElementById('Tr').style.display = "";
    //      window.frames[0].location.href="pantallazo.jsp";
    }
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
            .Estilo7 {font-size: 16px; color: #FF0000; font-weight: bold; font-style: italic; }
            .Estilo8 {font-size: 16px; color: #0066CC; font-weight: bold; font-style: italic; }
            .Estilo9 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
            .Estilo10 {color: #333333}
            -->
        </style>
    </head>
    <body onload="getvalorLiquidacionCia()">

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
                        Liquidacion_Cia liquidacion = model.consultarLiquidacionCIA(cparendo.getId_comparendo(),cparendo.getFk_persona());
                        
                        if(liquidacion!=null){

                            if(liquidacion.getEstado()==1){
                                saldo = cartera.getSaldo()+liquidacion.getValor();
                            }else{
                                saldo = cartera.getSaldo();
                            }
                        }else{
                            saldo = cartera.getSaldo();
                        }
                        
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
                                 <input type="hidden" name="id_comparendo" id="id_comparendo" value="<%=cparendo.getId_comparendo()%>"/>
                            </td>
                        </tr>
                        <tr>
                            <td width="12%" class="style2"><span class="Estilo9">N&ordm;&nbsp;COMPARENDO</span></td>
                            <td  width="13%" align="left">
                                <input name="textfield1" type="text" style="text-align:center; width:110px" value="<%= cparendo.getNumero()%>" readonly/></td>

                            <td width="21%"><span class="Estilo9">FECHA</span></td>
                            <td  width="12%">                                  
                               <input type="text" style="text-align:center; width:110px" value="<%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(cparendo.getFecha())%>" readonly />                           </td>
                            <td width="19%"><span class="Estilo9">ESTADO&nbsp;COMPARENDO</span></td>
                            <td  width="23%"><input name="textfield3" type="text" style="text-align:center; width:110px" value="<%= parametro.getNombre()%>" readonly/></td>
                        </tr>

                        <tr>
                            <td width="12%" class="style2"><span class="Estilo9">VALOR</span></td>
                            <td  width="13%" align="left">
                                <input name="textfield4" type="text" style="text-align:center; width:110px" value="<%= valor%>" readonly/></td>

                            <td width="21%"><span class="Estilo9">SALDO</span></td>
                            <td  width="12%"><input name="textfield5" type="text" style="text-align:center; width:110px" value="<%= saldo%>" readonly/></td>

                            <td width="19%"><span class="Estilo9">ESTADO&nbsp;CARTERA</span></td>
                            <td  width="23%"><input name="textfield6" type="text" style="text-align:center;width:110px" value="<%= estado%>" readonly/></td>
                        </tr>
                        <tr>
                            <td width="12%" class="style2 Estilo10">DOCUMENTO</td>
                            <td  width="13%" align="left">
                                <input name="textfield4" type="text" style="text-align:center; width:110px" value="<%= persona.getDocumento()%>" readonly/></td>

                            <td width="21%"><span class="Estilo9">NOMBRE</span></td>
                            <td colspan="3"><input name="textfield5" type="text" style="text-align:center; width:370px" value="<%= persona.getNombre_1() + " " + persona.getApellido_1()%>" readonly/></td>
                        </tr>
                        <tr>
                            <td width="12%" class="style2 Estilo10">N&ordm; INFRACCION </td>
                            <td align="left" colspan="5"><input name="textfield52" type="text" style="text-align:center; width:560px; font-size:10px" value="<%= infraccion.getNumero() + " - " + infraccion.getDescripcion()%>" readonly/></td>

                        </tr>

                        <% liquidacion = model.consultarLiquidacionCIA(cparendo.getId_comparendo(),cparendo.getFk_persona());
                        if(liquidacion==null&&descuento!=""){
%>
                        <tr class="style2">
                            <td colspan="8">&nbsp;</td>
                        </tr>
                        <tr style="border:none; background:url(../html/images/inicio_3.png)">
                            <td colspan="11" align="center"><span class="style2 style14 style7">TOTAL DESCUENTOS</span></td>
                        </tr>

                        <tr>
                            <td width="12%" class="style2 Estilo10">CURSO CIA</td>
                            <td  width="13%" align="center">
                            <input name="valorcertificadocia" id="valorcertificadocia" type="text" style="text-align:center; width:110px" value="" readonly/></td>
                            <td width="12%" align="center"><span class="Estilo9">DESCUENTO</span></td>
                            <td><input name="vrDescuento" id="vrDescuento" type="text" style="text-align:center; width:110px" value="" readonly/></td>
                            <td width="12%" align="center" class="style2 Estilo10">TOTAL A PAGAR</td>
                            <td  width="13%" align="center">
                                <input name="tpagar" id="tpagar" type="text" style="text-align:center; width:110px" value="" readonly/></td>
                        </tr>

                        <tr class="style2">
                            <td colspan="8">&nbsp;</td>
                        </tr>
                        <% liquidacion = model.consultarLiquidacionCIA(cparendo.getId_comparendo(),cparendo.getFk_persona()); %>
                         <tr style="border:none; background:url(../html/images/inicio_3.png)">
                                            <td colspan="11" align="center"><span class="style2 style14 style7">ADICIONAR CERTIFICADO CURSO DE CAPACITACION </span></td>
                                        </tr>
                                        <tr>
                                            <td width="12%" class="style2"><span class="Estilo9">CERTIFICADO</span></td>
                                            <td  width="13%" align="left">
                                                <input name="certificado" type="text" style="text-align:center; width:110px" value=""/></td>
                                            <td width="21%"><span class="Estilo9">FECHA</span></td>
                                            <td  width="12%">
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
                                           
                                        </tr>
                                        <tr>
    <td width="12%" class="style2 Estilo10">LUGAR <select name="op" id="op" onblur="pasos()">
<option value="1" onclick="pasos()">CIA</option>
<option value="2" onclick="pasos()">OT</option>
</select></td>
                                            <td align="left" colspan="3">
                                                <select name="curso" id="curso" style="width:300px; font-size:10px">
                                                <%  java.util.List listaL = model.ListadoDeCursosCia();
                                                    for(int i=0;i<listaL.size();i++){
                                                        Cursos_cia parametrol = (Cursos_cia)listaL.get(i); %>

                                                        <option value="<%=parametrol.getCodigo()%>"><%=parametrol.getNombre()%></option>
                                                 <% } %>
                                                </select>

                                                 <select name="ot" id="ot" style="width:300px; font-size:10px; display:none">
                                                <%  java.util.List listaot = model.consultarSedes();
                                                    for(int i=0;i<listaot.size();i++){
                                                        Sede parame = (Sede)listaot.get(i);
												%>
                                                        <option value="<%=parame.getCodigo()%>"><%=parame.getNombre()%></option>
                                                 <% } %>
                                                </select>
                                            </td>
                                                                                        
                                        </tr>
                               <% } %>

                        <tr class="style2">
                            <td colspan="8">&nbsp;</td>
                            </tr>
                            <tr class="style2">
                            <td height="20%" colspan="2">&nbsp;</td>				  <td colspan="1" width="23%" valign="middle" align="center"><span class="Estilo9">
				  <input type="radio" name="busqueda" value="1"  onClick="rver()"/>
				  Local</span></td>
                            <td colspan="1" valign="middle"align="center" width="13%"><span class="Estilo9">
				  <input type="radio" name="busqueda" value="2" onClick="rver()" checked="checked"/>
				  Externo </span></td>
                            </tr>

                        <%
                        if (liquidacion==null) {
                            if(descuento.length()>0){ %>
                                <tr class="style2">
                                    <td colspan="8" align="center"><input id="generarLiquidacion" style="width:200px; background-color:#006600; color:#FFFFFF"  name="generarLiquidacion" type="button" value="Generar Descuento del  <%=descuento %> "  onclick="addCertificado()"/></td>
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
                                    <td width="16%" class="style2"><span class="Estilo9">&nbsp;</span></td>
                                    <td width="16%" class="style2"><span class="Estilo9">LIQUIDACION N#</span></td>
                                    <td  width="16%" align="left">
                                        <input name="numero" type="text" readonly style="text-align:center; width:110px" value="<%=liquidacion.getNumero()%>"/>
                                    </td>
                                    <td width="16%"><span class="Estilo9">VALOR</span></td>
                                    <td  width="16%"><input name="valorliquidacion" type="text" readonly style="text-align:center; width:110px" value="<%=liquidacion.getValor()%>" /></td>
                                    <td width="16%" class="style2"><span class="Estilo9">&nbsp;</span></td>
                                </tr>
                         <% }else{
                                Comparendo_Curso comparendoCurso = model.consultarComparendoCurso(cparendo.getId_comparendo());
                                if (comparendoCurso == null) { %>
                                        <tr style="border:none; background:url(../html/images/inicio_3.png)">
                                            <td colspan="11" align="center"><span class="style2 style14 style7">ADICIONAR CERTIFICADO CURSO DE CAPACITACION </span></td>
                                        </tr>
                                        <tr>
                                            <td width="12%" class="style2"><span class="Estilo9">CERTIFICADO</span></td>
                                            <td  width="13%" align="left">
                                                <input name="certificado" type="text" style="text-align:center; width:110px" value=""/></td>
                                            <td width="21%"><span class="Estilo9">FECHA</span></td>
                                            <td  width="12%">
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
                                            <td width="19%"><span class="Estilo9">VALOR</span></td>
                                            <td  width="23%"><input name="valor" type="text" readonly style="text-align:center; width:110px" value="<%=liquidacion.getValor()%>" /></td>
                                        </tr>
                                        <tr>
                                            <td width="12%" class="style2 Estilo10">LUGAR </td>
                                            <td align="left" colspan="3">
                                                <select name="lugar" style="width:300px; font-size:10px">
                                                <%java.util.List  listaL = model.listadoParametros(348);
                                                    for(int i=0;i<listaL.size();i++){
                                                        Parametro parametrol = (Parametro)listaL.get(i); %>
                                                        <option value="<%=parametrol.getCodigo()%>"><%=parametrol.getNombre()%></option>
                                                 <% } %>
                                                </select>
                                            </td>
                                            <td width="19%"><span class="Estilo9">PAGO</span></td>
                                            <td  width="23%"><input name="pago" readonly type="text" style="text-align:center; width:110px" value="<%=liquidacion.getReferencia() %>" /></td>
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
                                        <td width="12%" class="style2"><span class="Estilo9">CERTIFICADO</span></td>
                                        <td  width="13%" align="left">
                                            <input name="certificado" type="text" style="text-align:center; width:110px" value="<%= certificado%>" readonly/></td>
                                        <td width="21%"><span class="Estilo9">FECHA</span></td>
                                        <td  width="12%">
                                            <input name="fecha" type="text" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; width:110px" value="<%= fechaCurso%>" readonly/>				  </td>

                                        <td width="19%"><span class="Estilo9">VALOR</span></td>
                                        <td  width="23%"><input name="valor" type="text" style="text-align:center; width:110px" value="<%= valorCurso%>" readonly/></td>
                                    </tr>
                                    <tr>
                                        <td width="12%" class="style2 Estilo10">LUGAR </td>
                                        <td align="left" colspan="3">
                                            <input name="lugar" type="text" style="text-align:center; width:300px; font-size:10px" value="<%= lugar%> " readonly/></td>
                                        <td width="19%"><span class="Estilo9">ESTADO</span></td>
                                        <td  width="23%"><input name="estado" type="text" style="text-align:center; width:110px" value="<%= estadoCurso%>" readonly/></td>
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
            <script type="javascript" type="text/javascript">
                            document.form.valorcertificadocia.value=0;
            </script>
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

