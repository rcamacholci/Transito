<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  import="java.sql.*" import="java.util.*"  import="modelo.Model"  import="modelo.Usuario" import="modelo.Sede" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.Date"%>
<%@page import="Cifrado.*" %>

<%@ page import="modelo.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>****CIVITRANS****</title>
<script language="javascript" type="text/javascript">
	function validarIndex(){
            document.location.href="index.html";
        }

        function paso(){
		if(document.form.user.value.length>0){
			if(document.form.password.value.length>0){
				document.form.action='index.jsp'
				document.form.submit();
			}else{
				alert("Digite password de usuario");
			}	
		}else{
			alert("Digite nombre de usuario");
		}
	}
        /*function imprimir(){
		ancho = 1280;
		alto = 1024;
		barra = 0;
		izquierda = (document.width) ? (document.width-ancho)/2 : 1280;  
		arriba = (document.height) ? (document.height-alto)/2 : 1024;  
		opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';  
		url = "paginas/jsp/inicio.jsp";
		window.open(url, 'popUp', opciones);
	}*/
</script>
<style type="text/css">
<!--
.Estilo11 {
	color: #FFFFFF;
	font-weight: bold;
	font-style: italic;
	font-size: 12px;
	font-family: Tahoma;
}
.Estilo17 {
	font-family: "Palatino Linotype";
	font-weight: bold;
	color: #FFFFFF;
}
.Estilo18 {color: #FFFFFF}
-->
</style>
</head>

<link href="paginas/html/css/inicio.css" rel="stylesheet" type="text/css">

<body  bgcolor="#ffffff" onload="validarIndex()">
<form name="form" action="javascript:paso()" method="post">

<div id= "contenedor">


            <table width="100%" border="0" align="top" height= "640" width= "1400" cellpadding= "0" cellspacing= "0" background="paginas/multimedia/inicio.jpg">
        
            <tr>
   <td height="65" colspan="6"></td>
 </tr>

   <tr>
    <td width="371" height="12">&nbsp;</td>
    <td width="72" align="center"><t>Usuario</t></td>
    <td width="105"><input name="user" type="text" size="18" style="border-color:#333333" autocomplete="off"/></td>
    <td width="72" align="center"><t>Contraseña</t></td>
<td width="105"><input width="100%" type="password" name="password" size="18" style="border-color:#333333" autocomplete="off"/></td>
  <td width="88"><button type="submit" name="aceptar" id="aceptar" ><span class="style2">Iniciar Sesion</span><img src="paginas/html/images/sesion.png" width="19" height="18"/></button>
	<!--<input type="submit" name="aceptar" id="aceptar" value="Iniciar Sesion" onclick="" style="color:#333333; font-weight:100"/>--></td>
  </tr>

  <tr>
      <td height="440" colspan="6" align="right" valign="bottom">
    
               <embed wmode="transparent" src="paginas/multimedia/inicio.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="740" height="150"></embed>
    
    </td>

  </tr>
  <tr>
    <td height="60" colspan="6">&nbsp;</td>

  </tr>
</table>
     </div>

     
     
</form>	
<%
try{   

   

        if(request.getParameter("user")!=null&&request.getParameter("password")!=null){
            java.io.File f = new java.io.File("C:/Civitrans/logInicio.txt");
            java.io.FileOutputStream fos = new java.io.FileOutputStream(f,true);
            java.io.DataOutputStream dos = new java.io.DataOutputStream(fos);
            dos.writeBytes(request.getRemoteAddr()+"&"+request.getParameter("user")+"&"+new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm:ss aa").format(new java.util.Date()));
            dos.writeBytes("\n");
            dos.close();
            fos.close();
            Model model = new Model();
            model.conectar();
            String user = request.getParameter("user").toUpperCase();
            String pass = request.getParameter("password");
            Usuario usuario = model.consultarUsuario(user, KeyStore.Encriptar(pass));
 
               if(usuario!=null){
                java.util.List<String> listaIP = model.consultarUsuariosIP(usuario.getId_usuario());
                boolean access = false;
               if(listaIP.size()==0){
                    access = true;
               }else{
                    System.out.println("Direccion Ip: "+request.getRemoteAddr());
                    if(listaIP.contains(request.getRemoteAddr())){
                        access = true;
                    }
                }

                if(access){
                    session.setAttribute("sesionDe", usuario.getNombre()+" - "+request.getRemoteAddr());
                    session.setAttribute("model",model);
                    session.setAttribute("usuario", usuario);

                    model.SetIpCivitrans(request.getRemoteAddr());
                    model.SetUsuarioApp(usuario.getNombre());
                    

                    java.util.List lista = model.consultarCajasUsuario(usuario.getId_usuario());
                    for(int i=0;i<lista.size();i++){
                        modelo.UsuarioCaja usuarioCaja = (modelo.UsuarioCaja)lista.get(i);
                        modelo.Taquilla taquilla = model.consultar_Taquilla(usuarioCaja.getFk_caja(),usuarioCaja.getFk_sede(),usuarioCaja.getFk_usuario());
                        if(taquilla!=null){
                            if(taquilla.getEstado()==1){
                                String fechaA = new java.text.SimpleDateFormat("MM/dd/yyyy").format(new java.sql.Date(taquilla.getFecha_ini().getTime()));
                                String fechaB = new java.text.SimpleDateFormat("MM/dd/yyyy").format(new java.sql.Date(new java.util.Date().getTime()));
                                if(!fechaA.equals(fechaB)){
                                    taquilla.setEstado(3);
                                    float total = model.consultarValorTaquilla(taquilla.getId_taquilla());
                                    taquilla.setValor_nota_debito(total);
                                    taquilla.setValor_taquilla(total);
                                    taquilla.setFecha_ini(new java.sql.Timestamp(new java.util.Date().getTime()));
                                    model.actualizarTaquilla(taquilla, taquilla.getId_taquilla());
                                    if(usuario.getId_usuario()==31)
                                        model.actualizarParametroConfiguracion(2, 0);
                                    model.getCon().commit();
                                }
                            }
                        }
                    }
                    session.setAttribute("permisosU", model.obtenerPermisos(usuario.getId_usuario()));
                    Sede sede = model.consultarSede(usuario.getFk_sede());
                    session.setAttribute("sede",sede);
                    modelo.UsuarioRunt usuarioRunt = model.consultarUsuarioRunt(usuario.getId_usuario());
					// consuta en el historial del usuario
                    /*FechaMaxUsuario fechau = null;
                            fechau  = model.consultarMaxFechaHis(usuario.getId_usuario());
                            System.out.println("--|-----|----|---|----:  "+fechau.getFecha());*/
                            java.util.List<HIS_PAS_USUARIO> historial = model.consultarHIS_PAS_USUARIO(usuario.getId_usuario());
                            long mayor =0;
                            int guia=0;
                            for(int i=0;i<historial.size();i++){
                                HIS_PAS_USUARIO historial2 = historial.get(i);
                                if(mayor<historial2.getCONSECUTIVO()){
                                    mayor=historial2.getCONSECUTIVO();
                                    guia=i;
                                }
                             }
                            GregorianCalendar fechaactss = new GregorianCalendar();
                               Date fec1 = historial.get(guia).getFECHA();
                               Date fec2 = fechaactss.getTime();
                               long time = fec2.getTime() - fec1.getTime();
                            long dif = (time/(3600*24*1000));
                // fin de la consulta del usuario
                    if(usuarioRunt!=null){
                        modelo.Model.userHandler = usuarioRunt.getCodigo();
                        model.userHandler = usuarioRunt.getCodigo();
                        modelo.Model.passUserHandler = usuarioRunt.getPassword();
                        model.passUserHandler = usuarioRunt.getPassword();
                        modelo.Model.userToken = usuarioRunt.getTemplate();
                        model.userToken = usuarioRunt.getTemplate();
                        if(usuarioRunt.getFecha_ini().getYear()!=109){
                                if(dif<15){
                            %>
                            <script language="javascript" type="text/javascript">
                                document.location = "paginas/jsp/autenticarUsuario.jsp?&dif="+<%=dif%>;
                            </script>
                            <%}else{
                                %><script language="javascript" type="text/javascript">
                                alert("Por razones de seguridad es obligatorio cambiar su Contraseña periodicamente! \n Han padado quince (15) días despues del cambio de su contraseña, Lo invitamos a actualizarla nuevamente!");
                                window.parent.parent.document.location.href = "editarpasswordobligatoria.jsp";
                                </script><% 
                            }
                        }else{ // inicio 1
                %><script language="javascript" type="text/javascript">
                document.location = "paginas/jsp/inicio.jsp?&dif="+<%=dif%>;
                </script><%
        } // fin incio 1
                    }else{ // inico 2
                        //long dif = (time/(3600*24*1000));
                        %><script language="javascript" type="text/javascript">
                        UsuarioRunt();
                         function UsuarioRunt(){
                            if(confirm("Posee Usuario Runt")){
                                abrirVentanaAutenticar();
                            }else{
                                document.location = "paginas/jsp/inicio.jsp?&dif="+<%=dif%>;
                            }
                        }


                         function abrirVentanaAutenticar(){
                            var ancho = 800;
                            var alto = 150;
                            var izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
                            var arriba = (screen.height) ? (screen.height-alto)/2 : 100;
                            var opciones = 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
                            var url = "paginas/jsp/UsuarioRunt.jsp";
                            var ventana = window.open(url, 'popUp', opciones);
                         }

                        </script><%
                    }// inicio 2
                }else{ %>
                       <script language="javascript" type="text/javascript">
                            alert("No se puede acceder a la aplicacion desde este equipo");
                            document.location = "index.jsp";
                        </script>
            <%    }
            }else{%>
                <script language="javascript" type="text/javascript">
                    alert("Error Digite password correctamente ");
                    document.location = "index.jsp";
		</script>
          <%}
	}
 }catch(Exception exc){
     exc.printStackTrace();
 }
%>
</body>
</html>
