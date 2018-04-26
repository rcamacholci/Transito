<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"
		 import="modelo.Concepto" import="java.util.LinkedList" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Documento sin t&iacute;tulo</title>
<style type="text/css">
<!--
.Estilo1 {
	color: #CCCCCC;
	font-weight: bold;
	font-family: "Times New Roman", Times, serif;
}
.Estilo2 {
	color: #CCCCCC;
	font-family: "Times New Roman", Times, serif;
}
-->
</style>
</head>
<%      
        LinkedList listado_conceptos = new LinkedList() ;
		Model model = (Model) session.getAttribute("model") ;
        if(Long.parseLong(request.getParameter("fk_sede")) != 0){
            long fk_sede = Long.parseLong(request.getParameter("fk_sede")) ;
            listado_conceptos = model.listadoConceptosSedeTramite(fk_sede) ;
        }
%>

<body>
<form id="form1" name="form1" method="post" action="">
  <table width="100%" border="1">
    <tr>
      <th bgcolor="#0033FF" scope="col"><span class="Estilo2">Id</span></th>
      <th bgcolor="#0033FF" scope="col"><span class="Estilo1">Conceptos</span></th>
    </tr>
<%  
	if(!listado_conceptos.isEmpty()){
		for(int i = 0 ; i < listado_conceptos.size() ; i++){
			Concepto concepto = (Concepto) listado_conceptos.get(i) ;
%>
			<tr id="<%=concepto.getId_concepto()%>">
				<td><strong><%=concepto.getId_concepto()%></strong></td>
				<td><strong><%=concepto.getNombre()%></strong></td>
			</tr>
<%		}
	}
%>
  </table>
</form>
</body>
</html>
