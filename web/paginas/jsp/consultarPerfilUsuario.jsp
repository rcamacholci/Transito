<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Vehiculo</title>
<!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
		
		<script language="javascript" type="text/javascript">
                 

			  function paso(){
                            var perf = window.document.form.perfil.value;
                            window.document.location.href = "consultarPerfilUsuario.jsp?tipo=1&perfil="+perf;
			  }

                          function paso2(){
                            var perfUsuario = window.document.form.perfilusuario.value;
                            window.document.location.href = "consultarPerfilUsuario.jsp?tipo=2&usuario="+perfUsuario;
			  }
			  
			  
                        function verReportePerfiles(){
                            ancho = 789;
                            alto = 600;
                            barra = 0;
                            izquierda = (document.width) ? (document.width-ancho)/2 : 100;
                            arriba = (document.height) ? (document.height-alto)/2 : 100;
                            opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + 			ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                            var dir = "usuarios/perfilesporusuario.jasper";
                            var nombre = "Perfildeusuario";
                            url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
                            window.open(url, 'popUp', opciones);
                        }

                         function verReporteUsuario(){
                            ancho = 789;
                            alto = 600;
                            barra = 0;
                            izquierda = (document.width) ? (document.width-ancho)/2 : 100;
                            arriba = (document.height) ? (document.height-alto)/2 : 100;
                            opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + 			ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                            var dir = "usuarios/usariosporperfiles.jasper";
                            var nombre = "usuariosPerfiles";
                            url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
                            window.open(url, 'popUp', opciones);
                        }

      function ver(){
				if(document.form.busqueda[0].checked){
					document.getElementById('tabla1').style.display = "block";
					document.getElementById('tabla2').style.display = "none";
               }else{
                   
                    document.getElementById('tabla1').style.display = "none";
					document.getElementById('tabla2').style.display = "block";
               }
	}
						
                      </script>


<style type="text/css">
<!--
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style3 {color: #FFFFFF}
.style31 {color: #333333; font-size: 12px; font-weight: bold; font-family: Tahoma; }
.Estilo2 {
	color: #FFFFFF;
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
}
-->
</style>



</head>
    <%
    Model model = null;
    Usuario usuario = new Usuario ();
     Sede sede = (Sede) session.getAttribute("sede");
      java.util.List<Perfil> perfil = null;

    try {
        model = (Model) session.getAttribute("model");
    } catch (Exception exc) {
        exc.printStackTrace();
    }

     try{
   
    if(request.getParameter("tipo")!=null&&!request.getParameter("tipo").isEmpty()){
    System.out.println("tipo :"+request.getParameter("tipo").equals("1"));
    }
    if(request.getParameter("tipo").equals("1")){
     if(request.getParameter("perfil")!=null&&!request.getParameter("perfil").isEmpty()){
        long id_perfil = Long.parseLong(request.getParameter("perfil"));
        System.out.println("perfil : "+id_perfil);
        HashMap parameters = new java.util.HashMap();
        parameters.put("ID_PERFIL",id_perfil);
        session.setAttribute("Perfildeusuario", parameters);
%>
        <script language="javascript" type="text/javascript">
              verReportePerfiles();            
	</script>

<%  }
     }else{
        if(request.getParameter("tipo").equals("2")){
         if(request.getParameter("usuario")!=null&&!request.getParameter("usuario").isEmpty()){
        long id_usuario = Long.parseLong(request.getParameter("usuario"));
        System.out.println("usuario : "+id_usuario);
        HashMap parameters = new java.util.HashMap();
        parameters.put("ID_USUARIO",id_usuario);
        session.setAttribute("usuariosPerfiles", parameters);
%>
        <script language="javascript" type="text/javascript">
              verReporteUsuario();
	</script>

<%  }
         }

     }
     } catch (Exception exc) {
        exc.printStackTrace();
    }
    %>

    <body> 
	<form name="form" id="form" method="post" action="" onSubmit="">
	       
		<table width="100%" border="0"  bordercolor="#FFFFFF" align="center" >
				<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="Estilo2">CONSULTAR USUARIOS POR PERFILES</span></td>
	    </tr>
				<tr>
					<td colspan="5">
						
						
								
											</td>
				</tr>	
           </table>
		   <table width="100%" border="0" align="center">
				<tr>
				  <td colspan="2" valign="middle" align="center" width="50%"><span class="Estilo11">
				  <input type="radio" name="busqueda" value="1" checked="checked" onClick="ver()">
				  PERFIL
				  </span></td>
					<td colspan="1" valign="middle" align="center" width="50%"><span class="Estilo11">
				  <input type="radio" name="busqueda" value="1" onClick="ver()">
				  USUARIOS</span></td>
				 			
				</tr>
				<tr>
					<td colspan="5">
						<table border="0" width="100%" id="tabla1">
							  <tr valign="middle">
								 <td width="46%" scope="col" align="right"><label style="color:#333333"><span class="style2">PERFIL</span></label>							  </td>
							  <td width="15%" scope="col" align="right">
                                                              <select name="perfil"  id="perfil"   style=" width:180px; color:#333333; font-size:12px">
                                                                     <option value="0">---- Seleccione un Perfil ----</option>
                                                              <%
                                                             perfil = model.consultarPerfiles();
                                                                if(perfil.size()>0){
                                                                    for(int i=0;i<perfil.size();i++){
                                                                Perfil perfil2 = perfil.get(i);%>

                                                             <option value="<%=perfil2.getId_perfil() %>"><%=perfil2.getNombre()%></option>
					        
                                                             <% }
                                                             }%>
                                                               </select>
							  </label></td>
							  
							  
				                <td width="39%" scope="col">
							
<input id="consultar"  name="consultar" type="button" value="    Consultar    " style="color:#333333" onClick="paso()" /></td>
							</tr>
							
							
						</table>
						<table border="0" width="100%" id="tabla2" style="display:none">
							  <tr valign="middle">
								 <td width="46%" scope="col" align="right"><label style="color:#333333"><span class="style2">USUARIO</span></label>							  </td>
							  <td width="15%" scope="col" align="right">
      <select name="perfilusuario"  id="perfilusuario"   style=" width:180px; color:#333333; font-size:12px">
                                                                     <option value="0">---- Seleccione un Usuario ----</option>
                                                              <%
                                                             java.util.List lista = model.listarUsuarios(sede.getId_sede());
                                                                if(lista.size()>0){
                                                                    for(int i=0;i<lista.size();i++){
                                                                  usuario = (Usuario) lista.get(i);
                                                                    if (usuario.getFechaFin()== null) {   %>

                                                             <option value="<%=usuario.getId_usuario() %>"><%=usuario.getNombre()%></option>
					        
                                                             <% }
                                                                  }
                                                             }%>
                                                               </select>
							  </label></td>
							  
							  
				                <td width="39%" scope="col">
							
<input id="consultar"  name="consultar" type="button" value="    Consultar    " style="color:#333333" onClick="paso2()" /></td>
							</tr>
							
							
						</table>
						
						
										
					</td>
				</tr>	
           </table>
		  </fieldset>
		
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
		</script>  <%
	}
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
