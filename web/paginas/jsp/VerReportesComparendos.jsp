<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarRadicacion.jsp")){
                    modelo.Model model = (modelo.Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                    String usu = usuario.getNombre();
   
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
                   function verR2(idr,inf){
                           window.location.href = "VerReportesComparendos.jsp?lol="+idr+"&ind="+inf;
			}
                       function verR(){
                                ancho = 789;
				alto = 250;
				barra = 0;
				izquierda = (document.width) ? (document.width-ancho)/2 : 100;
				arriba = (document.height) ? (document.height-alto)/2 : 100;
				opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
				var dir = "comparendos/comparendo.jasper";
			        var nombre = "Comparendos_por_Dias";
				url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
				window.open(url, 'popUp', opciones);
			}
			function sombrear(tr,color){
				tr.style.backgroundColor = color;
			}
			function renovar(tr){
				tr.style.backgroundColor = "#FFFFFF";
			}

                      

                        function verI(td){
                            var comparendo = td.id;
                            alert(comparendo);
                                ancho = 789;
				alto = 250;
				barra = 0;
				izquierda = (document.width) ? (document.width-ancho)/2 : 100;
				arriba = (document.height) ? (document.height-alto)/2 : 100;
				opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
				
			        var nombre = document.form.hidden.value;
                                alert(nombre);
				url = "consultarComparendo.jsp?id=0&comparendo="+comparendo;
				window.open(url, 'popUp', opciones);


                        }
		</script>
		
</head>
    <body>
            <table width="100%" border="1" cellpadding="1" cellspacing="0">
              <tr style="background:url(../html/images/inicio_3.png)">
                <th width="17%" scope="col"><span class="Estilo3">NUMERO</span></th>
                <th width="8%" scope="col"><span class="Estilo3">FECHA</span></th>
                <th width="30%" scope="col"><span class="Estilo3">INFRACTOR</span></th>
                <th width="8%" scope="col"><span class="Estilo3">ESTADO</span></th>
		<th width="34%" scope="col"><span class="Estilo3">DETALLE</span></th>
                <th width="3%" scope="col"><span class="Estilo3">VER</span></th>
               </tr>
              <%
     try{
         Comparendo comparendos = null;
         Sede sede = (Sede)session.getAttribute("sede");
        // java.util.List<Radicacion> radicaciones = null;
         //java.util.List<Comparendo> comparendo = null;
         java.util.List<Comparendo> info = null;
                 Persona personas = null;
                 Infraccion infracciones =null;
                 Parametro parametros = null;
                 //Comparendo comparendos = null;
          String fechaf = "00/00/0000";
          String x =null;

         if(request.getParameter("comparendo")!=null){ 	 
              comparendos = model.consultar_Comparendo(request.getParameter("comparendo").toUpperCase());
              personas = model.consultarPersona(comparendos.getFk_persona());
              infracciones = model.consultarInfraccion(comparendos.getFk_infraccion());
              parametros = model.consultarParametro(comparendos.getEstado(),67);
                           HashMap parameters = new java.util.HashMap();
                           parameters.put("COMPARENDO",comparendos.getNumero().toString());
                           session.setAttribute("Comparendos_por_Dias", parameters);

         if(comparendos!=null){
              if(comparendos.getFk_persona()!=0){
                      %>                     
                        <tr>
                            <td><div align="center"><span class="Estilo4"><%=comparendos.getNumero()%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(comparendos.getFecha())%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=personas.getDocumento()%>-<%=personas.getNombre_1()%> <%=personas.getApellido_1()%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=parametros.getNombre()%></span></div></td>
                            <td bgcolor=""><div align="center"><span class="Estilo4"><%=infracciones.getNumero()%>-<%=infracciones.getDescripcion()%></span></div></td>
                            <td onMouseOver="sombrear(this,'#FFFFFF')" onMouseOut="renovar(this)"><div align="center"><img src="../html/images/detalle.png" height="25" width="25" onClick="verR()" style="cursor:pointer"/></div></td>
                        </tr>
                        <%
                }else{
               // javax.swing.JOptionPane.showMessageDialog(null,"No de encontraron registros");
                        %>
                        <script language="javascript" type="text/javascript">
                            alert("no se encontraron registros");
                        </script>
                        <%
                }
                }
         }else{//end if Comparendo
          if(request.getParameter("infraccion")!=null){

               info = model.ConsultarComparendoByInfraccion(Long.parseLong(request.getParameter("infraccion")));
               infracciones =model.consultarInfraccion(Long.parseLong(request.getParameter("infraccion")));
               HashMap parameters = new java.util.HashMap();
                parameters.put("INFRACCION",infracciones.getNumero()+"");
                parameters.put("FECHA_INI",fechaf);
                parameters.put("FECHA_FIN" ,fechaf);
                parameters.put("USUARIO",usu);
                session.setAttribute("Comparendos_por_Dias", parameters);	   
	       if (info.size()>0){
               for(int i=0;i<info.size();i++){
                      Comparendo comp = info.get(i);
                      personas = model.consultarPersona(comp.getFk_persona());
                      parametros = model.consultarParametro(comp.getEstado(),67);
                        //  parameters.put("COMPARENDO",comp.getNumero());
                         // session.setAttribute("Comparendos_por_Dias", parameters);
                       String num = comp.getNumero();
                    %>                 
                    <tr>
                            <td><div align="center"><span class="Estilo4"><%=comp.getNumero()%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(comp.getFecha())%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=personas.getDocumento()%>-<%=personas.getNombre_1()%> <%=personas.getApellido_1()%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=parametros.getNombre()%></span></div></td>
                            <td bgcolor=""><div align="center"><span class="Estilo4"><%=infracciones.getDescripcion()%></span></div></td>
                            <td><img  src="../html/images/detalle.png" height="25" width="25" onClick="verR2('<%=infracciones.getId_infraccion()%>','<%=i%>')" style="cursor:pointer"/></td>
                    </tr>
                      <%
                      }
                }else{
                //javax.swing.JOptionPane.showMessageDialog(null,"No se encontraron registros");
                 %>
                        <script language="javascript" type="text/javascript">
                            alert("no se encontraron registros");
                        </script>
                        <%
                }

          }else{
          if(request.getParameter("lol")!=null){
                           info = model.ConsultarComparendoByInfraccion(Long.parseLong(request.getParameter("lol")));
                           infracciones =model.consultarInfraccion(Long.parseLong(request.getParameter("lol")));
                           Comparendo comp = info.get(Integer.parseInt(request.getParameter("ind")));
                           
                           HashMap parameters1 = new java.util.HashMap();
                           parameters1.put("COMPARENDO",comp.getNumero().toString());
                           session.setAttribute("Comparendos_por_Dias", parameters1);
                           %>
                           <script language="javascript" type="text/javascript">
                               verR();
                           </script>
                           <%
                           if (info.size()>0){
               for(int i=0;i<info.size();i++){
                      comp = info.get(i);
                      personas = model.consultarPersona(comp.getFk_persona());
                      parametros = model.consultarParametro(comp.getEstado(),67);
                        //  parameters.put("COMPARENDO",comp.getNumero());
                         // session.setAttribute("Comparendos_por_Dias", parameters);
                       String num = comp.getNumero();
                    %>
                    <tr>
                            <td><div align="center"><span class="Estilo4"><%=comp.getNumero()%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(comp.getFecha())%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=personas.getDocumento()%>-<%=personas.getNombre_1()%> <%=personas.getApellido_1()%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=parametros.getNombre()%></span></div></td>
                            <td bgcolor=""><div align="center"><span class="Estilo4"><%=infracciones.getDescripcion()%></span></div></td>
                            <td><img  src="../html/images/detalle.png" height="25" width="25" onClick="verR2('<%=infracciones.getId_infraccion()%>','<%=i%>')" style="cursor:pointer"/></td>
                    </tr>
                      <%
                      }
              }
          }//end if Infraccion
          }
      }
    }
    catch(Exception exc){
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