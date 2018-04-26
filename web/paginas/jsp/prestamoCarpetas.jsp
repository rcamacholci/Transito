<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                       modelo.Model modelo = (modelo.Model)session.getAttribute("model");
                       
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="../html/scripts/calendar.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">



	 function mostrar(){
             if(document.getElementById("motivos").value==7){
                 document.getElementById('tramites').style.display = "block";
                 document.getElementById('lbtramites').style.display = "block";
            }else{
                document.getElementById('tramites').style.display = "none";
                document.getElementById('lbtramites').style.display = "none";
            }
        }

        function validar(){
                  if(document.getElementById("placa").value.length>0){
                        if(document.getElementById("motivos").value>0){
                                if(document.getElementById("observacion").value.length>0){
                                        if(document.getElementById("motivos").value == 7){
                                            if(document.getElementById("tramites").value!=0){
                                                 document.form.submit();
                                            }else{
                                                    alert("Seleccione un tramite");
                                            }
                                        }else{
                                              document.form.submit();
                                        }
                                }else{
                                       alert("Digite alguna observacion");
                                    }
                         }else{
                                alert("Seleccione algun motivo");
                         }
                   }else{
                        alert("Digite la numero de la placa");
                   }
        }

		
		
       
</script>

<style type="text/css">
<!--
.style1 {
	font-family: Tahoma;
	font-size: 12px;
	color: #FFFFFF;
	font-weight: bold;
}
.style7 {
	font-size: 12px;
	font-weight: bold;
}
.style9 {color: #333333; font-family: Tahoma; font-size: 12px; font-weight: bold; }
.Estilo8 {color: #333333; font-weight: bold; font-size: 12px; }
.style10 {font-family: Tahoma; font-size: 12px; font-weight: bold; }
-->
</style>
</head>
<% 
  modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");

%>
<body>
 <form id="form"  name="form" method="post" action="procesarPrestamo.jsp" onsubmit="validar()"> 
<fieldset>
<table width="80%" border="0" align="center" >
  <tr style="background:url(../html/images/inicio_3.png); border:none">
    <td colspan="4" align="center"><span class="style1">REGISTRO DE PRESTAMOS </span></td>
  </tr>
  <tr>
    <td width="20%"><span class="style9">PLACA</span></td>
    <td width="20%"  align="left" ><input id="placa" name="placa" type="text" maxlength="6" style="text-align:center;color:#333333; font:bold; text-transform:uppercase; width:140px"/></td>
	<td width="20%">&nbsp;</td>
	<td width="20%">&nbsp;</td>
  </tr>
  <tr>
    <td><span class="style9">MOTIVO</span></td>
    <td align="left"><span style="font-size: 10px">
      <select name="motivos" onchange="mostrar()" id="motivos"  style="width:142px;  font-size:10px; color:#333333">
        <option value="0">&lt;&lt;--Seleccione Motivo--&gt;&gt;</option>
        <%  java.util.List clases = modelo.listadoParametros(334);
                            for (int i = 0; i < clases.size(); i++) {
                                Parametro parametro = (Parametro) clases.get(i);%>
        <option  value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%></option>
        <%} %>
      </select>
    </span></td>
    <td colspan=""  align="center" class="style9"><label id="lbtramites" style="display:none"> TRAMITE</label></td>
	<td>
		    <select name="tramites" id="tramites"  style="width:140px; font-size:10px; color:#333333; display:none">
                                            <option value="0"><<--Seleccione Tramite-->></option>
                                            <% java.util.List tramites = modelo.consultarTramites(1,usuario.getFk_sede());
                                            for (int i = 0; i < tramites.size(); i++) {
                                                Tramite tramite = (Tramite) tramites.get(i);
                                            %>
                                             <option value="<%=tramite.getId_tramite()%>"><%= tramite.getNombre()%> </option>
                                             <%   }
                                             tramites = modelo.consultarTramites(2,usuario.getFk_sede());
                                             for (int i = 0; i < tramites.size(); i++) {
                                                Tramite tramite = (Tramite) tramites.get(i);%>
                                               <option value="<%=tramite.getId_tramite()%>"><%= tramite.getNombre()%> </option>
                                         <%   } %>
      </select>
                      
    </span></td>
  </tr>
 
  <tr class="style9">
  <td>OBSERVACION</td>
  <td colspan="3" align="justify"><span class="style10" style="color: #333333">
    <textarea name="observacion" id="observacion" style="width:480px; height:20x; font-size:11px"></textarea>
  </span></td>
  </tr>
  <tr>
  	<td colspan="4" align="center"><span style="border:none">
  	  <input name="adicionar" type="button" id="adicionar" value="Enviar Solicitud" style="width:150px; text-align:center" onclick="validar()"/>
  	</span></td>
  </tr>
</table>
</fieldset>
</body>
</form>
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