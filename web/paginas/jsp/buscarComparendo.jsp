<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Comparendo</title>
        <style type="text/css">
            <!--
            .Estilo4 {
                font-weight: bold;
                font-family: "Times New Roman", Times, serif;
                color: #FFFF99;
                font-size:10px;
            }
            -->
            
        </style>
	    <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <META http-equiv=Content-Type content="text/html; charset=windows-1252">
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
		<SCRIPT SRC="../html/scripts/ssm.js" language="javascript"></SCRIPT>
		<SCRIPT SRC="../html/scripts/ssmItems2.js" language="javascript"></SCRIPT>
        <script language="javascript" type="text/javascript">
            function consultarComparendo(){
                if(document.form.comparendo.value.length>0){
                    var ncomparendo = document.form.comparendo.value;
					window.frames[0].location.href = "consultarComparendo.jsp?id=0&comparendo="+ncomparendo;
                }else{
                    alert("Digite un numero de comparendo correcta");
                }
            }
                
    </script>
        <STYLE>
<!--
A.ssmItems:link		{color:black;text-decoration:none;}
A.ssmItems:hover	{color:black;text-decoration:none;}
A.ssmItems:active	{color:black;text-decoration:none;}
A.ssmItems:visited	{color:black;text-decoration:none;}
.style2 {
	color: #333333;
	font-size: 12px;
	font-family: Tahoma;
	font-weight: bold;
}
.style3 {font-size: 12px}
.Estilo11 {color: #FFFFFF}
-->
        </STYLE>


</head>
    <body> 
        <table width="100%" border="0" align="center">
		
			
            <tr valign="middle">
                <th height="50" colspan="2" scope="col">
                    <form name="form" id="form" method="post" action="javascript:consultarComparendo()">
                        
						<fieldset>
						<table width="100%" border="0">
						<tr style="border:none; background:url(../html/images/inicio_3.png)">
        <td colspan="11" align="center"><span class="style2 style14 style7 Estilo11">CONSULTAR COMPARENDOS </span></td>
     </tr>
                            <tr>
                                <th width="35%" scope="col"><label style="color:#333333"></label></th>
                              <th width="7%" scope="col"><label style="color:#333333"><span class="style2">NUMERO</span></label></th>
                              <th width="15%" scope="col">
							  <input id="comparendo" name="comparendo" type="text" size="25" style="text-align:center;color:#333333; font:bold; text-transform:uppercase"/></th>
                              <th width="8%" scope="col">
<button id="consultaComparendo"  name="consultaComparendo" type="button" onclick="consultarComparendo()"><span class="style2">Consultar </span><img src="../html/images/lupa.png" width="19" height="18"/></button>							  
<!--  <input id="consultaComparendo"  name="consultaComparendo" type="button" value="Consultar"  onclick="consultarComparendo()" /> --></th>
                                <th width="35%" scope="col">&nbsp;</th>
                            </tr>
                        </table>
						</fieldset>
                    </form>               
                </th>
            </tr>
			<tr valign="top">
                <th width="100%" scope="row" valign="top" align="left">
                    <table width="100%" border="0" align="left" >
						<tr>
							<td width="2%" valign="top">&nbsp;
							</td>
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
