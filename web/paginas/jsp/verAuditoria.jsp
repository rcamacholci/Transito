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
.Estilo20 {font-size: 12px; font-weight: bold;  }
.style9 {color: #FFFFFF; font-weight: bold; font-family: Tahoma; font-size: 12px; }
.style17 {color: #333333; font-size: 11px; font-family: Tahoma; font-weight: bold; }
-->
</style>
<script language="javascript" type="text/javascript">
	function verDetalle(opcion){
		window.parent.frames[1].location.href = "detalle_auditoria.jsp?id="+opcion.id;

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
Usuario usu = (Usuario)session.getAttribute("usuario");
String usuario = "0";
String tabla = "0";
String accion = "0";
String action = "0";
long vehiculo = 0;
String placa = "";
String fecha = "";
if(request.getParameter("usuario")!=null)
    if(request.getParameter("usuario").length()>0)
        usuario = request.getParameter("usuario");

if(request.getParameter("tabla")!=null)
    if(request.getParameter("tabla").length()>0)
        tabla = request.getParameter("tabla");

if(request.getParameter("accion")!=null)
    if(request.getParameter("accion").length()>0)
        accion = request.getParameter("accion");
        action = accion;

if(request.getParameter("placa")!=null)
    if(request.getParameter("placa").length()>0){
        placa = request.getParameter("placa").toUpperCase();
        Vehiculo veh = modelo.consultarVehiculo(placa);
        if(veh!=null)
            vehiculo = veh.getId_vehiculo();
   }

if(request.getParameter("fecha")!=null)
    if(request.getParameter("fecha").length()>0)
        fecha = request.getParameter("fecha").toUpperCase();

%>
<body>
<table width="100%" border="1" cellpadding="1" cellspacing="0">
   <tr style="border:none; background:url(../html/images/inicio_3.png)">
    <td width="4%"  style="border:none"><div align="center" class="style9">N</div></td>
    <td width="16%"  style="border:none"><div align="center" class="style9">PLACA</div></td>
    <td width="16%" style="border:none"><div align="center" class="style9">TABLA</div></td>
    <td width="16%" style="border:none"><div align="center" class="style9">ACCION</div></td>
    <td width="16%" style="border:none"><div align="center" class="style9">FECHA </div></td>
    <td width="16%" style="border:none"><div align="center" class="style9">TIPO </div></td>
    <td width="16%" style="border:none"><div align="center" class="style9">USUARIO </div></td>
    <td width="16%" style="border:none"><div align="center" class="style9">IP </div></td>
  </tr>
  <%
    String fechai = request.getParameter("fechaI");
    String fechaf = request.getParameter("fechaF");
    String user = usu.getNombre();
   java.util.List lista   =  modelo.listarAuditoria(usuario, tabla, accion, vehiculo,fechai,fechaf);
   for(int i=0;i<lista.size();i++){
       Auditoria auditoria = (Auditoria)lista.get(i);

       Vehiculo veh = modelo.consultarVehiculoById(auditoria.getVehiculo());
       if(veh!=null)
           placa = veh.getPlaca();

       accion = auditoria.getAccion().equals("INSERT")?"INSERCION":(auditoria.getAccion().equals("DELETE")?"ELIMINACION":"MODIFICACION");
       String fechaA = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss ").format(auditoria.getFecha());
       String tipo = auditoria.getFlag()==0?"TRAMITE":"CORRECION";
       //String user = usuario;//modelo.consultarUsuario(auditoria.getFk_usuario()).getNombre();
       String ip = auditoria.getIp();


     %>
        <tr bgcolor="#FFFFFF" id="<%=auditoria.getId_auditoria()%>"   ondblclick="verDetalle(this)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=(i+1)%></span></td>
            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= placa %></span></td>
            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= auditoria.getTabla()%></span></td>
            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= accion %></span></td>
            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= fechaA %> </span></td>
            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= tipo %></span></td>
            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= auditoria.getFk_usuario() %></span></td>
            <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= ip %></span></td>
        </tr>
     <%
   }
    HashMap parameters = new java.util.HashMap();
    //javax.swing.JOptionPane.showMessageDialog(null,tabla+"--"+usuario+"---"+vehiculo+"---"+action+"--"+usuario);
    parameters.put("TABLA",tabla);
    parameters.put("FK_USUARIO",usuario);
    parameters.put("FK_VEHICULO",vehiculo);
    parameters.put("USUARIO",user);
    parameters.put("ACTION", action);
    parameters.put("FECHAI", fechai);
    parameters.put("FECHAF", fechaf);
    session.setAttribute("AUDITORIA_", parameters);
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