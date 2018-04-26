<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Reports" import="net.sf.jasperreports.engine.*" errorPage="" %>
<%
	Model model = null;
	try {
            model = (Model) session.getAttribute("model");
			if(session.getAttribute("reporteOT")!=null){
				java.util.Map parameters = (java.util.HashMap)session.getAttribute("reporteOT");
				//String dir = application.getRealPath("/paginas/reports/recaudoycartera/pagos/multipleTiquetePagoReport.jasper");
				String dir = "C:/Civitrans/transito/web/paginas/reports/recaudoycartera/pagos/multipleTiquetePagoReport.jasper";
                                Reports reporte = new Reports(model,parameters,dir,response);
				session.removeAttribute("reporteOT");
			}
        } catch (Exception exc) {
		exc.printStackTrace();
	}	
%>
