<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.DatosVehiculo" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Prestamos</title>
<style type="text/css">
<!--
.Estilo13 {color: #FFFFFF; font-weight: bold; }
.Estilo20 {font-size: 12px; font-weight: bold;  }
.style9 {color: #FFFFFF; font-weight: bold; font-family: Tahoma; font-size: 12px; }
.style17 {color: #333333; font-size: 11px; font-family: Tahoma; font-weight: bold; }
-->
</style>
<script language="javascript" type="text/javascript">
	function edit(opcion){
		window.location.href = "AsignarPerfiles.jsp?id_usuario="+opcion.id;
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
Sede sede= (Sede)session.getAttribute("sede");



%>
<body>
<fieldset>
<table width="100%" border="1" cellpadding="1" cellspacing="0">
   <tr style="border:none; background:url(../html/images/inicio_3.png)">
    <td width="10%"  style="border:none"><div align="center" class="style9">USUARIO</div></td>
    <td width="10%" style="border:none"><div align="center" class="style9">DOCUMENTO</div></td>
    <td width="35%" style="border:none"><div align="center" class="style9">NOMBRE </div></td>
	<td width="15%" style="border:none"><div align="center" class="style9">ESTADO</div></td>
    <td width="15%" style="border:none"><div align="center" class="style9">CAJA</div></td>
    <td width="15%" style="border:none"><div align="center" class="style9">RUNT</div></td>
   
  </tr>
  <%

   java.util.List lista   =  modelo.listarUsuarios(sede.getId_sede());
   for(int i=0;i<lista.size();i++){
        Usuario usuario = (Usuario)lista.get(i);
    Persona persona = modelo.consultarPersona(usuario.getFk_persona());
    UsuarioCaja usu_caja = modelo.consultarCajaUsuario(usuario.getId_usuario());
    UsuarioRunt usu_runt = modelo.consultarUsuarioRunt(usuario.getId_usuario());
    String caja = "";
    String runt = "";
    if(usu_caja!=null){
        caja = "SI";
    }else{
        caja = "NO";
    }

    if(usu_runt!=null){
        runt = "SI";
    }else{
        runt = "NO";
    }
%>

                <tr bgcolor="#FFFFFF" id="<%= usuario.getId_usuario() %>"   ondblclick="edit(this)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= usuario.getNombre() %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= persona.getDocumento()%></span></td>
		<td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= persona.getNombre_1()+" "+persona.getApellido_1() %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= usuario.getFechaFin()==null?"ACTIVO":"INACTIVO" %></span></td>
		<td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= caja %></span></td>
                <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= runt %></span></td>
               
  </tr>

     <%

   }
   %>
</table>
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
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>