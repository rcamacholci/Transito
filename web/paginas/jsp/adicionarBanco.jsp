<%--
    Document   : buscarInfraccion
    Created on : 14/03/2011, 01:58:59 PM
    Author     : Administrador
--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <%
try{
    Model modelo = (Model)session.getAttribute("model");
    Parametro parametro=new Parametro();

%>
<head>
    <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
    <script type="text/javascript" src="../html/scripts/tablecloth.js"></script>
    <link href="../html/css/page2Colum.css" rel="stylesheet" type="text/css" media="screen" />
    <title>Adicionar Banco</title>
    
<script language="javascript" type="text/javascript">
	function Adicionar(){
            var Nbanco = document.form.banco.value;
            if(Nbanco.length>0){
            if(confirm("Desea adicionar el Banco?")){
                window.frames[0].location.href = "agregarBanco.jsp?NombreBanc="+Nbanco;
                window.opener.document.forms[0].NombreBanco.value = Nbanco
            }
            }else{
                alert("No ha digitado Banco");
            }
        }
        
</script>
    
</head>
<body>
    <form  name="form"  method="post" action="javascript:Adicionar()">
	<fieldset>
	   <table>
			<tr>
                            <th align="center" style="background-position:center">Nombre Banco</th>
                            <td><input type="text" class="text" name="banco" style="width:350px; font-size:11px"  /></td>
			</tr>

	  </table>
	</fieldset>
        <iframe src="#" width="100%" id="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe>
</form>
</body>
</html>
<%
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% } %>