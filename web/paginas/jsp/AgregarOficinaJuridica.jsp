<%-- 
    Document   : AgregarOficinaJuridica
    Created on : 9/08/2012, 02:30:31 PM
    Author     : Administrador
--%>


       <%@ page import="modelo.*"%>
       <%@page import="java.util.*"%>
<%
	if(session.getAttribute("model")!=null){
        Model modelo =(Model)session.getAttribute("model");
%>

<html>
<head>
<script type="text/javascript" src="../html/scripts/AgregarOficinaJuridica.js"></script>
<title>Agregar Oficina Juridica</title>

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
  <body><form name="form" method="post" action="javascript:VerificarCampo()">
  <table width="56%" border="0" align="center">
  <tr>
  <td>
      <fieldset>
      <table width="100%" border="0" align="center">
	  <tr style="border:none; background:url(../html/images/inicio_3.png)">
		<td colspan="11" align="center"><span class="style2 style14 style3">Agregar Oficina Juridica </span></td>
		  </tr>

	  	<tr>
			<td colspan="5"><span class="style3"></span></td>
		</tr>
        <tr>
            <td width="17%" colspan="2"><span class="Estilo8">Oficina Juridica</span></td>
           <td colspan="3"><span class="style10" style="color: #333333">
            
       <select name="oficina" id="oficina" style="width:100%;font-size:12px" onchange="VerificarOficina(this.value)">
          <option value="nuevo">Nuevo</option>

       <%
	   java.util.List list = modelo.consultarOficinasJuridicas();
	   Iterator it = list.iterator();
		while (it.hasNext()) {
			Oficina_Juridica oficina = (Oficina_Juridica)it.next(); %>
                        
                       <option value="<%=oficina.getId_oficina()+""%>"><%=oficina.getNombre()%></option>
          <%}%>
       </select>
           </span> </td>
           
        </tr>

        <tr>
            <td width="18%"colspan="2"><div align="center"><strong class="Estilo8">Editar</strong></div></td>
            <td width="100%" colspan="3">
                <input name="idoficinaJuridica" value="nuevo" type="hidden" style="color:#333333; text-align:center"/>
                <input name="oficinaJuridica" type="text" style="width:100%; color:#333333; text-align:center" value=""/></td>
            <td width="13%"><input name="guardar" type="submit" style="font-size:11px" value="Guardar"/></td>
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