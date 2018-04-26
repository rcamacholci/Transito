
       <%@ page import="modelo.*"%>
       <%@page import="java.util.*"%>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>

<html>
<head>
    <script language="JavaScript1.2" type="text/javascript">
	function validarDocumento(form){
     	if(form.documento.value.length>0){
			if(!isNaN(form.documento.value)){
	       		return true;
			}else{
				alert("Digite un numero de identificacion valido");
			}	
     	}else{
			alert("Digite un numero de identificacion");
		}
		return false;
   }

 </script>

<title></title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<SCRIPT SRC="../html/scripts/ssm.js" language="JavaScript1.2"></SCRIPT>
<!--<SCRIPT SRC="../html/scripts/ssmItems3.js" language="JavaScript1.2"></SCRIPT>!-->
<link rel="stylesheet" type="text/css" href='../html/css/style.css' />
<style type="text/css">
<!--
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style3 {color: #FFFFFF}
.style31 {color: #333333; font-size: 12px; font-weight: bold; font-family: Tahoma; }
.Estilo2 {
	color: #FFFFFF;
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
}
-->
</style>
</head>
  <body><form name="forma"  onSubmit="return validarDocumento(this)"  method="post" action="datosPersona.jsp" target="persona">
          <fieldset>
      <table width="60%" border="0"  bordercolor="#FFFFFF" align="center" >
	   
	  	<tr class="title_">
			<td colspan="11" align="center"><span >INSCRIPCION Y CONSULTA DE PERSONA NATURAL/JURIDICA</span></td>
	    </tr>
        <tr>
           <td width="10%"><span class="style2">TIPO&nbsp;DOCUMENTO </span></td>
           <td width="30%">
            <select name="tipo"  style=" width:180px; color:#333333; font-size:12px">
		     <%
        		Model modelo= (Model)session.getAttribute("model");
                        session.removeAttribute("certificado");
                        session.removeAttribute("id_persona");
				Parametro parametro=new Parametro();
		        List list=modelo.listadoParametros(5);
        	    Iterator it = list.iterator(); 
	            while (it.hasNext()) {
                    parametro = (Parametro)it.next();%> 
                    <option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
              <%}%>
            </select>          </td>
          <td width="10%"><strong class="style2">DOCUMENTO</strong></td>
          <td width="30%"><input type="text" name="documento" style="color:#333333; font-size:12px; text-align:center" value=""/></td>
          <td width="20%"><input type="submit" name="Submit" value="Consultar"/></td>
        </tr>
		
      </table>
	  </fieldset>
  </form>
            <iframe name="persona" width="100%" frameborder="0" height="600px">

            </iframe>
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