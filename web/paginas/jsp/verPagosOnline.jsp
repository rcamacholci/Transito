<%--
    Document   : verPagosOnline
    Created on : 26/06/2013, 03:32:28 PM
    Author     : jjpadillag
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*" import="org.ita.webservice.Pago"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarPagosOnline.jsp")){
                   Model model = (Model)session.getAttribute("model");
                   Usuario user = (Usuario)session.getAttribute("usuario");
                   java.util.List list = new java.util.LinkedList();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="../html/scripts/tablecloth.js"></script>
        <script>
            function bloquear(){
                document.form.aplicar.disabled = true;
                document.form.aplicar.value = "Aplicando Espere...";
            }
        </script>

        <title>Ver pagos Online</title>
    </head>
    <body>
        <form name="form" method="post" action="procesarPagoOnline.jsp">
                    <fieldset>
                <table>
                   <tr>
                        <th>PLACA</th>
                        <th>BANCO</th>
                        <th>REFERENCIA</th>
                        <th>FECHA PAGO</th>
                        <th>VALOR</th>
                    </tr>
    <%-- start web service invocation --%><hr/>
    <%
    try {
        org.ita.webservice.PagosEnLinea_Service service = new org.ita.webservice.PagosEnLinea_Service();
	org.ita.webservice.PagosEnLinea port = service.getPagosEnLineaPort();
	// TODO process result here
	java.util.List<org.ita.webservice.Pago> result = port.consultarPagosEfectivos();
        for(int i=0;i<result.size();i++){
        org.ita.webservice.Pago pago = (org.ita.webservice.Pago)result.get(i);
        list.add(pago.getId());
%>
                    <tr>
                        <td><%=pago.getPlaca() %></td>
                        <td><%=pago.getNombreBanco() %></td>
                        <td><%=pago.getReferencia() %></td>
                        <td><%=pago.getFechaProceso() %></td>
                        <td><%=pago.getValorPagado() %></td>
                    </tr>

<%
    }
    } catch (Exception ex) {
	// TODO handle custom exceptions here
    }
    %>
    <%-- end web service invocation --%><hr/>

                </table>

<%
boolean estTaquilla = false;
java.util.List lista = model.consultarCajasUsuario(user.getId_usuario());
for(int i=0;i<lista.size();i++){
        UsuarioCaja usuarioCaja = (UsuarioCaja)lista.get(i);
        Taquilla taquilla = model.consultar_Taquilla(usuarioCaja.getFk_caja(),usuarioCaja.getFk_sede(),usuarioCaja.getFk_usuario());
        Caja caja = model.consultarCaja(usuarioCaja.getFk_caja());
        if(caja.getFecha_fin()==null){
            boolean estadoTaquilla = taquilla!=null?(taquilla.getEstado()==1?true:false):false;
            if(estadoTaquilla){
                            estTaquilla = true;
                            %>
                            <input type="hidden" name="idTaquilla" value="<%=taquilla.getId_taquilla() %>">
                        <%
            }
                       %>
                  </div>
              </td>
            </tr>

            <%
        }
  }
%>

<div align="right">
    <%if(estTaquilla && list.size()>0){ %>
    <input type="submit" name="aplicar" value="Aplicar Pagos" onclick="bloquear()" >
    <% }else{ %>
    <script>alert("No existen cajas abiertas ó Pagos a aplicar");</script>
    <input type="submit" value="Aplicar Pagos" disabled >
  <%}%>
</div>

    </div>
            </fieldset>
    </form>
    </body>
</html>

<%  }else{ %>
			   <jsp:forward page="no_access.jsp">
				 <jsp:param name="tipo" value="1"></jsp:param>
			   </jsp:forward>
	<%  }
	}else{ %>
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>