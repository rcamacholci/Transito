<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%

		
                    Model modelo = (Model) session.getAttribute("model");
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

             function buscarDoc(){
                    if(document.form.numero.value!=0){
                        window.frames[0].location.href = "consultarOrdenSalida.jsp?numero="+document.form.numero.value;
                    }else{
                         alert("Digite El Numero de la Orden de Salida");
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
.style5 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
.Estilo1 {color: #FFFFFF}
-->
        </STYLE>


</head>

    <body>
		<form name="form" id="form" method="post" action="">
	        <fieldset>
			<table width="100%" border="0" align="center">
              <tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="style14 style2 style1 Estilo1"><strong>IMPRIMIR ORDEN DE SALIDA </strong></span></td>
		  </tr>
              <tr>
                <td colspan="7"><table border="0" width="100%" id="tabla1">
                    <tr valign="middle">
					
                      <td width="30%" scope="col"   align="right" colspan=""><label style="color:#666666"><span class="style5">REFERENCIA </span></label></td>
					  <td width="6%">&nbsp;</td>
                      <td width="33%" scope="col" align="left" colspan=""><input id="numero" name="numero" type="text" style="text-align:center;color:#333333;font:bold; text-transform:uppercase; width:300px"/></td>
                    
                     
                      <td width="31%" scope="col" align="center"><input id="buscar"  name="buscar" type="button" value="Buscar" style="color:#333333; width:100px" onClick="buscarDoc()"/></td>
                    </tr>
                    
                    
                  </table>
				
                   			  			  
			    </td>
              </tr>
            </table>
		  </fieldset>
		  </br>
		  <fieldset>
		  <iframe src="#" width="100%" id="respuesta" height="200"  frameborder="0" scrolling="auto"></iframe>
		  </fieldset>
		</form>
    </body>
</html>
