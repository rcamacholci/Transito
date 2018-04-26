<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*"  import="modelo.Parametro"  errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Vehiculo</title>
    <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
		<script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
	<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
	<script language="javascript" type="text/javascript">

        function buscarS(){
             window.frames[0].location.href = "verSalariosMinimos.jsp?vigencia="+document.form.vigenciaC.value;
        }
        function ingresarS(){
                if(document.form.vigenciaI.value.length>0){
                        if(document.form.valor.value.length>0){
                           window.location.href = "procesarSalarioMinimo.jsp?vigencia="+document.form.vigenciaI.value+"&valor="+document.form.valor.value;
                        }else{
                            alert("Digite El valor de La vigencia : "+document.form.vigenciaI.value);
                        }
                }else{
                    alert("Digite vigencia a Ingresar");
                }
        }


			function ver(){
				if(document.form.busqueda[0].checked){
					document.getElementById('tabla1').style.display = "block";
					document.getElementById('tabla2').style.display = "none";
                                }else{
                                      	document.getElementById('tabla1').style.display = "none";
					document.getElementById('tabla2').style.display = "block";
                                }
			}
		
		</script>
		<STYLE>
<!--
A.ssmItems:link		{color:black;text-decoration:none;}
A.ssmItems:hover	{color:black;text-decoration:none;}
A.ssmItems:active	{color:black;text-decoration:none;}
A.ssmItems:visited	{color:black;text-decoration:none;}
.style1 {
	font-size: 12px;
	font-family: Tahoma;
}
.style5 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
.Estilo11 {
	color: #0066CC;
	font-weight: bold;
	font-size: 10px;
}
-->
        </STYLE>


</head>
    <%
    Model model = null;
    try {
        model = (Model) session.getAttribute("model");
    } catch (Exception exc) {
        exc.printStackTrace();
    }
    %>
    <body>
        <form name="form" id="form" method="post" action="">
	        <fieldset>
			<table width="100%" border="0" align="center">
           <tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="4" align="center"><span class="style5">CONSULTA E INGRESO DE SALARIOS MINIMOS</span></td>
	    </tr> 
				<tr>                                
				  <td colspan="2" valign="middle" align="center" width="50%"><span class="Estilo11">
				  <input type="radio" name="busqueda" value="1" checked="checked" onClick="ver()">
				  CONSULTAR SALARIOS MINIMOS
				  </span></td>
				  <td colspan="2" valign="middle" align="center" width="50%"><span class="Estilo11">
				  <input type="radio" name="busqueda" value="2" onClick="ver()">
				  INGRESAR SALARIOS MINIMOS</span></td>
				</tr>
            
				<tr>
					<td colspan="4">
                                            <fieldset>
					<table border="0" width="100%" id="tabla1">
                                  	<tr valign="middle">
                                            <td width="33%" scope="col" align="center" colspan="3"><label style="color:#333333"><span class="Estilo11">VIGENCIA</span></label></td>
                                            <td>&nbsp;</td>
                                            <td width="33%" scope="col" align="center" colspan="3"><span style="border:none">
                                              <select name="vigenciaC" id="vigenciaC" style="width:200px; font-size:11px">
                                                    <option value="0"> -- SELECCIONE VIGENCIA -- </option>
                                                <% 
		         java.util.List list = model.consultarSalariosMinimos(0,0);
        		 java.util.Iterator it = list.iterator();
		         while (it.hasNext()) {
        	         Salarios_Minimos salarioM = (Salarios_Minimos)it.next();
                        %>
                                                <option value="<%=salarioM.getVigencia()%>"><%=salarioM.getVigencia() %></option>
                                                <% 
                                                    
                         }%> <% Salarios_Minimos sm = model.buscarUltimoSalarioMinimo(); %>
                                              </select>
                                      </span></td>
                                            <td>&nbsp;</td>
                                            <td width="33%" scope="col" align="center" colspan="3"><input id="consultar"  name="consultar" type="button" onClick="buscarS()" value="Consultar Salario Minimo" style="color:#333333"/></td>
                                            <td>&nbsp;</td>
                                           
                                        </tr>
						</table>
                                              
                                            <table border="0" width="100%" id="tabla2" style="display:none">
                                      
					<tr valign="middle">
                                            <td width="20%" scope="col" align="center" colspan="3"><label style="color:#333333"><span class="Estilo11">VIGENCIA</span></label></td>
                                           
                                            <td width="20%" align="center"><input id="vigenciaI" maxlength="4" name="vigenciaI"  onKeyPress="return soloNumeros(event)" type="text" style="text-align:center;color:#333333;font:bold; width:130px" value="<%= (sm.getVigencia() + 1)%>" readonly="readonly"/></td>
                                            <td width="20%" scope="col" align="center" colspan="3"><span class="Estilo11">VALOR</span></td>
                                            <td width="20%" align="center"><input id="valor" name="valor" type="text" style="text-align:center;color:#333333;font:bold; width:130px"/></td>
                                            <td width="40%" scope="col" align="center" colspan="3"><input id="consultar"  name="consultar" onClick="ingresarS()" type="button" value="Ingresar Salario Minimo" style="color:#333333"/></td>
                                            <td>&nbsp;</td>

                                        </tr>
						</table>
                                                </fieldset>
                                         
					</td>
				</tr>
           </table>
		  </fieldset>
		  <iframe src="#" width="100%" id="respuesta" height="500"  align="center" frameborder="0" scrolling="auto"></iframe>
        </form>
    </body>
</html>
<%  }else{ %>
			   <jsp:forward page="no_access.jsp">
				 <jsp:param name="tipo" value="1"></jsp:param>
			   </jsp:forward>
	<%  }
	}else{ %>
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
