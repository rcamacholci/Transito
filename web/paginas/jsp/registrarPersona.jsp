
       <%@ page import="modelo.*"%>
       <%@page import="java.util.*"%>
<%
	if(session.getAttribute("model")!=null){
%>

<html>
<head>
    <script language="JavaScript1.2" type="text/javascript">
	function validarDocumento(form){
     	if(form.documento.value.length>0){
		
	       		return true;
				
     	}else{
			alert("Digite un numero de identificacion");
		}
		return false;
   }

 </script>

<title></title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<style type="text/css">
<!--
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style3 {color: #FFFFFF}
.style31 {color: #333333; font-size: 12px; font-weight: bold; font-family: Tahoma; }
.Estilo8 {font-size: 11px; font-weight: bold; color: #333333; font-family: Tahoma; }
-->
</style>
</head>
  <body><form name="forma"  onSubmit="return validarDocumento(this)"  method="post" action="registrarDatosPersona.jsp">
  <table width="56%" border="0" align="center">
  <tr>
  <td>
      <fieldset>
      <table width="100%" border="0" align="center">
	  <tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="style2 style14 style3">REGISTRAR DATOS DE PERSONA </span></td>
		  </tr>
	   
	  	<tr>
			<td colspan="5"><span class="style3"></span></td>
		</tr>
        <tr>
           <td width="17%"><span class="Estilo8">TIPO&nbsp;DOCUMENTO </span></td>
           <td width="29%"><span style="font-size: 11px">
             <select name="tipo"  style=" width:180px; color:#333333; font-size:11px">
               <%
        		Model modelo= (Model)session.getAttribute("model");
				Parametro parametro=new Parametro();
		        List list=modelo.listadoParametros(5);
        	    Iterator it = list.iterator(); 
	            while (it.hasNext()) {
                    parametro = (Parametro)it.next();%> 
               <option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
                <%}%>
             </select>
           </span> </td>
           <td width="18%"><div align="center"><strong class="Estilo8">DOCUMENTO</strong></div></td>
          <td width="23%"><input name="documento" type="text" style="color:#333333; text-align:center" value=""/></td>
          <td width="13%"><input name="Submit" type="submit" style="font-size:11px" value="Consultar"/></td>
        </tr>
      </table>
	  </fieldset>
	  </td>
    </tr>
    </table>
  </form>
  </body>
</html>
<%  }else{ %>
       <jsp:forward page="no_access.jsp">
             <jsp:param name="tipo" value="1"></jsp:param>
       </jsp:forward>
<%  }%>