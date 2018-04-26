<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
try{
    if(session.getAttribute("model")!=null){
            if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("tramites.jsp")){
                    Model modelo= (Model)session.getAttribute("model");
                    if (!request.getParameter("clase").equals("")){%>
<style type="text/css">
<!--
.style1 {
	font-family: Tahoma;
	font-weight: bold;
	font-size: 12px;
}
.style2 {
	font-family: Tahoma;
	font-weight: bold;
}
-->
</style>

	<table width="100%" border="1" align="center"  cellpadding="1" cellspacing="0">
  <tr bgcolor="#CCCCCC" style="border:none;background:url(../html/images/inicio_3.png)">
    <td width="25%" style="border:none"><div align="center" class="style1" style="color:#FFFFFF" >CODIGO</div></td>
    <td width="55%" style="border:none"><div align="center" class="style1" style="color:#FFFFFF" ><strong>TRAMITE</strong></div></td>
   <td width="20%" style="border:none"><div align="center" class="style1" style="color:#FFFFFF" ><strong>ABREVIATURA</strong></div>	</td>

   <tr>
<%		 Sede sede = (Sede) session.getAttribute("sede");
         List listTramite = modelo.consultarTramites(Integer.parseInt(request.getParameter("clase")),sede.getId_sede()); 
         if(listTramite!=null){
	         Tramite tramite = new Tramite();
    	     Iterator itt = listTramite.iterator(); 
        	 while (itt.hasNext()) {
                   tramite = (Tramite)itt.next();
         %>
    <td width="10%"><div align="center" class="style2" style="color:#333333; font-size:12px"    ><%= tramite.getId_tramite() %> </div></td>
      <td width="50%"><div align="left" class="style2" style="color:#333333; font-size:12px"><%= tramite.getNombre() %></div></td>
      <td width="40%"><div align="left" class="style2" style="color:#333333; font-size:12px"> <%=tramite.getAbreviatura()==null?"":tramite.getAbreviatura()%></div></td>
    </tr>
   <%
       }// fin while
    } %>
  </tr>
</table>
  <%
}
                  }else{ %>
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
	