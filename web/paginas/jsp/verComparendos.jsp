<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("reportesComparendos.jsp")){
                    modelo.Model model = (modelo.Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
   
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href='../html/css/style.css' />
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
              <tr class="title_">
                <th scope="col"><span >N</span></th>
                <th scope="col"><span >RECIBO</span></th>
                <th scope="col"><span >FECHA PAGO</span></th>
                <th scope="col"><span >COMPARENDO</span></th>
                <th scope="col"><span >FECHA COMP.</span></th>
                <th scope="col"><span >VLR PAGADO</span></th>
                <th scope="col"><span >POLCA</span></th>
                <th scope="col"><span >PERSONA</span></th>
              </tr>
              <%
     try{
         Sede sede = (Sede)session.getAttribute("sede");
         java.util.List<Radicacion> radicaciones = null;
         if(request.getParameter("fi")!=null&&request.getParameter("ff")!=null){
                String fechaI = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fi")));
                String fechaF = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("ff")));
                 String polca = "0";
                 System.out.println("fecha Ini :"+fechaI);
                 System.out.println("fecha fin :"+fechaF);
                if(request.getParameter("polca")!=null){
                     polca = request.getParameter("polca");
                }
                 System.out.println("polca :"+polca);
                
                List<Cartera> listComparendos = model.listarCarteraComparendosPagados(fechaI, fechaF,Integer.parseInt(polca));
                HashMap parameters = new java.util.HashMap();
                parameters.put("USUARIO", usuario.getId_usuario()+"");
                parameters.put("POLCA",Integer.parseInt(polca));
                parameters.put("FECHA_INI", fechaI);
                parameters.put("FECHA_FIN", fechaF);
                session.setAttribute("recaudoC", parameters);
                int i = 0;
            for (Cartera cartera : listComparendos) {
                i++;
                Persona persona = model.consultarPersona(cartera.getFk_persona());
                Pago pago = model.consultarPago(cartera.getFk_pago());
                Comparendo comparendo = model.consultar_Comparendo(cartera.getReferencia());
               %>
        <tr>
            <td align="center"><%=i%></td>
            <td align="center"><%=pago.getNumero_factura() %></td>   
            <td align="center"><%=  new java.text.SimpleDateFormat("dd/MM/yyyy").format(pago.getFecha()) %></td>   
            <td align="center"><%= comparendo.getNumero()%></td>
            <td align="center"><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(comparendo.getFecha())%></td> 
            <td align="right"><%= pago.getValor_total()%></td>
            <td align="center"><%= comparendo.getPolca()==0?"No":"Si" %></td>
            <td align="left"><%= persona.getDocumento()+" - "+persona.getNombreCompleto()%></td>
        </tr>
        <%
                
            }
         
               
                    %>
                       
        <%          }
                
        
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