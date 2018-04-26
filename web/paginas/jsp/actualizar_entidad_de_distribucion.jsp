<%@ page import = "modelo.Model" import = "modelo.Banco" import = "modelo.Entidad_Distribucion" import = "java.util.LinkedList" import = "modelo.Persona"%>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Documento sin t&iacute;tulo</title>
<style type="text/css">
.Estilo8 {color: #333333; font-weight: bold; font-size: 12px; }
.Estilo14 {color: #333333; font-size: 12px; }
.style1 {font-family: Tahoma}
.style2 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
.Estilo18 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
</style>
<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="../html/scripts/calendar.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
		
		function salir(){
		window.location.href = "entidades_de_distribucion.jsp?id=1";
		}
		
		</script>
</head>
<% 
	Model model = (Model) session.getAttribute("model") ;
        long id_entidad_distribucion = Long.parseLong(request.getParameter("id_entidad")) ;
	Entidad_Distribucion entidad_a_actualizar = model.getEntidad_distribucion(id_entidad_distribucion) ;
	if(request.getParameter("act_ent") != null){
            Persona persona = model.consultarPersona(2,request.getParameter("nit")) ;  
            entidad_a_actualizar.setFk_persona(persona.getId_persona()) ;
            entidad_a_actualizar.setFk_banco(Long.parseLong(request.getParameter("bancos"))) ;
            entidad_a_actualizar.setCuenta(request.getParameter("cuenta"));
            entidad_a_actualizar.setDefecto(Integer.parseInt(request.getParameter("defecto"))) ;
            model.actualizar_entidad_distribucion(entidad_a_actualizar) ; %>
           <jsp:forward page="entidades_de_distribucion.jsp" />      
<%	}else{	
		LinkedList listado_bancos = model.listado_bancos() ;
		id_entidad_distribucion = Long.parseLong(request.getParameter("id_entidad")) ;
		Persona persona = model.consultarPersona(entidad_a_actualizar.getFk_persona()) ;
	%>
			<body>
			<form id="form1" name="form1" method="post" action="">
			  <div align="center">
				<p>&nbsp;</p>
				
				<table width="70%" border="1"  style="border-color:#000099">
				  <tr style="background:url(../html/images/inicio_3.png)">
					<th colspan="2"><span class="Estilo18">DATOS ENTIDAD</span></th>
				  </tr>
				  <tr>
					<th style="border:none" width="28%" scope="col"><span class="style2">CODIGO</span></th>
					<th style="border:none" width="72%" scope="col"></th>
				  </tr>
				  <tr>
					<th style="border:none"><span class="style2">NIT</span></th>
					<td style="border:none">
					  <input name="nit" type="text" id="nit" style="width:400px" value="<%=persona.getDocumento()%>" />					</td>
				  </tr>
				  <tr>
					<th colspan="2" style="border:none"><div align="center" class="style4" id="div_nombre_entidad"><strong><%=persona.getNombre_1()+" "+persona.getApellido_1()%></strong></div></th>
				  </tr>
				  <tr>
					<th style="border:none"><span class="style2">BANCO</span></th>
					<td style="border:none"><label>
					<select name="bancos" style="width:400px">
					  <%
								if(!listado_bancos.isEmpty()){
									for(int i = 0 ; i < listado_bancos.size() ; i++){
										Banco banco = (Banco) listado_bancos.get(i) ;
										if(banco.getId_banco() == entidad_a_actualizar.getFk_banco()){		
					 %>
											 <option value="<%= banco.getId_banco()%>" selected="selected"><%=banco.getNombre()%></option>
					  <%                                    }else{  %>
											 <option value="<%= banco.getId_banco()%>"><%=banco.getNombre()%></option>
					  <%                                    } 
                                                                          }
                                                                 }          
							%>
					</select>
					</label></td>
				  </tr>
				  <tr>
					<th style="border:none"><span class="style2">CUENTA</span></th>
					<td style="border:none"><input name="cuenta" type="text" id="cuenta" style="width:400px" value="<%=entidad_a_actualizar.getCuenta()%>" /></td>
				  </tr>
				  <tr>
					<th colspan="2" style="border:none">
					  <span class="style4">
					  <%if(entidad_a_actualizar.getDefecto() == 1){%>
						  <input type="checkbox" name="defecto" value="" checked />
				      <%}else{%>
						  <input type="checkbox" name="defecto" value="" />
				      <%}%>
					
					EMPRESA POR DEFECTO </span></th>
				  </tr>
				  
				</table>
				<table width="70%" border="0"  style="border-color:#000099">
				<tr>
				  <th width="50%" style="border:none">
<button type="button" name="enviar"  onclick="actualizar_entidad('<%=entidad_a_actualizar.getId_entidad_distribucion()%>')"><span class="style2">Enviar </span><img src="../html/images/enviar.png" width="18" height="18" /></button>				
<!-- <input type="button" name="enviar" value="Enviar"  style="width:100px" onclick="actualizar_entidad(" /> --> </th>
					 <th width="50%"><span style="border:none">
<button type="reset" name="cancelar" onclick="salir()"><span class="style2">Cancelar </span><img src="../html/images/cancelar.png" width="18" height="18" /></button>						 
				<!-- 	   <input type="reset" name="cancelar" style="width:100px" value="Cancelar" onclick="salir()" /> -->
				  </span></th>
				  </tr>
				</table>
			  </div>
			</form>
			</body>
			</html>
	<%}%>
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