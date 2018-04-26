<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<META http-equiv=Content-Type content="text/html; charset=windows-1252">
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script src="../html/scripts/editarPropietario.js" type="text/javascript"></script>
		<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>

<title>Adicionar Propietario</title>
<style type="text/css">
<!--
.Estilo1 {
	color: #0066CC;
	font-weight: bold;
}
.style2 {
	color: #333333;
	font-weight: bold;
	font-size: 12px;
	font-family: Tahoma;
}
-->
</style>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>

<%
Model modelo= (Model)session.getAttribute("model");
String placa = "";
if(request.getParameter("id")=="0"){
	placa =  request.getParameter("placa");
}else{
	placa =  session.getAttribute("placa")+"";
}
if(placa!=null){
Vehiculo vehiculo  = new Vehiculo();
vehiculo=modelo.consultarVehiculo(placa.toUpperCase());
if (vehiculo!=null){
    Parametro parametro = new Parametro();
    long id_propietario = Long.parseLong(request.getParameter("id_propietario"));
    Propietario propietario = modelo.getPropietario(id_propietario);
    Persona persona = modelo.consultarPersona(propietario.getFk_persona());
    if(persona!=null && propietario!=null){
        session.setAttribute("propietario", propietario);



%>
<body>
<form id="form" name="form" method="post" action="actualizar_propietario.jsp">
<input type="hidden" name="vehiculo" id="vehiculo" value="<%=vehiculo.getId_vehiculo()%>"/>
 <fieldset>
 <div align="center">
   <legend class="style2"><strong>EDITAR</strong></legend>
 </div>
 <table width="70%" border="0" align="center" cellpadding="1" cellspacing="0">

    <tr>
      <td width="15%" style="border:none"><span class="style2">TIPO&nbsp;DOCUMENTO </span></td>
      <td width="23%" style="border:none">
          <%
          parametro = modelo.consultarParametro(persona.getTipo_documento(), 5);

          %>
          <input type="text" disabled value="<%=parametro.getNombre()%>" size="30">	  </td>
	  <td width="1%" style="border:none">&nbsp;</td>
      <td width="22%" style="border:none"><span class="style2">DOCUMENTO</span></td>
      <td colspan="2" style="border:none"><input type="text" name="documento" disabled id="documento" onBlur="validarPersona()" style="width:200px" value="<%=persona.getDocumento()%>" /></td>
    </tr>
    <tr>
      <td style="border:none"><span class="style2">NOMBRES Y APELLIDOS </span></td>
      <td colspan="3" style="border:none">
          <input type="text" name="nombre" id="nombre" disabled style="width:300px" value="<%=persona.getNombre_1()+" "+(persona.getNombre_2()!=null?persona.getNombre_2():"")+" "+persona.getApellido_1()+" "+(persona.getApellido_2()!=null?persona.getApellido_2():"") %>"/>      </td>
      <td width="17%" style="border:none"><span class="style2">PORCENTAJE</span></td>
      <td width="22%" style="border:none"><select name="porcentaje" style="width:70px">
			   <%
                           String Selected = "";

                           for(int i=100;i>=10;i=i-10){
                               if(propietario.getPorcentaje()==i)
                                   Selected="selected";
                               else Selected = "";

                               %>
                               <option <%=Selected%> value="<%=i%>"><%=i%></option>
		        <%}%>
      		</select>
      <span class="style2" >&nbsp;%</span></td>
    </tr>
    <tr>

        <td class="style2">TIPO&nbsp;PROPIEDAD</td>
        <td>
            <%

            List listaParametros = modelo.listadoParametros(327);

%>

            <select name="tipoPropiedad">
                <%
                Selected ="";
                for(int i=0;i<listaParametros.size();i++){
                    parametro = (Parametro) listaParametros.get(i);
                    if(propietario.getTipoPropiedad()!=null){
                        if(parametro.getCodigo()==Long.parseLong(propietario.getTipoPropiedad()))
                            Selected="selected";
                        else Selected="";
                    }

                    %>
                    <option <%=Selected%> value="<%=parametro.getCodigo()%>"><%=parametro.getNombre()%></option>
                <%
                }
                %>
            </select>        </td>
        <td></td>
        <td class="style2">PROINDIVISO</td>
        <td>
            <%
            String chk1="",chk2="";
            if(propietario.getProIndiviso()!=null){
                if(propietario.getProIndiviso().equalsIgnoreCase("s"))
                    chk1="checked";
                else chk2="checked";
            }

            %>
            <span class="style2">Si</span>&nbsp;
            <input type="radio" name="proIndiviso" <%=chk1%> value="S">&nbsp;
        <span class="style2">No</span>&nbsp;
        <input type="radio" name="proIndiviso" <%=chk2%> value="N">        </td>
		<td>&nbsp;</td>
    </tr>

    <tr>
      <td style="border:none"><span class="style2" >FECHA &nbsp;INICIAL </span></td>
      <td style="border:none"><input  id="fecha_inicial" name="fecha_inicial" value="<%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(propietario.getFecha_inicio())%>" style="text-align:center; width:120px" onkeyup="mascara(this,'/',true)" maxlength="10"/>
        <input name="button" type="button" id="lanzador" style="width:25px; color:#000000" value="<<"/>
      <SCRIPT type="text/javascript">
           Calendar.setup({
           inputField     :    "fecha_inicial",      // id del campo de texto
           ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
           button         :    "lanzador"   // el id del botón que lanzará el calendario
          });
	    </SCRIPT>	  </td>
	  <td style="border:none">&nbsp;</td>
      <td style="border:none"><span class="style2">FECHA&nbsp;FINAL</span></td>
      <td colspan="2" style="border:none">
          <input  id="fecha_final" name="fecha_final" value="<%=propietario.getFecha_final()!=null?new java.text.SimpleDateFormat("dd/MM/yyyy").format(propietario.getFecha_final()):""%>" style="text-align:center;width:120px" onkeyup="mascara(this,'/',true)" maxlength="10"/>
         <input name="button" type="button" id="lanzador2" style="width:25px; color:#000000" value="<<" />
        <SCRIPT type="text/javascript">
           Calendar.setup({
           inputField     :    "fecha_final",      // id del campo de texto
           ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
           button         :    "lanzador2"   // el id del botón que lanzará el calendario
          });
	    </SCRIPT> </td>
    </tr>

    <tr>
      <td colspan="6" align="center" style="border:none">
	  	<table width="100%" border="0">
          <tr>
            <th width="50%" scope="col" style="border:none">
			<input name="adicionar" type="button" id="adicionar" value="Actualizar" style="width:100px; text-align:center" onclick="revisar()"/></th>
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
    }
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