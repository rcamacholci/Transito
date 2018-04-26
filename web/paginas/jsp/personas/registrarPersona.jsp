<%-- 
    Document   : registrarPersona.jsp
    Created on : 14-jul-2010, 23:47:43
    Author     : Civitrans
--%>

<%@ page import="modelo.Persona,modelo.Model,modelo.Parametro" %>
<%
	if(session.getAttribute("model")!=null){
%>

<html>
<head>
    <script language="javascript" type="text/javascript">
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
        <style type="text/css">
            <!--
.Estilo6 {
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
	color: #FFFFFF;
}
.Estilo9 {font-family: Tahoma; font-weight: bold; color: #333333; font-size: 12px; }
						-->
        </style>

</head>
  <body>
      <form name="forma"  onSubmit="return validarDocumento(this)"  method="post" action="registrarDatosPersona.jsp">
  <table width="49%" border="0" align="center">
 <tr style="border:none; background:url(../../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="style2 style14 style3 Estilo6">REGISTRAR DATOS DE PERSONA </span></td>
    </tr>
	  
  <tr>
  	  	

  <td>
  	<fieldset>
        <table width="100%" border="0" align="center">
        <tr>
           <td width="17%"><span class="Estilo9">TIPO&nbsp;DOCUMENTO  </span></td>
           <td width="29%"><span style="font-size: 11px">
             <select name="tipo"  style=" width:180px; color:#333333; font-size:11px">
               <%
                    Model model= (Model)session.getAttribute("model");
                    Parametro parametro = null;
                    java.util.List lista = model.listadoParametros(5);
                    java.util.Iterator iterator = lista.iterator();
                    while (iterator.hasNext()) {
                        parametro = (Parametro)iterator.next();
                        if(parametro.getCodigo()==1||parametro.getCodigo()==3||parametro.getCodigo()==4||parametro.getCodigo()==5){ %>
                            <option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
                  <%    }
                     }
  %>
             </select>
           </span> </td>
           <td width="18%"><div align="center" class="Estilo9">DOCUMENTO</div></td>
          <td width="23%"><input name="documento" type="text" style="color:#333333; width:100px; text-align:center" value=""/></td>
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
       <jsp:forward page="../no_access.jsp">
             <jsp:param name="tipo" value="1"></jsp:param>
       </jsp:forward>
<%  }%>
