<%-- 
    Document   : verTramiteDescuentos
    Created on : 15/02/2013, 02:08:29 PM
    Author     : Jefrey
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		//if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("Pase_Conceptos.jsp")){
                    if(1==1){
                    modelo.Model modelo = (modelo.Model)session.getAttribute("model");
                    Usuario usuario = (Usuario)session.getAttribute("usuario");
                    Sede sede = (Sede)session.getAttribute("sede");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="../html/css/lineaVertical.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="../html/scripts/tablecloth.js"></script>
        <script type="text/javascript">
            function CargarT(option){
                window.parent.frames[1].location.href = "verTablaPase_Conceptos.jsp?id_concepto="+option.value;
            }
        </script>
        <title>Ver tramite Descuento</title>
    </head>
    <body>
        <form name="form" method="post" action="">
         <table border="1">
         <tr>
          <th width="267" colspan="4" scope="col">CONCEPTOS</th>
         </tr>
          <tr>
            <th width="32" scope="col">ID</th>
            <th width="230" scope="col">NOMBRE CONCEPTO</th>
            <th width="71" scope="col">SELEC</th>
          </tr>
          <%
          java.util.List conceptos = modelo.listadoConceptosSedeTramite(usuario.getFk_sede());
          for(int i=0;i<conceptos.size();i++){
          Concepto concepto = (Concepto)conceptos.get(i);
          Configuracion_descuentos conf = modelo.getConfiguracion_descuento(sede.getId_sede(),concepto.getId_concepto(),1,1);
          if(conf!=null){
              Concepto conc = modelo.consultarConcepto(conf.getFk_concepto());
           %>
          <tr>
            <td scope="col"><center><%=conc.getId_concepto() %></center></td>
            <td scope="col"><%=conc.getNombre() %></td>
            <td scope="col"><center><input type="radio" name="id_concepto" id="id_concepto" value="<%=conc.getId_concepto() %>" onclick="CargarT(this)"></center></td>
          </tr>
          <%}}%>
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
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>