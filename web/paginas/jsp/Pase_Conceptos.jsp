<%-- 
    Document   : descuentoConceptos
    Created on : 6/02/2013, 05:22:42 PM
    Author     : Jefrey
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
    if(session.getAttribute("model")!=null){
	//if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
if(1==1){
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
        <title>Descuento Conceptos</title>
    </head>
   

    <script>
    function AplicarExcedente(){
            if(document.getElementById('observacion').value.length>1){
                if(confirm("Esta seguro que desea aplicar Excedente?")){
                    elem = document.getElementById('procesando');
                    elem.style.display='block';
                    elem1 = document.getElementById('procesando1');
                    elem1.style.display='block';
                    document.location.href = "procesarExcedente.jsp?id_tiquete1="+document.form.id_tiquete1.value+"&id_tiquete2="+document.form.id_tiquete2.value+"&valorT="+document.form.valorT.value+"&observacion="+document.form.observacion.value;
                 }
	    }else{
                alert("Debe ingresar un motivo");
	    }
    }


    </script>

    <body>
<fieldset>
<table width="953" border="1">
  <tr>
    <th width="943" scope="col">CAMBIO DE AÑO CONCEPTOS</th>
  </tr>
</table>

    <div id="lateral">
        <iframe src="verTramitePase_Conceptos.jsp" id="verTramiteDescuentos" name="verTramiteDescuentos" marginwidth="0" height="500" width="100%" marginheight="0" align="top" scrolling="auto" style="border:none"></iframe>
    </div>

    <div id="div-border"></div>
    <div id="principal">
    <iframe src="" id="verTablaPase_Conceptos" name="verTablaDescuento" marginwidth="0" height="300" width="100%" marginheight="0" align="top" scrolling="auto" style="border:none"></iframe>
    
    </div>

</fieldset>
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