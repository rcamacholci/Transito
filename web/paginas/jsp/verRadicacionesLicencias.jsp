<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarRadicacionLicencias.jsp")){
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
			function verR(idr){
                            document.location.href = "radicarLicencia.jsp?radicacionl="+idr;
			}
			function sombrear(tr,color){
				tr.style.backgroundColor = color;
			}
			function renovar(tr){
				tr.style.backgroundColor = "#FFFFFF";
			}
		</script>

</head>
    <body>
            <table width="100%" border="1" cellpadding="1" cellspacing="0">
              <tr style="background:url(../html/images/inicio_3.png)">
                <th scope="col"><span class="Estilo3">NUMERO</span></th>
                <th scope="col"><span class="Estilo3">FECHA</span></th>
                <th scope="col"><span class="Estilo3">NOMBRE&nbsp;PERSONA</span></th>
                <th scope="col"><span class="Estilo3">USUARIO</span></th>
		<th scope="col"><span class="Estilo3">ESTADO</span></th>
                <th scope="col"><span class="Estilo3">VER</span></th>
              </tr>
              <%
     try{
         Sede sede = (Sede)session.getAttribute("sede");
         java.util.List<Radicacion_Licencia> radicacionesLicencias = null;
         if(request.getParameter("opcion")!=null&&!request.getParameter("opcion").isEmpty()){
             String opcion = request.getParameter("opcion");
             if(opcion.equals("1")){
                    if(request.getParameter("fi")!=null&&request.getParameter("ff")!=null){
                        String fechaI = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.text.SimpleDateFormat("yyyy/MM/dd").parse(request.getParameter("fi")));
                        String fechaF = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.text.SimpleDateFormat("yyyy/MM/dd").parse(request.getParameter("ff")));
                        radicacionesLicencias = model.consultarRadicacionesLicencias(fechaI,fechaF,sede.getId_sede());
                        HashMap parameters = new java.util.HashMap();
                        parameters.put("USUARIO", usuario.getId_usuario()+"");
                        parameters.put("FECHA_INI", fechaI);
                        parameters.put("FECHA_FIN", fechaF);
                        session.setAttribute("reporteTramiteLicencias", parameters);
                    }
              }else{
                  if(opcion.equals("2")){
                       if(request.getParameter("tipoDoc")!=null&&!request.getParameter("tipoDoc").isEmpty()&&request.getParameter("documento")!=null&&!request.getParameter("documento").isEmpty()){
                            String documento = request.getParameter("documento");
                            int tipoDoc = Integer.parseInt(request.getParameter("tipoDoc"));
                            Persona persona =  model.consultarPersona(tipoDoc, documento);
                            if(persona!=null){
                                radicacionesLicencias = model.consultarRadicacionesLicenciasPersona(persona.getId_persona());
                            }
                    }

                  }
              }
         if(radicacionesLicencias!=null){
                java.util.HashMap estado = model.crearHashParametros(52);
                for(int i=0;i<radicacionesLicencias.size();i++){
                    Radicacion_Licencia radicacionLicencia = radicacionesLicencias.get(i);
                    String placa = model.consultarPlacaByRadicacion(radicacionLicencia.getId_radicacion_licencia());
                    Persona persona = model.consultarPersona(radicacionLicencia.getFk_persona());
                    String tipoD = model.consultarParametro(persona.getTipo_documento(), 5).getNombreCorto();
                    String numeroD = persona.getDocumento();
                    String nombrePersona = persona.getNombre_1()+" "+persona.getApellido_1();
                    String nombreUsuario = model.consultarUsuario(radicacionLicencia.getFk_usuario()).getNombre();
		    String color = "#FFFFFF";
                    switch(radicacionLicencia.getEstado()){
                        case 2:color = "#FFB366";break;
                        case 3:color = "#C0C0C0";break;
                        case 4:color = "#8AFF8A";break;
                        case 5:color = "#3C9DFF";break;
                        case 6:color = "#FF6F6F";break;
                    }
                %>
                            <tr>
                                    <td><div align="center"><span class="Estilo4"><%=radicacionLicencia.getNumero()%></span></div></td>
                                    <td><div align="center"><span class="Estilo4"><%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(radicacionLicencia.getFecha())%></span></div></td>
                                    <td><div align="center"><span class="Estilo4"><%=tipoD+"  "+numeroD+"  -  "+nombrePersona%></span></div></td>
                                    <td><div align="center"><span class="Estilo4"><%=nombreUsuario%></span></div></td>
                                    <td bgcolor="<%=color%>"><div align="center"><span class="Estilo4"><%= estado.get(radicacionLicencia.getEstado()+"")%> </span></div></td>
                                    <td onMouseOver="sombrear(this,'<%=color%>')" onMouseOut="renovar(this)"><div align="center"><img src="../html/images/editar.png" height="16" width="16" onClick="verR('<%=radicacionLicencia.getId_radicacion_licencia()%>')" style="cursor:pointer"/></div></td>
                       </tr>
    <%          }
            }
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