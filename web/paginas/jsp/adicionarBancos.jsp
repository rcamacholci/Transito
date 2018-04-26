<%--
    Document   : adicionarBancos
    Created on : 8/02/2013, 02:34:45 PM
    Author     : Jefrey
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                    modelo.Model model = (modelo.Model)session.getAttribute("model");
%>

<html>
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="../html/css/lineaVertical.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="../html/css/3pestanas.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="../html/scripts/tablecloth.js"></script>
        <script type="text/javascript" src="../html/scripts/bancos.js"></script>
        <link href="../html/css/page2Colum.css" rel="stylesheet" type="text/css" media="screen" />
        <title>Adicionar Bancos</title>
    </head>

<body>
    <form name="form" action="" method="post">
  <fieldset>
    <div id="contenedor">

        <div id="lateral">
            <table width="400" border="1">
  <tr>
    <th scope="col">
        <div align="center">
            <img src="../html/images/adicionar.gif" alt="Nueva" name="adicionarBanco" width="15" height="15" id="adicionarBanco" style="cursor:pointer" onclick="anadirBanco()"/>
        AÑADIR BANCO</div>
    </th>

  </tr>
  
  <tr>
      <td width="100%" scope="row"><center><input type="text" align="center" name="NombreBanco" readonly id="NombreBanco" style="text-align:center; text-transform:uppercase; width:300px;" ></center></td>

  </tr>
</table>

    <table width="400" border="1">
  <tr>
    <th scope="col">
        <div align="center">
            <img src="../html/images/adicionar.gif" alt="Nueva" name="adicionarTipoPago" width="15" height="15" id="adicionarTipoPago" style="cursor:pointer" onclick="anadirTipoPago()"/>
        AÑADIR FORMAS DE PAGO</div>
    </th>

  </tr>

  <tr>
      <td width="100%" scope="row"><center><input type="text" align="center" name="NombreTipoPago" readonly id="NombreTipoPago" style="text-align:center; text-transform:uppercase; width:300px;" ></center></td>

  </tr>
</table>

  <table width="400" border="1">
  <tr>
    <th scope="col">
        <div align="center">
            <img src="../html/images/adicionar.gif" alt="Nueva" name="adicionarConcepto" width="15" height="15" id="adicionarConcepto" style="cursor:pointer" onclick="anadirConcepto()"/>
        AÑADIR CONCEPTOS</div>
    </th>

  </tr>

  <tr>
      <td width="100%" scope="row"><center><input type="text" align="center" name="NombreConcepto" readonly id="NombreConcepto" style="text-align:center; text-transform:uppercase; width:300px;" ></center></td>

  </tr>
</table>
    </div>
        <br>
<div id="div-border"></div>
        <div id="principal">

            <div class="tabs">
   <div class="tab">
       <input type="radio" id="tab-1" name="tab-group-1" checked>
       <label for="tab-1">Bancos</label>
       <div class="content">
           <iframe src="listarBancos.jsp" id="verBancos" name="verBancos" marginwidth="0" height="100%" width="100%" marginheight="0" align="top" scrolling="auto" style="border:none"></iframe>
       </div>
   </div>
   <div class="tab">
       <input type="radio" id="tab-2" name="tab-group-1">
       <label for="tab-2">Formas de pago</label>
       <div class="content">
           <iframe src="listarFormasdepago.jsp" id="verTiposdePago" name="verTiposdePago" marginwidth="0" height="100%" width="100%" marginheight="0" align="top" scrolling="auto" style="border:none"></iframe>
       </div>
   </div>
    <div class="tab">
       <input type="radio" id="tab-3" name="tab-group-1">
       <label for="tab-3">Conceptos</label>
       <div class="content">
           <iframe src="listarConceptos.jsp" id="verConceptos" name="verConceptos" marginwidth="0" height="100%" width="100%" marginheight="0" align="top" scrolling="auto" style="border:none"></iframe>
       </div>
   </div>
</div>

            
        </div>

</div>
  </fieldset>
</form>
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