<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarEmpresaVinculadora.jsp")){
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Alertas</title>
<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<link rel=StyleSheet href="../html/css/msj.css" Ttype="text/css" media=screen>
<script type="text/javascript" src="../html/scripts/calendar.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
<script type="text/javascript" src="../html/scripts/alertas.js"></script>
<script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
 <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="../html/scripts/tablecloth.js"></script>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>

<%
Model modelo= (Model)session.getAttribute("model");
String placa = "";
if(request.getParameter("id")=="0"){
	placa =  request.getParameter("placa");
}else{
	placa =  session.getAttribute("placa")+"";
}
if(placa!=null){
Vehiculo vehiculo  = new Vehiculo();
vehiculo=modelo.consultarVehiculo(placa.toUpperCase());
if (vehiculo!=null){
%>
<script language="javascript" type="text/javascript">
	function edit(opcion){
		document.location.href = "editarEmpresaV.jsp?idEmpresaV="+opcion.id;
	}
	function sombrear(tr){
		tr.style.backgroundColor="#CCCCCC";
	}
	function renovar(tr){
		tr.style.backgroundColor="#FFFFFF";
	}

</script>
<body>
<table width="90%" border="1" >
   <tr>
    <th width="18%" scope="col">NIT</th>
    <th width="45%" scope="col">EMPRESA</th>
   <th width="10%" scope="col">FECHA INICIO</th>
    <th width="13%" scope="col">FECHA FIN</th>
	</tr>
  <%

   java.util.List lista   =  modelo.consultarEmpresaVinculadora(vehiculo.getId_vehiculo());

   for(int i=0;i<lista.size();i++){
       Empresa_Vinculadora empresaV = (Empresa_Vinculadora)lista.get(i);
       String nombre="";
       if(empresaV.getFk_persona()>0){
            Persona persona = modelo.consultarPersona(empresaV.getFk_persona());
            if(persona!=null){
                nombre=(persona.getNombre_1()+" "+persona.getApellido_1());

 %>
              <tr style="cursor:pointer" id="<%=empresaV.getId_empresa_vinculadora() %>" ondblclick="edit(this)" >
                <td scope="col"><%=persona.getDocumento()%></td>
                <td scope="col"><%=nombre%></td>
		<td scope="col"><%=empresaV.getFecha_inicio()%></td>
                <td scope="col"><%=empresaV.getFecha_fin()!=null?empresaV.getFecha_fin():""%></td>
              </tr>

   <%
            }
        }
   }
   %>
</table>
<% }
 }
%>
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
           mexe.printStackTrace();     %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>