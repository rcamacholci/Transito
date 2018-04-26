
<%@ page  import = "modelo.Model" import ="modelo.Persona" import = "modelo.Banco" import = "modelo.Entidad_Distribucion" import = "java.util.LinkedList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
               
%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Documento sin t&iacute;tulo</title>
<style type="text/css">
<!--
.Estilo13 {color: #FFFFFF; font-weight: bold; }
.Estilo20 {font-size: 12px; font-weight: bold; color: #333333; }
.Estilo12 {
	font-size: 14px;
	color: #0066CC;
}
.style1 {
	color: #333333;
	font-family: Tahoma;
	font-size: 12px;
}
.style5 {color: #333333}
.style8 {
	font-family: Tahoma;
	font-size: 11px;
}
.style9 {font-size: 11px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style10 {color: #333333; font-weight: bold; font-family: Tahoma; font-size: 11px; }
.style11 {color: #FFFFFF}
.style12 {color: #FFFFFF; font-weight: bold; font-family: Tahoma; font-size: 12px; }
.style15 {font-size: 10px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style16 {
	font-size: 12px;
	color: #333333;
}
-->
</style>
<script type="text/javascript" src="../html/scripts/entidades_de_distribucionScript.js"></script>
<script language="javascript" type="text/javascript">
			
			function newE(){
				window.location.href = "adicionar_entidad_de_distribucion.jsp?id=1";
			}
			
			function verReporte(dir,nombre){
				ancho = 789;
				alto = 400;
				barra = 0;
				izquierda = (document.width) ? (document.width-ancho)/2 : 100;
				arriba = (document.height) ? (document.height-alto)/2 : 100;
				opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
				url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
				window.open(url, 'popUp', opciones);
			}
		</script>
</head>
<%
	Model model =(Model) session.getAttribute("model") ;
	LinkedList entidades_de_distribucion = model.listado_entidades_distribucion() ;
	//HashMap parameters = new java.util.HashMap();
  	//parameters.put("TAQUILLA", taquilla.getId_taquilla());
  	//session.setAttribute("reporteTaquilla", parameters);
  	String direccion = "recaudoycartera/distribucion/.jasper";
  	String nombreR = "";
	
	String nombre_persona ;
%>
<body>
<form id="form1" name="form1" method="post" action="">
    <fieldset><div align="center">
   <legend align="center" class="style9 style16">LISTA DE ENTIDADES</legend>
    </div>
    <div align="center">
      <div id="tabla_entidades">
	  
         <table width="94%" border="0" align="center" >
	  <tr>
	  <td colspan="3">&nbsp;</td>
	  <td width="4%" align="right" valign="middle" bgcolor="#FFFFFF">
	  	<div align="center">
		<img src="../html/images/adicionar.gif" alt="Nueva"  width="22" height="22" style="cursor:pointer" onclick="newE()"/>
		<span class="style15">NUEVO</span></div>
	  </td>
	  <td width="4%" align="right" valign="middle" bgcolor="#FFFFFF">
	  	<div align="center">
		<img src="../html/images/reporte.png" alt="ver Reporte" width="22" height="22" style="cursor:pointer"onclick="verReporte('<%=direccion%>','<%=nombreR%>')"/>
		<span class="style15">REPORTE</span></div>
	  </td>
	  
	  </tr>
</table>
		<table width="94%" border="1" cellpadding="1" cellspacing="0" align="center">
		  <tr bgcolor="#CCCCCC" style="background:url(../html/images/inicio_3.png)">
            <td width="10%" style="border:none"><div align="center" class="Estilo13 style1 style11">NIT</div></td>
            <td width="44%" style="border:none"><div align="center" class="style12">NOMBRE </div></td>
            <td width="21%" style="border:none"><div align="center" class="style12">BANCO</div></td>
            <td width="10%" style="border:none"><div align="center" class="style12">CUENTA Nº</div></td>
            <td width="3%" style="border:none"><div align="center" class="style12">D</div></td>
          </tr>
		  <%
            if(!entidades_de_distribucion.isEmpty()){
			
				for(int i =0 ; i < entidades_de_distribucion.size() ; i ++ ) {
                    nombre_persona = "" ; 
					Entidad_Distribucion entidad_distribucion = (Entidad_Distribucion) entidades_de_distribucion.get(i) ;
					Persona persona = model.consultarPersona(entidad_distribucion.getFk_persona()) ;
					Banco banco = model.get_banco(entidad_distribucion.getFk_banco()) ;
					nombre_persona +=   persona.getApellido_1()+" " ;
					nombre_persona +=   persona.getApellido_2() != null ? persona.getApellido_2()+" " : ""  ;
					nombre_persona +=   persona.getNombre_1()+" " ;
					nombre_persona +=   persona.getNombre_2() != null ? persona.getNombre_2() : ""  ; %>
					<tr  bgcolor="#FFFFFF" style="cursor:pointer" id="<%=entidad_distribucion.getId_entidad_distribucion()%>" ondblclick="vista_actualizar(this)">
						<td width="5%"><div align="center" class="Estilo20 style5 style8"><%=persona.getDocumento()%></div></td>
						<td width="50%"><div align="center" class="style10"><%=nombre_persona%></div></td>
						<td width="15%"><div align="center" class="style10"><%=banco.getNombre()%></div></td>
						<td width="15%"><div align="center" class="style10"><%=entidad_distribucion.getCuenta()%></div></td>
						<td width="15%"><div align="center" class="style9">
						  <span class="style5">
						  <input onclick="setDefecto(this)" name="entidades" type="checkbox" id = "<%=entidad_distribucion.getId_entidad_distribucion()%>" <%=entidad_distribucion.getDefecto()==1?"checked":""%> />
						  </span>
										 </div>					  </td>
					</tr>
		   <%	
		   		}
			}
		  
		  %>
        </table>
      </div>
    </div>
	</fieldset>
</form>
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
