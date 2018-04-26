<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarLicencias.jsp")){
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
                <th width="10%" scope="col"><span class="Estilo3">RADICACION</span></th>
                <th width="10%" scope="col"><span class="Estilo3">LICENCIA</span></th>
                <th width="10%" scope="col"><span class="Estilo3">FECHA</span></th>
                <th width="20%" scope="col"><span class="Estilo3">PERSONA</span></th>
		        <th width="4%" scope="col"><span class="Estilo3">CATEGORIA</span></th>
                <th width="35%" scope="col"><span class="Estilo3">TRAMITE</span></th>
				<th width="10%" scope="col"><span class="Estilo3">SUSTRATO</span></th>
              </tr>
              <%
     try{
         Sede sede = (Sede)session.getAttribute("sede");
         Licencia_Conduccion licencia  = null;
         Persona persona = null;
         if(request.getParameter("opcion")!=null&&!request.getParameter("opcion").isEmpty()){

             String opcion = request.getParameter("opcion");
             HashMap parameters = new java.util.HashMap();
             if(opcion.equals("1")){
                 if(request.getParameter("licencia")!=null&&!request.getParameter("licencia").isEmpty()){
                     licencia = model.consultarLicencia(request.getParameter("licencia"));
                     if(licencia!=null){
                         persona = model.consultarPersona(licencia.getFk_persona());
                         parameters.put("LICENCIA", licencia.getNumeroLicencia());
                         parameters.put("DOCUMENTO","0");
                         parameters.put("USUARIO",usuario.getNombre());
                         session.setAttribute("reporteLicencia", parameters);
                     }
                 }
             }else{
                if(opcion.equals("2")){
                     if(request.getParameter("documento")!=null&&!request.getParameter("documento").isEmpty()&&request.getParameter("tipoDoc")!=null&&!request.getParameter("tipoDoc").isEmpty()){
                     persona = model.consultarPersona(Integer.parseInt(request.getParameter("tipoDoc")), request.getParameter("documento"));
                        if(persona!=null){
                             licencia = model.consultarLicenciaIdPersona(persona.getId_persona());
                             if(licencia!=null){
                                 parameters.put("LICENCIA","0");
                                 parameters.put("DOCUMENTO",persona.getDocumento());
                                 parameters.put("USUARIO",usuario.getNombre());
                                 session.setAttribute("reporteLicencia", parameters);
                             }
                        }
                    }
                }
             }

            if(licencia!=null){
                Radicacion_Licencia radicacionLicencia = model.consultar_RadicacionLicencia(licencia.getFk_radicacionLicencia());
                String nombrePersona = persona.getNombre_1()+" "+persona.getApellido_1();
                Tramite tramite = model.consultarTramite(licencia.getFk_tramite());
        %>
                    <tr>
                        <td><div align="center"><span class="Estilo4"><%=radicacionLicencia.getNumero()%></span></div></td>
                        <td><div align="center"><span class="Estilo4"><%=licencia.getNumeroLicencia()%></span></div></td>
                        <td><div align="center"><span class="Estilo4"><%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(licencia.getFechaRegistro())%></span></div></td>
                        <td><div align="center"><span class="Estilo4"><%=nombrePersona%></span></div></td>
                        <td><div align="center"><span class="Estilo4"><%=licencia.getCategoria()!=null?licencia.getCategoria():"" %> </span></div></td>
                        <td><div align="center"><span class="Estilo4"><%=tramite.getNombre()!=null?tramite.getNombre():""%></span></div></td>
                        <td><div align="center"><span class="Estilo4"><%=licencia.getNumeroSustrato()!=null?licencia.getNumeroSustrato():""%></span></div></td>
           </tr>
    <%          }else{ %>
                <script>
			alert("No se encontraron registros");
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