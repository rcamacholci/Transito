<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*"  import="modelo.Parametro"  import="java.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarRadicacion.jsp")){
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
             
                            function ver(){
                                ancho = 789;
				alto = 250;
				barra = 0;
				izquierda = (document.width) ? (document.width-ancho)/2 : 100;
				arriba = (document.height) ? (document.height-alto)/2 : 100;
				opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
				var dir = "Comparendo/reporteInfraccionAnual/Infraccion_anual.jasper";
			        var nombre = "Comparendos";
				url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
				window.open(url, 'popUp', opciones);
                            }
                        
		
			function verR(idr){
                     
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
                <th width="17%" scope="col"><span class="Estilo3">NUMERO</span></th>
                <th width="8%" scope="col"><span class="Estilo3">FECHA</span></th>
                <th width="30%" scope="col"><span class="Estilo3">INFRACTOR</span></th>
                <th width="8%" scope="col"><span class="Estilo3">ESTADO</span></th>
		<th width="34%" scope="col"><span class="Estilo3">DETALLE</span></th>
               <!-- -->
              </tr>
              <%
                try{
                 Persona personas = null;
                 Infraccion infracciones =null;
                 Parametro parametros = null;
                 Comparendo comparendos = null;

                    java.util.List<Comparendo> lista = null;
                 
                    System.out.println("tamaño lista :"+request.getParameter("infrac"));
       
                     
                     String fechaI = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fi")));
                        String fechaF = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("ff")));
                        lista = model.consultarComparendoByFecha(fechaI, fechaF);
                      //javax.swing.JOptionPane.showMessageDialog(null,fechaI+">>"+fechaF+"\n numero registros"+lista.size());
                          System.out.println("tamaño lista :"+lista.size());
                          HashMap parameters = new java.util.HashMap();
                           parameters.put("INFRACCION","1000");
                           parameters.put("FECHA_INI",request.getParameter("fi"));
                           parameters.put("FECHA_FIN",request.getParameter("ff"));
                           session.setAttribute("Comparendos_por_Dias", parameters);

                           for(int i=0;i<lista.size();i++){
                                Comparendo comp = lista.get(i);
                                Parametro parametro = null;
                                parametro = model.consultarParametro(comp.getEstado(),67);
                                personas = model.consultarPersona(comp.getFk_persona());                                
                                infracciones = model.consultarInfraccion(comp.getFk_infraccion());                             
                                parametro = model.consultarParametro(comp.getEstado(),67);
                                    if(personas!=null){
                                       %>
                                      <tr>
                            <td><div align="center"><span class="Estilo4"><%=comp.getNumero()%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(comp.getFecha())%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=personas.getDocumento()%>-<%=personas.getNombre_1()%> <%=personas.getApellido_1()%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=parametro.getNombre()%></span></div></td>
                            <td bgcolor=""><div align="center"><span class="Estilo4"><%=infracciones.getNumero()%>-<%=infracciones.getDescripcion()%></span></div></td>
                                     </tr>
                                  <%
                                    
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