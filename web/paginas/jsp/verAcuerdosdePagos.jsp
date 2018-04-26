<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" pageEncoding="ISO-8859-1" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%

try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarAcuerdosdePago.jsp")){
                   modelo.Model model = (modelo.Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                    modelo.Persona persona2 = model.consultarPersona(usuario.getFk_persona());
                    String nombreU = persona2.getNombre_1()+" "+persona2.getApellido_1()+" "+(persona2.getApellido_2()!=null?persona2.getApellido_2():"");
                    String fecha = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
   
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
                            window.parent.document.location.href = "formularioTramite.jsp?id_radicacion="+idr;
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
<%    if(request.getParameter("excel").equals("1")){
response.setContentType ("application/vnd.ms-excel"); //Tipo de fichero.
response.setHeader ("Content-Disposition", "attachment;filename=\"AcuerdosDePagoFecha.xls\"");
%> <tr>
<td>Generado por:</td>
<td align="left"><%=nombreU%></td>
</tr>
<tr>
<td>Fecha:</td>
<td align="left"><%=fecha%></td>
</tr><%
} %>
              <tr style="background:url(../html/images/inicio_3.png)">
			    <th width="5%" scope="col"><span class="Estilo2">N°</span></th>
                <th width="10%" scope="col"><span class="Estilo2">USUARIO</span></th>
                <th width="10%" scope="col"><span class="Estilo2">FECHA</span></th>
                <th width="10%" scope="col"><span class="Estilo2">NUMERO</span></th>
				<th width="25%" scope="col"><span class="Estilo2">PERSONA</span></th>
                <th width="10%" scope="col"><span class="Estilo2">C.&nbsp;INICIAL</span></th>
				<th width="5%" scope="col"><span class="Estilo2">CUOTAS</span></th>
                <th width="15%" scope="col"><span class="Estilo2">VALOR</span></th>
                <th width="10%" scope="col"><span class="Estilo2">ESTADO</span></th>
              </tr>
              <%
     try{
         Sede sede = (Sede)session.getAttribute("sede");
         java.util.List<Financiacion> financiacion = null;
                  if(request.getParameter("opcion").equals("1")){
             if(request.getParameter("fi")!=null&&request.getParameter("ff")!=null){
String fechaI = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.text.SimpleDateFormat("yyyy/MM/dd").parse(request.getParameter("fi")));
String fechaF = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.text.SimpleDateFormat("yyyy/MM/dd").parse(request.getParameter("ff")));
java.sql.Date  fecha_inicial = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fechaI).getTime());
java.sql.Date  fecha_final = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fechaF).getTime());
                    financiacion = model.consultarFinanciacionesFechas(fechaI,fechaF);
                    HashMap parameters = new java.util.HashMap();
                    parameters.put("F_INICIAL", fecha_inicial);
                    parameters.put("F_FINAL", fecha_final);
                    session.setAttribute("reporteFinanciaciones", parameters);
             }
         }else{
              if(request.getParameter("opcion").equals("2")){
                  if(request.getParameter("fi")!=null&&request.getParameter("ff")!=null){
                    String fechaI = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.text.SimpleDateFormat("yyyy/MM/dd").parse(request.getParameter("fi")));
                    String fechaF = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.text.SimpleDateFormat("yyyy/MM/dd").parse(request.getParameter("ff")));
                    java.sql.Date  fecha_inicial = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fechaI).getTime());
                    java.sql.Date  fecha_final = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fechaF).getTime());
                    financiacion = model.consultarFinanciacionesFechasIncumplidas(fechaI,fechaF);
                    HashMap parameters = new java.util.HashMap();
                    parameters.put("F_INICIAL", fecha_inicial);
                    parameters.put("F_FINAL", fecha_final);
                    session.setAttribute("reporteFinanciacionesIncumplidas", parameters);
                 }
         }

         }
         if(financiacion!=null){               
                for(int i=0;i<financiacion.size();i++){
                    Financiacion finan = financiacion.get(i);
                    if(request.getParameter("opcion").equals("1")){
                        if(finan.getFk_persona()!=0){
                            Persona persona = model.consultarPersona(finan.getFk_persona());
                            String nombreUsuario = model.consultarUsuario(finan.getFk_usuario()).getNombre();
                            Parametro estado = model.consultarParametro(finan.getEstado(), 59);
                           %>
                        <tr>
                            <td><div align="center"><span class="Estilo4"><%=i+1%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=nombreUsuario%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(finan.getFecha())%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=finan.getNumero()%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=persona.getNombre_1()+" "+persona.getApellido_1() %></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=finan.getCuota_inicial()%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=finan.getCuotas()%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=finan.getValor()%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=estado.getNombre()%></span></div></td>
                         
                            
                        </tr>
        <%               }
                    }
                       if(request.getParameter("opcion").equals("2")){
                        if(finan.getFk_persona()!=0){
                            Persona persona = model.consultarPersona(finan.getFk_persona());
                            String nombreUsuario = model.consultarUsuario(finan.getFk_usuario()).getNombre();
                            Parametro estado = model.consultarParametro(finan.getEstado(), 59);
                           %>
                        <tr>
                            <td><div align="center"><span class="Estilo4"><%=i+1%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=nombreUsuario%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(finan.getFecha())%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=finan.getNumero()%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=persona.getNombre_1()+" "+persona.getApellido_1() %></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=finan.getCuota_inicial()%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=finan.getCuotas()%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=finan.getValor()%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=estado.getNombre()%></span></div></td>


                        </tr>
        <%

                         }
                    }
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