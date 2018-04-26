<%-- 
    Document   : listarInfracciones
    Created on : 14/03/2011, 01:51:45 PM
    Author     : Administrador
--%>

<%@ page  import="modelo.Infraccion" import="modelo.Model" %>
<html>
<head>
    <title></title>
<style type="text/css">
<!--
.style1 {
	font-size: 12px;
	font-weight: bold;
	font-style: italic;
	color: #003366;
        text-align:center;
}
-->
</style>
<script language="javascript" type="text/javascript">
	function ver(n,id,c,t,cl){
		if(n==0){
			document.location = "listarInfracciones.jsp?id=0&infraccion="+cl;
		}else{
			if(n==2){
				if((id+c)<t){
					id = id + c;
					document.location = "listarInfracciones.jsp?id="+id+"&infraccion="+cl;
				}
			}else{
				if(n==1){
					if((id-c)>=0){
						id = id - c;
						document.location = "listarInfracciones.jsp?id="+id+"&infraccion="+cl;
					}
				}else{
					id = (t/c)*c-1;
					document.location = "listarInfracciones.jsp?id="+id+"&infraccion="+cl;
				}
			}
		}
	}
	function selC(codigo,text){
            if(confirm("Desea adicionar la infraccion ["+codigo+"]?")){
                window.parent.opener.document.form.infraccion.value = codigo;
                window.parent.opener.document.form.nombreInfraccion.value = text;
                window.parent.close();
            }
	}
</script>
</head>
<body>
<%
    try {
        if(request.getParameter("infraccion")!=null&&request.getParameter("id")!=null){
            if(!request.getParameter("infraccion").equals("")){
                Model model = (Model) session.getAttribute("model");
                java.util.List lista = model.listarInfraccionesByCodigo(request.getParameter("infraccion").toUpperCase());
                if(lista.size()>0){
                      String ninfraccion = request.getParameter("infraccion").toUpperCase();
                      int cr = 10;//Cantidad Registros
                      int id = Integer.parseInt(request.getParameter("id"));
                      int size = lista.size(); %>
                      <table border="0" cellpadding="1" cellspacing="0" width="100%">
                  <%  for(int i=id;i<(id+cr)&&i<lista.size();i++){
                         Infraccion infraccion = (Infraccion)lista.get(i); %>
                         <tr bgcolor="<%=(i%2==0?"#F6F3F0":"#FFFFFF")%>">
                             <td colspan="2" style="cursor:pointer">
                                <div class="style1" id='<%=infraccion.getNumero()%>' onclick="selC('<%=infraccion.getNumero() %>','<%=infraccion.getDescripcion()%>')">
                                    <label style="font-size:17px;font-weight:bold;text-align:center"><%=infraccion.getNumero()%></label>
                                    </br>
                                    <label style="font-size:11px;text-align:justify"><%=infraccion.getDescripcion()%></label>
                                </div>
                             </td>
                         </tr>
                   <%  } %>
                       <tr>
                    <%   if((id-cr)>=0){ %>
                            <td align="center">
                             <input type="button" id="anterior" value="Anterior" style="width:70px; font-size:11px" onClick="ver(1,<%=id%>,10,<%=size%>,'<%=ninfraccion%>')"/>
                             </td>
	             <% }else{ %>
				 <td align="center">
				 <input type="button" id="anterior" value="Anterior"  style="width:70px; font-size:11px" disabled="disabled"/>
				 </td>
			<% }
		      if((id+cr)<size){ %>
				 <td align="center">
				 <input type="button" id="siguiente" value="Siguiente" style="width:70px; font-size:11px" onClick="ver(2,<%=id%>,10,<%=size%>,'<%=ninfraccion%>')"/>
				 </td>
			<% }else{ %>
			    <td align="center">
				<input type="button" id="siguiente" value="Siguiente" style="width:70px; font-size:11px" disabled="disabled"/>
				</td>
			<% } %>
                       </tr>
                      </table>
           <%     }
            }
        }
    } catch (Exception exc) {
        exc.printStackTrace();
    }
%>
</body>
</html>