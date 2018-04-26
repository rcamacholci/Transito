<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarAgentes.jsp")){
                    modelo.Model model = (modelo.Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
<!--
.Estilo3 {font-size: 12px; color: #FFFFFF; }
.Estilo4 {
	color: #333333;
	font-weight: bold;
	font-size: 12px;
}
-->
        </style>
		<script language="javascript" type="text/javascript">
		</script>

</head>
    <body>
            <table width="100%" border="1" cellpadding="1" cellspacing="0">
              <tr style="background:url(../html/images/inicio_3.png)">
                <th width="10%" scope="col"><span class="Estilo3">N</span></th>
                <th width="20%" scope="col"><span class="Estilo3">PLACA</span></th>
                <th width="70%" scope="col"><span class="Estilo3">NOMBRE</span></th>
              </tr>
              <%
     try{
         if(request.getParameter("placa")!=null&&!request.getParameter("placa").isEmpty()&&request.getParameter("nombre")!=null&&!request.getParameter("nombre").isEmpty()){
             String nombre = request.getParameter("nombre");
             int placa = Integer.parseInt(request.getParameter("placa"));
             java.util.List<Agente> list = model.consultarListadoAgentes(placa, nombre);
                if(list.size()>0){
                    for(int i=0;i<list.size();i++){
                        Agente agente = list.get(i);
        %>
                    <tr>
                        <td><div align="center"><span class="Estilo4"><%=i+1%></span></div></td>
                        <td><div align="center"><span class="Estilo4"><%=agente.getPlaca()%></span></div></td>
                        <td><div align="center"><span class="Estilo4"><%=agente.getNombre() %></span></div></td>                       
                    </tr>
    <%              }
                    }else{ %>
                <script>
			alert("No se encontraron registros de Agentes");
		</script>
            <%    }
       }
   }catch(Exception exc){
       exc.printStackTrace();
   }  %>
          </table>
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