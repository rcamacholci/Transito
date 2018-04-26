<%-- 
    Document   : IPporUsuarios
    Created on : 5/06/2012, 02:50:24 PM
    Author     : Sistemas
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*"  import="modelo.Parametro"  errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>

<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("HabilitarIPUsuarios.jsp")){
                    modelo.Model model = (modelo.Model)session.getAttribute("model");

        long id_usuario = Long.parseLong(request.getParameter("id_usuario"));
        Usuario usuario = model.consultarUsuario(id_usuario);

%>


<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Ver prendas por beneficiario</title>
        <style type="text/css">
            <!--
            .Estilo4 {
                font-weight: bold;
                font-family: "Times New Roman", Times, serif;
                color: #FFFF99;
                font-size:12px;
            }
            -->

        </style>
	    <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <META http-equiv=Content-Type content="text/html; charset=windows-1252">

        <script language="javascript" type="text/javascript">
	
        function nuevoAjax(){
            var xmlhttp= false;
            try{xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
            }catch(e){try { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }catch(E){xmlhttp = false;}
        }
            if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
            xmlhttp = new XMLHttpRequest();
        }
         return xmlhttp;
        }
 
 
        function ActualizarIP(idusuario,idIP, direccion_ip){

            var tabla = document.getElementById('ip');
            ajax2=nuevoAjax();
            ajax2.open("POST", "ActualizarIP.jsp",true);
                ajax2.onreadystatechange=function() {
                if (ajax2.readyState==4) {
                        tabla.innerHTML = ajax2.responseText;
                }
        }
            ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
            ajax2.send("id_ip="+idIP+"&dir_ip="+direccion_ip+"&id_usuario="+idusuario);
            window.location.href="IPporUsuarios.jsp?id_usuario="+idusuario;
}


  function AgregarIP(idusuario, direccion_ip){

            var idIP = 0;
            var tabla = document.getElementById('ip');
            ajax2=nuevoAjax();
            ajax2.open("POST", "ActualizarIP.jsp",true);
                ajax2.onreadystatechange=function() {
                if (ajax2.readyState==4) {
                        tabla.innerHTML = ajax2.responseText;
                }
        }
            ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
            ajax2.send("id_usuario="+idusuario+"&dir_ip="+direccion_ip+"&id_ip="+idIP);
            elem = document.getElementById('agregarip');
            elem.style.display='block';
            window.location.href="IPporUsuarios.jsp?id_usuario="+idusuario;
        }
        
 function NuevaIP(agregarip){
     
        elem = document.getElementById(agregarip);
        elem.style.display='block';
 }
      
</script>

        <STYLE>


<!--
A.ssmItems:link		{color:black;text-decoration:none}
A.ssmItems:hover	{color:black;text-decoration:none}
A.ssmItems:active	{color:black;text-decoration:none}
A.ssmItems:visited	{color:black;text-decoration:none}
.style3 {font-size: 12px; font-family: Tahoma; }
.style6 {color: #333333; font-size: 12px; font-weight: bold; }
.Estilo32 {
	color: #ffffff;
	font-weight: bold;
	font-size: 12px;
}

.style5 {
	color: #333333;
	font-size: 10px;
	font-family: Tahoma;
	font-weight: bold;
}
-->
        </STYLE>
</head>
    <body>
        <center><fieldset style="width:30%">
        <table width="100%" border="0" align="center"  cellpadding="1" cellspacing="0">
    <tr style="border:none;background:url(../html/images/inicio_3.png)">
      <td colspan="2" width="80%" align="center" class="Estilo32" style="border:none" class="Estilo32">ASIGNAR IP A USUARIOS</td>
   </tr>

    <tr style="border:none;">
        
        <td width="50%" align="center" colspan="2"><span class="style6" style="border:none"><br> USUARIO: <%=usuario.getNombre()%> <hr></span></td>
        
    </tr>
    
    <tr>
        <td align="right" colspan="2">
                <img src="../html/images/adicionar.gif" alt="Nuevo" name="adicionar" width="22" height="22" id="adicionar" style="cursor:pointer; text-align:center;" onclick="NuevaIP('agregarip')"/>
	<span class="style5">NUEVO</span></td>
    </tr>

        <%

        java.util.List<UsuariosIP> ipUsuarios = null;
        long IDUsuario = usuario.getId_usuario();
        ipUsuarios  = model.consultarIPporUsuario(IDUsuario);
        for(int i=0;i<ipUsuarios.size();i++){
        UsuariosIP ip = ipUsuarios.get(i);
        %>
      <tr>

          <td  width="10%" align="center" colspan="2" class="style2" style="color:#333333; font-size:12px"><input type="text" style="text-align:center;" onchange="ActualizarIP(<%=usuario.getId_usuario()%>,<%=ip.getid_usuario_ip()%>, this.value)" value="<%=ip.getip()%>"/></td>
          

      </tr>

     <% } %>



     <div id="ip"></div>


</table>

     <div id="agregarip" style="display:none">

         <table width="100%" border="0" align="center"  cellpadding="1" cellspacing="0">
            <tr>
                <td  width="10%" align="center"  class="style2" style="color:#333333; font-size:12px; "><input style="text-align:center;" type="text" onchange="AgregarIP(<%=usuario.getId_usuario()%>, this.value)"/></td>
                
            </tr>
        </table>

     </div>

     </fieldset>
</center>
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
