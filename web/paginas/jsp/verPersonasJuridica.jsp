<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarDatosPersona.jsp")){
                        Model modelo = (Model)session.getAttribute("model");
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
			function verR(idr){
                            document.location.href = "formularioTramite.jsp?id_radicacion="+idr;
			}
			function sombrear(tr){
				tr.style.backgroundColor = "#CCCCCC";
			}
			function renovar(tr){
				tr.style.backgroundColor = "#FFFFFF";
			}
                         function datosPersona(tr){
                            var documento = tr.id;
                            var paso = 1;
                            var tipoDoc = 2;
				 window.location.href = "consultarPersonaRUNT.jsp?paso="+paso+"&documento="+documento+"&tipo="+tipoDoc;
			}


		</script>

</head>
    <body>
            <table width="70%" border="1" cellpadding="1" align="center" cellspacing="0">
              <tr style="background:url(../html/images/inicio_3.png); border:none">
                <th width="30%" style="border:none" scope="col"><span class="Estilo3">NIT</span></th>
                <th width="70%" style="border:none" scope="col"><span class="Estilo3">RAZON SOCIAL</span></th>
                
              </tr>
              <%
     try{
         if(request.getParameter("razon")!=null){
                String razon = request.getParameter("razon");
                java.util.List<Empresa> Listempresas = modelo.consultarEmpresaRazonSocial(razon);
               
                for(int i=0;i<Listempresas.size();i++){
                    Empresa empresa = Listempresas.get(i);
                   
                %>
                <tr id="<%=empresa.getNit()%>"  bgcolor="#FFFFFF"  style="cursor:pointer;"  onclick="datosPersona(this)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                    <td><div align="center"><span class="Estilo4"><%=empresa.getNit()%></span></div></td>
                    <td><div align="center"><span class="Estilo4"><%=empresa.getRazon_social()!=null?empresa.getRazon_social():""%></span></div></td>
               </tr>
<%          }
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

 