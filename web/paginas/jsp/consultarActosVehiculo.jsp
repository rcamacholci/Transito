<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title></title>
<style type="text/css">
<!--
.style7 {color: #FFFFFF; font-size: 12px; font-family: Tahoma; font-weight: bold; }
.style21 {
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
	color: #333333;
}
.Estilo7 {font-family: Tahoma; font-size: 11px; color: #333333; }
-->
</style>
<script language="javascript" type="text/javascript">
	function mostrar(tr){
		document.location.href = "formularioTramite.jsp?id_radicacion="+tr.id;
	}
	function sombrear(tr){
		tr.style.backgroundColor="#CCCCCC";
	}
	function renovar(tr){
		tr.style.backgroundColor="#FFFFFF";
	}

</script>



</head>
<body>
<%
	Model modelo= (Model)session.getAttribute("model");
	String placa = "";
	if(request.getParameter("id")=="0"){
		placa =  request.getParameter("placa");
	}else{
		placa =  session.getAttribute("placa")+"";
	}
	Tramite tramite= new Tramite();
	Formulario formulario=new Formulario();
	Vehiculo vehiculo  = new Vehiculo();
	vehiculo=modelo.consultarVehiculo(placa.toUpperCase());
	if(placa!=null){
%>

<p align="center" class="style21">ACTOS ADMINISTRATIVOS</p>
	<div align="center">
	  <table width="90%" border="1" cellpadding="1" cellspacing="0" align="center">

		<tr style="border:none; background:url(../html/images/inicio_3.png)">
		  <th width="10%" style="border:none" scope="col"><span class="style7">NUMERO</span></th>
		  <th width="22%" style="border:none" scope="col"><span class="style7">FECHA</span></th>
		  <th width="10%" style="border:none" scope="col"><span class="style7">ACTO</span></th>
		  <th width="35%" style="border:none" scope="col"><span class="style7">PROCESO</span></th>
		  <th width="15%" style="border:none" scope="col"><span class="style7">PLACA</span></th>
		  <th width="20%" style="border:none" scope="col"><span class="style7">USUARIO</span></th>
		  </tr>
                  <%
                    Actos_Administrativos act = null;
                    System.out.print("vehiculo:->"+vehiculo.getId_vehiculo());
                    java.util.List temp =modelo.listaActos(vehiculo.getId_vehiculo());
                  if(temp!=null){
                      int i=0;

                      for(i=0;i<temp.size();i++){
                          act = (Actos_Administrativos)temp.get(i);
                          Usuario usu = modelo.consultarUsuario(act.getFK_USUARIO());
            %>
            <tr bgcolor="#FFFFFF" onMouseOver="sombrear(this)"  style="cursor:pointer" onMouseOut="renovar(this)" id="0">
            <th scope="col"><span class="Estilo7"><%=i%></span></th>
            <th scope="col"><span class="Estilo7"><%=new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm:ss").format(act.getFECHA_PROCESO())%></span></th>
            <th scope="col"><span class="Estilo7"><%=act.getNUMERO()%></span></th>
            <th scope="col"><span class="Estilo7"><%=act.getTRAMITE()%></span></th>
	    <th scope="col"><span class="Estilo7"><%=vehiculo.getPlaca()%></span></th>
	    <th scope="col"><span class="Estilo7"><%=usu.getNombre()%></span></th>
            </tr>
            <%}
            }else{%>
            <tr bgcolor="#FFFFFF" onMouseOver="sombrear(this)"  style="cursor:pointer" onMouseOut="renovar(this)" id="0">
                <th scope="col" colspan="6"><span class="Estilo7">No Posee Actos Administrativos</span></th>
            </tr>
            <%}%>
  </table>
 <% }
%>
</div>
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