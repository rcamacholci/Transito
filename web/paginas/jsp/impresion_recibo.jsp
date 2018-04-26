<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Reports" import="net.sf.jasperreports.engine.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Documento sin t&iacute;tulo</title>
    </head>
    <body>
        <table width="100%" border="0">
<%
	Model model = null;
	try {
            model = (Model) session.getAttribute("model");
            if(session.getAttribute("reporteOT")!=null){
                if(request.getParameter("id").equals("1")){
                    java.util.Map parameters = (java.util.HashMap)session.getAttribute("reporteOT");
                    String dir = application.getRealPath("/paginas/reports/recaudoycartera/pagos/multipleTiquetePagoReport.jasper");
                    Reports reporte = new Reports(model,parameters,dir,response);
                }else{
                    if(request.getParameter("id").equals("2")){
                        byte[] content = (byte[])session.getAttribute("reporteRUNT");
                        Reports reporteRunt = new Reports(content,response);
                    }
                }
            }else{
                if(request.getParameter("id").equals("2")){
                    byte[] content = (byte[])session.getAttribute("reporteRUNT");
                    Reports reporteRunt = new Reports(content,response);
                }
            }
        } catch (Exception exc) {
            //exc.printStackTrace();
	}	
%>
          <tr>
            <th colspan="4" scope="col">&nbsp; </th>
          </tr>
        </table>
    </body>
</html>
