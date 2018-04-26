<%-- 
    Document   : saldoFavorRecibo
    Created on : 12/03/2013, 10:20:02 AM
    Author     : Jefrey
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
    if(session.getAttribute("model")!=null){
	if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
            Model modelo = (Model)session.getAttribute("model");
            Usuario usuario = (Usuario)session.getAttribute("usuario");
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="../html/css/lineaVertical.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="../html/scripts/tablecloth.js"></script>
        <link href="../html/css/page2ColumDescuentoC.css" rel="stylesheet" type="text/css" media="screen" />
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script type="text/javascript" src="../html/scripts/calendar.js"></script>
        <script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
        <script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <script src="../html/scripts/saldoFavorRecibo.js" type="text/javascript"></script>
        
        <title>Descuento Conceptos</title>
    </head>

    <form name="form" method="post" action="">
    <body>

<fieldset>
<table width="953" border="1">
  <tr>
    <th width="943" scope="col">DESCUENTO CONCEPTOS</th>
  </tr>
</table>

    <div id="lateral">
        <table>
            <tr>
                <th scope="col">NUMERO RECIBO APLICADO</th>
            </tr>
            <tr>
                <td scope="col">
                    <center><input type="text" name="rAplicado" id="rAplicado" maxlength="7" style="text-align:center; font:bold; text-transform:uppercase;" onblur="validarReciboAplicado1(this.value)" /></center>
                </td>
            </tr>
            <tr>
                <td scope="col">&nbsp;</td>
            </tr>
            <tr>
                <th scope="col">NUMERO RECIBO A APLICAR</th>
            </tr>
            <tr>
                <td scope="col">
                    <center><input type="text" name="rAplicar" maxlength="7" style="text-align:center; font:bold; text-transform:uppercase;" id="rAplicar" onblur="validarReciboAplicado2(this.value)"/></center>
                </td>
            </tr>
        </table>
        <input type="button" value="Calcular" onclick="consultar()">
    </div>
    
    <div id="principal">
    <iframe src="" id="verTablarecibos" name="verTablarecibos" marginwidth="0" height="300" width="100%" marginheight="0" align="top" scrolling="auto" style="border:none"></iframe>
    </div>

</fieldset>
</body>
</form>
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