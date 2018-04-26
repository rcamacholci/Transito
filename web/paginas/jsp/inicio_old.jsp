<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  import="java.sql.*" import="modelo.*" import="java.util.*" import="modelo.Usuario" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%

try{
     String fecha ="";
      String token = "";
       Model modelo= (Model)session.getAttribute("model");
       modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
       UsuarioRunt userRunt = modelo.consultarUsuarioRunt(usuario.getId_usuario());
        if(request.getParameter("token")!=null&&!request.getParameter("token").isEmpty()){
         token = request.getParameter("token");
         session.setAttribute("token2", token);
        }

       
        if(session.getAttribute("model")==null){
            if(token!=null){
                if(token.length()>5){
                    Model waitmodel = (Model)session.getAttribute("waitmodel");
                    session.setAttribute("model", waitmodel);
                    session.removeAttribute("waitmodel");
                }
            }
        }
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                     if(usuario!=null){
                        modelo.UsuarioRunt usu2 = modelo.consultarUsuarioRunt(usuario.getId_usuario());
                        if(usu2!=null){
                            fecha = ""+usu2.getFecha_ini();
                            //System.out.println("fecha : "+fecha);
                            fecha = fecha.substring(0,4);
                            //System.out.println("fecha1 : "+fecha);
                        }
                    }

                    if(usuario.getId_usuario()==0 ||(usuario.getId_usuario()==1000 && fecha.equals("2010"))){
                                            Model.userToken = token;
                                            modelo.userToken = token;
                                            modelo.editarTokentodos(token);
                                            modelo.UsuarioRunt usu = modelo.consultarUsuarioRunt(usuario.getId_usuario());
                                            /*String fc = "";
                                            fc = usu.getFecha_ini().toString();
                                            fc=fc.substring(8,10)+"/"+fc.substring(5,7)+"/2009";
                                            java.sql.Date fechaUpdate = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fc).getTime());
                                            //modelo.actualizarusuruntfecha(fechaUpdate,usu.getFk_usuario());*/
                     }
                    modelo.Persona persona = modelo.consultarPersona(usuario.getFk_persona());
                    String nombreU = persona.getNombre_1()+" "+persona.getApellido_1()+" "+(persona.getApellido_2()!=null?persona.getApellido_2():"");
                    long fk_usuario = usuario.getId_usuario();
                    %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>****CIVITRANS 2013****</title>

    <%

    if(request.getParameter("dif")!=null && !request.getParameter("dif").isEmpty()){
    long dif = Long.parseLong(request.getParameter("dif"));
    if(dif>=15){
    %><script language="javascript" type="text/javascript">
        alert("Por razones de seguridad es obligatorio cambiar su Contraseña periodicamente! \n Han padado quince (15) días despues del cambio de su contraseña, Lo invitamos a actualizarla nuevamente!");
       window.parent.parent.document.location.href = "../../editarpasswordobligatoria.jsp";
      </script>
    <% }else{
    %>
    <!-- Deluxe Tree -->
    <script type="text/javascript">var tWorkPath = "../html/scripts/dataMenu.files/";</script>
   <script type="text/javascript" src="../html/scripts/dataMenu.files/dtree.js"></script>
    <%
}
}else{
    %>
    <!-- Deluxe Tree -->
    <script type="text/javascript">var tWorkPath = "../html/scripts/dataMenu.files/";</script>
   <script type="text/javascript" src="../html/scripts/dataMenu.files/dtree.js"></script>
   <script src="../html/scripts/autenticarUsuario.js" type="text/javascript"></script>
    <%
}              %>
	<script language="javascript" type="text/javascript">
		function hide(){
                    if(document.getElementById('menup').style.display!='none'){
                        document.getElementById('menup').style.display = 'none';
                        document.getElementById('bodyp').style.width = '100%';
                    }
		}
                    function direccionar(){

                    }

                function show(){
                    if(document.getElementById('menup').style.display=='none'){
                        document.getElementById('menup').style.display = 'block';
                        document.getElementById('menup').style.width = '10%';
                        document.getElementById('bodyp').style.width = '90%';
                    }
                }

		function cerrarSesion(){
                    if(confirm("Desea salir de la aplicacion?")){
                        document.location.href = "cerrarSesion.jsp";
                    }
		}

                function Llamarjsp(ubicacion , jsp){

                    if(ubicacion == ""){
                        window.frames[0].location.href = jsp;
                    }else{
                         window.frames[0].location.href = ubicacion + "/"+ jsp;
                    }

                }

                 function editarPassRunt(){
                    var ancho = 650;
                    var alto = 200;
                    var izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
                    var arriba = (screen.height) ? (screen.height-alto)/2 : 100;
                    var opciones = 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
                    var url = "editarpasswordRunt.jsp";
                    var ventana = window.open(url, 'popUp', opciones);
                }

                 function activarToken(){
                    var ancho = 400;
                    var alto = 360;
                    var izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
                    var arriba = (screen.height) ? (screen.height-alto)/2 : 100;
                    var opciones = 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
                    var url = "autenticarUser.jsp";
                    var ventana = window.open(url, 'popUp', opciones);
                }

	</script>
    <!-- (c) 2009, http://deluxe-tree.com -->
    <style type="text/css">
<!--
.Estilo1 {
	color: #000033;
	font-weight: bold;
	font-style: italic;
}
.Estilo2 {
	color: #0066CC;
	font-style: italic;
	font-weight: bold;
	font-size:12px;
}
.Estilo3 {
	color: #000033;
	font-weight: bold;
	text-decoration:underline;
	font-size: 12px;
	font-family: Tahoma;
}
.Estilo4 {
	font-family: Tahoma;
	font-size: 12px;
}
-->
    </style>

    <link href="../html/css/inicio.css" rel="stylesheet" type="text/css">

</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0" style="border:none" bgcolor="#CCCCCC">

    <div id="contenedor">
    <table width="100%" border="0"  height="1024px" align="center" cellpadding="0" cellspacing="0" style="border:none" bgcolor="#FFFFFF">
    <tr>
	<td colspan="6" align="center" valign="top">
		<embed wmode="transparent" src="../multimedia/Banner_civitrans.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="1280" height="81"></embed>
        </td>
    </tr>

    <tr>
        <td colspan="6">

    <link type="text/css" href="menu.css" rel="stylesheet" />
    <script type="text/javascript" src="jquery.js"></script>
    <script type="text/javascript" src="menu.js"></script>

    <style type="text/css">
* { margin:0;
    padding:0;
}
body { background:#555 url(images/back.jpg); }
#menu { top:-18px; }
#copyright {
    margin:100px auto;
    width:80%;
    font:12px 'Trebuchet MS';
    color:#bbb;
    text-indent:20px;
    padding:40px 0 0 0;
}
#copyright a { color:#bbb; }
#copyright a:hover { color:#fff; }
</style>

    <!--PRUEBA RECURSOS-->



<div id="menu">
    <ul class="menu">
        <li><a href="inicio.jsp" class="last"><span>Inicio</span></a>
        <li><a href="#" class="parent"><span>Modulos</span></a>
            <div><ul>

                     <%
        java.util.List<Modulos> modul = null;
        java.util.List<ModulosPerfil> modulosperfil = null;
        Perfil perfil = modelo.consultarPerfilByUsuario(fk_usuario);
        modul  = modelo.ConsultarModulosByUsuario(perfil.getId_perfil());
        for(int i=0;i<modul.size();i++){
        Modulos mod = modul.get(i);
%>

                <li><a href="#" class="parent"><span><%=mod.getModulo()%></span></a>
                    <div><ul>

                             <%
                                modulosperfil  = modelo.consultarModulosporPerfil(mod.getCodigo(), perfil.getId_perfil(),1);
                                for(int c=0;c<modulosperfil.size();c++){
                                ModulosPerfil co = modulosperfil.get(c);
                                if(co!=null){%>

                        <li><a href="#" class="parent"><span>CONSULTAS</span></a>
                            <div><ul>
                                <%

                                for(int j=0;j<modulosperfil.size();j++){
                                ModulosPerfil mp = modulosperfil.get(j);
                                String ubicacion = "";
                                if(mp.getUbicacion()!=null){
                                    ubicacion = mp.getUbicacion();
                                }

                                %>

                                                        <li><a href="#" onclick="Llamarjsp('<%=ubicacion%>','<%=mp.getDescripcion()%>')"><span><%=mp.getNombre()%></span></a></li>
                                                        <%
                                    }
                                %>


                            </ul></div>
                        </li><%}
                                break;
                                        }%>
<!--Fin Consultas-->

<!--REPORTES-->


        <%
                                modulosperfil  = modelo.consultarModulosporPerfil(mod.getCodigo(), perfil.getId_perfil(),2);
                                for(int c=0;c<modulosperfil.size();c++){
                                ModulosPerfil co = modulosperfil.get(c);
                                if(co!=null){%>

                        <li><a href="#" class="parent"><span>REPORTES</span></a>
                            <div><ul>
                                <%

                                for(int j=0;j<modulosperfil.size();j++){
                                ModulosPerfil mp = modulosperfil.get(j);
                                String ubicacion = "";
                                if(mp.getUbicacion()!=null){
                                    ubicacion = mp.getUbicacion();
                                }

                                %>

                                                        <li><a href="#" onclick="Llamarjsp('<%=ubicacion%>','<%=mp.getDescripcion()%>')"><span><%=mp.getNombre()%></span></a></li>
                                                        <%
                                    }
                                %>


                            </ul></div>
                        </li><%}
                                break;
                                        }%>

<!--Fin Reportes-->

<!--PROCESOS-->



        <%
                                modulosperfil  = modelo.consultarModulosporPerfil(mod.getCodigo(), perfil.getId_perfil(),3);
                                for(int c=0;c<modulosperfil.size();c++){
                                ModulosPerfil co = modulosperfil.get(c);
                                if(co!=null){%>

                        <li><a href="#" class="parent"><span>PROCESOS</span></a>
                            <div><ul>
                                <%

                                for(int j=0;j<modulosperfil.size();j++){
                                ModulosPerfil mp = modulosperfil.get(j);
                                String ubicacion = "";
                                if(mp.getUbicacion()!=null){
                                    ubicacion = mp.getUbicacion();
                                }

                                %>

                                                        <li><a href="#" onclick="Llamarjsp('<%=ubicacion%>','<%=mp.getDescripcion()%>')"><span><%=mp.getNombre()%></span></a></li>
                                                        <%
                                    }
                                %>


                            </ul></div>
                        </li><%}
                                break;
                                        }%>

<!--Fin Procesos-->


<!--OTROS REPORTES-->


        <%
                                modulosperfil  = modelo.consultarModulosporPerfil(mod.getCodigo(), perfil.getId_perfil(),4);
                                for(int o=0;o<modulosperfil.size();o++){
                                ModulosPerfil or = modulosperfil.get(o);
                                if(or!=null){%>

                        <li><a href="#" class="parent"><span>OTROS REPORTES</span></a>
                            <div><ul>
                                <%

                                for(int jh=0;jh<modulosperfil.size();jh++){
                                ModulosPerfil mp = modulosperfil.get(jh);
                                String ubicacion = "";
                                if(mp.getUbicacion()!=null){
                                    ubicacion = mp.getUbicacion();
                                }

                                %>

                                                        <li><a href="#" onclick="Llamarjsp('<%=ubicacion%>','<%=mp.getDescripcion()%>')"><span><%=mp.getNombre()%></span></a></li>
                                                        <%
                                    }
                                %>


                            </ul></div>
                        </li><%}
                                break;
                                        }%>

<!--Fin Otros Reportes-->

<!--IMPRESIONES-->


        <%
                                modulosperfil  = modelo.consultarModulosporPerfil(mod.getCodigo(), perfil.getId_perfil(),5);
                                for(int im=0;im<modulosperfil.size();im++){
                                ModulosPerfil imp = modulosperfil.get(im);
                                if(imp!=null){%>

                        <li><a href="#" class="parent"><span>IMPRESIONES</span></a>
                            <div><ul>
                                <%

                                for(int j=0;j<modulosperfil.size();j++){
                                ModulosPerfil mp = modulosperfil.get(j);
                                String ubicacion = "";
                                if(mp.getUbicacion()!=null){
                                    ubicacion = mp.getUbicacion();
                                }

                                %>

                                                        <li><a href="#" onclick="Llamarjsp('<%=ubicacion%>','<%=mp.getDescripcion()%>')"><span><%=mp.getNombre()%></span></a></li>
                                                        <%
                                    }
                                %>


                            </ul></div>
                        </li><%}
                                break;
                                        }%>

<!--Fin Impresiones-->

                    </ul></div>
                </li>

<%}%>
            </ul></div>
        </li>

        <%      int m = 0;
               modul  = modelo.ConsultarModulosByUsuarioTramites(perfil.getId_perfil());
               for(int t=0;t<modul.size();t++){
               Modulos md = modul.get(t);
               if(md!=null){%>

              <li><a href="#" class="parent"><span>Tramites</span></a>
            <div><ul>

                     <%

        modul  = modelo.ConsultarModulosByUsuarioTramites(perfil.getId_perfil());
        for(int i=0;i<modul.size();i++){
        Modulos mod = modul.get(i);
%>

                <li><a href="#" class="parent"><span><%=mod.getModulo()%></span></a>
                    <div><ul>

                             <%
                                modulosperfil  = modelo.consultarModulosporPerfil(mod.getCodigo(), perfil.getId_perfil(),1);
                                for(int c=0;c<modulosperfil.size();c++){
                                ModulosPerfil co = modulosperfil.get(c);
                                if(co!=null){%>

                        <li><a href="#" class="parent"><span>CONSULTAS</span></a>
                            <div><ul>
                                <%

                                for(int j=0;j<modulosperfil.size();j++){
                                ModulosPerfil mp = modulosperfil.get(j);
                                String ubicacion = "";
                                if(mp.getUbicacion()!=null){
                                    ubicacion = mp.getUbicacion();
                                }

                                %>

                                                        <li><a href="#" onclick="Llamarjsp('<%=ubicacion%>','<%=mp.getDescripcion()%>')"><span><%=mp.getNombre()%></span></a></li>
                                                        <%
                                    }
                                %>


                            </ul></div>
                        </li><%}
                                break;
                                        }%>
<!--Fin Consultas-->

<!--REPORTES-->


        <%
                                modulosperfil  = modelo.consultarModulosporPerfil(mod.getCodigo(), perfil.getId_perfil(),2);
                                for(int c=0;c<modulosperfil.size();c++){
                                ModulosPerfil co = modulosperfil.get(c);
                                if(co!=null){%>

                        <li><a href="#" class="parent"><span>REPORTES</span></a>
                            <div><ul>
                                <%

                                for(int j=0;j<modulosperfil.size();j++){
                                ModulosPerfil mp = modulosperfil.get(j);
                                String ubicacion = "";
                                if(mp.getUbicacion()!=null){
                                    ubicacion = mp.getUbicacion();
                                }

                                %>

                                                        <li><a href="#" onclick="Llamarjsp('<%=ubicacion%>','<%=mp.getDescripcion()%>')"><span><%=mp.getNombre()%></span></a></li>
                                                        <%
                                    }
                                %>


                            </ul></div>
                        </li><%}
                                break;
                                        }%>

<!--Fin Reportes-->

<!--PROCESOS-->



        <%
                                modulosperfil  = modelo.consultarModulosporPerfil(mod.getCodigo(), perfil.getId_perfil(),3);
                                for(int c=0;c<modulosperfil.size();c++){
                                ModulosPerfil co = modulosperfil.get(c);
                                if(co!=null){%>

                        <li><a href="#" class="parent"><span>PROCESOS</span></a>
                            <div><ul>
                                <%

                                for(int j=0;j<modulosperfil.size();j++){
                                ModulosPerfil mp = modulosperfil.get(j);
                                String ubicacion = "";
                                if(mp.getUbicacion()!=null){
                                    ubicacion = mp.getUbicacion();
                                }

                                %>

                                                        <li><a href="#" onclick="Llamarjsp('<%=ubicacion%>','<%=mp.getDescripcion()%>')"><span><%=mp.getNombre()%></span></a></li>
                                                        <%
                                    }
                                %>


                            </ul></div>
                        </li><%}
                                break;
                                        }%>

<!--Fin Procesos-->

                    </ul></div>
                </li>

<%}%>
            </ul></div>
        </li>
        <li><a href="#"><span>Ayuda</span></a></li>
        <li class="last"><a href="#"><span>Contáctenos</span></a></li>
         <li class="last"><a href="#" hidden><span>&nbsp;</span></a></li>
        <li class="last"><a href="#" hidden><span>&nbsp;&nbsp;</span></a></li>
        <%
         m=1;
               }
                                break;
                                        }

        if(m!=1){
        %>
        <li><a href="#"><span>Ayuda</span></a></li>
        <li class="last"><a href="#"><span>Contáctenos</span></a></li>
         <li class="last"><a href="#" hidden><span>&nbsp;</span></a></li>
         <li class="last"><a href="#" hidden><span>&nbsp;</span></a></li>
         <li class="last"><a href="#" hidden><span>&nbsp;</span></a></li>
        <li class="last"><a href="#" hidden><span>&nbsp;&nbsp;</span></a></li>
        <%
        }

       %>


        <li class="last" align="right" ><a href="#"><span><%=nombreU%></span></a>
            <div><ul>
                    <li><a href="#" onclick="activarToken()" class="last"><span>Actualizar Token Runt</span></a></li>
                    <li><a href="#" onclick="Llamarjsp('','../../editarpasswordobligatoria.jsp')" class="last"><span>Cambiar Contraseña</span></a></li>
                    <li><a href="#" onclick="editarPassRunt()" class="last"><span>Cambiar Contraseña Runt</span></a></li>
            </ul></div>
        </li>
        <li class="last" align="right" ><a href="#"><span><img src="../multimedia/salir.png" width="28" height="28" valing="center" onclick="cerrarSesion()" style="cursor:pointer"/></span></a></li>
    </ul>
</div>

    <!--FIN DE PRUEBA-->

        </td>


    </tr>

    <tr height="100%" valign="top">
        <td colspan="2" height="100%" align="left">
            <table width="100%" border="0" align="center" height="700px" cellpadding="0" cellspacing="0" style="border:none">
               <tr>
                    <!--<td background="../html/images/tab2.png" valign="middle" align="left" width="20px" style="width:20px; border:none" onclick="show()">
                        <img id="icono" src="../html/images/tab.png" height="49" width="20px" onclick="show()"/>
                    </td> -->
                    <!--<td width="221px" height="100%" valign="top" align="left" scope="row" bordercolor="#CCCCCC" id="menup" style="border:none" onclick="show()">
                        <%
                        if(!modelo.listarPerfilesUsuarioByFkUusario(usuario.getId_usuario()).contains("29")){ %>
                            <script type="text/javascript" src="../html/scripts/dataMenu.js"></script>
                     <% }else{ %>
                            <script type="text/javascript" src="../html/scripts/dataMenuConcesionario.js"></script>
                     <% } %>
                    </td>-->
                    <td width="100%" height="100%" valign="top" align="left" id="bodyp">
                        <iframe src="pantallazo.jsp" width="100%" height="700px" allowtransparency="1" frameborder="0" scrolling="auto" id="init" name="init"></iframe>
                    </td>
                </tr>
            </table>
	</td>
   </tr>
</table>

                   </div>
<div><a href="http://apycom.com/"></a></div>
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