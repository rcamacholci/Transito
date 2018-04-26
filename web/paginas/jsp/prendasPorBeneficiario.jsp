<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Prendas por beneficiario</title>
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

          function ConsultarPrendas(){

              var nprenda = document.form.prenda.value;

                    window.frames[0].location.href = "VerprendasPorBeneficiario.jsp?&prenda="+nprenda;
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
                    <form action="" method="post" name="form" class="style3" id="form">

					   <fieldset>


					    <table width="100%" border="0">
						<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="style2 style14 Estilo32">CONSULTAR PRENDAS</span></td>
		  </tr>
                            <tr>
                              <th width="35%" scope="col"><label style="color:#CC0000"></label></th>
                              <th width="7%" scope="col"><label style="color:#CC0000"><span class="style6">PRENDA</span></label>                              </th>
                              <th width="16%" scope="col"> <input id="prenda" name="prenda" type="text" style="color:#333333; font:bold; width:300px"/></th>
                              <th width="7%" scope="col"><input id="ConsultarPrendatarios"  name="ConsultarPrendatarios" type="button" value="Consultar"  onclick="ConsultarPrendas()" /></th>
                                <th width="35%" scope="col">&nbsp;</th>
                            </tr>
                        </table>
						</fieldset>
              </form>                </th>
            </tr>
            <tr valign="top">
                <th height="469" colspan="4" class="Estilo4" scope="col" valign="top">
                    <iframe src="VerprendasPorBeneficiario.jsp?&prenda=""" width="100%" id="VerprendasPorBeneficiario" height="500"  frameborder="0" scrolling="auto"></iframe>
                </th>
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