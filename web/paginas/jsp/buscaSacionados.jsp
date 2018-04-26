<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		//if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
            if(1==1){ 
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Comparendo</title>


	    <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <META http-equiv=Content-Type content="text/html; charset=windows-1252">
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
		<SCRIPT SRC="../html/scripts/ssm.js" language="javascript"></SCRIPT>
		<SCRIPT SRC="../html/scripts/ssmItems0.js" language="javascript"></SCRIPT>
    <script language="javascript" type="text/javascript">
            function consultarComparendo(){
                if(document.form.comparendo.value.length>0){
                    var ncomparendo = document.form.comparendo.value;
					window.frames[0].location.href = "VerReporteReimpresionSancionados.jsp?id=0&comparendo="+ncomparendo;
                }else{
                    alert("Digite un numero de comparendo correcta");
                }
            }
                
    </script>
 <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
 
</head>
    <body> 
       
                    <form name="form" id="form" method="post" action="javascript:consultarComparendo()">
                        
						<fieldset>
                                                    <table width="100%" border="0" align="center">
						<tr style="border:none;">
        <th colspan="11" align="center"><span class="style2 style14 style7 Estilo11">CONSULTAR COMPARENDOS </span></th>
     </tr>
                            <tr>
                                <td width="35%" scope="col"><label style="color:#333333"></label></td>
                              <td width="7%" scope="col"><label style="color:#333333"><span class="style2">NUMERO</span></label></td>
                              <td width="15%" scope="col">
				<input id="comparendo" name="comparendo" type="text" size="25" style="text-align:center;color:#333333; font:bold; text-transform:uppercase"/></td>
                              <td width="8%" scope="col">
                                <button id="consultaComparendo"  name="consultaComparendo" type="button" onClick="consultarComparendo()"><span class="style2">Consultar </span><img src="../html/images/lupa.png" width="19" height="18"/></button>
<!--  <input id="consultaComparendo"  name="consultaComparendo" type="button" value="Consultar"  onclick="consultarComparendo()" /> --></td>
                                <td width="35%" scope="col">&nbsp;</td>
                            </tr>
                        </table>
						</fieldset>
                    </form>               
               
			               
        <table width="100%" border="0" align="center" >
		                             <tr>
                                                 <td height="469" colspan="4" class="Estilo4" style="width:96%; right:0px;" scope="col" valign="top">
								<iframe src="#" id="vehiculo" name="vehiculo" frameborder="0" marginwidth="0" height="580" width="100%" marginheight="0" align="top" scrolling="auto"></iframe>
                            </td>
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
