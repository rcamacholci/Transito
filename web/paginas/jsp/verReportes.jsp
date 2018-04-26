<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Reports" import="net.sf.jasperreports.engine.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	Model model = null;
	try {
		model = (Model) session.getAttribute("model");
		String nombreReporte = request.getParameter("nombreReporte");
		String dirReporte = request.getParameter("dirReporte");
		java.util.Map parameters = (java.util.HashMap)session.getAttribute(nombreReporte);
		String dir = application.getRealPath("paginas/reports/"+dirReporte);
                dir="C:/Civitrans/transito/web/paginas/reports/"+dirReporte;
		parameters.put("SUBREPORT_DIR",dir.substring(0,dir.indexOf("reports")+8));
		Reports reporte = new Reports(model,parameters,dir,response);
    } catch (Exception exc) {
        exc.printStackTrace();
    }
%>
