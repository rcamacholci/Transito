<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.DatosVehiculo" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarAuditoria.jsp")){
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Ver Auditoria</title>
<style type="text/css">
<!--
.Estilo13 {color: #FFFFFF; font-weight: bold; }
.Estilo20 {font-size: 12px; font-weight: bold; }
.style9 {color: #FFFFFF; font-weight: bold; font-family: Tahoma; font-size: 12px; }
.style17 {color: #333333; font-size: 11px; font-family: Tahoma; font-weight: bold; }
-->
</style>
<script language="javascript" type="text/javascript">
	function edit(opcion){
		document.location.href = "editarCaracteristicas.jsp?idv="+opcion.id;
	}
	function sombrear(tr){
		tr.style.backgroundColor="#CCCCCC";
	}
	function renovar(tr){
		tr.style.backgroundColor="#FFFFFF";
	}

</script>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>



<%


Model modelo= (Model)session.getAttribute("model");
long id_auditoria = 0;
if(request.getParameter("id")!=null)
    if(request.getParameter("id").length()>0)
        id_auditoria = Long.parseLong(request.getParameter("id"));


%>
<body>


<table width="100%" border="1" cellpadding="1" cellspacing="0">
   <tr style="border:none; background:url(../html/images/inicio_3.png)">
       <td width="20%"  style="border:none"><div align="center" class="style9">PLACA</div></td>
    <td width="20%"  style="border:none"><div align="center" class="style9">COLUMNA</div></td>
    <td width="20%" style="border:none"><div align="center" class="style9">VALOR ANTERIOR </div></td>
    <td width="20%" style="border:none"><div align="center" class="style9">VALOR NUEVO </div></td>

  </tr>



  <%



   Auditoria_Detalle ad  =  modelo.consultarDetalleAuditoria(id_auditoria);

      if(ad!=null){
          Auditoria auditoria = modelo.consultarAuditoriaId(ad.getFk_auditoria());
          Vehiculo vehiculo = modelo.consultarVehiculoById(auditoria.getVehiculo());
          System.out.println("columna :" +ad.getColumna());

           %>

        <tr bgcolor="#FFFFFF" id=""   ondblclick="edit(this)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= vehiculo.getPlaca()!=null?vehiculo.getPlaca():"" %></span></td>
            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= ad.getColumna()!=null?ad.getColumna():"" %></span></td>
            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= ad.getValor_anterior()!=null?ad.getValor_anterior():"" %></span></td>
            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= ad.getValor_nuevo()!=null?ad.getValor_nuevo():"" %></span></td>

        </tr>
     <% }
   %>
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