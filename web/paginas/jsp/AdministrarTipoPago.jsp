<%-- 
    Document   : AdministrarTipoPago
    Created on : 12/06/2012, 02:05:21 PM
    Author     : acer
--%>

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
                    Long usu = Long.parseLong(request.getParameter("usu"));
                    Long cj =Long.parseLong(request.getParameter("caja"));
                    Usuario US = model.consultarUsuario(usu);
                    String nom = request.getParameter("nom");
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
        <form id="form" name="form" method="post" action="ProcesarTipoPago.jsp">
        <input type="hidden" name="fecha" id="fecha" />
        <input type="hidden" name="usu" id="usu" value="<%=usu%>" />
        <input type="hidden" name="cj" id="cj" value="<%=cj%>"/>
<script language="javascript" type="text/javascript">
var f = new Date();
//document.write(f.getDate() + "/" + (f.getMonth() +1) + "/" + f.getFullYear());
if(f.getMonth()+1<=9){
document.form.fecha.value=f.getDate() + "/0" + (f.getMonth() +1) + "/" + f.getFullYear();
}else{
 document.form.fecha.value=f.getDate() + "/" + (f.getMonth() +1) + "/" + f.getFullYear();
}

function Tipo_pago(imf){
    alert("lool"+imf);
    
}

</script>
        <table width="40%" border="1" align="center"  cellpadding="1" cellspacing="0" style="display:">
          <tr bgcolor="#CCCCCC" style="border:none;background:url(../html/images/inicio_3.png)">
             <th colspan="2" width="40%" style="border:none"  align="center" ><span class="style5">Caja</span></th>
          </tr>
          <tr bgcolor="#CCCCCC" style="border:none;background:url(../html/images/inicio_3.png)">
            <th colspan="2" width="40%" style="border:none"  align="center" ><span class="style1"><%=nom%></span></th>

            <%                        
               java.util.LinkedList imf = model.consultarTipoPagoByUsuario(usu,cj);
               java.util.LinkedList par = model.listadoParametros(301);
                String checked="";
               for (int i = 0; i <par.size(); i++){
                    Parametro parametro = (Parametro) par.get(i);                    
                        for(int j =0;j<imf.size();j++){
                            Parametro imfo = (Parametro) imf.get(j);
                           // System.out.println(parametro.getCodigo()+"=="+imfo.getTipo_pago()+"estado="+imfo.getEstado());
                            if(parametro.getCodigo()==imfo.getCodigo()){
                                checked="checked";
                            }
                        }
                               %>
                                <tr>
                                <td><%=parametro.getNombre()%></td>
                                  <td width="5%" align="center" class="style2" style="color:#333333; font-size:12px"><input type="checkbox" name="Fcaja" value="<%=parametro.getCodigo()%>" <%=checked.equals("")?"":"checked"%> /></td>
                                </tr>
                                <%
                                checked="";
               }
            %>
         </tr>
          <tr>
       <th height="40" colspan="3" align="center">
	  <button type="submit" value="Guardar">Guardar <img src="../html/images/guardar.png" width="18" height="18" /></button> 
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