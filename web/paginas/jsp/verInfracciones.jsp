<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("infracciones.jsp")){
                    modelo.Model model = (modelo.Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                    java.sql.Date fechaSystem= new java.sql.Date(new java.util.Date().getTime());
                    String fecha = new java.text.SimpleDateFormat("yyyy").format(fechaSystem);
                    System.out.println(" ano :"+fecha);
                   

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
	font-size: 13px;
}
-->
        </style>
		<script language="javascript" type="text/javascript">
			
			function sombrear(tr){
                            tr.style.backgroundColor="#CCCCCC";
                        }
                        function renovar(tr){ 
                                tr.style.backgroundColor="#FFFFFF";
                        }
		</script>

</head>
<body>
    <center>
        <fieldset>
            <table width="100%" border="0" cellpadding="0.5" cellspacing="0">
              <tr style="background:url(../html/images/inicio_3.png)">
                <th scope="col"><span class="Estilo3">CODIGO</span></th>
                <th scope="col"><span class="Estilo3">DESCRIPCION</span></th>
                <th scope="col" width="5%"><span class="Estilo3">VIG.</span></th>
                <th scope="col" width="5%"><span class="Estilo3">SALARIOS</span></th>
                <th scope="col" width="10%"><span class="Estilo3">VALOR</span></th>
              </tr> 
              <tr bgcolor="#66CCFF">
                  <td colspan="5">&nbsp;</td>
              </tr>
    <%
     try{
        java.util.List Infracc = null;
            if(request.getParameter("vigencia")!=null&&request.getParameter("infraccion")!=null){
                
                int vigencia = Integer.parseInt(request.getParameter("vigencia"));
                System.out.println("vigencia : " +vigencia);
                Infracc = model.listarInfraccionesByNumero(request.getParameter("infraccion").toUpperCase());
               
                    if(Infracc.size()>0){
                       for(int i=0;i<Infracc.size();i++){
                            Infraccion infraccion = (Infraccion)Infracc.get(i);
                            java.util.List valorI = model.listarValorInfraccionesVigencia(infraccion.getId_infraccion(),vigencia);
                                if(valorI.size()>0){
                                    for(int j=0;j<valorI.size();j++){
                                        Valor_Infraccion valorInfr = (Valor_Infraccion)valorI.get(j);


                                %>
                            <tr onMouseOver="sombrear(this)" onMouseOut="renovar(this)">

                            <td><div align="center"><span class="Estilo4"><%=infraccion.getNumero() %></span></div></td>
                            <td style="font-size:10px"><div align="left"><span class="Estilo4"><%=infraccion.getDescripcion() %></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%= new java.text.SimpleDateFormat("yyyy").format(valorInfr.getFecha_ini())%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=infraccion.getSalarios_minimos()  %></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%=valorInfr.getValor() %></span></div></td>
                            </tr>
    <%                          }
                            }
                        }
                    }
                }
   }catch(Exception exc){
       exc.printStackTrace();
   }  %>
          </table>
        </fieldset>
    </center>
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