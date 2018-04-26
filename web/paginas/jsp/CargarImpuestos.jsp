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
	function validarcamposImp(){
                    if(document.form.placa.value.length>4){
                        if(document.form.vigini.value!="< - >" && document.form.vigfin.value!="< - >"){
                            if(document.form.vigini.value<=document.form.vigfin.value){
                                if(document.form.observacion.value.length!=0){
                                return true;
                                }else{
                                    alert("Digite una observacion !!!");
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
              return false;
            }


       </script>
       <title>Cargar Impuestos Vehiculos</title>

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
        <script src="../html/scripts/cargarimpuestos.js" type="text/javascript"></script>
        <script src="../html/scripts/consultaractoadmin.js" type="text/javascript"></script>



    </head>
    <body>
<%
    HashMap parameters = new HashMap();
    session.setAttribute("reporte_rev_traslado", parameters);

%>
          <table width="100%" border="0" align="center">
            <tr valign="middle">
                <td height="50" colspan="2" scope="col">
                    <form name="form" method="post" class="style3" onSubmit="return validarcamposImp()" action="ProcesarCargueImpuestos.jsp" ><!---->
                        <fieldset>
                            <table border="0">
				<tr style="border:none; background:url(../html/images/inicio_3.png)">
                                    <td colspan="12" align="center"><span  class="style2 style14 Estilo32">CARGAR IMPUESTOS DE VEHICULOS</span></td>
                                </tr>
                                <tr align="center">
                                  <td width="102"scope="col"><label style="color:#333333"></label></td>
                                  <td width="164"scope="col"><label style="color:#333333"></label></td>
                                  <td width="123" scope="col"  align="right"><span class="style6">Placa</span></td>
                                  <td width="129" class="input"  align="left"><input name="placa" autocomplete="off" maxlength="6" type="text" size="25" class="text" onBlur="existenVehiculos(this)"/></td>
                                  <td width="89" scope="col" align="right"><span class="style6">Vigencia&nbsp;Inicial</span></td>
                                  <td width="45" scope="col" align="left"><span class="input">
                                    <select name="vigini" class="select" style="width:45px">
                                      <option>< - ></option>
                                      <% for (int m = 2000; m <= anoactual; m++) {%>
                                      <option><%=m%></option>
                                      <% }%>
                                    </select>
                                  </span></td>
                                  <td width="81"scope="col"  align="right"><span class="style6">Vigencia&nbsp;Final</span></td>
                                  <td width="102" scope="col" align="left"><span class="input">
                                  <select name="vigfin" class="select" style="width:45px" >
                                      <option>< - ></option>
                                      <% for (int m = 2000; m <= anoactual; m++) {%>
                                      <option><%=m%></option>
                                      <% }%>
                                  </select>
                                  </span></td>
                                  <td width="85"scope="col"><label style="color:#333333"></label></td>
                                  <td width="308" scope="col" rowspan="2"><input type="submit" name="Submit" value="Cargar Vigencia"/><span class="style2" ></span></td>
                              </tr>
                             <tr align="center">
                                <td width="85"scope="col"><label style="color:#333333"></label></td>
                                <td colspan="3" align="right"><span class="style6">Observaciones</span></td>
                                    <td colspan="2" align="left">
                                        <input id="observacion" name="observacion" class="style5" style="font-size:10px; text-align:center; color:#333333" size="90" >
                               </td>
							    <td width="85"scope="col"><label style="color:#333333"></label></td>
                              </tr>
                        </table>
		     </fieldset>
                    </form>
                </td>
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
        <h1></h1>
    </body>
</html>
