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

			function sombrear(tr){
				tr.style.backgroundColor = "#CCCCCC";
			}
			function renovar(tr){
				tr.style.backgroundColor = "#FFFFFF";
			}

                        function datosPersona(tr){
                            var documento = tr.id;
                            var paso = 1;
                            var tipoDoc = 1;
				 window.location.href = "consultarPersonaRUNT.jsp?paso="+paso+"&documento="+documento+"&tipo="+tipoDoc;
			}

                        


		</script>

</head>
    <body>
	<fieldset><div align="center">
		    <legend class="Estilo4"  align="center">DATOS DE LA PERSONA</legend>
		  	</div> 
            <table width="100%" border="1" cellpadding="1" align="center" cellspacing="0">
                <tr style="background:url(../html/images/inicio_3.png); border:none">
                <th width="20%" height="26" style="border:none" scope="col"><span class="Estilo3">DOCUMENTO</span></th>
                <th width="20%" style="border:none" scope="col"><span class="Estilo3">PRIMER&nbsp;NOMBRE</span></th>
                <th width="20%" style="border:none" scope="col"><span class="Estilo3">SEGUNDO&nbsp;NOMBRE</span></th>
                <th width="20%" style="border:none" scope="col"><span class="Estilo3">PRIMER&nbsp;APELLIDO</span></th>
                 <th width="20%" style="border:none" scope="col"><span class="Estilo3">SEGUNDO&nbsp;APELLIDO</span></th>
              </tr>
              <%
            String nombre1="";
            String nombre2="";
            String apellido1="";
            String apellido2="";


     try{
         if(request.getParameter("nombre1")!=null){
            nombre1 = request.getParameter("nombre1");
         }
         if(request.getParameter("nombre2")!=null){
            nombre2 = request.getParameter("nombre2");
         }
         if(request.getParameter("apellido1")!=null){
            apellido1 = request.getParameter("apellido1");
         }
         if(request.getParameter("apellido2")!=null){
            apellido2 = request.getParameter("apellido2");
         }


                java.util.List<Persona> ListPersonas = modelo.consultarPersonaNatural(nombre1,nombre2,apellido1,apellido2);
                   for(int i=0;i<ListPersonas.size();i++){
                             Persona personas = ListPersonas.get(i);

                %>
                 <tr id="<%=personas.getDocumento()%>"  bgcolor="#FFFFFF"  style="cursor:pointer;"  onclick="datosPersona(this)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                <td><div align="center"><span class="Estilo4"><%=personas.getDocumento()%></span></div></td>
                <td><div align="center"><span class="Estilo4"><%=personas.getNombre_1()!=null?personas.getNombre_1():""%></span></div></td>
                <td><div align="center"><span class="Estilo4"><%=personas.getNombre_2()!=null?personas.getNombre_2():""%></span></div></td>
                <td><div align="center"><span class="Estilo4"><%=personas.getApellido_1()!=null?personas.getApellido_1():""%></span></div></td>
                <td><div align="center"><span class="Estilo4"><%=personas.getApellido_2()!=null?personas.getApellido_2():""%></span></div></td>
                </tr>
    <%
                 }
   }catch(Exception exc){
       exc.printStackTrace();
   }  %>
          </table>
		  </fieldset>
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