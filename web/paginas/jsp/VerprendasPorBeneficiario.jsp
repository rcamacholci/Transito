<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>

<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("prendasPorBeneficiario.jsp")){
                    modelo.Model model = (modelo.Model)session.getAttribute("model");
%>


<script language="javascript" type="text/javascript">
	
        function edit(tr){
		document.location.href = "VerReportePorPrenda.jsp?&nombprenda="+tr.id;
	}
        function sombrear(tr){
		tr.style.backgroundColor="#CCCCCC";
	}
	function renovar(tr){
		tr.style.backgroundColor="#FFFFFF";
	}

        


</script>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Ver prendas por beneficiario</title>
        <style type="text/css">
            <!--
            .Estilo4 {
                font-weight: bold;
                font-family: "Times New Roman", Times, serif;
                color: #FFFF99;
                font-size:12px;
            }
            -->

        </style>
	    <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <META http-equiv=Content-Type content="text/html; charset=windows-1252">


        <STYLE>


<!--
A.ssmItems:link		{color:black;text-decoration:none}
A.ssmItems:hover	{color:black;text-decoration:none}
A.ssmItems:active	{color:black;text-decoration:none}
A.ssmItems:visited	{color:black;text-decoration:none}
.style3 {font-size: 12px; font-family: Tahoma; }
.style6 {color: #333333; font-size: 12px; font-weight: bold; }
.Estilo32 {
	color: #FFFFFF;
	font-weight: bold;
	font-size: 12px;
}
-->
        </STYLE>
</head>
    <body>
        <table width="100%" border="1" align="center"  cellpadding="1" cellspacing="0">
  <tr style="border:none;background:url(../html/images/inicio_3.png)">
    <td width="25%" style="border:none" align="center" class="Estilo32" >PRENDAS</td>
   </tr>
  
  
        <%
        java.util.List<Prendatarios> prendas = null;
        String prendatario = request.getParameter("prenda");
        prendas  = model.ConsultarPrendatarios(prendatario);
        for(int i=0;i<prendas.size();i++){
        Prendatarios prend = prendas.get(i);
        %>
       <tr onMouseOver="sombrear(this)"  style="cursor:pointer"  ondblclick="edit(this)" onMouseOut="renovar(this)" id="<%= prend.getObservaciones()%>">
       
      <td width="10%" align="center" class="style2" style="color:#333333; font-size:12px"><%=prend.getObservaciones()%></td>
      </tr>
    
     <% } %>

  
     
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
}catch(Exception mexe){
mexe.printStackTrace();
%>

    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
