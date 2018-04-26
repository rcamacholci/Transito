<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<%
try{
	if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
            if(session.getAttribute("model")!=null){  
%>

<html>
<head>
    <title></title>
    <style type="text/css">
    <!--
    .Estilo6 {color: #333333; font-size: 11px; font-weight:bold }
    .Estilo8 {color: #333333; font-size: 11px; }
    .Estilo10 {color: #333333; font-size: 14px; font-weight: bold; }
    .Estilo13 {font-weight: bold; color: #333333; font-size: 13px; }
.Estilo14 {font-size: 12px}
.Estilo15 {font-weight: bold; color: #333333; font-size: 12px; }
.style1 {color: #333333}
.style3 {font-size: 11px}
.style4 {font-family: Tahoma}
.style6 {color: #FFFFFF}
.style7 {font-weight: bold; color: #FFFFFF; font-size: 12px; font-family: Tahoma; }
    -->
    </style>

	<script language="javascript" type="text/javascript">
		function accion(sec){
			text = document.getElementById("nombre").value;
			if(text.length>0){
				document.location.href = "configuracion_distribucion.jsp?sec="+sec+"&text="+text;
			}else{
				document.location.href = "configuracion_distribucion.jsp?sec="+sec;
			}
		}
		
		function visualizar(objeto){
			document.getElementById(objeto).style.display = (document.getElementById(objeto).style.display=="block")?"none":"block";
		}
		
		function verifica_porcentaje(input){
			var sede = document.getElementById("sede").value;
			var entidades = document.getElementById("entidades");
			var id_input = input.id ;
			var idEnti_idConcep = id_input.split("|");
			var fk_concepto = idEnti_idConcep[0];
			var suma = 0;
			input.value = input.value.replace(",",".");
			for(i=0;i<entidades.options.length;i++){
				var valor = document.getElementById(fk_concepto+"|"+entidades.options[i].value).value;
				if(valor.length==0){
					valor = 0;
				}else{
					if(isNaN(valor)){
						valor = 0;
						document.getElementById(fk_concepto+"|"+entidades.options[i].value).value = "";
					}else{
						if(valor<0){
							valor = 0;
							document.getElementById(fk_concepto+"|"+entidades.options[i].value).value = "";			
						}
					}
				}
				suma += parseFloat(valor);
			}
			
			if(suma>100||suma<0){
				alert("La sumatoria de los porcentajes debe ser igual a 100%");
				input.value = "";
				input.focus();
			}else{
				var valor = document.getElementById(fk_concepto+"|"+idEnti_idConcep[1]).value;
				if(valor.length==0){
					valor = 0;
				}else{
					if(isNaN(valor)){
						valor = 0;
					}else{
						if(valor<0){
							valor = 0;	
						}
					}
				}			
				guardarDato(fk_concepto,idEnti_idConcep[1],valor);
				document.getElementById("t"+fk_concepto).value = suma;
			}
		}
		
		function cambiarElemento(){
			document.getElementById("lnombre").style.display = "none";
			document.getElementById("nombre").style.display = "block";
		}
		
		function buscarNombre(campo){
			text = campo.value;
			if(text.length>0){
				document.location.href = "configuracion_distribucion.jsp?sec=0&text="+text;
			}else{
				document.location.href = "configuracion_distribucion.jsp?sec=0";
			}
			document.getElementById("lnombre").style.display = "block";
			document.getElementById("nombre").style.display = "none";
		}
		
		function enviar(){
			document.form.submit();
		}
		
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

            function guardarDato(concepto,entidad,valor){
                sede = document.getElementById('sede').value;
                ajax=nuevoAjax();
                ajax.open("POST", "cargarConfiguracionDistribucion.jsp",true);
                ajax.onreadystatechange=function() {
                    if (ajax.readyState==4) {
                        
                    }
                }
                ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                ajax.send("sede="+sede+"&concepto="+concepto+"&entidad="+entidad+"&valor="+valor);
            }
			function sombrear(tr){
				tr.style.backgroundColor="#CCCCCC";
			}
			function renovar(tr){
				tr.style.backgroundColor="#FFFFFF";
			}
	</script>
</head>
<%
	Model model = (Model) session.getAttribute("model");
	Sede sede = (Sede)session.getAttribute("sede");
	LinkedList conceptos = model.listadoConceptosSedeTramite(sede.getId_sede());
	String text = request.getParameter("text");
	if(text!=null){
		if(text.trim().length()>0){
			for (int k = conceptos.size()-1; k >= 0 ; k--) {
				Concepto concepto = (Concepto)conceptos.get(k);
				if(concepto.getNombre().toLowerCase().trim().indexOf(text.toLowerCase().trim())!=0){
					conceptos.remove(k);
				}
			}	
		}	
	}else{
		text = "";
	}	
	LinkedList entidades = model.listado_entidades_distribucion();
%>
<body>
<form id="form" name="form" method="post" action="aplicar_configuracion_distribucion.jsp">
	<input type="hidden" name="sede" id="sede" value="<%=sede.getId_sede()%>"/>
	<select name="entidades" id="entidades" style="display:none">
            <%  
    for (int k = 0; k < entidades.size(); k++) {
		 Entidad_Distribucion entidad = (Entidad_Distribucion)entidades.get(k); %>
		 <option value="<%=entidad.getId_entidad_distribucion()%>"><%=entidad.getId_entidad_distribucion()%></option>
<%	}	  %>
	</select>
   <div align="center"><span class="Estilo10 style4 Estilo14">CONFIGURACION DE LA DISTRIBUCION</span></div>
   <p>&nbsp;</p>
  <table width="70%" border="1" cellpadding="1" cellspacing="0" align="center">
	<tr bgcolor="#CCCCCC" height="30" style="background:url(../html/images/inicio_3.png)"> 
	  <td width="10%" scope="col" style="border:none"><div align="center" class="Estilo13 Estilo14 style4 style6">CODIGO</div></td>
	  <td width="83%" scope="col" onDblClick="cambiarElemento()" style="border:none">
	  	<div class="style7" id="lnombre">
	  	  <div align="center">NOMBRE CONCEPTO</div>
	  	</div>
		<span class="style6" style="font-family: Tahoma">
		<input type="text" name="nombre" id="nombre" value="<%=text%>" onBlur="buscarNombre(this)" style="display:none; width:490px"/>	  
		</span></td>
	  <td width="7%" scope="col" style="border:none"><div align="center" class="style7"> %&nbsp;DIST. </div></td>
	</tr>



 <% 
int sec = 0;
if(request.getParameter("sec")!=null){
sec = Integer.parseInt(request.getParameter("sec"));
 }

 	 boolean pasoS = (15*(sec+1))<conceptos.size()?true:false;
	 boolean pasoA = (15*sec)>0?true:false;
	 for(int i=15*sec;i<(conceptos.size()>(15*(sec+1))?15*(sec+1):conceptos.size());i++){
	   Concepto concepto = (Concepto)conceptos.get(i); %>
   <tr onDblClick="visualizar(<%=concepto.getId_concepto()%>)"  onMouseOver="sombrear(this)" onMouseOut="renovar(this)" style="cursor:pointer">
	  <td scope="col" align="center"><span class="Estilo6 Estilo14 Estilo14 style1"><span class="Estilo14 Estilo14  style3 style4"><span class="Estilo14 Estilo14  style3"><label style="cursor:pointer"><%= concepto.getId_concepto() %></label></span></span></span> </td>
	  <td scope="col" align="left"><span class="Estilo6 Estilo14 Estilo14 style1"><span class="Estilo14 Estilo14  style3 style4"><span class="Estilo14 Estilo14  style3"><label style="cursor:pointer"><%=concepto.getNombre()%></label></span></span></span></td>
	  <td scope="col" align="center">
	  	<input name="t<%=concepto.getId_concepto()%>" type="text" disabled id="t<%=concepto.getId_concepto()%>" style="width:50px;text-align:center" value=""/>	  </td>
   </tr>
	<tr align="right">
	  <td colspan="3" align="right">
		<table border="0" cellpadding="0" cellspacing="0" id="<%=concepto.getId_concepto()%>" style="display:none" width="70%">
	<% float total = 0;
	   for (int k = 0; k < entidades.size(); k++) {
		 Entidad_Distribucion entidad = (Entidad_Distribucion)entidades.get(k);
		 Persona persona = model.consultarPersona(entidad.getFk_persona());
		 Configuracion_distribucion conf =model.getConfiguracion_distribucion(sede.getId_sede(),concepto.getId_concepto(),entidad.getId_entidad_distribucion());
		 String id = concepto.getId_concepto()+"|"+entidad.getId_entidad_distribucion();
		 float porcentaje = 0;
		 if(conf!=null){
			porcentaje = conf.getPorcentaje();
			total += porcentaje;
			total = (""+total).length()>5?Float.parseFloat((""+total).substring(0,5)):total;
		 }	 %>
		 <tr>
			<td width="10%" align="center"><span class="Estilo8"><label><%= entidad.getId_entidad_distribucion()%></label></span></td>
			<td width="80%" align="left"><span class="Estilo8"><label><%= persona.getNombre_1()+" "+persona.getApellido_1() %></label></span></td>
			<td width="10%" align="center">
			<input name ="<%=id%>" type="text" id = "<%=id%>" style= "width:50px;text-align:center; color:#333333; font-size:11px" onBlur="verifica_porcentaje(this)" value="<%=(porcentaje>0?porcentaje:"")%>" />			</td>
		</tr>
	<% } %>	
		<script language="javascript" type="text/javascript">document.getElementById("t<%=concepto.getId_concepto()%>").value = <%=total%>;</script>
		</table>      </td>
	</tr>
 <% } %> 
 </table>
 </br>
 <table border="0" width="70%" align="center">
				<tr>
					<td align="center" width="33%">
						<% if(pasoA){ %>
							<input type="button" name="anterior" id="anterior" value="Anterior" onClick="accion(<%=sec-1%>)"/>
						<% }%>
&nbsp;					</td>
					<td align="center" width="33%">
							<input type="button" name="aceptar" id="aceptar" value="Guardar" onClick="enviar()"/>				  </td> 
					<td align="center" width="33%">
						<% if(pasoS){ %>
							<input type="button" name="siguiente" id="siguiente" value="Siguiente" onClick="accion(<%=sec+1%>)"/>
						<% }%>
&nbsp;				  </td> 
				</tr>	 
  </table>
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