<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%
try{
    Model model = null;
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                    modelo.Model modelo = (modelo.Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                    model = (Model) session.getAttribute("model");
        %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Vehiculo</title>
<style type="text/css">

<!--
.Estilo8 {color: #333333; font-weight: bold; font-size: 12px; }
.Estilo14 {color: #333333; font-size: 12px; }
.style1 {font-family: Tahoma}
.style2 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
.Estilo18 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
-->
</style>
    <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
		<script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
		<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript">
		
                    function mostrar(){
                        if(document.form.numero_interno.value.length>0){
                            var numeroInt = document.form.numero_interno.value;
                            window.frames[0].location.href = "verOficios.jsp?numero_interno="+numeroInt;
	                }else{
                            alert("Favor digite El numero Interno de Seguridad");
                        }
                    }
			function validarCampos(){
				if(document.form.numero_interno.value.length>0){
                                    return true;
                                    alert("Ingrese numero Interno");
				}
                            return false;
			}
			
		</script>
<style type="text/css">

<!--
.Estilo8 {color: #333333; font-weight: bold; font-size: 12px; }
.Estilo14 {color: #333333; font-size: 12px; }
.style1 {font-family: Tahoma}
.style2 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
.Estilo18 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
-->
</style>


</head>
    <body>                                                                                                                         
        <form name="form" id="form" method="post" action="verOficios.jsp" target="respuesta" onSubmit="return validarCampos()">
	        <fieldset>
			<table width="100%" border="0" align="center">
			<tr style="border:none; background:url(../html/images/inicio_3.png)">
					<td colspan="11" align="center"><span class="Estilo18"><strong>RADICAR SOLICITUD DE OFICIOS </strong></span></td>
	      	  <tr>
				<tr>
					<td colspan="5">
						<table border="0" width="100%" id="tabla1">
							  <tr valign="middle">
								 <td width="36%" scope="col" align="right"><span class="Estilo8">NUMERO&nbsp;DE&nbsp;RADICACI&Oacute;N </span></td>						  
							  <td width="33%" scope="col"  align="center">
                                                              <% if(request.getParameter("numero_interno")!=null&&!request.getParameter("numero_interno").equals("0")){%>
                                                              <input id="numero_interno" value="<%=request.getParameter("numero_interno")%>" name="numero_interno" type="text" style="text-align:center;color:#333333;font:bold; width:150px"/>
                                                           <% }else{ %>
                                                           <input id="numero_interno" name="numero_interno" type="text" style="text-align:center;color:#333333;font:bold; width:150px"/>
                                <% } %>                                </td>
							 
							  <td width="31%"  align="center">
<button id="consultar"  name="consultar" type="button" onClick="mostrar()"><span class="style2">Consultar Información del Oficio </span><img src="../html/images/lupa.png" width="19" height="18"/></button>
<!-- <input id="consultar"  name="consultar" type="button" value="Consultar Informacion del Oficio" onClick="mostrar()" style="color:#333333"/> --></td>
							  </tr>
						</table>
						
						
										
					</td>
				</tr>	
           </table>
		  </fieldset>
               <iframe src="#" width="100%" id="respuesta" name="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe>
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

