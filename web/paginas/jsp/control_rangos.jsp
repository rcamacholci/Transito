
<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Documento sin t&iacute;tulo</title>
<script language="javascript" type="text/javascript">
	function verC(clase,i){
		clase.style.display = 'none';
		document.getElementById('clase'+i).style.display = 'block';
	}
	function aplicarC(clase,i,rango){
		document.getElementById('tclase'+i).value = clase.value;
		clase.style.display = 'none';
		document.getElementById('tclase'+i).style.display = 'block';
         document.location.href = "control_rangos.jsp?tipo=2&rango="+rango+"&clase="+clase.value+"&id="+i;
	}
	function verS(servicio,i){
		servicio.style.display = 'none';
		document.getElementById('servicio'+i).style.display = 'block';
	}
	function aplicarS(servicio,i,rango){
		document.getElementById('tservicio'+i).value = servicio.value;
		servicio.style.display = 'none';
		document.getElementById('tservicio'+i).style.display = 'block';
        document.location.href = "control_rangos.jsp?tipo=3&rango="+rango+"&servicio="+servicio.value+"&id="+i;
	}
	function eliminar(i){
		document.location.href = "control_rangos.jsp?tipo=4&id="+i;
	}
</script>
</head>
<body>
<table width="312" border="1" align="center">
  <tr bgcolor="#0066CC">
    <th scope="col" width="169"><font color="#FFFFFF" size="2">CLASE</font></th>
    <th scope="col" width="104"><font color="#FFFFFF" size="2">SERVICIO</font></th>
	<th scope="col" width="17"><font color="#FFFFFF" size="2">X</font></th>
  </tr>
  <% java.util.List lista =(java.util.List)session.getAttribute("control_rangos");
     Model modelo =(Model)session.getAttribute("model");
	if(lista==null){
	 	lista = new java.util.LinkedList();
	 }
	 if(request.getParameter("tipo")!=null){
		 if(request.getParameter("tipo").equals("1")){
			Control_Rango new_cr = new Control_Rango();
			new_cr.setFk_rango(Long.parseLong(request.getParameter("rango")));
			lista.add(new_cr);
			session.setAttribute("control_rangos",lista);
		 }else{	
			 if(request.getParameter("tipo").equals("2")){
				Control_Rango new_cr = (Control_Rango)lista.get(Integer.parseInt(request.getParameter("id")));
				new_cr.setClase(Integer.parseInt(request.getParameter("clase")));
				lista.set(Integer.parseInt(request.getParameter("id")),new_cr);
				session.setAttribute("control_rangos",lista);
			 }else{
				 if(request.getParameter("tipo").equals("3")){
					Control_Rango new_cr = (Control_Rango)lista.get(Integer.parseInt(request.getParameter("id")));
					new_cr.setServicio(Integer.parseInt(request.getParameter("servicio")));			
					lista.set(Integer.parseInt(request.getParameter("id")),new_cr);
					session.setAttribute("control_rangos",lista);
				 }else{
					if(request.getParameter("tipo").equals("4")){
						lista.remove(Integer.parseInt(request.getParameter("id")));
						session.setAttribute("control_rangos",lista);
					}else{
						if(request.getParameter("tipo").equals("5")){
                                                      modelo.eliminar_Control_Rango(Long.parseLong(request.getParameter("rango")));
						    for(int i=0;i<lista.size();i++){
                                		         Control_Rango control = (Control_Rango)lista.get(i);
                                                       
                                                          modelo.adicionar_Control_Rango(control);
                                                }
                                                %>
                                                        <script>
                                                                alert("Guardardo...");
                                                        </script>
						<%
						}
					}
				 }	
			 }
		 }
	}	 
	java.util.List clases = modelo.listadoParametros(1);
	java.util.HashMap clases2 = modelo.crearHashParametros(1);
	java.util.List servicios = modelo.listadoParametros(3);
	java.util.HashMap servicios2 = modelo.crearHashParametros(3);
	for(int i=0;i<lista.size();i++){
		Control_Rango cr = (Control_Rango)lista.get(i); %>
	  <tr>
		<td>    
         <input name="tclase<%=i%>" type="text" id="tclase<%=i%>" ondblclick="verC(this,<%=i%>)" value="<%=clases2.get(cr.getClase()+"")!=null?clases2.get(cr.getClase()+""):""%>" size="28" readonly="true"/>
			<select name="clase<%=i%>" id="clase<%=i%>" style="display:none;" onchange="aplicarC(this,<%=i%>,<%=request.getParameter("rango")%>)"> <%
                             for(int j=0;j<clases.size();j++){ 
                                 Parametro param = (Parametro)clases.get(j);
								 if(param.getCodigo()==cr.getClase()){%>
	                                <option value="<%=param.getCodigo()%>" selected="selected"><%=param.getNombre()%></option>
                          <%     }else{ %>
						  			<option value="<%=param.getCodigo()%>"><%=param.getNombre()%></option>
						  <%	 } 
						    } %>
			</select>
		</td>
		<td>
         <input name="tservicio<%=i%>" type="text" id="tservicio<%=i%>" ondblclick="verS(this,<%=i%>)" value="<%=servicios2.get(cr.getServicio()+"")!=null?servicios2.get(cr.getServicio()+""):""%>" size="16" readonly="true" />
			<select name="servicio<%=i%>" id="servicio<%=i%>" style="display:none;" onchange="aplicarS(this,<%=i%>,<%=request.getParameter("rango")%>)"> <%
                             for(int j=0;j<servicios.size();j++){ 
                                 Parametro param = (Parametro)servicios.get(j);
                                 if(param.getCodigo()==cr.getServicio()){%>
	                                <option value="<%=param.getCodigo()%>" selected="selected"><%=param.getNombre()%></option>
                          <%     }else{ %>
						  			<option value="<%=param.getCodigo()%>"><%=param.getNombre()%></option>
						  <%	 } 
						    } %>
			</select>
		</td>
		<td bgcolor="#0066CC" align="center"><label id="delete" onclick="eliminar(<%=i%>)"> <img src="../html/images/cortar.gif" alt="Nuevo Propietario" width="28" height="21" />	</label></td>
	  </tr>
      <% } %>
</table>
</body>
</html>
