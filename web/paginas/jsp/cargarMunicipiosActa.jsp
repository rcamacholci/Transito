<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="modelo.*"%>
<%@page import="java.util.*"%>

<% Model modelo = (Model) session.getAttribute("model");
if (!request.getParameter("fk_dpto").equals("")) {%>
	<select name="municipio" id="municipio" style="width:140px; font-size:10px; color:#333333">
		<%
		java.util.List lista = modelo.crearListaMunicipios(Integer.parseInt(request.getParameter("fk_dpto").toString()));
		for (int i = 0; i < lista.size(); i++) {
			Municipio municipio = (Municipio) lista.get(i);%>
			<option value="<%=municipio.getCodigo() + ""%>"><%=municipio.getNombre()%></option>
	<%	}%>
	</select>
	<%
}%>
