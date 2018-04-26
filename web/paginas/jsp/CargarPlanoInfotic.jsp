
<%@page import="modelo.Model"%>
<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="procesos.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try
{
    if(session.getAttribute("model")!=null){
    if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Civitrans</title>

        <script type="text/script">

            function Verificar(){


            }

        </script>

        <style type="text/css">
<!--
.style1 {color: #006699}
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
-->
        </style>

</head>
    <body>
        <form name="form" action="procesarPlanosInfotic.jsp" method="POST" enctype="multipart/form-data" target="respuesta">
			<table align="center" border="0" width="100%">
				<tr>
					<td  height="40px" align="center">
			            <h1 class="style1">Cargar Planos Infotic </h1>					</td>
				</tr>
				<tr>
					<td height="40px" align="center">
                                            <%
                                                modelo.Model model = new Model();
                                                procesos.CargueCobro c = new CargueCobro(request, model);
                                                String fa = c.getFechaActual();
                                            %>
			           <input type="hidden" name="filename" value="Infotic <%=fa%>.txt" />

			           <input type="file" name="archivo" size="80px" value="" />
					</td>
				</tr>
				<tr>
					<td height="40px" align="center">
                                            <button type="submit" name="aceptar"><span class="style2">Enviar </span><img src="../html/images/enviar.png" width="19" height="18"/></button>
			          <!-- <input type="submit" name="aceptar" value="Enviar"> -->
					</td>
				</tr>
				<tr>
					<td height="60px" align="center">&nbsp;

					</td>
				</tr>
				<tr>
					<td align="center">
			            <iframe allowtransparency="0" frameborder="0" height="300px" scrolling="no" width="400px" name="respuesta"></iframe>
					</td>
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
		</script>  <%
	}
}catch(Exception mexe){
mexe.printStackTrace();
%>

    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>