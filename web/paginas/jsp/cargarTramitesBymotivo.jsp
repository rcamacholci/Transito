<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="modelo.*"%>
<%@page import="java.util.*"%>

<% Model model = (Model) session.getAttribute("model");
if (!request.getParameter("motivo").equals("")&&!request.getParameter("motivo").equals("")) {%>
	<select name="<%=request.getParameter("name")%>" id="<%=request.getParameter("name")%>" style=" width:180px; color:#333333; font-size:11px">
		<option value="0">Seleccione</option>
                <%
                    List listTramites = model.listarTramitesByMotivoSinHuella(Integer.parseInt(request.getParameter("motivo")));
                    for (int i = 0; i < listTramites.size(); i++) {
                        Motivos_sinhuella mot = (Motivos_sinhuella)listTramites.get(i);
                        Tramite tramite = model.consultarTramite(mot.getFk_tramite());
                        if(tramite!=null){
                            Parametro par = model.consultarParametro(tramite.getClase_tramite(), 71);
                            long codigoTramiteRunt = model.consultarTramiteRUNT(tramite.getId_tramite());

                %>
                <option value="<%=codigoTramiteRunt%>"><%=tramite.getNombre()%> <%=par.getNombreCorto() %></option>
                <%      }
                    }%>
	</select>
	<%
}%>