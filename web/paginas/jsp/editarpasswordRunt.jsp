<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" errorPage="" %>

<%
try{
                                       %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Vehiculo</title>
</head>
<link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="../html/scripts/tablecloth.js"></script>
<script src="jscapslock.js" type="text/javascript"></script>

    <script>
        function prevalidarDatos(){
            if(document.form.usuario.value!=""){
                if(document.form.contrasena.value!=""){
                    if(document.form.newpassword.value!=""){
                            if(document.form.newpassword2.value!=""){
                                if(document.form.newpassword.value == document.form.newpassword2.value){
                                     document.form.action = "procesarEditarUsuarioRunt.jsp";
                                     document.form.submit()
                                }else{
                                    alert("El password nuevo no coincide con la confirmacion");
                                }
                            }else{
                                alert("El campo Confirmacion Password es obligatorio");
                            }
                    }else{
                        alert("El campo Nuevo Password es obligatorio");
                    }

                }else{
                    alert("El campo Contraseña es obligatorio");
                }
            }else{
                alert("Es campo usuario es obligatorio");
            }
        }

       function capLock(e){
            kc=e.keyCode?e.keyCode:e.which;
            sk=e.shiftKey?e.shiftKey:((kc==16)?true:false);
            if(((kc>=65&&kc<=90)&&!sk)||((kc>=97&&kc<=122)&&sk )){
                document.getElementById('caplock').style.display = 'block';
            }else{
                document.getElementById('caplock').style.display = 'none';
            }
        }

    </script>
<body>
    <form name="form" method="post" action="">
        <fieldset>
        <table width="1024" height="88" border="1">

        <tr>
            <th colspan="4">AUTENTICACION USUARIO RUNT</th>
        </tr>
        <tr>
        <tr>
          <td width="118">USUARIO</td>
          <td width="219"><input type="text" name="usuario"></td>
          <td width="204">CONTRASE&Ntilde;A</td>
          <td width="245"><input type="password" onkeypress="capLock(event)" name="contrasena"></td>
          <td width="245"><input type="hidden" name="fecha" value="01/05/2010"></td>
        </tr>
        <tr>
          <td>NUEVO PASSWORD</td>
          <td><input type="password" onkeypress="capLock(event)" name="newpassword"></td>
          <td>CONFIRMACION PASSWORD</td>
          <td><input type="password" onkeypress="capLock(event)" name="newpassword2"></td>
        </tr>
        <tr>
            <td colspan="3">
                <div id="caplock" style="display:none"><font size="2" color="red">El bloq de mayúsculas está activado</font></div>
            </td>
          <td><input type="button" value="Guardar" onclick="prevalidarDatos()"></td>
        </tr>
      </table>
     </fieldset>
    </form>
</body>

</html>
<%
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>