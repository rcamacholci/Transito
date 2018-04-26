<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
Model modelo = (Model)session.getAttribute("model");

            try{
                int anoactual = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                  if (session.getAttribute("model") != null) {
                      if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                         if (modelo != null) {

                            %>
<html>
    <head>

        <script language="JavaScript" type="text/javascript">
	function validarcampos(){
            if(document.form.numresolucion.value.length>0){
                if(document.form.fecharesolucion.value.length==10){
                    if(document.form.placa.value.length==6||document.form.placa.value.length==5){
                        if(document.form.vigini.value!="< - >" && document.form.vigfin.value!="< - >"){
                            if(document.form.vigini.value<=document.form.vigfin.value){
                                if(document.form.numR.value.length>0){
                                    document.form.Submit.disabled = true;
                                    document.form.Submit.value = "ESPERE...";
                                    return true;
                                }else{
                                    alert("Digite numero de la radicacion");
                                }
                             }else{
                                alert("La vigencia Inicial no puede ser mayor a la Vigencia final !!!");
                             }
                          }else{
                             alert("Seleccione la vigencia !!!");
                          }
                       }else{
                          alert("Digite la placa !!!");
                       }
                   }else{
                      alert("Digite la fecha de la resolucion !!!");
                   }
               }else{
                  alert("Digite el numero de resolucion !!!");
               }
              return false;
            }

            /*function verReporte(){
		ancho = 789;
		alto = 250;
		barra = 0;
		izquierda = (document.width) ? (document.width-ancho)/2 : 100;
		arriba = (document.height) ? (document.height-alto)/2 : 100;
		opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
		var dir = "revocatoriaTramite/reporte_rev_traslado.jasper";
		var nombre = "reporte_rev_traslado";

		url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
		window.open(url, 'popUp', opciones);
		}*/

       </script>
       <title>Revocatoria de Tramite de Traslado de Cuenta</title>

       <style type="text/css">
            .label {font-size: 11px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold ; width:110px}
            .text {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; width:120px; text-transform:uppercase}
            .date {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; width:100px }
            .bdate {font-size: 10px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold; width:20px }
            .select {font-size: 11px; color:#003366; text-align:left ; font-family:Arial; font-weight:bold; width:120px }
            .input { width:130px }
            .check { font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; }
        </style>


<STYLE>
<!--
A.ssmItems:link		{color:black;text-decoration:none}
A.ssmItems:hover	{color:black;text-decoration:none}
A.ssmItems:active	{color:black;text-decoration:none}
A.ssmItems:visited	{color:black;text-decoration:none}
.style3 {font-size: 12px; font-family: Tahoma; }
.style6 {color: #333333; font-size: 12px; font-weight: bold; }
.Estilo32 {
	color: #FFFFFF;
	font-weight: bold;
	font-size: 12px;
}
-->
</STYLE>

        <link title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
        <script type="text/javascript" src="../html/scripts/adicionarComparendo.js"></script>
        <script type="text/javascript" src="../html/scripts/consultasGenerales.js"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" ol type="text/javascript"></script>
        <script src="../html/scripts/revocatoriatraslado.js" type="text/javascript"></script>



    </head>
    <body>
        <form name="form" method="post" onSubmit="return validarcampos()" class="style3" action="ProcesarTraslado.jsp" >
<%
    HashMap parameters = new HashMap();
    session.setAttribute("reporte_rev_traslado", parameters);

%>
          <table width="100%" border="0" align="center">
            <tr valign="middle">
                <th height="50" colspan="2" scope="col">

                        <fieldset>
                            <table border="0">
				<tr style="border:none; background:url(../html/images/inicio_3.png)">
                                    <td colspan="10" align="center"><span  class="style2 style14 Estilo32">Revocatoria de Tramite de Traslado de Cuenta</span></td>
                                </tr>
                                <tr align="center">
                                  <th width="100"scope="col"><label style="color:#333333"></label></th>
                                  <th width="110" scope="col" align="right"><span class="style6">No.&nbsp;Resolucion</span></th>
                                  <th width="172" scope="col" align="left"><input name="numresolucion" autocomplete="off" type="text" size="25" class="text"/></th>
                                  <th width="137" scope="col" align="right"><span class="style6">Fecha&nbsp;Resolucion</span></th>
                                  <td class="input" align="left"><input name="fecharesolucion" id="fecha_resolucion" type="text"  style="width:99px; text-align:center; color:#333333" onKeyUp="mascara(this,'/',true)" value="" maxlength="10">
                                      <input name="button" type="button" id="lanzador" value="..."  style="width:22px;"/>
                                  <script type="text/javascript">
                                       Calendar.setup({
                                        inputField     :    "fecha_resolucion",      // id del campo de texto
                                        ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                        button         :    "lanzador"   // el id del bot&iuml;&iquest;&frac12;n que lanzar&iuml;&iquest;&frac12; el calendario
                                     });
                                    </script>
                                  </td>
                                  <th width="88" scope="col"  align="right"><span class="style6">Placa</span></th>
                                  <td width="128" class="input"  align="left"><input name="placa" autocomplete="off" maxlength="6" type="text" size="25" class="text" onblur="existeVehiculo(this)" /></td>
                                  <th width="159" scope="col" rowspan="2"><input type="submit" name="Submit" id="Submit" value="Cargar Vigencia"/><span class="style2" ></span></th>
                                 <!-- <th width="159" scope="col" rowspan="2"><button type="button" onClick="verReporte()"><span class="style2">Reporte</span><img src="../html/images/PDF.png"   onBlur="existeVehiculo(this)"   width="19" height="18"/></button></th>-->
                              </tr>
                             <tr align="center">
                                  <th width="100"scope="col"><label style="color:#333333"></label></th>
                                  <th width="110" scope="col" align="right"><span class="style6">Vigencia&nbsp;Inicial</span></th>
                                  <th width="172" scope="col" align="left"><span class="input">
                                    <select name="vigini" class="select" style="width:45px">
                                      <option>< - ></option>
                                      <% for (int m = 2000; m <= anoactual; m++) {%>
                                      <option><%=m%></option>
                                      <% }%>
                                    </select>
                                  </span></th>
                                  <th width="137"scope="col"  align="right"><span class="style6">Vigencia&nbsp;Final</span></th>
                                  <th width="164" scope="col" align="left"><span class="input">
                                  <select name="vigfin" class="select" style="width:45px" >
                                      <option><%=anoactual%></option>
                                  </select>
                                  </span></th>
                                  <th width="137"scope="col"  align="right"><span class="style6">Numero Radicacion</span></th>
                                          <th width="164" scope="col" align="left">
                                              <span class="input">
                                                  <input type="text" name="numR" id="numR" onblur="existeRadicacion()" />
                                              </span>
                                          </th>
                              </tr>
                        </table>
		     </fieldset>

                </th>
            </tr>
		<tr valign="top">
                    <th width="100%" scope="row" valign="top" align="left">
                        <table width="100%" border="0" align="left" >
                            <tr>
                                <td width="2%" valign="top">&nbsp;</td>
				<td width="98%">
                                    <table width="100%" border="0" align="left" >
                                        <tr>
                                            <th height="469" colspan="4" class="Estilo4" scope="col" valign="top">
                                            <iframe src="#" id="vehiculo" name="vehiculo" frameborder="0" marginwidth="0" height="580" width="100%" marginheight="0" align="top" scrolling="auto"></iframe>
                                            </th>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </th>
                </tr>
         </table>
        </form>
    </body>
</html>
<%
                                }
        }else{
%>
			   <jsp:forward page="no_access.jsp">
				 <jsp:param name="tipo" value="1"></jsp:param>
			   </jsp:forward>
<%  }
	}else{
%>
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>
<%

            }
}catch(Exception mexe){

%>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
}
%>