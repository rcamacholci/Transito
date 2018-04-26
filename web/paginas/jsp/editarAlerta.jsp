<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<title>Especificaciones</title>
<script language="javascript" type="text/javascript">

</script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<style type="text/css">
<!--
.style1 {
	color: #333333;
	font-family: Tahoma;
}
.style3 {
	color: #333333;
	font-size: 12px;
}
.style7 {
	color: #333333;
	font-size: 12px;
	font-weight: bold;
	font-family: Tahoma;
}
.style9 {color: #333333; font-size: small; font-weight: bold; font-family: Tahoma; }
.style10 {font-size: small}
.Estilo12 {
	color: #333333;
	font-size: 10px;
}
.Estilo15 {color: #333333; font-size: 10px; font-weight: bold; font-family: Tahoma; }
.Estilo16 {font-size: 10px}
-->
</style>
</head>
<%@ page import="modelo.*"%>
<%@ page import="java.util.*"%>


<%
Model modelo= (Model)session.getAttribute("model");
Alerta alerta;
Persona persona;

long id_alerta ;

if (!request.getParameter("id_alerta").isEmpty()){
    id_alerta = Long.parseLong(request.getParameter("id_alerta"));
    Parametro parametro = null;
    alerta = modelo.consultarAlertaPorId(id_alerta);

    
    if(alerta!=null){
        persona = modelo.consultarPersona(alerta.getFk_persona());
        session.setAttribute("alerta", alerta);

        String Selected = "";

%>
<body bgcolor="#FFFFFF">
<form name="form" method="post" action="procesar_alerta.jsp">

<fieldset >
  <legend class="style2 style7 style6 style5" align="center"><strong>DETALLES ALERTA</strong></legend>

<table width="70%" align="center" border="0">
   <tr>
    <td width="19%"><span class="Estilo15"><strong>TIPO&nbsp;DOCUMENTO</strong></span></td>
    <td width="31%"><span style="font-size: 10px">
      <select name="tipodocumento" id="tipodocumento" disabled style="width:150px;font-size:10px">
        <% 
		java.util.List list=modelo.listadoParametros(5);
		java.util.Iterator it = list.iterator(); 
		while (it.hasNext()) {
			parametro = (Parametro)it.next();
                        if(persona!=null){
                            if(parametro.getCodigo()==persona.getTipo_documento())
                                Selected = "selected";
                            else Selected = "";
                            }

               %>
        <option value="<%=parametro.getCodigo()+""%>" <%=Selected%> ><%=parametro.getNombre()%></option>
        <%}%>
      </select>
    </span></td>
   
    <td width="12%"><span class="Estilo15"><strong>NUMERO</strong></span></td>
    <td width="38%"><input name="documento" disabled id="documento" style="width:150px; text-align:center ; font-size:11px" onblur="consultaPersona()" value="<%=(persona!=null?persona.getDocumento():"")%>"/></td>
  </tr>
  <tr>
    <td><span class="Estilo15"><strong>NOMBRE</strong></span></td>
    <td colspan="3"><input name="nombres" disabled id="nombres" style="width:390px;text-transform:uppercase; font-size:11px" value="<%=(persona!=null?persona.getNombre_1()+" "+(persona.getNombre_2()!=null?persona.getNombre_2():""+" "+persona.getApellido_1()+" "+(persona.getApellido_2()!=null?persona.getApellido_2():"")):"")%>"  readonly/></td>
  </tr>
  
  
  <tr>
    <td><span class="Estilo15"><strong>TIPO&nbsp;ALERTA</strong></span></td>
    <td><span style="font-size: 10px">
      <select name="tipoalerta" id="tipoalerta" disabled style="width:150px;font-size:11px">
        <% 
		list=modelo.listadoParametros(4);
		it = list.iterator(); 
		while (it.hasNext()) {
			parametro = (Parametro)it.next(); 
                        
                        if(alerta.getTipo()==(int)parametro.getCodigo())
                            Selected="selected";
                        else Selected="";

                  %>
        <option value="<%=parametro.getCodigo()+""%>" <%=Selected%> ><%=parametro.getNombre()%></option>
        <%}%>
        </select>
    </span></td>
    
    <td class="Estilo15"><strong>GRADO</strong></td>
    <td><span class="Estilo12">
      <select name="grado" id="grado" disabled style="width:150px">
        <%
          
          for(int i = 1;i<=7;i++){
              if(alerta.getGrado()==i)
                  Selected = "selected";
              else Selected="";
%>
        <option value="<%=i%>" <%=Selected%> ><%=i%></option>
        <%}%>
      </select>
    </span></td>
  </tr>
  <tr>
    <td><span class="Estilo15"><strong>FECHA&nbsp;INICIO</strong></span></td>
    <td><span style="font-size: 10px">
      <input type="text" name="fecha_inicio" disabled id="fecha_inicio"  value="<%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(alerta.getFecha_ini())%>" style="width:125px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center; font-size:11px" onkeyup="mascara(this,'/',true)" maxlength="10"/>&nbsp;<input name="fechai" type="button" id="fechai" disabled value="<" style="width:20px; text-align:center; font-size:11px"/>
	  <script type="text/javascript">
			
		 </script>
    </span></td>
    
    <td><span class="Estilo15"><strong>FECHA&nbsp;FIN</strong></span></td>
    <td>
        <span class="Estilo16">
        <input type="text" name="fecha_fin" id="fecha_fin" disabled style="width:125px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center; font-size:11px" value="<%=(alerta.getFecha_fin()!=null?new java.text.SimpleDateFormat("dd/MM/yyyy").format(alerta.getFecha_fin()):"")%>" onkeyup="mascara(this,'/',true)" maxlength="10" />&nbsp;<input name="fechaf" type="button" id="fechaf" disabled value="<" style="width:20px; text-align:center; font-size:11px"/>
		 <script type="text/javascript">
			
		 </script>
        </span></td>
  </tr>
  
  <tr>
    <td><span class="Estilo15"><strong>OBSERVACIONES</strong></span></td>
    <td colspan="3"><span style="font-size: 10px">
      <textarea name="observacion" id="observacion"  disabled style="width:390px; height:40px; font-size:10px"><%=alerta.getObservaciones()%></textarea>
    </span></td>
  </tr>
  
  
  <tr>
    <td colspan="4" align="center">
		<table width="60%" border="0">
          <tr>
            <th width="50%" >
                <input name="beditar" type="button" id="beditar" value="Editar" style="width:100px; text-align:center" onclick="Editar(false)"/></th>
            <th width="50%" >
                <input name="cancelar" type="button" id="cancelar" value="Cerrar" style="width:100px; text-align:center" onclick="cerrarAnterior()"/></th>
          </tr>
        </table>    </td>
    </tr>
</table>
</fieldset>
</form>
</body>
<%
//NNK75 - SBW25 - RCH855
}else{
        session.removeAttribute("alerta");
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