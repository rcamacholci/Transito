<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("listar_sustratos.jsp")){
                        Model modelo= (Model)session.getAttribute("model");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	 <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
		<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
		function nuevoAjax(){
	var xmlhttp= false;
	try{
		xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
	}catch(e){
		try {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}catch(E){
			xmlhttp = false;
		}
	}

	if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
		xmlhttp = new XMLHttpRequest();
	}

	return xmlhttp;
}


	
	function revisar(){
            if(document.getElementById("estado").value!=0){
                if(document.getElementById("observacion").value!=0){
                    document.form.submit();
                }else{
                    alert("Dede escribir algun Motivo");
                }
                    
            }else{
                    alert(" Seleccione el estado ");
            }
        }

	function salir(){
            var rango = document.form.rango.value;
            window.location.href="listar_sustratos.jsp?rangoS="+rango+"&id=0&n=1";
        }
</script>


<title>Editar Venal</title>
<style type="text/css">
<!--
.style2 {
	color: #333333;
	font-weight: bold;
	font-size: 12px;
	font-family: Tahoma;
}
.Estilo2 {color: #FFFFFF}
.Estilo4 {font-family: Tahoma; font-size: 10px; font-weight: bold; }
-->
</style>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>


<%
  if(request.getParameter("sustrato")!=null){
	long id_sustrato = (Long.parseLong(request.getParameter("sustrato")));
        Sustratos sustrato = modelo.consultarSustratoById(id_sustrato);
        %>
<body>
<form id="form" name="form" method="post" action="procesar_sustrato.jsp?">

<input type="hidden" name="idSustrato" id="idSustrato" value="<%=id_sustrato%>"/>
<input type="hidden" name="rangoS" id="rangoS" value="<%=sustrato.getFk_rango_sustrato()%>"/>
 <fieldset>
 <div align="center">
     <legend class="style2"  align="center">
 </legend>
 </div>
 <table width="60%" border="0" align="center" cellpadding="1" cellspacing="0">
    <tr bgcolor="#CCCCCC" style="border:none;background:url(../html/images/inicio_3.png)">
		<td colspan="2" class="style2"><div align="center" class="Estilo2">SUSTRATO&nbsp;  N&ordm; - <%= sustrato.getNumero() %></div></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
    <tr>
      <td width="47%" style="border:none" align="center"><span class="style2"><span class="style2" style="border:none">ESTADO</span></span></td>
      <td width="53%" style="border:none" align="center"><select name="estado" id="estado"  style="width:150px;">
                           <option value="0"><<--Seleccione Estado-->></option>			
                        <%  java.util.List clases = modelo.listadoParametros(339);
                            for (int i = 0; i < clases.size(); i++) {
                                Parametro estado = (Parametro) clases.get(i);%>
                                <option  value="<%=estado.getCodigo()%>"><%= estado.getNombre()%></option>
                           <%} %>
      </select>         </td>
    </tr>
	<tr>
		
		<td class="style2" colspan="2"><div align="center">MOTIVO</div></td>
	</tr>
	<tr>
		
		<td align="center" colspan="2"><span class="Estilo4" style="color: #333333">
		  <textarea name="observacion"  id="observacion" style="width:430px; height:40px;font-size:11px"></textarea>
		</span></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>

   

    <tr>
      <td colspan="6" align="center" style="border:none">
	  	<table width="100%" border="0">
          <tr>
            <th width="50%" scope="col" style="border:none">
			<input name="enviar" type="button" id="enviar" value="Editar" style="width:100px; text-align:center" onclick="revisar()"/></th>
            <th width="50%" scope="col" style="border:none">
			<input name="cancelar" type="button" id="cancelar" value="Cancelar" style="width:100px; text-align:center" onclick="salir()"/></th>
          </tr>
        </table>	  </td>
    </tr>
  </table>
  </fieldset>
</form>
</body>
<%
}
 

%>
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