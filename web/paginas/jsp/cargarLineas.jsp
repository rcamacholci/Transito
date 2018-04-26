<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="modelo.*"%>
<%@page import="java.util.*"%>

<%  Model modelo = (Model) session.getAttribute("model");
        boolean enable = true;
        if(session.getAttribute("seleccionados")!=null)
            enable = modelo.isEnable((List) session.getAttribute("seleccionados"),8);
        String state = enable?"":"disabled";
	int marca_cod = 0;
	int linea_cod = 0;
        int tipo = 0;
	if(request.getParameter("marca")!=null){
		marca_cod = Integer.parseInt(request.getParameter("marca").toString());
	}
	if(request.getParameter("linea")!=null){
		linea_cod = Integer.parseInt(request.getParameter("linea").toString());
	}

        if(request.getParameter("tipoL")!=null){
		tipo = Integer.parseInt(request.getParameter("tipoL").toString());
	}

        if(tipo==1){

	java.util.List lineas = modelo.listaLineas(marca_cod); %>
	<select name="lineas" id="lineas" onchange="verCombo(this,'Linea')" style="width:200px;" <%=state%>>
		<option value="0"><<--Seleccione Linea-->></option>
	<%  for (int i = 0; i < lineas.size(); i++) {
			  Linea linea = (Linea) lineas.get(i);
			  if (linea.getId_linea() == linea_cod) {%>
				  <option value="<%=linea.getId_linea()%>" selected="selected"><%= linea.getNombre()%> </option>
			     <script type="text/javascript" language="javascript">document.getElementById('tipoLinea').value = <%=linea.getId_linea()%>;</script>
          <%  } else {%>
				  <option value="<%=linea.getId_linea()%>"><%= linea.getNombre()%> </option>
		  <%  }
		 } %>
		</select>

                <%
           }else{
            if(tipo==2){
java.util.List lineas = modelo.listaLineasRNRYS(marca_cod); %>
	<select name="lineas" id="lineas" onchange="verCombo(this,'Linea')" style="width:200px;" <%=state%>>
		<option value="0"><<--Seleccione Linea-->></option>
	<%  for (int i = 0; i < lineas.size(); i++) {
			  Linea_Remolques linea = (Linea_Remolques) lineas.get(i);
			  if (linea.getId_linea_rem() == linea_cod) {%>
				  <option value="<%=linea.getId_linea_rem()%>" selected="selected"><%= linea.getNombre()%> </option>
			     <script type="text/javascript" language="javascript">document.getElementById('tipoLinea').value = <%=linea.getId_linea_rem()%>;</script>
          <%  } else {%>
				  <option value="<%=linea.getId_linea_rem()%>"><%= linea.getNombre()%> </option>
		  <%  }
		 } %>
		</select>

                <%

            }
            
            if(tipo==3){
java.util.List lineas = modelo.listaLineasRNMA(marca_cod); %>
	<select name="lineas" id="lineas" onchange="verCombo(this,'Linea')" style="width:200px;" <%=state%>>
		<option value="0"><<--Seleccione Linea-->></option>
	<%  for (int i = 0; i < lineas.size(); i++) {
			  Linea_maquinaria linea = (Linea_maquinaria) lineas.get(i);
			  if (linea.getCodigo_linea()== linea_cod) {%>
				  <option value="<%=linea.getCodigo_linea()%>" selected="selected"><%= linea.getDescripcion()%> </option>
			     <script type="text/javascript" language="javascript">document.getElementById('tipoLinea').value = <%=linea.getCodigo_linea()%>;</script>
          <%  } else {%>
				  <option value="<%=linea.getCodigo_linea()%>"><%= linea.getDescripcion()%> </option>
		  <%  }
		 } %>
		</select>

                <%

            }
            
           }

%>
					 
