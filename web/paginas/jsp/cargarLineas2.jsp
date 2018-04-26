<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="modelo.*"%>
<%@page import="java.util.*"%>

<%  Model modelo = (Model) session.getAttribute("model");
        int marca_cod = 0;
	if(request.getParameter("marca")!=null){
		marca_cod = Integer.parseInt(request.getParameter("marca").toString());
	}

	java.util.List lineas = modelo.listaLineas(marca_cod); %>
        <label for="lineas">Lineas:</label>
	<select name="lineas" id="lineas" class="form-control form-control-sm">
		<option value="-1">Seleccione la Linea</option>
	<%  for (int i = 0; i < lineas.size(); i++) {
			  Linea linea = (Linea) lineas.get(i);
        %>
	  <option value="<%=linea.getId_linea()%>"><%= linea.getNombre()%> </option>
           <%} %>
	</select>

