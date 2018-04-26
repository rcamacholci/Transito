<%-- 
    Document   : AsignarCaja
    Created on : 8/06/2012, 09:05:14 AM
    Author     : acer
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("AdministrarCajas.jsp")){
                    modelo.Model model = (modelo.Model)session.getAttribute("model");
                    Long usu = Long.parseLong(request.getParameter("fk_usu"));
                    Usuario US = model.consultarUsuario(usu);
                    Persona persona = model.consultarPersona(US.getFk_persona());

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

 <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
	<link type="text/css" href="../html/css/button.css" rel="stylesheet"/>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Administrar Usuario</title>
		<STYLE>
<!--
A.ssmItems:link		{color:black;text-decoration:none;}
A.ssmItems:hover	{color:black;text-decoration:none;}
A.ssmItems:active	{color:black;text-decoration:none;}
A.ssmItems:visited	{color:black;text-decoration:none;}
.style1 {
	font-size: 12px;
	font-family: Tahoma;
}
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style5 {color: #ffffff; font-weight: bold; font-size: 17px; font-family: Tahoma; }
.Estilo11 {
	color: #0066CC;
	font-weight: bold;
	font-size: 10px;
}
-->
        </STYLE>


        <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <META http-equiv=Content-Type content="text/html; charset=windows-1252">

</head>

    <body>
        <form id="form" name="form" method="post" action="Procesar_Cajas_permiso.jsp">
        <input type="hidden" name="fecha" id="fecha" />
        <input type="hidden" name="usu" id="usu" value="<%=usu%>" />
<script language="javascript" type="text/javascript">
var f = new Date();
//document.write(f.getDate() + "/" + (f.getMonth() +1) + "/" + f.getFullYear());
if(f.getMonth()+1<=9){
document.form.fecha.value=f.getDate() + "/0" + (f.getMonth() +1) + "/" + f.getFullYear();
}else{
 document.form.fecha.value=f.getDate() + "/" + (f.getMonth() +1) + "/" + f.getFullYear();
}

function Tipo_pago(imf,cnom){
    document.location.href = "AdministrarTipoPago.jsp?usu="+document.form.usu.value+"&caja="+imf+"&nom="+cnom;
}

</script>
  <table width="40%" border="1" align="center"  cellpadding="1" cellspacing="0">
  <tr bgcolor="#CCCCCC" style="border:none;background:url(../html/images/inicio_3.png)">
      <th colspan="3" width="40%" style="border:none"  align="center" ><span class="style5">Usuario</span></td>
  </tr>
  <tr bgcolor="#CCCCCC" style="border:none;background:url(../html/images/inicio_3.png)">
      <th colspan="3" width="40%" style="border:none"  align="center" ><span class="style1"><%=persona.getNombre_1()%> <%=persona.getApellido_1()%></span></td>
  </tr>
  <tr>
      <td width="40%" style="border:"  align="center" ><span class="style1">Nombre</span></td>
      <td width="10%" style="border:" align="center"><span class="style1">Asignar</span></td>
      <td width="20%" style="border:" align="center"><span class="style1">Tipo Pago</span></td>
   </tr>



   <%

        java.util.List caja = model.listarCaja();
        String fecha ="";
        Persona per =null;
        UsuarioCaja cinfo=null;
        java.util.List<UsuarioCaja> uc = model.ListarUsuarioCajas(usu);
        if(uc.size()<=1){
           cinfo = model.consultarCajaUsuario(usu);
        }
        int con=0;
        for(int i=0;i<caja.size();i++){
            Caja info = (Caja)caja.get(i);
            //javax.swing.JOptionPane.showMessageDialog(null,usu);           

           for(int j=0;j<uc.size();j++){
            cinfo = uc.get(j);           
                if(info.getId_caja()==cinfo.getFk_caja() && cinfo.getFechaFin()==null){
                        fecha="cheked";
                }
           }
            //System.out.println(per.getNombre_1()+"-"+per.getApellido_1()+"-"+info.getNombre()+"-"+info.getFechaFin()+"\n");
                   %>

      <tr>
      <td width="65%" align="center" class="style2" style="color:#333333; font-size:12px"><%=info.getNombre()%></td>
      <td width="5%" align="center" class="style2" style="color:#333333; font-size:12px"><input type="checkbox" name="Fcaja" value="<%=info.getId_caja()%>" <%=fecha.equals("")?"":"checked"%> /></td>
      <td  align="center"><img src="../html/images/editar.png" alt="reporte" height="19" width="18" onclick="Tipo_pago('<%=info.getId_caja()%>','<%=info.getNombre()%>')"/></td>
      </tr>
   <%
   fecha="";
     }
   %>
      <tr>
       <th height="42" colspan="3" align="center">
	   <button type="submit" value="Guardar">Guardar <img src="../html/images/guardar.png" width="19" height="18"/></button>
	   <!-- <input type="submit" value="Guardar">--></th>
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
			window.parent.document.location.href = "../../index.jsp";
		</script>
<%
	}
}catch(Exception mexe){
mexe.printStackTrace();
%>

    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
