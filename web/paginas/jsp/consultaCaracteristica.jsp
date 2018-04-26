<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="modelo.*"%>
<%@page import="java.util.*"%>

<% Model modelo = (Model) session.getAttribute("model");
if (!request.getParameter("caracteristica").equals("")) {
        String clase = "";
        if(request.getParameter("clase")!=null)
            clase = request.getParameter("clase");
	int grupo = 0;
	switch(Integer.parseInt(request.getParameter("caracteristica"))){
		case 1:grupo = 1;break;
		case 2:grupo = 75;break;
		case 3:grupo = 3;break;
		case 4:grupo = 324;break;
		case 5:grupo = 0;break;
		case 6:grupo = 2;break;
		case 7:grupo = 0;break;
                case 8:grupo = 362;break;
	}
	if(request.getParameter("edicion")==null){%>
		<select name="parametro" id="parametro" style="width:120px">
			<%
			java.util.List lista = modelo.listadoParametros(grupo);
			Iterator it = lista.iterator(); 
			while (it.hasNext()) {
				Parametro parametro = (Parametro)it.next();
                                if(parametro.getFk_grupo()!=2){ %>
                                    <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
		<%              }else{
                                    if(parametro.getNombreCorto().equals(clase)){ %>
                                        <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
                                <%  }
                                }
                        }%>
		</select>
 <% }else{ %>
 		<select name="parametro" id="parametro" style="width:120px">
			<%
			java.util.List lista = modelo.listadoParametros(grupo);
			Iterator it = lista.iterator(); 
			while (it.hasNext()) {
				Parametro parametro = (Parametro)it.next(); 
				if(Integer.parseInt(request.getParameter("edicion"))==parametro.getCodigo()){ %>
					<option value="<%=parametro.getCodigo() + ""%>" selected="selected"><%=parametro.getNombre()%></option>
		<%	    }else{
				if(parametro.getFk_grupo()!=2){ %>
                                    <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
		<%              }else{
                                    if(parametro.getNombreCorto().equals(clase)){ %>
                                        <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
                                <%  }
                                }
                            }
			}	 %>
		</select>
<%   }
}%>
