<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="modelo.*"%>
<%@page import="java.util.*"%>

<% Model modelo = (Model) session.getAttribute("model");
String placa = request.getParameter("placa");
if (!request.getParameter("radicacion").equals("")&&!request.getParameter("name").equals("")) {%>
<select name="<%=request.getParameter("name")%>" id="<%=request.getParameter("name")%>" style="color:#333333; font:bold;font-size:12px; width:250px" onclick="verTramites('<%=placa%>')" onchange="verTramites('<%=placa%>')">
            <%
		java.util.List lista = modelo.crearListaClasesVeh(request.getParameter("radicacion"));
		for (int i = 0; i < lista.size(); i++) {
			Parametro parametro = (Parametro) lista.get(i);%>
                        <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
	<%	}%>
	</select>
	<%
}%>
