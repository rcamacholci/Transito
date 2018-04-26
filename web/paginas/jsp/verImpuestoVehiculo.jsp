<%-- 
    Document   : procesarImpuestoVehiculo
    Created on : 8/04/2013, 03:18:25 PM
    Author     : Sistemas
--%>

<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("cargarImpuestos.jsp")){
                 modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                 modelo.Model modelo = (modelo.Model)session.getAttribute("model");
%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="../html/scripts/tablecloth.js"></script>
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
        <script>
            function calcularImpuesto(){
                var vrAvaluo = document.form.vrAvaluo.value;
                var total = vrAvaluo * 3;
                document.form.vrImpuesto.value = total;
            }

            function AplicarVigencia(){
                if(confirm("Esta usted seguro de aplicar vigencia")){
                    document.form.action="procesarImpuestoVeh.jsp";
                    document.form.submit();
                }
        }

        </script>

        <title>Impuesto Vehiculo</title>
    </head>
    <body>
        <form name="form" method="post" action="procesarImpuestoVeh.jsp">

            <input type="hidden" name="placa" id="placa" value="<%=request.getParameter("placa")%>" />

        <table>
            <tr>
                <th colspan="4">VALOR IMPUESTO</th>
            </tr>
            <tr>
                <td colspan="2">SELECCIONE AÑO</td>
                <td colspan="2">
                    <select name="concepto" id="concepto">
                        <%
                        java.util.List conc = modelo.consultarVigencias();
                        for(int i=0;i<conc.size();i++){
                        Concepto c = (Concepto)conc.get(i);
                        %>
                        <option value="<%=c.getId_concepto() %>"><%=c.getDescripcion() %></option>
                        <%}%>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Valor Avaluo</td>
                <td><input type="text" name="vrAvaluo" onKeyPress="return soloNumeros(event)" id="vrAvaluo" title="Valor en miles" onblur="calcularImpuesto()" /></td>
                <td>Total Impuesto</td>
                <td><input type="text" readonly name="vrImpuesto" id="vrImpuesto" /></td>
            </tr>
            <tr>
                <td align="right"><input type="button" onclick="AplicarVigencia()" value="Aplicar"></td>
            </tr>
        </table>

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
			window.parent.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){
    mexe.printStackTrace(); %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>