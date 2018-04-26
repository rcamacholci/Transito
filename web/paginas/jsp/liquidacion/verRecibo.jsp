<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" import="modelo.*" import="java.util.*"%>
<%
try{
    if(request.getParameter("id").equals("1")){
        if(session.getAttribute("model")!=null){
             Model model = (Model)session.getAttribute("model");
             Usuario usuario = (Usuario)session.getAttribute("usuario");
             procesos.registrarLiquidacion registroL = new procesos.registrarLiquidacion();
             if(registroL.generarRecibo(request, model, usuario.getId_usuario())){
                 byte[] documentoPDF = registroL.getReciboPDF();
                 response.setContentType("application/pdf");
                 response.setContentLength(documentoPDF.length);
                 response.addHeader("Content-Disposition","inline;");
                 response.setBufferSize(1024 * 15);
                 try{
                    response.getOutputStream().write(documentoPDF);
                 }catch(Exception doc){
                 }
             }else{ %>
                <script language='javascript' type='text/javascript'>
                    alert('<%=registroL.getRespuestaRunt()%>');
                </script>
         <%  }%>
    <%
     }else{ %>
        <script language="javascript" type="text/javascript">window.parent.document.location.href = "../index.jsp";</script>
    <% }
    }
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% } %>