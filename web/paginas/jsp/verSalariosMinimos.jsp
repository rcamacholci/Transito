<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("salariosMinimos.jsp")){
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
            <table width="70%" border="0" cellpadding="0.5" cellspacing="0">
              <tr style="background:url(../html/images/inicio_3.png)">
                <th scope="col"><span class="Estilo3">NUMERO</span></th>
                <th scope="col"><span class="Estilo3">VIGENCIA</span></th>
                <th scope="col"><span class="Estilo3">VALOR</span></th>
              </tr>
              <tr bgcolor="#66CCFF">
                  <td colspan="3">&nbsp;</td>
              </tr>
    <%
     try{
        java.util.List<Salarios_Minimos> salariosM = null;
            if(request.getParameter("vigencia")!=null){
                System.out.println();
                long vigencia = Long.parseLong(request.getParameter("vigencia"));
                System.out.println("vigencia : " +vigencia);
                if(vigencia!=0){
                    salariosM = model.consultarSalariosMinimos(1,vigencia); 
                }else{
                    salariosM = model.consultarSalariosMinimos(0,vigencia);
                }
                    if(salariosM.size()>0){
                       for(int i=0;i<salariosM.size();i++){
                            Salarios_Minimos salario = salariosM.get(i);
                            %>
                        <tr onMouseOver="sombrear(this)" onMouseOut="renovar(this)"> 
                        <td><div align="center"><span class="Estilo4"><%=i+1%></span></div></td>
                        <td><div align="center"><span class="Estilo4"><%=salario.getVigencia()%></span></div></td>
                        <td><div align="center"><span class="Estilo4"><%="$ "+salario.getValor()+".00"%></span></div></td>
                        </tr>
<%          
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