<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("GenerarOficioEmbargo.jsp")){
%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Vehiculo</title>
        <style type="text/css">
            <!--
            .Estilo4 {
                font-weight: bold;
                font-family: "Times New Roman", Times, serif;
                color: #FFFF99;
                font-size:12px;
            }
            -->

        </style>
	    <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <META http-equiv=Content-Type content="text/html; charset=windows-1252">

        <script language="javascript" type="text/javascript">
            function consultarPlacas(){
                
                if(document.form.placa.value.length>=1&&document.form.placa.value.length<=6){
                    if(document.form.numOficio.value>0){
                          document.form.submit();
                        }else{
                                alert("Ingrese No de oficio");}
                }else{
					alert("Digite un numero de placa correcta");
					
                }
            }
            
    </script>

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
</head>
    <body>

        
        <table width="100%" border="0" align="center">


            <tr valign="middle">
                <th height="50" colspan="2" scope="col">
                    <form action="OficiosEmbargos.jsp" method="post" name="form" class="style3" id="form">

	 
<fieldset>

                                    <table width="100%" border="0">
		  <tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="style2 style14 Estilo32">REGISTRAR OFICIO</span></td>
		  </tr>
                            <tr>
                                <th width="35%" scope="col">&nbsp;</th>
                              <th width="7%" scope="col"><label style="color:#CC0000"><span class="style6">PLACA</span></label></th>
                              <th width="16%" scope="col"> <input id="placa" name="placa" type="text" maxlength="6" style="text-align:center;color:#333333; font:bold; text-transform:uppercase; width:150px"/></th>
                              <th width="10%" scope="col"><label style="color:#CC0000"><span class="style6">NO OFICIO&nbsp;</span></label></th>
                              <th><input type="text" name="numOficio"  id="numOficio" value="" style="width:150px; color:#333333; text-align:center"/></th>
                              <th width="7%" scope="col"><input id="RegistrarOficio"  name="RegistrarOficio" type="button" value="Siguiente"  onclick="consultarPlacas()" /></th>
                              <th width="35%" scope="col">&nbsp;</th>
                              
                           </tr>
           

                                            </table>
	 </fieldset>
              </form>                </th>
            </tr>
           
        </table>

        
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
}catch(Exception mexe){
mexe.printStackTrace();
%>

    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>