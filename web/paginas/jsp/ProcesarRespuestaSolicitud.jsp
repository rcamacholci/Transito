
<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Documento sin t&iacute;tulo</title>
<script src="../html/scripts/personas.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
		function revisar(){

                    if(document.form.num.value.length >0){
                        document.form.submit();
                    }else{
                        alert("Digite al menos 1 Placa");
                    }

                }
                
</script>
<style type="text/css">
<!--
.Estilo1 {
	color: #333333;
	font-weight: bold;
	font-family: Tahoma;
	font-size: 12px;
}
.Estilo2 {
	font-family: Tahoma;
	font-size: 12px;
}
-->
</style>
</head>
<body>
    <form name="form" id="form" method="POST" enctype="multipart/form-data" action="CargarRespuestaSolicitud.jsp" onsubmit="revisar()">
<table width="80%" border="0" align="center">
  <tr style="background:url(../html/images/inicio_3.png)">
      <th scope="col" colspan="2"><span class="Estilo2" style="color: #FFFFFF"><font style="font-size:11px">&nbsp;</font></span></th>
  </tr>
 <%
 int cantVeh;
 long id_oficio;
 String oficioC = "";

        if(request.getParameter("oficioC")!=null){
        oficioC = request.getParameter("oficioC");
        id_oficio = Long.parseLong(request.getParameter("id_oficio"));
        String num = request.getParameter("busqueda");
        System.out.println(oficioC+" "+id_oficio+" "+num);
        //cantVeh = Integer.parseInt(request.getParameter("cantVeh"));
        
		%>	

           
        <tr>
	<td width="50%" align="center"><span class="Estilo1">Cargar Plano</span></td>	
        <td height="40px" align="center"><input type="file" name="archivo" size="80px" value="" /></td>
        <input type="hidden" name="filename" value="Plano.txt" />
        <input type="hidden" id="idOficio" name="idOficio" value="<%=id_oficio%>" />
        <input type="hidden" id="oficioC" name="oficioC" value="<%=oficioC%>" />
        <input type="hidden" id="num" name="num" value="<%=num%>" />
       </tr>	    
 		
<%
 }
 %>
 
 <tr><td colspan="2" align="center"><input id="consultar"  name="consultar"  type="button" value="Generar Respuesta al Oficio" onclick="revisar()" style="color:#333333"/></td></tr>
</table>
</form>
</body>
</html>
