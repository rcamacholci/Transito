<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                       modelo.Model model = (modelo.Model)session.getAttribute("model");
                       
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
		<script language="javascript" type="text/javascript">
			
			function paso(){           
				if(document.form.numOficio.value.length!=0){
                                    if(document.form.fechaO.value.length!=0){
                                        var numOficio = document.form.numOficio.value;
                                        var fechaO = document.form.fechaO.value;
					window.frames[0].location.href = "verOficiosEmbargos.jsp?numOficio="+numOficio+"&fechaO="+fechaO;
                                    }else{
                                         alert("Digite la fecha del Oficio");
                                    }
                                }else{
                                    alert("Digite el Numero del Oficio");
                                }
			}
                        
		</script>
		<STYLE>
<!--
A.ssmItems:link		{color:black;text-decoration:none;}
A.ssmItems:hover	{color:black;text-decoration:none;}
A.ssmItems:active	{color:black;text-decoration:none;}
A.ssmItems:visited	{color:black;text-decoration:none;}
.Estilo11 {
	color: #0066CC;
	font-weight: bold;
	font-size: 10px;
}
.style7 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
.style8 {
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
	color: #333333;
}
-->
        </STYLE>


</head>
    <%
   
    try {
        model = (Model) session.getAttribute("model");
    } catch (Exception exc) {
        exc.printStackTrace();
    }
    %>
    <body> 
		<form name="form" id="form" method="post" action="verPrestamos.jsp" >
	        <fieldset>
			<table width="100%" border="0" align="center">
<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="6" align="center" valign="middle"><span class="style7">CONSULTAR OFICIOS DE EMBARGOS </span></td>
			</tr>
				
					<tr valign="middle">
					  <td width="20%"  align="center" scope="col" ><span class="style8">N&deg; OFICIO </span></td>
					  <td width="20%" align="center">
					  <input id="numOficio" name="numOficio" type="text"  style="text-align:center;color:#333333;font:bold; width:120px; text-transform:uppercase"/>					</td>
					<td width="20%"  align="center" class="style8" scope="col" >FECHA OFICIO </td>
					<td width="20%"><span class="Estilo8">
					  <input id="fechaO" name="fechaO" type="text" value="" style=" width:100px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; color:#333333; text-align:center" onKeyUp="mascara(this,'/',true)" maxlength="10"/>
					</span>
					  <input name="btfechaO" type="button" id="btfechaO" value="&lt;" style="width:20px; text-align:center"/>
					     <script type="text/javascript">
			Calendar.setup({
				inputField     :    "fechaO",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "btfechaO"   // el id del bot?n que lanzar? el calendario
			});
		 </script>					  </td>
                      <td width="20%"   align="center" scope="col"><input  name="generar1" type="button" id="generar1" style="width:150px" onClick="paso()" value="Consultar Oficio"/></td>
                    </tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
           </table>
		  </fieldset>
		  
		  <iframe src="#" width="100%" id="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe>
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