<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                    Model modelo= (Model)session.getAttribute("model");
                   
                    %>
<%@ page import="modelo.*"%>
<%@ page import="java.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>EDITAR EMBARGO</title>
<style type="text/css">
<!--
.Estilo1 {
	color: #0066CC;
	font-weight: bold;
}
-->
</style>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
	

        
</script>
<style type="text/css">
<!--
.style5 {color: #333333}
.style6 {
	font-family: Tahoma;
	font-size: 12px;
}
.style7 {font-family: Tahoma}
.style8 {font-size: 12px}
.style9 {
	color: #333333;
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
}
.style10 {font-family: Tahoma; font-size: 12px; font-weight: bold; }
.Estilo3 {font-size: 10px}
.Estilo4 {font-family: Tahoma; font-size: 10px; font-weight: bold; }
.Estilo6 {color: #333333; font-size: 10px; }
.Estilo7 {color: #333333; font-family: Tahoma; font-size: 10px; font-weight: bold; }
-->
</style>
</head>


<%
 String placa = "";
                    long id_embargo = 0;

                    if(!request.getParameter("id_embargo").isEmpty()){
                        id_embargo = Long.parseLong(request.getParameter("id_embargo"));
                    }

                        if(request.getParameter("id")=="0"){
                                placa =  request.getParameter("placa");
                        }else{
                                placa =  session.getAttribute("placa")+"";
                        }
                        if(placa!=null){
                            Vehiculo vehiculo  = new Vehiculo();
                            vehiculo=modelo.consultarVehiculo(placa.toUpperCase());
                            Embargo embargo;
                        if (vehiculo!=null){
                              Parametro parametro = null;
                              embargo = modelo.consultarEmbargo(id_embargo);
 Persona persona = modelo.consultarPersona(embargo.getFk_persona());
  session.setAttribute("embargo", embargo);


 

        
  





%>
<body>
<form name="form" method="post" action="procesar_embargo.jsp">
<input type="hidden" name="vehiculo" id="vehiculo" value="<%=vehiculo.getId_vehiculo()%>"/>
<fieldset style="">
  <legend class="style2 style7 style6 style5"><strong>DETALLES EMBARGO</strong></legend>
 
<table width="70%" align="center" border="0">
   <tr class="style9">
    <td width="19%"><span class="Estilo1 style5 style7"><span class="Estilo3">DEPARTAMENTO</span></span></td>
    <td width="29%"><span class="Estilo4" style="color: #333333">
            <select name="departamento" id="departamento" disabled onchange="buscarMunicipios()" style="width:150px;font-size:9px">
        <% List list= modelo.crearListaDpto();
			Iterator it = list.iterator();
                        String Selected = "";
                        Divipo emb_dpto = modelo.getDivipo(embargo.getFk_divipo());

			while (it.hasNext()) {
				Departamento dpto = (Departamento)it.next();
                                if(emb_dpto!=null){
                                    if(emb_dpto.getFk_departamento()==dpto.getId_departamento())
                                        Selected = "selected";
                                    else Selected = "";
                                }
                                
                        %>
        <option value="<%=dpto.getId_departamento()+""%>" <%=Selected%>><%=dpto.getNombre()%></option>
          <%}%>
      </select>
    </span> </td>
   
    <td width="18%"><span class="Estilo1 style5 style7"><span class="Estilo3">MUNICIPIO</span></span></td>
    <td width="34%"><div class="Estilo4" id="municipios" style="width:150px">
            <select name="municipio" id="municipio" disabled style="width:150px;font-size:9px">
		<%
		java.util.List lista = modelo.crearListaMunicipios((int)emb_dpto.getFk_departamento());
		for (int i = 0; i < lista.size(); i++) {
			Municipio municipio = (Municipio) lista.get(i);%>
			<option value="<%=municipio.getCodigo() + ""%>"><%=municipio.getNombre()%></option>
	<%	}%>
	</select> </div></td>
  </tr>
  
  <tr class="style9">
    <td><span class="Estilo1 style5 style7"><span class="Estilo3">TIPO&nbsp;DOCUMENTO </span></span></td>
    <td><span class="Estilo4" style="color: #333333">
            <select name="tipodocumento" id="tipodocumento" disabled style="width:150px;font-size:9px">
        <% 
		list=modelo.listadoParametros(5);
		it = list.iterator(); 
		while (it.hasNext()) {
			parametro = (Parametro)it.next(); %> 
        <option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
          <%}%>
      </select>
    </span></td>
   
    <td><span class="Estilo1 style5 style7"><span class="Estilo3">NUMERO</span></span></td>
    <td><input name="documento" disabled id="documento" style="width:150px; text-align:center;font-size:9px" onblur="consultaPersona()"
               value="<%
               if(persona!=null){
                   out.print(persona.getDocumento());
               
               }
               
          
          %>"


               /></td>
  </tr>
  <tr class="style9">
    <td><span class="Estilo1 style5 style7"><span class="Estilo3">NOMBRE&nbsp;PERSONA </span></span></td>
    <td colspan="4"><input name="nombres" disabled id="nombres" style="width:430px;text-transform:uppercase;font-size:9px" value="<%
               if(persona!=null){
                   out.print(persona.getNombre_1()+" "+(persona.getNombre_2()!=null?persona.getNombre_2():"")+" "+persona.getApellido_1()+" "+(persona.getApellido_2()!=null?persona.getApellido_2():""));

               }


          %>" readonly /></td>
  </tr>
  <tr class="style9">
    <td><span class="Estilo1 style5 style7"><span class="Estilo3">DEMANDANTE </span></span></td>
    <td colspan="4"><input name="demandante" disabled id="demandante" style="width:430px;text-transform:uppercase;font-size:9px" value="<%=(embargo.getDemandante()!=null?embargo.getDemandante():"")%>" /></td>
  </tr>
  
  <tr>
    <td class="style9"><span class="Estilo1 style5 style7"><span class="Estilo3">OFICINA&nbsp;JURIDICA </span></span></td>
    <td colspan="4"><span class="Estilo4" style="color: #333333">
            <select name="oficina" id="oficina" disabled style="width:430px;font-size:9px">
        <%
	   list=modelo.consultarOficinasJuridicas();
	   it = list.iterator();
           Selected="";
		while (it.hasNext()) {

			Oficina_Juridica oficina = (Oficina_Juridica)it.next();
                        if(embargo.getFk_oficina()==oficina.getId_oficina())
                            Selected="selected";
                        else Selected="";
                
                %>

        <option value="<%=oficina.getId_oficina()+""%>" <%=Selected%>><%=oficina.getNombre()%></option>
          <%}%>
      </select>
    </span></td>
  </tr>
  <tr class="style9">
    <td><span class="Estilo1 style5 style7"><span class="Estilo3">TIPO&nbsp;EMBARGO</span></span></td>
    <td><span class="Estilo4" style="color: #333333">
            <select name="tipoembargo" id="tipoembargo" disabled style="width:150px;font-size:9px">
        <% 
		list=modelo.listadoParametros(341);
		it = list.iterator();
                Selected = "";
		while (it.hasNext()) {
			parametro = (Parametro)it.next();
                        if(embargo.getTipo()==(int)parametro.getCodigo())
                            Selected = "selected";
                        else Selected ="";

                %>
        <option value="<%=parametro.getCodigo()+""%>" <%=Selected%> ><%=parametro.getNombre()%></option>
          <%}%>
      </select>
    </span></td>
    
    <td><span class="Estilo1 style5 style7"><span class="Estilo3">PROCESO</span></span></td>
    <td><span class="Estilo4" style="color: #333333">
      <select name="proceso" id="proceso" disabled="disabled" style="width:150px;font-size:9px">
        <% 
		list=modelo.listadoParametros(23);
		it = list.iterator();
                Selected = "";
		while (it.hasNext()) {
			parametro = (Parametro)it.next();
                        if(embargo.getTipo()==(int)parametro.getCodigo())
                            Selected = "selected";
                        else Selected ="";

                %>
        <option value="<%=parametro.getCodigo()+""%>" <%=Selected%> ><%=parametro.getNombre()%></option>
        <%}%>
      </select>
    </span></td>
  </tr>
  <tr class="style9">
    <td><span class="Estilo1 style5 style7"><span class="Estilo3">Nª&nbsp;RADICACION</span></span></td>
    <td><span class="Estilo6">
      <input name="numero_radicacion" id="numero_radicacion" style="width:150px; text-align:center;font-size:9px" value="<%=embargo.getNro_radicacion()!=null?embargo.getNro_radicacion():""%>" disabled="disabled" />
    </span></td>
    
    <td><span class="Estilo1 style5 style7"><span class="Estilo3">FECHA&nbsp;RAD.</span></span></td>
    <td><span class="Estilo6">
      <input type="text" name="fecha_radicacion" id="fecha_radicacion"  style="width:130px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center;font-size:9px" value="<%=(embargo.getFecha_radicacion()!=null?new java.text.SimpleDateFormat("dd/MM/yyyy").format(embargo.getFecha_radicacion()):"")%>" onkeyup="mascara(this,'/',true)" maxlength="10"   disabled="disabled" />
      <input  name="fechaR"  type="button" id="fechaR" value="<" disabled="disabled"  style="width:20px; text-align:center;font-size:9px"/>
   </span></td>
  </tr>
  
  
  <tr class="style9">
    <td><span class="Estilo1 style5 style7"><span class="Estilo3">NUMERO&nbsp;OFICIO </span></span></td>
    <td><input name="numero_oficio" disabled id="numero_oficio" style="width:150px; text-align:center;font-size:9px" value="<%=embargo.getOficio()%>"/></td>
    
    <td><span class="Estilo1 style5 style7"><span class="Estilo3">FECHA&nbsp;OFICIO </span></span></td>
    <td>
         <span class="Estilo7">
             <input type="text" name="fecha_oficio" id="fecha_oficio"  style="width:130px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center;font-size:9px" value="<%
             out.print(embargo.getFecha_oficio()!=null?new java.text.SimpleDateFormat("dd/MM/yyyy").format(embargo.getFecha_oficio()):"");%>" onkeyup="mascara(this,'/',true)" maxlength="10"   disabled/>
         <input name="fecha" type="button" id="fecha" value="<" disabled style="width:20px; text-align:center;font-size:9px"/>
         </span></td>
  </tr>
	<tr class="style9">
		<td><span class="Estilo1 style5 style7"><span class="Estilo3">No&nbsp;LEVANTAMIENTO </span></span></td>
		<td><input name="numero_levantamiento" disabled id="numero_levantamiento" style="width:150px; text-align:center;font-size:9px" value="<%=embargo.getNro_levantamiento()!=null?embargo.getNro_levantamiento():""%>" /></td>
		
		<td><span class="Estilo1 style5 style7"><span class="Estilo3">FECHA&nbsp;LEV. </span></span></td>
		<td><span style="font-size: 10px">
	    <input type="text" name="fecha_levantamiento" id="fecha_levantamiento"  style="width:130px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center;font-size:9px" value="<%=(embargo.getFecha_levantamiento()!=null?new java.text.SimpleDateFormat("dd/MM/yyyy").format(embargo.getFecha_levantamiento()):"")%>" onkeyup="mascara(this,'/',true)" maxlength="10"  disabled="disabled" />
        <input  name="fechaL"  type="button" id="fechaL" value="<" disabled  style="width:20px; text-align:center;font-size:9px"/>		
        </span></td>
	</tr>
	
	
  <tr class="style9">
    <td><span class="Estilo1 style5 style7"><span class="Estilo3">OBSERVACIONES</span></span></td>
    <td colspan="4"><span class="Estilo4" style="color: #333333">
      <textarea name="observacion" disabled id="observacion" style="width:430px; height:40px;font-size:9px"><%=(embargo.getObservaciones()!=null?embargo.getObservaciones():"")%></textarea>
    </span></td>
  </tr>
  
  
  <tr>
    <td colspan="5" align="center">
		<table width="100%" border="0">
          <tr>
            <th width="50%" scope="col">
			<input name="beditar" type="button" id="beditar" value="Editar" style="width:100px; text-align:center" onclick="Editar(false)"/></th>
			
            <th width="50%" scope="col">
			<input name="cancelar" type="button" id="cancelar" value="Cerrar" style="width:100px; text-align:center" onclick="cerrarAnterior()"/></th>
          </tr>
        </table>	</td>
    </tr>
</table>
</fieldset>
</form>
</body>
<%
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
