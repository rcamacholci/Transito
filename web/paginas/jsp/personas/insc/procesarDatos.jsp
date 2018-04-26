<%-- 
    Document   : procesarDatos
    Created on : 18/08/2011, 10:03:44 PM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
    if(session.getAttribute("usuario")!=null){
        modelo.Model model = (modelo.Model)session.getAttribute("model");
        modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");

        if(model!=null&&usuario!=null){
            new inscripcion.procesarDatos(request, model, usuario);
        }
    } %>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Archivos Planos</title>
        <style type="text/css">
<!--
.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
.style2 {color: #FFFFFF}
.style3 {
	color: #006699;
	font-weight: bold;
}
-->
        </style>
</head>
    <body>
        <table border="0" width="50%" align="center">
            <tr>
                <td height="40" align="center" bgcolor="#CCCCCC"><span class="style3">PAGOS APLICADO</span></td>
            </tr>
    </table>
    </body>
<%
}catch(Exception mexe){
    mexe.printStackTrace();
} %>