<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="modelo.*"%>
<%@page import="java.util.*"%>

<% Model modelo = (Model) session.getAttribute("model");
	boolean enable = modelo.isEnable((List) session.getAttribute("seleccionados"),19);
	String state = enable?"":"disabled";
            if (!request.getParameter("fk_dpto").equals("")) {
				int codigo = 0;
				if (!request.getParameter("codigo").equals("")) {
					codigo = Integer.parseInt(request.getParameter("codigo").toString());
				}	%>
		<select name="ciudades" id="ciudades" onchange="verCombo(this,'Ciudad')" style="width:200px;" <%=state%>>
			<option value="0"><<--Seleccione Ciudad-->></option>
			   <%
			   java.util.List municipios = modelo.crearListaMunicipios(Integer.parseInt(request.getParameter("fk_dpto").toString()));
			   for (int i = 0; i < municipios.size(); i++) {
				   Municipio municipio = (Municipio) municipios.get(i);
				   if (codigo == municipio.getCodigo()) {%>
					  <option value="<%=municipio.getCodigo()%>" selected="selected"><%= municipio.getNombre()%> </option>
					  <script type="text/javascript" language="javascript">document.getElementById('tipoCiudad').value = <%=municipio.getCodigo()%>;</script>
	  <%           } else {%>
					  <option value="<%=municipio.getCodigo()%>"><%= municipio.getNombre()%> </option>
			   <%  }
			  } %>
	</select>
	<%  }%>