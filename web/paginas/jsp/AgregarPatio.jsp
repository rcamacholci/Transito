<%-- 
    Document   : AgregarPatio
    Created on : 13/09/2013, 09:21:33 AM
    Author     : ORLA
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" pageEncoding="UTF-8" language="java" import="java.sql.*" import="modelo.*" import="procesos.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
	//if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("CargarPlanosPolca.jsp")){
        if(1==1){
        modelo.Model model = (modelo.Model)session.getAttribute("model");
        modelo.Usuario usu = (modelo.Usuario)session.getAttribute("usuario");
        String respuesta = "";
        if(model!=null){
            CargarPlanosSimit c = new CargarPlanosSimit();
            c.CargarPlano(request, model,usu);
            respuesta = c.getMsg();
        }
  %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="../html/css/lineaVertical.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="../html/css/3pestanas.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="../html/scripts/tablecloth.js"></script>
        <link href="../html/css/page2Colum.css" rel="stylesheet" type="text/css" media="screen" />
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script type="text/javascript" language="javascript">
            function sombrear(tr){
                tr.style.backgroundColor="#CCCCCC";
            }
            function renovar(tr){
                tr.style.backgroundColor="#FFFFFF";
            }
        </script>
        <style type="text/css">
<!--
.Estilo7 {color: #006699}
.Estilo10 {
	color: #333333;
	font-weight: bold;
	font-size: 14px;
}
.Estilo15 {
	color: #003399;
	font-size: 16px;
}
.Estilo16 {color: #333333}
.Estilo19 {
	font-size: 12px;
	font-weight: bold;
	color: #333333;
}
.Estilo20 {
	font-size: 13px;
	font-weight: bold;
	color: #0066CC;
}
-->
        </style>
    </head>
    <body>
        <h1>Hello World!</h1>
       <form id="form" name="form" method="post" action="ProcesarInsertarPatio.jsp">
           <div align="center">
                 <table border="1" style="width:40%" align="center">
                    <tr>
                        <th colspan="2">Agregar Patio</th>
                    </tr>
                    <tr>
                        <td colspan="1">Nombre</td>
                        <td colspan="1"><input name="nombrep" id="nombrep" style="width:90%"></td>
                    </tr>
                    <tr>
                        <td colspan="1">Dirreccion</td>
                        <td colspan="1"><input name="direccion" id="direccion"  style="width:90%" ></td>
                    </tr>
                    <tr>
                        <td colspan="1">Telefono</td>
                        <td colspan="1"><input name="telefono" id="telefono"  style="width:90%" ></td>
                    </tr>
                    <tr>
                        <th colspan="2"><input type="submit" id="play" name="play"></th>
                    </tr>
               </table>
         </div>
       </form>
    </body>
</html>
<%
}
}
}catch(Exception mexe){
mexe.printStackTrace();
%>

    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>